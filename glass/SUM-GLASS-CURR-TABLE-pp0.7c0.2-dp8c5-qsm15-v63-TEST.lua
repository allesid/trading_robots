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

-- CLASS="CETS_MTL"
-- TRADE_ACC   = "MB0094600602"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="MC0094600000"

path_name = "C:/Projects/trading_robots/glass/results/"
qsummax = 20
dpart = 8 --коэффициент превышения суммы объема бид и оффер для сделки открытия позиции
-- например: сумма бидов умноженная на dpart > суммы офферов - покупка
dpartc = 5 -- то же для сделки закрытия позиции
qstep_min = 15
price_part = 0.7 -- цена выставления ордера между средним (бид и оффер) и бид/оффер макс в интервале [0.0-1.0]
price_partc = 0.2 -- то же для сделки закрытия позиции
ver = "v63-TEST" -- "WORK"
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
elseif CLASS =="CETS_MTL" then
	EXCH = "GOLD" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_([%w_]+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 700
	end_time = 1839
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
elseif CLASS == "TQTF" then
	EXCH = "MOEX-ETF" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 1000
	end_time = 2349
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
elseif CLASS == "SPBFUT" then
	EXCH = "FUTUR" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%w+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 0 --900 --SPBFUT 
	end_time = 2349 --SPBFUT 
	stime = 1850
	etime = 1905
	dub_up = 1  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
elseif CLASS == "CETS" then
	EXCH = "CURR" -- "SPBEX" -- "SPBDE" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_([%w_]+)" -- "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+_NY)" -- 
	start_time = 700 --CETS
	end_time = 1859 --CETS
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
elseif CLASS == "SPBXM" then
	EXCH = "SPBEX" -- "SPBDE" -- "MOEX-SEC" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%a+_XM)" -- "sec_(%w+@DE_XM)" -- "sec_(%a+)" -- "sec_(%a+_NY)" -- 
	start_time =  0 -- 1200
	end_time = 2500
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
elseif CLASS == "SPBDE" then
	EXCH = "SPBDE" -- "SPBEX" -- "MOEX-SEC" -- "NYSE" -- "NASDAQ" -- "MOEX-ETF" -- 
	sec_pattern = "sec_(%w+@DE_XM)" -- "sec_(%a+_XM)" -- "sec_(%a+)" -- "sec_(%a+_NY)" -- 
	dub_up = 0  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
else
	message("CLASS not found", 3)
	is_run = false
	return
end
instr_file_name = CLASS.."_instruments.txt"
-- time_interval = INTERVAL_H1
	-- money_limit=205
	-- currency = "SUR" -- "USD" --
	-- position_code= "EQTV" -- "GLSP" --
ld_pattern = "ld_(%-?%d)"
res_pattern = "res_(%-?%d+[.]?%d*)"
pos_pattern = "pos_(%-?%d+[.]?%d*)"
pospct_pattern = "pospct_(%-?%d+[.]?%d*)"
prc_pattern = "prc_(%-?%d+[.]?%d*)"
comis = 0.0005
sec_list = {}
last_deal = {} -- [vers num][SEC][DEAL_variant]{last_deal, res, pos}
qt = {}
filer = nil
prc_bid = 0
prc_off = 0
ma_per = 5
price_format = '%.4f'
 is_run = true
tm_minute = 0
data_file_name = ""
dt = getTradeDate().date
tm = os.sysdate().hour * 100 + os.sysdate().min * 1
meanhl = {}
result_file_name = ""
imax = {}
ss_last_deal = {}
i_last_deal = {}


function OnInit(s)
end
--  ============================================

function main()
	-- message("Start cycle tm= "..tm.." "..end_of_name, 1)
	-- message("Start time = "..start_time, 1)
	--message("1 "..tostring(filer1))
	
-- last_deal[][SEC][1] - last_deal = open position in lots [+-0]
-- last_deal[][SEC][2] - result
-- last_deal[][SEC][3] - position sum
-- last_deal[][SEC][4] - res percent
-- last_deal[][SEC][5] - last deal price [+-0]
-- last_deal[][SEC][6] - last order price [+-0]
	filer0=io.open(instr_file_name, "r")

	if filer0 == nil then
		filer0=io.open(instr_file_name, "w")
		message("Insert sequrities to data file: "..instr_file_name,3)
		filer0:close()
		return
	end
		end_of_name = EXCH.."-M".."-pp"..tostring(price_part).."c"..tostring(price_partc).."-dp"..tostring(dpart).."c"..tostring(dpartc).."-qsm"..tostring(qstep_min).."-"..ver..".txt"
		data_file_name = path_name.."data-GLASS-"..end_of_name
		result_file_name = path_name.."Result-GLASS-"..end_of_name

		filer1=io.open(data_file_name, "r")

		if filer1 == nil then
			filer1=io.open(data_file_name, "w")
			filer0:seek("set")
			str = filer0:read("*l")
			message("Inserting sequrities to data file: "..data_file_name,2)
			while str do
				filer1:write(str,'\n')
				str = filer0:read("*l")
			end
			filer1:close()
			sleep(500)
			filer1=io.open(data_file_name, "r")
		end
			--message("2 "..tostring(filer1))
		last_deal = {}
		str = filer1:read("*l")
		if str then
			len_SEC = 0
			while str do
			-- message("3 "..tostring(str))
			-- message(str)
					--message(SEC, 1)
				len_SEC = len_SEC + 1
				SEC = string.match(str, sec_pattern)
				if SEC then
					sec_list[len_SEC] = SEC
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
				last_deal[SEC][6] = 0
				str = filer1:read("*l")
			message(" SEC= "..tostring(SEC), 1)
			end
			message("len_SEC= "..tostring(len_SEC), 1)
		else
			message("No input data ", 1)
		end
		filer1:close()
		prints(sec_list, last_deal)
		filer=io.open(result_file_name, "a")
		filer:write("=========================================", '\n')
		filer:write("Start: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')
	filer0:close()

tb_res = AllocTable()
ac_res = AddColumn(tb_res, 1, "SEC", true, QTABLE_CACHED_STRING_TYPE , 8)
ac_res = AddColumn(tb_res, 2, "CLASS", true, QTABLE_CACHED_STRING_TYPE , 10)
ac_res = AddColumn(tb_res, 3, "Name", true, QTABLE_CACHED_STRING_TYPE, 17)
ac_res = AddColumn(tb_res, 4, "spred", true, QTABLE_CACHED_STRING_TYPE, 10)
ac_res = AddColumn(tb_res, 5, "# qstep", true, QTABLE_CACHED_STRING_TYPE, 10)
ac_res = AddColumn(tb_res, 6, "orderPrice", true, QTABLE_CACHED_STRING_TYPE, 10)
ac_res = AddColumn(tb_res, 7, "RES %", true, QTABLE_CACHED_STRING_TYPE, 10)
ac_res = AddColumn(tb_res, 8, "DEAL", true, QTABLE_CACHED_STRING_TYPE, 10) 
-- for i=1,qsummax do 
	-- ac_res = AddColumn(tb_res, 7, tostring(i).." RES %", true, QTABLE_CACHED_STRING_TYPE, 10)
	-- ac_res = AddColumn(tb_res, 8, tostring(i).." DEAL", true, QTABLE_CACHED_STRING_TYPE, 6) 
-- end
CreateWindow(tb_res)
	SetWindowCaption(tb_res, "RESULT mult".." "..EXCH.."-pp"..tostring(price_part).."c"..tostring(price_partc).."-dp"..tostring(dpart).."c"..tostring(dpartc).."-qsm"..tostring(qstep_min).." "..ver)
	dt = getTradeDate().date
	while tm<start_time do
		sleep(5000)
		tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	end
	message("====================", 1)
	sl = {}
	sl_len = 0
-- last_deal[][SEC][1] - last_deal = open position in lots [+-0]
-- last_deal[][SEC][2] - result
-- last_deal[][SEC][3] - position sum
-- last_deal[][SEC][4] - res percent
-- last_deal[][SEC][5] - last deal price [+-0]
-- last_deal[][SEC][6] - last order price [+-0]
	for row, SEC in pairs(sec_list) do
		sleep(100)
		if Subscribe_Level_II_Quotes(CLASS, SEC) then
			SetCell(tb_res, row, 5, string.format("%.0f", 0))
			SetCell(tb_res, row, 6, string.format("%.2f", last_deal[SEC][6]))
			SetCell(tb_res, row, 7, string.format("%.1f", last_deal[SEC][4]))
			SetCell(tb_res, row, 8, string.format("%.1f", last_deal[SEC][5]))
			sl_len = sl_len + 1
			sl[sl_len] = SEC
		else
			message("Bad SEC="..SEC.." Subscribe_Level_II_Quotes", 2)
		end
	end
	sec_list = sl
	for i, SEC in pairs(sec_list) do
		-- message("Table SEC="..SEC.." i="..i, 1)
		row = InsertRow( tb_res, -1)
		SetCell(tb_res, row, 1, SEC)
		SetCell(tb_res, row, 2, CLASS)
		SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name )
	end

	--message(class_list, 1)
	-- mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal 
	-- message("mpos= "..mpos.." "..currency, 1)
		last_row = InsertRow( tb_res, -1)
		
		SetCell(tb_res, last_row, 3, "Average res, %")
		message(tostring(sec_list))
		sleep(1000)
		-- total(sec_list, last_deal, ds)
-- is_run = false	
		for row, SEC in pairs(sec_list) do
			ss_last_deal[row] = 0
			i_last_deal[row] = 0
		end
	while is_run do
		sleep(30)
		if os.sysdate().min ~= tm_minute then
			-- total(sec_list, last_deal, ds)
			tm_minute = os.sysdate().min
				dvl_sum = 0
				for row, SEC in pairs(sec_list) do
					pct=set_sell_neg(tb_res, row, SEC, last_deal)
					dvl_sum = dvl_sum + pct
				end
				lds = dvl_sum/#sec_list
				SetCell(tb_res, last_row, 7,  string.format('%.2f', lds))
				if lds > 0 then
					SetColor(tb_res, last_row, 7, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
				elseif lds < 0 then
					SetColor(tb_res, last_row, 7, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
				else
					SetColor(tb_res, last_row, 7, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
				end
			-- message("sum="..dvl_sum, 1)
		end
		while tm >= stime and tm < etime do
			tm = os.sysdate().hour * 100 + os.sysdate().min
			sleep(1000)
		end
			
		for row, SEC in pairs(sec_list) do
			sleep(30)
			qt = getQuoteLevel2(CLASS, SEC)
			if tonumber(qt.bid_count)>=qsummax and tonumber(qt.offer_count)>=qsummax  then
				prc_bid = tonumber(qt.bid[qt.bid_count-0].price)
				prc_off = tonumber(qt.offer[1].price)
-- ver
				qt_bid_sum = 0
				qt_of_sum = 0
				for i=1,qstep_min-1 do 
					qt_bid_sum = qt_bid_sum + tonumber(qt.bid[1+qt.bid_count-i].quantity)
					qt_of_sum = qt_of_sum + tonumber(qt.offer[i].quantity)
				end
					ld_1 = last_deal[SEC][1]
					if ss_last_deal[row] > 0 then
						if prc_off <= ss_last_deal[row] then
							if last_deal[SEC][1] < 1 then
								SetCell(tb_res, row, 8, "BUY")
								-- SetColor(tb_res, row, 8, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
								last_deal = position_up(SEC, last_deal)
								filer:write(SEC.." BUY: date="..dt.." time="..tm.." res="..last_deal[SEC][2].." price="..prc_off, '\n')
								last_deal[SEC][6] = 0
								ss_last_deal[row] = 0
								i_last_deal[row] = 0
							end
						end
					elseif ss_last_deal[row] < 0 then
						if prc_bid >= -ss_last_deal[row] then
							if last_deal[SEC][1] > -dub_up then
								SetCell(tb_res, row, 8, "SELL")
								-- SetColor(tb_res, row, 8, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
								last_deal = position_dn(SEC, last_deal)
								filer:write(SEC.." SELL: date="..dt.." time="..tm.." res="..last_deal[SEC][2].." price="..prc_bid, '\n')
								last_deal[SEC][6] = 0 
								ss_last_deal[row] = 0
								i_last_deal[row] = 0
							end
						end
					end
					if ld_1 ~= last_deal[SEC][1] then
						prints(sec_list, last_deal)
					end
					last_deal_aver(last_deal, tb_res, last_row)
-- ===============================================
				for i=qstep_min,qsummax do 
					qt_bid_sum = qt_bid_sum + tonumber(qt.bid[1+qt.bid_count-i].quantity)
					qt_of_sum = qt_of_sum + tonumber(qt.offer[i].quantity)
					
					if last_deal[SEC][1]==0 then
						price_p = price_part
					else
						price_p = price_partc
					end
					if qt_bid_sum*dpart < qt_of_sum then
						if last_deal[SEC][1]>=(1-dub_up) then
							PRICE_STEP=getSecurityInfo(CLASS, SEC).min_price_step
							prc_deal = (prc_off*price_p + tonumber(qt.offer[i].price)*(1.0-price_p))
							last_deal[SEC][6] = -(prc_deal - (prc_deal - prc_off)%PRICE_STEP)
							imax[row] = i
						end
					elseif qt_bid_sum > qt_of_sum*dpart then
						if last_deal[SEC][1]<=0 then
							PRICE_STEP=getSecurityInfo(CLASS, SEC).min_price_step
							prc_deal = (prc_bid*price_p + tonumber(qt.bid[1+qt.bid_count-i].price)*(1.0-price_p))
							last_deal[SEC][6] = prc_deal + (prc_bid - prc_deal)%PRICE_STEP
							imax[row] = i
						end
					end
				end
				if ss_last_deal[row] > 0 then
					if last_deal[SEC][6] < ss_last_deal[row] then
						i_last_deal[row] = i_last_deal[row] + 1
						ss_last_deal[row] = ((i_last_deal[row] - 1) * ss_last_deal[row] + 2 * last_deal[SEC][6]) / (i_last_deal[row] + 1)
					-- elseif last_deal[SEC][6] >= 0 then
						-- ss_last_deal[row] = last_deal[SEC][6]
					end
				elseif ss_last_deal[row] < 0 then
					if last_deal[SEC][6] > ss_last_deal[row] then
						i_last_deal[row] = i_last_deal[row] + 1
						ss_last_deal[row] = ((i_last_deal[row] - 1) * ss_last_deal[row] + 2 * last_deal[SEC][6]) / (i_last_deal[row] + 1)
					-- elseif last_deal[SEC][6] >= 0 then
						-- ss_last_deal[row] = last_deal[SEC][6]
					end
				else
					ss_last_deal[row] = last_deal[SEC][6]
				end	
-- ===============================================
				SetCell(tb_res, row, 4, string.format('%.2f',(prc_off/prc_bid-1)*100).."%")
				SetCell(tb_res, row, 5, tostring(imax[row]))
				SetCell(tb_res, row, 6, tostring(ss_last_deal[row]))
				SetCell(tb_res, row, 8, tostring(last_deal[SEC][1]))
				if prc_bid < prc_off and  prc_off < prc_bid*1.001 then  
					SetColor(tb_res, row, 4, RGB(255,255,255),RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
				else
					SetColor(tb_res, row, 4, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
				end
			else
				SetCell(tb_res, row, 4, "no quote")
				-- SetColor(tb_res, row, 8, RGB(160,160,160),RGB(0,0,0), RGB(160,160,160), RGB(0,0,0))
			end
		end
		tm = os.sysdate().hour * 100 + os.sysdate().min
		if tm >= end_time then
			stop_main(tb_res)
			break
		end
	end
end
--  ============================================
function last_deal_aver(last_deal, tb_res, last_row)
	last_deal_sum = 0
	for i, SEC in pairs(sec_list) do
		last_deal_sum = last_deal_sum + math.abs(last_deal[SEC][1])
	end
	lds = last_deal_sum / #sec_list
	SetCell(tb_res, last_row, 8, string.format("%.2f", lds))
end
--  ============================================
function position_up(SEC, last_dealu)
	local last_deal = last_dealu
		if last_deal[SEC][1] < 0  then
			res = last_deal[SEC][3]+(last_deal[SEC][1])*last_deal[SEC][6]-math.abs(last_deal[SEC][1])*comis*last_deal[SEC][6]
			last_deal[SEC][4] = last_deal[SEC][4] + (res - last_deal[SEC][2])*100/math.abs(last_deal[SEC][5])
			last_deal[SEC][2] = res
			ld = 0
			last_deal[SEC][5] = 0
		elseif last_deal[SEC][1] == 0 then
			last_deal[SEC][5] = last_deal[SEC][6]
			ld = 1
		else
			ld = last_deal[SEC][1]
		end
		last_deal[SEC][3]=last_deal[SEC][3]-(ld-last_deal[SEC][1])*last_deal[SEC][6]-math.abs(ld-last_deal[SEC][1])*comis*last_deal[SEC][6]
		last_deal[SEC][1] = ld
	return last_deal
end
--  ============================================
function position_dn(SEC, last_deald)
	local last_deal = last_deald
	bidS = math.abs(last_deal[SEC][6])
	if last_deal[SEC][1] > 0 then
		res = last_deal[SEC][3]+(last_deal[SEC][1])*bidS-math.abs(last_deal[SEC][1])*comis*bidS
		last_deal[SEC][4] = last_deal[SEC][4] + (res - last_deal[SEC][2])*100/math.abs(last_deal[SEC][5])
		last_deal[SEC][2] = res
		ld = 0
		last_deal[SEC][5] = 0
	elseif last_deal[SEC][1] == 0 then
		if dub_up == 1 then
			ld = -dub_up
			last_deal[SEC][5] = last_deal[SEC][6]
		end
	else
		ld = last_deal[SEC][1]
	end
		last_deal[SEC][3]=last_deal[SEC][3]-(ld-last_deal[SEC][1])*bidS-math.abs(ld-last_deal[SEC][1])*comis*bidS
		last_deal[SEC][1] = ld
	return last_deal
end
--  ============================================
function set_sell_neg(tb_res, row, SEC, last_deal)
	-- message(SEC.." "..vers, 1)
	SetCell(tb_res, row, 8, string.format("%.0f", last_deal[SEC][1]))
	-- SCALE=getSecurityInfo(CLASS, SEC).scale
	-- price_format = '%.'..tostring(SCALE)..'f'
	price_format = '%.2f'
	qt = getQuoteLevel2(CLASS, SEC)
	res = last_deal[SEC][2]
	percent = last_deal[SEC][4]
	if qt and qt.offer and tonumber(qt.offer_count) ~= 0 then
		if last_deal[SEC][5] < 0 then
			offS = tonumber(qt.offer[1].price)
			res = last_deal[SEC][3]+(last_deal[SEC][1])*offS-math.abs(last_deal[SEC][1])*comis*offS
		end
		if last_deal[SEC][5] > 0 then
			bidS = tonumber(qt.bid[qt.bid_count-0].price)
			res = last_deal[SEC][3]+(last_deal[SEC][1])*bidS-math.abs(last_deal[SEC][1])*comis*bidS
		end
	end
	if last_deal[SEC][5] ~= 0 then
		percent = last_deal[SEC][4] + (res - last_deal[SEC][2])*100/math.abs(last_deal[SEC][5])
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
function prints(sec_list, last_dealc)
	filer2=io.open(data_file_name, "w")
	if filer2 ~= nil then
		for i, SEC in pairs(sec_list) do
			filer2:write("sec_"..SEC)
			filer2:write(" ld_"..last_dealc[SEC][1])
			filer2:write(" res_"..last_dealc[SEC][2])
			filer2:write(" pos_"..last_dealc[SEC][3])
			filer2:write(" pospct_"..last_dealc[SEC][4])
			filer2:write(" prc_"..last_dealc[SEC][5])
			filer2:write('\n')
		end
		filer2:close()
	end
end
--  ============================================

function OnStop(s)
	stop_main(tb_res, ds)
end
--  ============================================
function stop_main(tb_res, ds)
	if not IsWindowClosed(tb_res) then
		DestroyTable(tb_res)
	end
		dvl_sum = 0
		for row, SEC in pairs(sec_list) do
			pct=set_sell_neg(tb_res, row, SEC, last_deal)
			dvl_sum = dvl_sum + pct
		end
		if filer ~= nil then
			filer:write("Stop: date="..dt.." time="..tm, '\n')
			filer:write("Stop: summary result = "..string.format('%.2f', dvl_sum/#sec_list).." %", '\n')
			filer:close()
		end
		prints(sec_list, last_deal)
	for i, SEC in pairs(sec_list) do
		if IsSubscribed_Level_II_Quotes(CLASS, SEC) then
			Unsubscribe_Level_II_Quotes(CLASS, SEC)
		end
	end
	is_run = false
end