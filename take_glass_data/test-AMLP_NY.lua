SEC = "AMLP_NY"
CLASS = "NY_ETF"
TRADE_ACC   = "SV02"   -- торговый счет
CLIENT_CODE = "1206"          -- код клиента
FIRM_ID="MC0094600000"
is_run = true
--  ============================================

function OnInit(s)
		local qt = getQuoteLevel2(CLASS, SEC)
  if (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) then
	return                     
  end
	dt = getTradeDate().date
    filer=io.open("C:/QuikKITFinanceEurope/data/Test-1/test-"..SEC.."-bid-of-"..dt..".txt", "w")
    filer:write("bid of bid2 of2 bid3 of3 bid4 of4 bid5 of5 qbid qof qbid2 qof2 qbid3  qof3  qbid4  qof4 qbid5  qof5 cls vol TIME" , '\n')
	
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
        message(SEC.." OnInit  bid : "..tostring(bid).."  of=" .. tostring(of) , 1)

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

    while is_run do   
		sleep(500)
    end
  filer:close()
end
--  ============================================

function OnQuote(class_code, sec_code) -- ФОВ вызывается терминалом QUIK при получении изменения стакана котировок
  if (sec_code ~= SEC) then
	return
  end
			local qt = getQuoteLevel2(CLASS, SEC)
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)

	local bid2 = tonumber(qt.bid[qt.bid_count-1].price)
	local of2 = tonumber(qt.offer[2].price)
	local bid3 = tonumber(qt.bid[qt.bid_count-2].price)
	local of3 = tonumber(qt.offer[3].price)
	local bid4 = tonumber(qt.bid[qt.bid_count-3].price)
	local of4 = tonumber(qt.offer[4].price)
	local bid5 = tonumber(qt.bid[qt.bid_count-4].price)
	local of5 = tonumber(qt.offer[5].price)
	
	qbid = tonumber(qt.bid[qt.bid_count-0].quantity)
	qof = tonumber(qt.offer[1].quantity)

	local qbid2 = tonumber(qt.bid[qt.bid_count-1].quantity)
	local qof2 = tonumber(qt.offer[2].quantity)
	local qbid3 = tonumber(qt.bid[qt.bid_count-2].quantity)
	local qof3 = tonumber(qt.offer[3].quantity)
	local qbid4 = tonumber(qt.bid[qt.bid_count-3].quantity)
	local qof4 = tonumber(qt.offer[4].quantity)
	local qbid5 = tonumber(qt.bid[qt.bid_count-4].quantity)
	local qof5 = tonumber(qt.offer[5].quantity)
            --message(SEC.." bid3=" .. tostring(bid3).." of3=" .. tostring(of3), 1)

		cls = ds:C(ds:Size())
		vol = ds:V(ds:Size())
		tm = getInfoParam("LOCALTIME")

            --message("OnQuote bid=" .. tostring(bid))
         filer:write(tostring(bid).." "..tostring(of).." "..tostring(bid2).." "..tostring(of2).." "..tostring(bid3).." "..tostring(of3).." "..tostring(bid4).." "..tostring(of4).." "..tostring(bid5).." "..tostring(of5) )
         filer:write(" "..tostring(qbid).." "..tostring(qof).." "..tostring(qbid2).." "..tostring(qof2).." "..tostring(qbid3).." "..tostring(qof3).." "..tostring(qbid4).." "..tostring(qof4).." "..tostring(qbid5).." "..tostring(qof5) )
         filer:write(" "..tostring(cls).." "..tostring(vol).." "..tostring(tm), '\n')
end
--  ============================================

function OnStop(s)
  is_run = false
end
