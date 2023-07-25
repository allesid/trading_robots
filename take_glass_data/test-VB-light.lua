SEC = "VBH0"
CLASS = "SPBFUT"
TRADE_ACC   = "1500c6h"   -- торговый счет
CLIENT_CODE = "54078"          -- код клиента
FIRM_ID="SPBFUT"
tm=0
is_run = true
--  ============================================

function OnInit(s)
 	tm = os.sysdate().hour * 100 + os.sysdate().min
		local qt = getQuoteLevel2(CLASS, SEC)
	dt = getTradeDate().date
    filer=io.open("C:/QuikKITFinanceEurope/data/Test-1/test-"..SEC.."-light-"..dt..".txt", "w")
    filer:write("bid of qbid qof qbid2 qof2 cls vol TIME" , '\n')
	
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
        message(SEC.." OnInit  bid : "..tostring(bid).."  of=" .. tostring(of) , 1)
 	tm = 0 + os.sysdate().hour * 100 + os.sysdate().min*1

end
--  ============================================

function main()
	while true do
		sleep(1000)
		qt = getQuoteLevel2(CLASS, SEC)
		if (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) then
			--message(SEC.." (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) ", 3)
		else
			break
		end
	end
	while true do
		sleep(1000)
		tm = os.sysdate().hour * 100 + os.sysdate().min
		if tm>=1000 then
			break
		end
	end

	while true do
		sleep(1000)
		ds=CreateDataSource (CLASS, SEC, INTERVAL_D1) 
		if ds:Size() == 0 then 
		  ds:SetEmptyCallback()
		  sleep(500)
		end
		if ds == nil then
			--message(" ds == nil ", 1) 
		else
			break
		end
	end
    while is_run do   
		sleep(50)
 	tm = 0 + os.sysdate().hour * 100 + os.sysdate().min*1
		if tm<1000 or (tm>1843 and tm<1900) then
			wrk=0
		else
			wrk=1
		end
		if tm>=2344 then
			is_run = false
		end
    end
	
  filer:close()
  ds:Close()
end
--  ============================================

function OnQuote(class_code, sec_code) -- ФОВ вызывается терминалом QUIK при получении изменения стакана котировок
  if (sec_code ~= SEC) or  wrk==0 then
	return
  end
	qt = getQuoteLevel2(CLASS, SEC)

    filer:write(qt.bid[qt.bid_count-0].price.." "..qt.offer[1].price.." "..qt.bid[qt.bid_count-0].quantity.." "..qt.offer[1].quantity.." "..qt.bid[qt.bid_count-1].quantity.." "..qt.offer[2].quantity.." "..tostring(ds:C(ds:Size())).." "..tostring(ds:V(ds:Size())).." "..tostring(getInfoParam("LOCALTIME")), '\n')
end
--  ============================================

function OnStop(s)
  is_run = false
end
