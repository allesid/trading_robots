SEC = "TCS_XM"
CLASS = "SPBXM"
TRADE_ACC   = "CITFS00003"   -- торговый счет
CLIENT_CODE = "65425"          -- код клиента
FIRM_ID="MC0094600000"
is_run = true
--  ============================================

function OnInit(s)
	dt = getTradeDate().date
        message(" dt == "..tostring(dt), 1) 
    filer=io.open("C:/QuikKITFinance/data/Test-1/test-"..SEC.."-averQ-"..dt..".txt", "w")
        message(" filer == "..tostring(filer), 1) 
	if filer == nil then
        message(" filer == nil ", 1) 
		is_run = false
	end
		local qt = getQuoteLevel2(CLASS, SEC)
  if (qt.bid_count+0 == 0) or (qt.offer_count+0 == 0) then
        message(" count = nil ", 1) 
		is_run = false
	return                     
  end
     filer:write("bid of cls vol TIME bid_count offer_count averQ averQi averQ09 averQiw" , '\n')
	
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
        message(SEC.." OnInit  bid : "..tostring(bid).."  of=" .. tostring(of) , 1)
    ds=CreateDataSource (CLASS, SEC, INTERVAL_D1) 
	if ds:Size() == 0 then 
	  ds:SetEmptyCallback()
	  sleep(500)
	end
	if ds == nil then
        message(" ds == nil ", 1) 
		is_run = false
	end

end
--  ============================================

function main()

    while is_run do   
		sleep(50)
    end
  filer:close()
  ds:Close()
end
--  ============================================

function OnQuote(class_code, sec_code) -- ФОВ вызывается терминалом QUIK при получении изменения стакана котировок
  if (sec_code ~= SEC) then
	return
  end
			local qt = getQuoteLevel2(CLASS, SEC)
	bid = tonumber(qt.bid[qt.bid_count-0].price)
	of = tonumber(qt.offer[1].price)
		cls = ds:C(ds:Size())
		vol = ds:V(ds:Size())
		tm = getInfoParam("LOCALTIME")
		
		smbs=0
		smq=0
		smbsi=0
		smqi=0
		smbs09=0
		smq09=0
		smbsiw=0
		smqiw=0
		for i=0, qt.bid_count-1 do
		smbs=smbs+tonumber(qt.bid[qt.bid_count-i].price)*tonumber(qt.bid[qt.bid_count-i].quantity)
		smq=smq+tonumber(qt.bid[qt.bid_count-i].quantity)
		smbsi=smbsi+tonumber(qt.bid[qt.bid_count-i].price)*tonumber(qt.bid[qt.bid_count-i].quantity)/(i+1)
		smqi=smqi+tonumber(qt.bid[qt.bid_count-i].quantity)/(i+1)
		smbs09=smbs09+tonumber(qt.bid[qt.bid_count-i].price)*tonumber(qt.bid[qt.bid_count-i].quantity)*math.pow(0.9, i)
		smq09=smq09+tonumber(qt.bid[qt.bid_count-i].quantity)*math.pow(0.9, i)
		smbsiw=smbsiw+tonumber(qt.bid[qt.bid_count-i].price)*tonumber(qt.bid[qt.bid_count-i].quantity)*(1-i/qt.bid_count)
		smqiw=smqiw+tonumber(qt.bid[qt.bid_count-i].quantity)*(1-i/qt.bid_count)
		end
		for i=0, qt.offer_count-1 do
		smbs=smbs+tonumber(qt.offer[1+i].price)*tonumber(qt.offer[1+i].quantity)
		smq=smq+tonumber(qt.offer[1+i].quantity)
		smbsi=smbsi+tonumber(qt.offer[1+i].price)*tonumber(qt.offer[1+i].quantity)/(i+1)
		smqi=smqi+tonumber(qt.offer[1+i].quantity)/(i+1)
		smbs09=smbs09+tonumber(qt.offer[1+i].price)*tonumber(qt.offer[1+i].quantity)*math.pow(0.9, i)
		smq09=smq09+tonumber(qt.offer[1+i].quantity)*math.pow(0.9, i)
		smbsiw=smbsiw+tonumber(qt.offer[1+i].price)*tonumber(qt.offer[1+i].quantity)*(1-i/qt.offer_count)
		smqiw=smqiw+tonumber(qt.offer[1+i].quantity)*(1-i/qt.offer_count)
		end
		averQ=smbs/smq
		averQi=smbsi/smqi
		averQ09=smbs09/smq09
		averQiw=smbsiw/smqiw

         filer:write(tostring(bid).." "..tostring(of).." "..tostring(cls).." "..tostring(vol).." "..tostring(tm) )
         filer:write(" "..tostring(qt.bid_count).." "..tostring(qt.offer_count).." "..tostring(averQ).." "..tostring(averQi))
         filer:write(" ".." "..tostring(averQ09).." "..tostring(averQiw), '\n')
end
--  ============================================

function OnStop(s)
  is_run = false
end
