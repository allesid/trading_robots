SEC="MOEX"
CLASS="TQBR"
TRADE_ACC   = "L01-00000F00"   -- торговый счет
CLIENT_CODE = "54174"          -- код клиента
FIRM_ID="MC0094600000"
is_run = true
wrk=0
n = 5
--  ============================================

function OnInit(s)
	dt = getTradeDate().date
    filer=io.open("C:/QuikKITFinance/data/Test-1/test-"..SEC.."-"..n.."-"..dt..".txt", "w")
	for i = 1, n do
    filer:write(" bid"..i.." qbid"..i)
	end
	for i = 1, n do
    filer:write(" of"..i.." qof"..i)
	end
    filer:write(" cls vol TIME" , '\n')
	
end
--  ============================================

function main()
	tm = os.sysdate().hour * 100 + os.sysdate().min
	while tm < 1000 do
		sleep(1000)
		tm = os.sysdate().hour * 100 + os.sysdate().min
	end
	
	while not Subscribe_Level_II_Quotes(CLASS, SEC) do
		sleep(3000)
	end
	qt = getQuoteLevel2(CLASS, SEC)
	while qt.bid_count == 0 or qt.offer_count == 0 do
		sleep(3000)
		qt = getQuoteLevel2(CLASS, SEC)
	end
	while not qt.offer or not qt.bid do
		qt = getQuoteLevel2(CLASS, SEC)
		sleep(3000)
	end
    ds=CreateDataSource (CLASS, SEC, INTERVAL_D1) 
	if ds:Size() == 0 then 
	  ds:SetEmptyCallback()
	  sleep(500)
	end
	if ds == nil then
        message(" ds == nil ", 1) 
		is_run = false
	end
	while true do
	  qt = getQuoteLevel2(CLASS, SEC)
		tm=os.sysdate().hour*100+os.sysdate().min
	  if (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) then
		  sleep(1000)
	  else
		break
	  end
	end
		wrk=1

	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
        message(SEC.." OnInit bid : "..tostring(bid).."  of=" .. tostring(of) , 1)

    while is_run do   
		sleep(50)
		tm=os.sysdate().hour*100+os.sysdate().min
		if tm > 1835 then
			if tm>2339 then
				wrk=0
				is_run = false
			else
				if tm < 1906 then
					wrk=0
				else
					wrk=1
				end
			end
		end
    end
  ds:Close()
  filer:close()
  Unsubscribe_Level_II_Quotes(CLASS, SEC)
end
--  ============================================

function OnQuote(class_code, sec_code) -- ФОВ вызывается терминалом QUIK при получении изменения стакана котировок
  if (sec_code ~= SEC) or wrk==0 then
	return
  end
	qt = getQuoteLevel2(CLASS, SEC)

 	for i = 0, n-1 do
    filer:write(qt.bid[qt.bid_count-i].price.." "..qt.bid[qt.bid_count-i].quantity.." ")
	end
 	for i = 0, n-1 do
    filer:write(qt.offer[1+i].price.." "..qt.offer[1+i].quantity.." ")
	end

    filer:write(tostring(ds:C(ds:Size())).." "..tostring(ds:V(ds:Size())).." "..tostring(getInfoParam("LOCALTIME")), '\n')
end
--  ============================================

function OnStop(s)
	is_run = false
end
