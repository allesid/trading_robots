
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

CLASS="CETS"
TRADE_ACC   = "MB0094600602"   -- торговый счет
CLIENT_CODE = "65425"          -- код клиента
FIRM_ID="MC0094600000"

-- CLASS="TQBR"
-- TRADE_ACC   = "L01-00000F00"   -- торговый счет
-- CLIENT_CODE = "54174"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="SPBFUT"
-- TRADE_ACC   = "1500c6h"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="SPBFUT"

-- dub_up = 1  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
path_name = "C:/QuikKITFinance/data/ADX/CETS/"
vers = "v33dub-var-TEST"
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
	stime = 1838
	etime = 1906
	dub_up = 1  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "L01-00000F00"   -- торговый счет
	CLIENT_CODE = "54174"          -- код клиента
	FIRM_ID="MC0094600000"
elseif CLASS =="CETS_MTL" then
	EXCH = "GOLD" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_([%w_]+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 700
	end_time = 1839
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "MB0094600602"   -- торговый счет
	CLIENT_CODE = "65425"          -- код клиента
	FIRM_ID="MC0094600000"
elseif CLASS == "TQTF" then
	EXCH = "MOEX-ETF" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 1000
	end_time = 2349
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "L01-00000F00"   -- торговый счет
	CLIENT_CODE = "54174"          -- код клиента
	FIRM_ID="MC0094600000"
elseif CLASS == "SPBFUT" then
	EXCH = "FUTUR" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%w+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 0 --900 --SPBFUT 
	end_time = 2349 --SPBFUT 
	stime = 1850
	etime = 1905
	dub_up = 1  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "1500c6h"   -- торговый счет
	CLIENT_CODE = "65425"          -- код клиента
	FIRM_ID="SPBFUT"
elseif CLASS == "CETS" then
	EXCH = "CURR" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_([%w_]+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 700 --CETS
	end_time = 1859 --CETS
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "MB0094600602"   -- торговый счет
	CLIENT_CODE = "65425"          -- код клиента
	FIRM_ID="MC0094600000"
elseif CLASS == "SPBXM" then
	EXCH = "SPBEX" -- "SPBDE" -- "MOEX-SEC" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+)" -- "sec_(%a+_NY)" -- 
	start_time =  0 -- 1200
	end_time = 2500
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "CITFS00003"   -- торговый счет
	CLIENT_CODE = "65425"          -- код клиента
	FIRM_ID="MC0094600000"
elseif CLASS == "SPBDE" then
	EXCH = "SPBDE" -- "SPBEX" -- "MOEX-SEC" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%w+@DE_XM)" -- "sec_(%a+_XM)" -- "sec_(%a+)" -- "sec_(%a+_NY)" -- 
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
	TRADE_ACC   = "CITFS00003"   -- торговый счет
	CLIENT_CODE = "65425"          -- код клиента
	FIRM_ID="MC0094600000"
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
comis = 0.0
len_SEC = 0
sec_list = {}
last_deal = {} -- [SEC][DEAL_variant]{last_deal, res, pos}
MA = {} -- [SEC]
qt = {}
end_of_name = vers.."-"..EXCH.."-M"..time_interval..".txt"
-- data_file_name = path_name.."data-ADX-"..end_of_name
data_file_name = path_name.."CETS_instruments.txt"
result_file_name = path_name.."Result-ADX-"..end_of_name

-- ma_per = 14
price_format = '%.4f'
 is_run = true
tm_minute = 0
glob_sum_res = 0
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



--  ============================================
function OnInit(s)
end
--  ============================================

function main()
	tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	-- message("Start cycle tm= "..tm.." "..end_of_name, 1)
	-- message("Start time = "..start_time, 1)
	filer1=io.open(data_file_name, "r")
	--message("1 "..tostring(filer1))
	
-- last_deal[SEC][1] - last_deal
-- last_deal[SEC][2] - result
-- last_deal[SEC][3] - position
-- last_deal[SEC][4] - res percent
-- last_deal[SEC][5] - last price

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
				else
					SEC = str
					sec_list[len_SEC] = SEC
						last_deal[SEC] = {}
						last_deal[SEC][1] = 0
						last_deal[SEC][2] = 0
						last_deal[SEC][3] = 0
						last_deal[SEC][4] = 0
						last_deal[SEC][5] = 0   -- 
				end
				-- message(SEC, 1)
				str = filer1:read("*l")
			end
			message("Load vers: "..vers, 1)
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
			end
		end
		message(SEC.." ds[SEC]:Size() == "..ds[SEC]:Size(), 2)
	end
	dt = getTradeDate().date
 	tm = os.sysdate().hour * 100 + os.sysdate().min
	sl = {}
	sl_len = 0
	for row, SEC in pairs(sec_list) do
		sleep(100)
		if Subscribe_Level_II_Quotes(CLASS, SEC) then
			-- SetCell(tb_res, row, 8, string.format("%.0f", last_deal[SEC][1]))
			-- SetCell(tb_res, row, 7, string.format("%.1f", last_deal[SEC][4]))
			sl_len = sl_len + 1
			sl[sl_len] = SEC
		else
			message("Bad SEC="..SEC, 2)
		end
	end
	sec_list = sl
	for c, SEC in pairs(sec_list) do
		chart_tag = SEC
		DelAllLabels(chart_tag)
		res_table = {{0,0,0,0,0,0},{0,0,0,0,0,0},{0,0,0,0,0,0}}
		res_sec_max = 0
		curr_sec_min = -1
		div_res_curr = 0
		glob_ld = 0
		glob_res = 0
		glob_pos = 0
		glob_res_min = 0
		glob_res_max = 0
		glob_curr_min = 0
		idx=ds[SEC]:Size()
		MA = {0,0,0,0,0,0}
		lc = idx+last_candle
		row = InsertRow( tb_res, -1)
		curr_ma_per = 250
		for i0 = lc, idx do
			for ma_per=2,max_ma_per do
				-- message("Table SEC="..SEC.." ma_per="..ma_per, 1)
				pdi = 0
				mdi = 0
				adx = 0
				first_candle = i0 - length_candles
				-- message(SEC.." ds[SEC]:Size() == "..idx, 1)
				pos = 0
				res = 0
				ld = 0
				res_min = 0
				res_max = 0
				curr_min = 0
				for j=first_candle,i0 do
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
				
			-- for n = 1,3 do
			SetCell(tb_res, row, 1, SEC)
			SetCell(tb_res, row, 2, CLASS)
			SetCell(tb_res, row, 3, "i0="..tostring(i0))
			SetCell(tb_res, row, 4, string.format(price_format, res_table[res_variant][1]))
			SetCell(tb_res, row, 5, string.format(price_format, res_table[res_variant][2]))
			SetCell(tb_res, row, 6, string.format(price_format, res_table[res_variant][3]))
			SetCell(tb_res, row, 7, string.format(price_format,res_table[res_variant][4]))
			SetCell(tb_res, row, 8, string.format('%.0f', res_table[res_variant][5]))
			SetCell(tb_res, row, 9, "ld="..tostring(res_table[res_variant][6]))
			-- SetCell(tb_res, row, 10, "adx="..tostring())
			-- end
			glob_ld_1 = glob_ld

			-- if res_table[res_variant][5] >= ma_per_level then
				-- if dub_up == 1 then
					-- glob_ld = -res_table[res_variant][6]
				-- else
					-- if res_table[res_variant][6] == 0 then
						-- glob_ld = 1
					-- else
						-- glob_ld = 0
					-- end
				-- end
			-- else
				glob_ld = res_table[res_variant][6]  --res_variant
			-- end
			-- curr_ma_per = res_table[res_variant][5]
		
			if glob_ld_1 ~= glob_ld then
				c_date = ds[SEC]:T(i0).year*10000+ds[SEC]:T(i0).month*100+ds[SEC]:T(i0).day
				-- row = InsertRow( tb_res, -1)
				-- SetCell(tb_res, row, 1, SEC)
				-- SetCell(tb_res, row, 2, CLASS)
				-- SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name )
				-- SetCell(tb_res, row, 4, string.format(price_format, res_table[res_variant][1]))
				-- SetCell(tb_res, row, 5, string.format(price_format, res_table[res_variant][2]))
				-- SetCell(tb_res, row, 6, string.format(price_format, res_table[res_variant][3]))
				-- SetCell(tb_res, row, 7, string.format(price_format,res_table[res_variant][4]))
				-- SetCell(tb_res, row, 8, string.format('%.0f', res_table[res_variant][5]))
				-- SetCell(tb_res, row, 10, tostring(c_date))
			
			
				prc = ds[SEC]:C(i0)
				glob_res = glob_pos + glob_ld_1 * prc
				glob_pos = glob_pos - (glob_ld-glob_ld_1) * prc - math.abs(glob_ld-glob_ld_1) * comis * prc
				if glob_res_min > glob_res then
					glob_res_min = glob_res
				end
				if glob_res_max < glob_res then
					glob_res_max = glob_res
				end
				if glob_res_max ~= -ds[SEC]:C(first_candle) then
					if glob_curr_min > (glob_res-glob_res_max)/(glob_res_max + ds[SEC]:C(first_candle)) then
						glob_curr_min = (glob_res-glob_res_max)/(glob_res_max + ds[SEC]:C(first_candle))
						tmcm = ds[SEC]:T(i0).year*10000+ds[SEC]:T(i0).month*100+ds[SEC]:T(i0).day
					end
				end
				if glob_ld == 1 then
					Blabel["YVALUE"]=prc
					Blabel["DATE"]=c_date
					Blabel["TIME"]=ds[SEC]:T(i0).hour*10000+ds[SEC]:T(i0).min*100
					Blabel["HINT"]=string.format('%.2f',glob_res)
					AddLabel(chart_tag, Blabel)
				elseif glob_ld == -1 then
					Slabel["YVALUE"]=prc
					Slabel["DATE"]=c_date
					Slabel["TIME"]=ds[SEC]:T(i0).hour*10000+ds[SEC]:T(i0).min*100
					Slabel["HINT"]=string.format('%.2f',glob_res)
					AddLabel(chart_tag, Slabel)
				else
					STOPlabel["YVALUE"]=prc
					STOPlabel["DATE"]=c_date
					STOPlabel["TIME"]=ds[SEC]:T(i0).hour*10000+ds[SEC]:T(i0).min*100
					STOPlabel["HINT"]=string.format('%.2f',glob_res)
					AddLabel(chart_tag, STOPlabel)
				end
				SetCell(tb_res, row, 1, SEC)
				SetCell(tb_res, row, 2, CLASS)
				SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name )
				SetCell(tb_res, row, 4, string.format(price_format, glob_curr_min))
				SetCell(tb_res, row, 5, string.format(price_format, glob_res_min))
				SetCell(tb_res, row, 6, string.format(price_format, glob_res_max))
				SetCell(tb_res, row, 7, string.format(price_format, glob_res*100/ds[SEC]:C(first_candle)))
				SetCell(tb_res, row, 8, tostring(res_table[res_variant][5]))
				SetCell(tb_res, row, 9, tostring(i0))
				SetCell(tb_res, row, 10, tostring(c_date))
				row = InsertRow( tb_res, -1)
			end
		end   -- for i0 = ls, idx then
		if glob_ld ~= 0 then
			glob_res = glob_pos + glob_ld * ds[SEC]:C(idx)
		end
		if glob_res_min > glob_res then
			glob_res_min = glob_res
		end
		if glob_res_max < glob_res then
			glob_res_max = glob_res
		end
		if glob_res_max ~= -ds[SEC]:C(lc) then
			if glob_curr_min > (glob_res-glob_res_max)/(glob_res_max + ds[SEC]:C(lc)) then
				glob_curr_min = (glob_res-glob_res_max)/(glob_res_max + ds[SEC]:C(lc))
			end
		end

		SetCell(tb_res, row, 1, SEC)
		SetCell(tb_res, row, 2, CLASS)
		SetCell(tb_res, row, 3, "GLOB" )
		SetCell(tb_res, row, 4, string.format(price_format, glob_curr_min))
		SetCell(tb_res, row, 5, string.format(price_format, glob_res_min))
		SetCell(tb_res, row, 6, string.format(price_format, glob_res_max))
		SetCell(tb_res, row, 7, string.format(price_format, glob_res*100/ds[SEC]:C(lc)))
		row = InsertRow( tb_res, -1)
		-- c_date = ds[SEC]:T(i0).year*10000+ds[SEC]:T(i0).month*100+ds[SEC]:T(i0).day
		-- SetCell(tb_res, row, 10, tostring(c_date))
		
		
			-- MA[SEC] = {idx, pdi, mdi, pdi_1, mdi_1, adx, adx_1}
		-- message("SEC="..SEC.." adx="..tostring(adx).." pdi="..tostring(pdi).." mdi="..tostring(mdi), 1)
			-- message("SEC="..SEC.." adx_1="..tostring(adx_1).." pdi_1="..tostring(pdi_1).." mdi_1="..tostring(mdi_1), 1)
		filer:write("SEC============ "..SEC, '\n')
		filer:write("data0="..tostring(ds[SEC]:T(lc).year*10000+ds[SEC]:T(lc).month*100+ds[SEC]:T(lc).day), '\n')
		filer:write("data_last="..tostring(ds[SEC]:T(idx).year*10000+ds[SEC]:T(idx).month*100+ds[SEC]:T(idx).day), '\n')
		filer:write("income percent="..tostring(glob_res*100/ds[SEC]:C(lc)), '\n')
		message("income percent="..tostring(glob_res*100/ds[SEC]:C(lc)), 1)
		filer:write("lc="..lc, '\n')
		filer:write(" r_min="..glob_res_min.." c_min="..glob_curr_min.." r_max="..glob_res_max, '\n')
		message(" r_min="..glob_res_min.." c_min="..glob_curr_min.." r_max="..glob_res_max, 1)	
		glob_sum_res = glob_sum_res + glob_res*100/ds[SEC]:C(lc)

	end   -- for c, SEC in pairs(sec_list) do
	row = InsertRow( tb_res, -1)
	SetCell(tb_res, row, 1, SEC)
	SetCell(tb_res, row, 2, CLASS)
	SetCell(tb_res, row, 3, "SUMMA % = " )
	SetCell(tb_res, row, 4, string.format(price_format, glob_sum_res))
	filer:write("-----------------------------", '\n')
	filer:write("glob_sum_res="..glob_sum_res, '\n')
	filer:write("=============================", '\n')
	filer:close()
end
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
function last_deal_aver(last_deal, sec_list, tb_res, last_row)
	last_deal_sum = 0
	for i, SEC in pairs(sec_list) do
		last_deal_sum = last_deal_sum + last_deal[SEC][1]
	end
	lds = last_deal_sum / #sec_list
	SetCell(tb_res, last_row, 8, string.format("%.2f", lds))
end
--  ============================================
function position_null(SEC, last_deal)
	qt = getQuoteLevel2(CLASS, SEC)
	if last_deal[SEC][1] > 0 then
		prc = tonumber(qt.bid[qt.bid_count-0].price)
	end
	if last_deal[SEC][1] < 0 then
		prc = tonumber(qt.offer[1].price)
	end
	res = last_deal[SEC][3]+(last_deal[SEC][1])*prc
	if last_deal[SEC][5] ~= 0 then
		last_deal[SEC][4] = last_deal[SEC][4] + (res - last_deal[SEC][2])*100/last_deal[SEC][5]
	end
	ld = 0
	last_deal[SEC][3]=last_deal[SEC][3]-(ld-last_deal[SEC][1])*prc-math.abs(ld-last_deal[SEC][1])*comis*prc
	last_deal[SEC][1] = ld
	last_deal[SEC][2] = res
	last_deal[SEC][5] = 0
	return last_deal
end
--  ============================================
function position_up(SEC, last_deal, ldnums)
	qt = getQuoteLevel2(CLASS, SEC)
	if qt and qt.offer and tonumber(qt.offer_count) ~= 0 then
		ofS = tonumber(qt.offer[1].price)
		res = last_deal[SEC][3]+(last_deal[SEC][1])*ofS
		if last_deal[SEC][5] ~= 0 then
			last_deal[SEC][4] = last_deal[SEC][4] + (res - last_deal[SEC][2])*100/last_deal[SEC][5]
		end
		ld = ldnums
		last_deal[SEC][3]=last_deal[SEC][3]-(ld-last_deal[SEC][1])*ofS-math.abs(ld-last_deal[SEC][1])*comis*ofS
		last_deal[SEC][1] = ld
		last_deal[SEC][2] = res
		last_deal[SEC][5] = ofS
	end
	return last_deal
end
--  ============================================
function position_dn(SEC, last_deal, ldnums)
	qt = getQuoteLevel2(CLASS, SEC)
	if qt and qt.bid and tonumber(qt.bid_count) ~= 0 then
		bidS = tonumber(qt.bid[qt.bid_count-0].price)
		res = last_deal[SEC][3]+(last_deal[SEC][1])*bidS
		if last_deal[SEC][5] ~= 0 then
			last_deal[SEC][4] = last_deal[SEC][4] + (res - last_deal[SEC][2])*100/last_deal[SEC][5]
		end
		ld = -dub_up * ldnums
		last_deal[SEC][3]=last_deal[SEC][3]-(ld-last_deal[SEC][1])*bidS-math.abs(ld-last_deal[SEC][1])*comis*bidS
		last_deal[SEC][1] = ld
		last_deal[SEC][2] = res
		last_deal[SEC][5] = bidS * dub_up
	end
	return last_deal
end
--  ============================================
function set_sell_neg(tb_res, row, SEC, last_deal)
	-- message(SEC.." "..vers, 1)
	SetCell(tb_res, row, 8, string.format("%.0f", last_deal[SEC][1]))
	-- SCALE=getSecurityInfo(CLASS, SEC).scale
	-- price_format = '%.'..tostring(SCALE)..'f'
	price_format = '%.2f'
	percent = tonumber(last_deal[SEC][4])
	if last_deal[SEC][5] > 0 then
		idx=ds[SEC]:Size()
		percent = percent +(last_deal[SEC][3]+last_deal[SEC][1]*ds[SEC]:C(idx)-last_deal[SEC][2])*100/last_deal[SEC][5]
	end
	SetCell(tb_res, row, 7, string.format(price_format, percent))
	if percent > 0 then
		SetColor(tb_res, row, 7, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
	elseif percent < 0 then
		SetColor(tb_res, row, 7, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
	else
		SetColor(tb_res, row, 7, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
	end
	return percent
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
		filer2:write('\n')
	end
	filer2:close()
end
--  ============================================

function OnStop(s)
	-- if not IsWindowClosed(tb_res) then
		-- DestroyTable(tb_res)
	-- end
	for i, SEC in pairs(sec_list) do
			if ds[SEC] then
				ds[SEC]:Close()
			end
		if IsSubscribed_Level_II_Quotes(CLASS, SEC) then
			Unsubscribe_Level_II_Quotes(CLASS, SEC)
		end
	end
	-- filer:write("Stop: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')
	-- filer:write("Stop: summary result = "..string.format('%.2f', dvl_sum/#sec_list).." %", '\n')
	filer:close()
	is_run = false
end
--  ============================================
