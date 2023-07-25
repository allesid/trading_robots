SEC = "CNYRUB_TOM"
CLASS = "CETS"
-- TRADE_ACC   = "L01-00000F00"   -- торговый счет
-- CLIENT_CODE = "54078"          -- код клиента
-- FIRM_ID="MC0094600000"
is_run = true
start_time = 70000
end_time = 185000
vers = "1"
--  ============================================

function OnInit(s)
	dt = getTradeDate().date
    filer=io.open("C:/Projects/trading_robots/take_glass_data/test-"..SEC.."-"..vers.."-"..dt..".csv", "w")
	
end
--  ============================================

function main()
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
		tm=os.sysdate().hour*10000+os.sysdate().min*100+os.sysdate().sec
	  if (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) or tm < start_time then
		  sleep(1000)
	  else
		break
	  end
	end
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
    message(SEC.." OnInit light bid : "..tostring(bid).."  of=" .. tostring(of) , 1)
	
	for i = 1, qt.bid_count do
    filer:write("bid"..i.." qbid"..i)
	end
	for i = 1, qt.offer_count do
    filer:write(" of"..i.." qof"..i)
	end
    filer:write(" cls vol TIME" , '\n')

    while is_run do   
		sleep(50)
		tm=os.sysdate().hour*10000+os.sysdate().min*100+os.sysdate().sec
		if tm >= end_time then
			is_run = false
		end
    end
  ds:Close()
  filer:close()
end
--  ============================================

function OnQuote(class_code, sec_code)

  if (sec_code ~= SEC) or not is_run then
	return
  end
	qt = getQuoteLevel2(CLASS, SEC)

 	for i = 0, qt.bid_count-1 do
    filer:write(tonumber(qt.bid[1+i].price).." "..tonumber(qt.bid[1+i].quantity).." ")
	end
 	for i = 0, qt.offer_count-1 do
    filer:write(tonumber(qt.offer[1+i].price).." "..tonumber(qt.offer[1+i].quantity).." ")
	end

    filer:write(tostring(ds:C(ds:Size())).." "..tostring(ds:V(ds:Size())).." "..tostring(os.sysdate().hour*10000+os.sysdate().min*100+os.sysdate().sec), '\n')
end
--  ============================================

function OnStop(s)
  is_run = false
end
