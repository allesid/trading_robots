SEC = "MGNT"
CLASS = "TQBR"
TRADE_ACC   = "L01-00000F00"   -- торговый счет
CLIENT_CODE = "54078"          -- код клиента
FIRM_ID="MC0094600000"
is_run = true
wrk=0

--  ============================================

function OnInit(s)
	dt = getTradeDate().date
    filer=io.open("C:/QuikKITFinanceEurope/data/Test-1/test-"..SEC.."-light-"..dt..".txt", "w")
    filer:write("bid of qbid qof qbid2 qof2 cls vol TIME" , '\n')
	
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
		tm=os.sysdate().hour*100+os.sysdate().min
	  if (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) or tm<1000 then
		  sleep(1000)
	  else
		break
	  end
	end
		wrk=1

	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
        message(SEC.." OnInit light bid : "..tostring(bid).."  of=" .. tostring(of) , 1)

    while is_run do   
		sleep(50)
		tm=os.sysdate().hour*100+os.sysdate().min
		if tm>1838 then
			is_run = false
		end
    end
  filer:close()
  ds:Close()
end
--  ============================================

function OnQuote(class_code, sec_code) -- ФОВ вызывается терминалом QUIK при получении изменения стакана котировок
  if (sec_code ~= SEC) or wrk==0 then
	return
  end
	qt = getQuoteLevel2(CLASS, SEC)
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
	qbid = tonumber(qt.bid[qt.bid_count-0].quantity)
	qof = tonumber(qt.offer[1].quantity)
	qbid2 = tonumber(qt.bid[qt.bid_count-1].quantity)
	qof2 = tonumber(qt.offer[2].quantity)

		cls = ds:C(ds:Size())
		vol = ds:V(ds:Size())
		tm = getInfoParam("LOCALTIME")

         filer:write(tostring(bid).." "..tostring(of).." "..tostring(qbid).." "..tostring(qof).." "..tostring(qbid2).." "..tostring(qof2).." "..tostring(cls).." "..tostring(vol).." "..tostring(tm), '\n')
end
--  ============================================

function OnStop(s)
  is_run = false
end
