
-- CLASS="NY_LIGHT"
-- TRADE_ACC   = "SV02"   -- торговый счет
-- CLIENT_CODE = "1206"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="TQTF"
-- TRADE_ACC   = "L01-00000F00"   -- торговый счет
-- CLIENT_CODE = "54174"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="SPBDE"
-- TRADE_ACC   = "CITFS00003"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="SPBXM"
-- TRADE_ACC   = "CITFS00003"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="SPBFUT"
-- TRADE_ACC   = "1500c6h"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="SPBFUT"

-- CLASS="CETS"
-- TRADE_ACC   = "MB0094600602"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="CETS_MTL"
-- TRADE_ACC   = "MB0094600602"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="MC0094600000"

CLASS="TQBR"
TRADE_ACC   = "L01-00000F00"   -- торговый счет
CLIENT_CODE = "49215"          -- код клиента
FIRM_ID="MC0094600000"

dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
path_name = "C:/QuikKITFinance/data/ADX/CETS/"
vers = "vmul33-TEST-online"
res_variant = 3
max_ma_per = 250
last_candle = -750
length_candles = 500

--  ========    DATA    ====================
stime = 2500
etime = 0
if CLASS == "TQBR" then
	EXCH = "MOEX-SEC" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 1000 --TQBR
	end_time = 2349 --TQBR
	stime = 1840
	etime = 1905
elseif CLASS == "TQTF" then
	EXCH = "MOEX-ETF" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 1000
	end_time = 2349
elseif CLASS == "SPBFUT" then
	EXCH = "FUTUR" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%w+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 900 --SPBFUT 
	end_time = 2349 --SPBFUT 
	stime = 1850
	etime = 1905
elseif CLASS == "CETS" then
	EXCH = "CURR" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_([%w_]+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 700 --CETS
	end_time = 2200 --CETS
	stime = 1200
	etime = 1201
elseif CLASS =="CETS_MTL" then
	EXCH = "GOLD" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_([%w_]+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 1000
	end_time = 1859 -- CETS_MTL
elseif CLASS == "SPBXM" then
	EXCH = "SPBEX" -- "SPBDE" -- "MOEX-SEC" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+)" -- "sec_(%a+_NY)" -- 
	start_time = 1200
	end_time = 2500
elseif CLASS == "SPBDE" then
	EXCH = "SPBDE" -- "SPBEX" -- "MOEX-SEC" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%w+@DE_XM)" -- "sec_(%a+_XM)" -- "sec_(%a+)" -- "sec_(%a+_NY)" -- 
else
	message("CLASS not found", 3)
	is_run = false
	return
end
time_interval = INTERVAL_M5
	money_limit=205
	currency = "SUR" -- "USD" --
	position_code= "EQTV" -- "GLSP" --
ld_pattern = "ld_(%-?%d)"
res_pattern = "res_(%-?%d+[.]?%d*)"
pos_pattern = "pos_(%-?%d+[.]?%d*)"
pospct_pattern = "pospct_(%-?%d+[.]?%d*)"
prc_pattern = "prc_(%d+[.]?%d*)"
openpos_pattern = "openpos_(%d+)"
comis = 0.0005
len_SEC = 0
sec_list = {}
last_deal = {} -- [SEC][DEAL_variant]{last_deal, res, pos}
MA = {} -- [SEC]
qt = {}
meanhl = {}

end_of_name = EXCH.."-M"..time_interval.."-"..vers..".txt"
data_file_name = path_name.."data-ADX-"..end_of_name
result_file_name = path_name.."Result-ADX-"..end_of_name

price_format = '%.4f'
 is_run = true
tm_minute = 0
uniq_trans_id = 0
--  ============================================
		Blabel={
			["TEXT"]="<buy",
			["IMAGE_PATH STRING"]="",
			["ALIGNMENT"]="RIGHT",
			["YVALUE"]=0,
			["DATE"]=0,
			["TIME"]=0,
			["B"]=0,
			["R"]=0,
			["G"]=128,
			["FONT_FACE_NAME"]="Arial",
			["FONT_HEIGHT"]=10,
			["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
			["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
			}
		Slabel={
			["TEXT"]="<sell",
			["IMAGE_PATH STRING"]="",
			["ALIGNMENT"]="RIGHT",
			["YVALUE"]=0,
			["DATE"]=0,
			["TIME"]=0,
			["B"]=0,
			["R"]=255,
			["G"]=0,
			["FONT_FACE_NAME"]="Arial",
			["FONT_HEIGHT"]=10,
			["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
			["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
			}
		STOPlabel={
			["TEXT"]="<stop",
			["IMAGE_PATH STRING"]="",
			["ALIGNMENT"]="RIGHT",
			["YVALUE"]=0,
			["DATE"]=0,
			["TIME"]=0,
			["B"]=255,
			["R"]=0,
			["G"]=0,
			["FONT_FACE_NAME"]="Arial",
			["FONT_HEIGHT"]=10,
			["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
			["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
			}



	trans_B = {
        ["ACTION"] = "NEW_ORDER",
        ["CLASSCODE"] = CLASS,
        ["SECCODE"] = SEC,
        ["ACCOUNT"] = TRADE_ACC,
        ["CLIENT_CODE"] = CLIENT_CODE,
        ["OPERATION"] = 'B',
        ["PRICE"] =  '1',
        ["QUANTITY"] = string.format('%.0f', 1),
        ["TRANS_ID"] = '1'
                }
	trans_S = {
        ["ACTION"] = "NEW_ORDER",
        ["CLASSCODE"] = CLASS,
        ["SECCODE"] = SEC,
        ["ACCOUNT"] = TRADE_ACC,
        ["CLIENT_CODE"] = CLIENT_CODE,
        ["OPERATION"] = 'S',
        ["PRICE"] =  '1',
        ["QUANTITY"] = string.format('%.0f', 1),
        ["TRANS_ID"] = '2'
                }
--  ============================================
function sell_now(tn, Trvol, SEC, price_format, PRICE_STEP)
	ops=getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).locked_sell
 --=====================  Постановка ордеров  ===========================	
	--=============== SELL =====================
	-- mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal 
	qt = getQuoteLevel2(CLASS, SEC)
	ofS = tonumber(qt.offer[1].price)
	price = ofS - 3*PRICE_STEP
	
	if (tn - Trvol) > 0 and ops == 0 then
		uniq_trans_id = uniq_trans_id  + 1
		trans_S["TRANS_ID"] = tostring(uniq_trans_id)
		trans_S["SECCODE"] = SEC
		trans_S["PRICE"] =  string.format(price_format, price) -- MakeStringPrice(price),
		trans_S["QUANTITY"] = string.format('%.0f', tn - Trvol)
		resd = sendTransaction(trans_S)
		--message(SEC.." resd:"..resd.." SELL price= " .. tostring(prc).."  tn= "..tostring(tn).." qty="..string.format('%.0f',trans["QUANTITY"]), 1)
		message(SEC.." 1 resd= " .. tostring(resd), 1)
		-- message(SEC.." sell_now mpos= "..mpos.." tn= "..tn.." ops= "..ops.." price= "..price, 1)
		-- sell_price = bidS
	end
end
--  ============================================
function buy_now(tn, Trvol, SEC, price_format, PRICE_STEP)
		opb=getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).locked_buy/LOTS_VALUE
 --=====================  Постановка ордеров  ===========================	
		--=============== BUY =====================
	mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal - getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).locked 
	qt = getQuoteLevel2(CLASS, SEC)
	bidS = tonumber(qt.bid[qt.bid_count-0].price)
	price = bidS + 3*PRICE_STEP
	if (Trvol-tn)>0 and opb == 0 then -- 
		uniq_trans_id = uniq_trans_id  + 1
		trans_B["TRANS_ID"] = tostring(uniq_trans_id)
		trans_B["SECCODE"] = SEC
		trans_B["PRICE"] =  string.format(price_format,price) -- MakeStringPrice(price),
		trans_B["QUANTITY"] = string.format('%.0f', Trvol-tn)
		resd = sendTransaction(trans_B)
		--message(SEC.." resd:"..resd.." BUY price= " .. tostring(prc).."  tn= "..tostring(tn).." qty="..string.format('%.0f',trans["QUANTITY"]), 1)
		message(SEC.." 21 resd= " .. tostring(resd), 1)
		-- message(SEC.." buy_now mpos= "..mpos.." tn= "..tn.." opb= "..opb.." prc= "..price, 1)
	end	
end
--  ============================================

function OnInit(s)
end
--  ============================================

function main()
	tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	-- message("Start cycle tm= "..tm.." "..end_of_name, 1)
	-- message("Start time = "..start_time, 1)
	while tm<start_time do
		sleep(5000)
		tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	end
	message("====================", 1)
	filer1=io.open(data_file_name, "r")
	--message("1 "..tostring(filer1))
	
-- last_deal[SEC][1] - last_deal
-- last_deal[SEC][2] - result
-- last_deal[SEC][3] - position
-- last_deal[SEC][4] - res percent
-- last_deal[SEC][5] - last price
-- last_deal[SEC][6] - open position in lots

	if filer1 == nil then
		filer1=io.open(data_file_name, "w")
		message("Insert sequrities to data file: "..data_file_name,3)
		filer1:close()
		return
		--message("2 "..tostring(filer1))
	else
		str = filer1:read("*l")
		if str then
			while str do
			-- message("3 "..tostring(str))
			-- message(str)
					--message(SEC, 1)
				len_SEC = len_SEC + 1
				SEC = string.match(str, sec_pattern)
				if SEC then
					sec_list[len_SEC] = SEC
					last_deal[SEC] = {}
						last_deal[SEC] = {}
						last_deal[SEC][1] = tonumber(string.match(str, ld_pattern))
						if last_deal[SEC][1] then
						else
							message("Bad last_deal input: SEC="..SEC,2)
							last_deal[SEC][1] = 0
						end
						last_deal[SEC][2] = tonumber(string.match(str, res_pattern))
						if last_deal[SEC][2] then
						else
							message("Bad res input: SEC="..SEC,2)
							last_deal[SEC][2] = 0
						end
						last_deal[SEC][3] = tonumber(string.match(str, pos_pattern))
						if last_deal[SEC][3] then
						else
							message("Bad pos input: SEC="..SEC,2)
							last_deal[SEC][3] = 0
						end
						last_deal[SEC][4] = tonumber(string.match(str, pospct_pattern))
						if last_deal[SEC][4] then
						else
							message("Bad pospct input: SEC="..SEC,2)
							last_deal[SEC][4] = 0
						end
						last_deal[SEC][5] = tonumber(string.match(str, prc_pattern))
						if last_deal[SEC][5] then
						else
							message("Bad prc input: SEC="..SEC,2)
							last_deal[SEC][5] = 0
						end
						last_deal[SEC][6] = tonumber(string.match(str, openpos_pattern))
						if last_deal[SEC][6] then
						else
							message("Bad prc input: SEC="..SEC,2)
							last_deal[SEC][6] = 1
						end
				else
					SEC = str
					sec_list[len_SEC] = SEC
						last_deal[SEC] = {}
						last_deal[SEC][1] = 0
						last_deal[SEC][2] = 0
						last_deal[SEC][3] = 0
						last_deal[SEC][4] = 0
						last_deal[SEC][5] = 0 
						last_deal[SEC][6] = 1 
				end
				-- message(SEC, 1)
				str = filer1:read("*l")
			end
			message("Load vers: "..vers.." SEC= "..tostring(SEC).." len_SEC= "..tostring(len_SEC).." DEAL_variant_length= "..tostring(DEAL_variant_length), 1)
		else
			message("No input data "..vers, 1)
		end
	end
	filer1:close()
	prints(sec_list, last_deal)

	dt = getTradeDate().date
	filer=io.open(result_file_name, "a")
	filer:write("=========================================", '\n')
	tm = os.sysdate().hour * 100 + os.sysdate().min

	filer:write("Start: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')
	filer:write("Length candles="..tostring(length_candles), '\n')		
	filer:write("max_ma_per="..tostring(max_ma_per), '\n')
	filer:write("ma_per_level="..tostring(ma_per_level), '\n')
	filer:write("dub_up="..dub_up, '\n')

tb_res = AllocTable()
ac_res = AddColumn(tb_res, 1, "SEC", true, QTABLE_CACHED_STRING_TYPE , 15)
ac_res = AddColumn(tb_res, 2, "CLASS", true, QTABLE_CACHED_STRING_TYPE , 12)
ac_res = AddColumn(tb_res, 3, "Name", true, QTABLE_CACHED_STRING_TYPE, 20)
ac_res = AddColumn(tb_res, 4, "Curr_lose", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 5, "Res_min", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 6, "Res_max", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 7, "RES %", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 8, "ma_per", true, QTABLE_CACHED_STRING_TYPE, 10)
ac_res = AddColumn(tb_res, 9, "curr_cand", true, QTABLE_CACHED_STRING_TYPE, 10)
ac_res = AddColumn(tb_res, 10, "Date", true, QTABLE_CACHED_STRING_TYPE, 15)

-- ac_res = AddColumn(tb_res, 4, "PDI", true, QTABLE_CACHED_STRING_TYPE, 10)
-- ac_res = AddColumn(tb_res, 5, "MDI", true, QTABLE_CACHED_STRING_TYPE, 10)
-- ac_res = AddColumn(tb_res, 6, "Price", true, QTABLE_CACHED_STRING_TYPE, 12)
-- ac_res = AddColumn(tb_res, 7, "RES %", true, QTABLE_CACHED_STRING_TYPE, 12)
-- ac_res = AddColumn(tb_res, 8, "DEAL", true, QTABLE_CACHED_STRING_TYPE, 8) 
-- ac_res = AddColumn(tb_res, 9, "pmin", true, QTABLE_CACHED_STRING_TYPE, 10)
-- ac_res = AddColumn(tb_res, 10, "pmax", true, QTABLE_CACHED_STRING_TYPE, 10)
-- ac_res = AddColumn(tb_res, 11, "mmin", true, QTABLE_CACHED_STRING_TYPE, 10)
-- ac_res = AddColumn(tb_res, 12, "mmax", true, QTABLE_CACHED_STRING_TYPE, 10)

CreateWindow(tb_res)
	SetWindowCaption(tb_res, "RESULT "..vers.." "..EXCH.." M"..time_interval)
	ds = {}
	for i, SEC in pairs(sec_list) do
		ds[SEC] = {}
		ds0, error_desc = CreateDataSource(CLASS, SEC, time_interval) 
		sleep(100)
		if ds0 == nil then
			message(SEC.." error in CreateDataSource: "..error_desc, 2)
			sec_list[i] = nil
			filer:write(SEC.." 1 error: "..error_desc, '\n')
		else
			ds[SEC] = ds0
			if ds[SEC]:Size() == 0 then 
				ds[SEC]:SetEmptyCallback()
				sleep(500)
				--message(SEC.." ds:Size() == "..ds:Size(), 2)
			end
		end
	end
	dt = getTradeDate().date
 	tm = os.sysdate().hour * 100 + os.sysdate().min
	sl = {}
	sl_len = 0
	for row, SEC in pairs(sec_list) do
		sleep(100)
		if Subscribe_Level_II_Quotes(CLASS, SEC) then
			SetCell(tb_res, row, 7, string.format("%.1f", last_deal[SEC][4]))
			sl_len = sl_len + 1
			sl[sl_len] = SEC
		else
			message("Bad SEC="..SEC, 2)
		end
	end
	sec_list = sl
	for i, SEC in pairs(sec_list) do
		MA[SEC] = best_ma_per(SEC, idx, ds, tb_res, max_ma_per)		-- SetCell(tb_res, row, 9, string.format('%.2f', pmin))
		-- SetCell(tb_res, row, 10, string.format('%.2f', pmax))
		-- SetCell(tb_res, row, 11, string.format('%.2f', mmin))
		-- SetCell(tb_res, row, 12, string.format('%.2f', mmax)) 
	end

	--message(class_list, 1)
	-- mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal 
	-- message("mpos= "..mpos.." "..currency, 1)
		last_row = InsertRow( tb_res, -1)
		message(tostring(sec_list))
		sleep(1000)
		-- total(sec_list, last_deal, ds)
	
	while is_run do
		sleep(100)
		if os.sysdate().min ~= tm_minute then
			-- total(sec_list, last_deal, ds)
			tm_minute = os.sysdate().min
					dvl_sum = 0
			for row, SEC in pairs(sec_list) do
				pct=set_sell_neg(tb_res, row, SEC, last_deal)
				dvl_sum = dvl_sum + pct
			end
			SetCell(tb_res, last_row, 7,  string.format('%.2f', dvl_sum/#sec_list))
			-- message("sum="..dvl_sum, 1)
		end
		while tm >= stime and tm < etime do
			tm = os.sysdate().hour * 100 + os.sysdate().min
			sleep(1000)
		end
			
		for row, SEC in pairs(sec_list) do
			sleep(100)
			idx=ds[SEC]:Size()
			if idx ~= MA[SEC][1]  then
				MA[SEC] = best_ma_per(SEC, idx, ds, tb_res, max_ma_per)		-- SetCell(tb_res, row, 9, string.format('%.2f', pmin))
				adx, pdi, mdi = psdf(j, ds, SEC, MA[SEC][2], MA[SEC][3], MA[SEC][4], MA[SEC][5])
				ld_1 = ld
				if adx > MA[SEC][2] then
					if pdi > MA[SEC][4] then
						ld = 1
					elseif mdi > MA[SEC][6] then
						ld = -dub_up
					end
				end
		-- MA[SEC] = {idx, adx, pdi, mdi, ma_per, ld}
		
				if ld ~= ld_1 then
					prc = ds[SEC]:C(idx-1)
					res = pos + ld_1 * prc
					pos = pos - (ld-ld_1) * prc - math.abs(ld-ld_1) * comis * prc
					last_deal[SEC][1] = ld -- last_deal
					last_deal[SEC][2] = res -- result
					last_deal[SEC][3] = pos -- position
					last_deal[SEC][4] = res/ds[SEC]:C(idx+last_candle) -- res percent
					last_deal[SEC][5] = prc -- last price
					-- last_deal[SEC][6] =  -- open position in lots
					
					c_date = ds[SEC]:T(idx-1).year*10000+ds[SEC]:T(idx-1).month*100+ds[SEC]:T(idx-1).day
					prc = ds[SEC]:C(idx-1)
					chart_tag = SEC
					if ld == 1 then
						Blabel["YVALUE"]=prc
						Blabel["DATE"]=c_date
						Blabel["TIME"]=ds[SEC]:T(idx-1).hour*10000+ds[SEC]:T(idx-1).min*100
						Blabel["HINT"]=string.format('%.2f', res)
						AddLabel(chart_tag, Blabel)
					elseif ld == -1 then
						Slabel["YVALUE"]=prc
						Slabel["DATE"]=c_date
						Slabel["TIME"]=ds[SEC]:T(idx-1).hour*10000+ds[SEC]:T(idx-1).min*100
						Slabel["HINT"]=string.format('%.2f',res)
						AddLabel(chart_tag, Slabel)
					else
						STOPlabel["YVALUE"]=prc
						STOPlabel["DATE"]=c_date
						STOPlabel["TIME"]=ds[SEC]:T(idx-1).hour*10000+ds[SEC]:T(idx-1).min*100
						STOPlabel["HINT"]=string.format('%.2f',res)
						AddLabel(chart_tag, STOPlabel)
					end
				end
				prints(sec_list, last_deal)
			end
			
-- last_deal[SEC][1] - last_deal
-- last_deal[SEC][2] - result
-- last_deal[SEC][3] - position
-- last_deal[SEC][4] - res percent
-- last_deal[SEC][5] - last price
-- last_deal[SEC][6] - open position in lots
			
			
			
				-- SetCell(tb_res, row, 9, string.format('%.2f', MA[SEC][8]))
				-- SetCell(tb_res, row, 10, string.format('%.2f', MA[SEC][9]))
				-- SetCell(tb_res, row, 11, string.format('%.2f', MA[SEC][10]))
				-- SetCell(tb_res, row, 12, string.format('%.2f', MA[SEC][11]))
			

		end
		tm = os.sysdate().hour * 100 + os.sysdate().min
		if tm >= end_time then
			if not IsWindowClosed(tb_res) then
				DestroyTable(tb_res)
			end
			for i, SEC in pairs(sec_list) do
					if ds[SEC] then
						ds[SEC]:Close()
					end
				if IsSubscribed_Level_II_Quotes(CLASS, SEC) then
					Unsubscribe_Level_II_Quotes(CLASS, SEC)
				end
			end
			filer:write("Stop: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')
			filer:write("Stop: summary result = "..string.format('%.2f', dvl_sum/#sec_list).." %", '\n')
			filer:close()
			is_run = false
			break
		end
	end
end
--  ============================================
function best_ma_per(SEC, idx, ds, tb_res, max_ma_per)
	res_table = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}}
	res_sec_max = 0
	curr_sec_min = -1
	div_res_curr = 0
	row = InsertRow( tb_res, -1)
	first_candle = idx - length_candles
	local MA = {0,0,0,0,0,0}
	for ma_per=2, max_ma_per do
		-- message("Table SEC="..SEC.." ma_per="..ma_per, 1)
		pdi = 0
		mdi = 0
		adx = 0
		-- message(SEC.." ds[SEC]:Size() == "..idx, 1)
		pos = 0
		res = 0
		ld = 0
		res_min = 0
		res_max = 0
		curr_min = 0
		for j=first_candle,idx-1 do
			pdi_1 = pdi
			mdi_1 = mdi
			adx_1 = adx
			adx, pdi, mdi = psdf(j, ds, SEC, adx_1, pdi_1, mdi_1, ma_per)
			ld_1 = ld
			if adx > adx_1 then
				if pdi > pdi_1 then
					ld = 1
				elseif mdi > mdi_1 then
					ld = -dub_up
				end
			end
	
			if ld ~= ld_1 then
				prc = ds[SEC]:C(j)
				res = pos + ld_1 * prc
				pos = pos - (ld-ld_1) * prc - math.abs(ld-ld_1) * comis * prc
			end
			if res_min > res then
				res_min = res
			end
			if res_max < res then
				res_max = res
			end
			if res_max ~= -ds[SEC]:C(first_candle) then
				if curr_min > (res-res_max)/(res_max + ds[SEC]:C(first_candle)) then
					curr_min = (res-res_max)/(res_max + ds[SEC]:C(first_candle))
					tmcm = ds[SEC]:T(j).year*10000+ds[SEC]:T(j).month*100+ds[SEC]:T(j).day
				end
			end
		end	
		if res > res_sec_max then 
			res_sec_max = res
			res_table[1] = {curr_min, res_min, res_max, res*100/ds[SEC]:O(first_candle), ma_per, ld}
		end
		
		if curr_sec_min < curr_min then
			curr_sec_min = curr_min
			res_table[2] = {curr_min, res_min, res_max, res*100/ds[SEC]:O(first_candle), ma_per, ld}
		end
			
		if div_res_curr < -res/curr_min then
			div_res_curr = -res/curr_min
			res_table[3] = {curr_min, res_min, res_max, res*100/ds[SEC]:O(first_candle), ma_per, ld}
			-- MA = {adx, adx_1, pdi, pdi_1, mdi, mdi_1}
		end
	end

	MA = {idx, adx, pdi, mdi, res_table[res_variant][5], res_table[res_variant][6]}
	return MA
--  ============================================
function psdf(j, ds, SEC, adx0, pdi0, mdi0, ma_per)
	pdm = math.max(0, ds[SEC]:H(j) - ds[SEC]:H(j-1))
	mdm = math.max(0, ds[SEC]:L(j-1) - ds[SEC]:L(j))
	if pdm > mdm then
		mdm = 0
	elseif mdm > pdm then
		pdm = 0
	else
		pdm = 0
		mdm = 0
	end
	tr = math.max(ds[SEC]:H(j), ds[SEC]:C(j-1)) - math.min(ds[SEC]:L(j),ds[SEC]:C(j-1))
	if tr ~= 0 then
		psd = 100*pdm/tr
		msd = 100*mdm/tr
	else
		psd = 0
		msd = 0
	end
	pdi = ((ma_per-1)*pdi0+2*psd)/(ma_per+1)
	mdi = ((ma_per-1)*mdi0+2*msd)/(ma_per+1)
	if (pdi+mdi) ~= 0 then
		dx = 100*math.abs(pdi-mdi)/(pdi+mdi)
	else
		dx = 0
	end
	adx = ((ma_per-1)*adx0+2*dx)/(ma_per+1)
	
	return adx, pdi, mdi
end
--  ============================================
function prints(sec_list, last_deal)
	filer2=io.open(data_file_name, "w")
	for i, SEC in pairs(sec_list) do
		filer2:write("sec_"..SEC)
		filer2:write(" ld_"..last_deal[SEC][1])
		filer2:write(" res_"..last_deal[SEC][2])
		filer2:write(" pos_"..last_deal[SEC][3])
		filer2:write(" pospct_"..last_deal[SEC][4])
		filer2:write(" prc_"..last_deal[SEC][5])
		filer2:write(" openpos_"..last_deal[SEC][6])
		filer2:write('\n')
	end
	filer2:close()
end
--  ============================================

function OnStop(s)
	filer:write("Stop: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')
	filer:write("Stop: summary result = "..string.format('%.2f', dvl_sum/#sec_list).." %", '\n')
	filer:close()
	if not IsWindowClosed(tb_res) then
		DestroyTable(tb_res)
	end
	for i, SEC in pairs(sec_list) do
			if ds[SEC] then
				ds[SEC]:Close()
			end
		if IsSubscribed_Level_II_Quotes(CLASS, SEC) then
			Unsubscribe_Level_II_Quotes(CLASS, SEC)
		end
	end
	is_run = false
end
--  ============================================
