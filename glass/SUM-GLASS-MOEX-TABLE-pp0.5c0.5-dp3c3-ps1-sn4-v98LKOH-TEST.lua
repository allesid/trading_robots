-- CLASS="NY_LIGHT"
-- TRADE_ACC   = "SV02"   -- торговый счет
-- CLIENT_CODE = "1206"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="TQTF"

-- CLASS="SPBDE"

-- CLASS="SPBXM"
-- SEC = "MSFT_XM"
-- SEC = "BABA_XM"
-- SEC = "NVDA_XM"

-- CLASS="CETS"  -- CURR

CLASS="TQBR"
-- SEC = "VTBR"
-- SEC = "SBER"
-- SEC = "GAZP"
SEC = "LKOH"

-- CLASS="SPBFUT"

-- CLASS="CETS_MTL"

path_name = "C:/Projects/trading_robots/glass/results/"
qsummax = 20

price_part = 0.5 -- цена выставления ордера между средним (бид и оффер) и бид/оффер макс в интервале [0.0-1.0]
price_partc = 0.5 -- то же для сделки закрытия позиции
dpart = 3 --коэффициент превышения суммы объема бид и оффер для сделки открытия позиции
-- например: сумма бидов умноженная на dpart > суммы офферов - покупка
dpartc = 3 -- то же для сделки закрытия позиции
ver = "v98"..SEC.."-TEST" -- "WORK"
ps = 1
sum_n_lim = 4
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

ld_pattern = "ld_(%-?%d)"
res_pattern = "res_(%-?%d+[.]?%d*)"
pos_pattern = "pos_(%-?%d+[.]?%d*)"
pospct_pattern = "pospct_(%-?%d+[.]?%d*)"
prc_pattern = "prc_(%-?%d+[.]?%d*)"
comis = 0.0005
sec_list = {}
last_deal = {} -- [vers num][DEAL_variant]{last_deal, res, pos}
qt = {}
filer = {}
prc_bid = 0
prc_off = 0
price_format = '%.4f'
 is_run = true
tm_minute = 0
data_file_name = {}
end_of_name = {}
dt = getTradeDate().date
tm = os.sysdate().hour * 100 + os.sysdate().min * 1
result_file_name = {}
tb_res = {}
PRICE_STEP = getSecurityInfo(CLASS, SEC).min_price_step
summary_res = {0,0.,0.,0.,0.,0,0}
-- [1] - last_deal
-- [2] - result
-- [3] - pos
-- [4] - percent
-- [5] - last price
-- [6] - qs number
-- [7] - last_deal_1


function OnInit(s)

	for i=1,qsummax do 
		end_of_name[i] = EXCH.."-M-qs"..tostring(i).."-pp"..tostring(price_part).."c"..tostring(price_partc).."-dp"..tostring(dpart).."c"..tostring(dpartc).."-ps"..tostring(ps).."-sn"..tostring(sum_n_lim).."-"..ver..".txt"
		data_file_name[i] = path_name.."data-GLASS-"..end_of_name[i]
		result_file_name[i] = path_name.."Result-GLASS-"..end_of_name[i]

		

		last_deal[i] = {}
						last_deal[i] = {}
						last_deal[i][1] = 0
						last_deal[i][2] = 0
						last_deal[i][3] = 0
						last_deal[i][4] = 0
						last_deal[i][5] = 0.   -- 
				last_deal[i][6] = 0
				last_deal[i][7] = 0
		-- filer[i]=io.open(result_file_name[i], "a")
		-- filer[i]:write("=========================================", '\n')
		-- filer[i]:write("Start: date="..dt.." time="..tm.." data_file_name="..data_file_name[i], '\n')
	end
		end_of_name_res = EXCH.."-pp"..tostring(price_part).."c"..tostring(price_partc).."-dp"..tostring(dpart).."c"..tostring(dpartc).."-ps"..tostring(ps).."-sn"..tostring(sum_n_lim).."-"..ver..".txt"
		sum_result_fn = path_name.."Summary_Res-GLASS-"..end_of_name_res
	filer_res=io.open(sum_result_fn, "a")
	filer_res:write("========================================", '\n')
	filer_res:write(SEC.."  "..tostring(dt).."  "..tostring(tm), '\n')
end
--  ============================================

function main()
	-- message("Start cycle tm= "..tm.." "..end_of_name, 1)
	-- message("Start time = "..start_time, 1)
	--message("1 "..tostring(filer1))
	
-- last_deal[][1] - last_deal = open position in lots [+-0]
-- last_deal[][2] - result
-- last_deal[][3] - position sum
-- last_deal[][4] - res percent
-- last_deal[][5] - last deal price [+-0]
-- last_deal[][6] - last order price [+0]
-- last_deal[][7] - last order price [-0]

	dt = getTradeDate().date
 	tm = os.sysdate().hour * 100 + os.sysdate().min
		if Subscribe_Level_II_Quotes(CLASS, SEC) then
			for i=1, qsummax do 
				SetCell(tb_res, row, 2*i+4, string.format("%.0f", last_deal[i][1]))
				SetCell(tb_res, row, 2*i+3, string.format("%.1f", last_deal[i][4]))
			end
		else
			message("Bad SEC="..SEC.." Subscribe_Level_II_Quotes", 2)
		end
		-- message("Table SEC="..SEC.." i="..i, 1)
		tb_res = AllocTable()
		ac_res = AddColumn(tb_res, 1, "SEC", true, QTABLE_CACHED_STRING_TYPE , 8)
		ac_res = AddColumn(tb_res, 2, "CLASS", true, QTABLE_CACHED_STRING_TYPE , 10)
		ac_res = AddColumn(tb_res, 3, "Name", true, QTABLE_CACHED_STRING_TYPE, 17)
		ac_res = AddColumn(tb_res, 4, "spred", true, QTABLE_CACHED_STRING_TYPE, 10)
		-- ac_res = AddColumn(tb_res, 4, "ADX_1", true, QTABLE_CACHED_STRING_TYPE, 10)
		-- ac_res = AddColumn(tb_res, 5, "ADX", true, QTABLE_CACHED_STRING_TYPE, 10)
		-- ac_res = AddColumn(tb_res, 6, "Price", true, QTABLE_CACHED_STRING_TYPE, 10)
		-- ac_res = AddColumn(tb_res, 7, "RES %", true, QTABLE_CACHED_STRING_TYPE, 10)
		-- ac_res = AddColumn(tb_res, 8, "DEAL", true, QTABLE_CACHED_STRING_TYPE, 10) 
		for i=1,qsummax do 
			ac_res = AddColumn(tb_res, 2*i+3, tostring(i).." RES %", true, QTABLE_CACHED_STRING_TYPE, 10)
			ac_res = AddColumn(tb_res, 2*i+4, tostring(i).." DEAL", true, QTABLE_CACHED_STRING_TYPE, 6) 
		end
		CreateWindow(tb_res)
			SetWindowCaption(tb_res, "RESULT mult".." "..EXCH.."-pp"..tostring(price_part).."c"..tostring(price_partc).."-dp"..tostring(dpart).."c"..tostring(dpartc).."-ps"..tostring(ps).."-sn"..tostring(sum_n_lim).." "..ver)	
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 1, SEC)
		SetCell(tb_res, row, 2, CLASS)
		SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name )
		row_sum = InsertRow(tb_res, -1)
		SetCell(tb_res, row_sum, 3, "Summary res, %")
		SetCell(tb_res, row_sum, 6, "ld=")
		SetCell(tb_res, row_sum, 8, "res=")
		SetCell(tb_res, row_sum, 10, "prc=")
		SetCell(tb_res, row_sum, 12, "pos=")

	--message(class_list, 1)
	-- mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal 
	-- message("mpos= "..mpos.." "..currency, 1)

		sleep(500)
	while tm<start_time do
		sleep(5000)
		tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	end
	message("====================", 1)
		-- total(sec_list, last_deal, ds)
-- is_run = false	
	while is_run do
		sleep(50)
		tm = os.sysdate().hour * 100 + os.sysdate().min
		while tm >= stime and tm < etime do
			tm = os.sysdate().hour * 100 + os.sysdate().min
			sleep(1000)
		end
		if tm >= end_time then
			stop_main(tb_res)
			break
		end
			
		if os.sysdate().min ~= tm_minute then
			sum_pct = 0
			sum_ld = 0
			sum_n = 0
			for i=1, qsummax do 
				if last_deal[i][1] ~= 0 then
					SetCell(tb_res, row, 2*i+4, tostring(last_deal[i][1]))
				else
					if last_deal[i][7] ~= 0 then
						SetCell(tb_res, row, 2*i+4, "or-"..tostring(last_deal[i][7]))
					end
					if last_deal[i][6] ~= 0 then
						SetCell(tb_res, row, 2*i+4, "or+"..tostring(last_deal[i][6]))
					end
				end
				-- prints(data_file_name[i],last_deal[i])
				pct = set_sell_neg(tb_res, row, SEC, last_deal[i], i)
				if pct > 0 then
					sum_pct = sum_pct + pct
					sum_ld = sum_ld + last_deal[i][1]
					sum_n = sum_n + 1
				end
			end
			if sum_n >= sum_n_lim then
				if sum_pct > 0 then
					ldc = sum_ld / sum_n
					if ldc > 0.5 then
						ldc = 1
					elseif ldc < -0.5 then
						ldc = -dub_up
					else
						ldc = 0
					end
				else
					ldc = 0
				end
			else
				ldc = 0
			end
				ld_1 = summary_res[1]
				summary_res[1] = ldc
				if math.abs(summary_res[1] - ld_1) > 1 then
					summary_res[1] = 0
				end
					qt = getQuoteLevel2(CLASS, SEC)


				if summary_res[1] > ld_1 then
					prc_off = tonumber(qt.offer[1].price)
					-- ress = summary_res[2]+(summary_res[1]-comis)*(prc_bid+prc_off)/2
					if ld_1 < 0 then
						res_1 = summary_res[2]
						summary_res[2] = summary_res[3]+(ld_1-comis)*prc_off
						summary_res[4] = summary_res[4] + (summary_res[2] - res_1)*100/math.abs(summary_res[5])
							-- message(SEC.." pct="..summary_res[4], 1)
						summary_res[3] = summary_res[2]
						filer_res:write(SEC.." BUY1: date="..dt.." time="..tm.." res="..summary_res[2].." price="..tostring(prc_off), '\n')
					elseif ld_1 == 0 then
						summary_res[3] = summary_res[3]-(summary_res[1] + comis)*prc_off
						filer_res:write(SEC.." BUY0: date="..dt.." time="..tm.." price="..tostring(prc_off), '\n')
					end
					summary_res[5] = prc_off
				elseif summary_res[1] < ld_1 then
					prc_bid = tonumber(qt.bid[qt.bid_count-0].price)
					if ld_1 > 0 then
						res_1 = summary_res[2]
						summary_res[2] = summary_res[3]+(ld_1-comis)*prc_bid
						summary_res[4] = summary_res[4] + (summary_res[2] - res_1)*100/math.abs(summary_res[5])
							-- message(SEC.." pct="..summary_res[4], 1)
						summary_res[3] = summary_res[2]
						filer_res:write(SEC.." SELL1: date="..dt.." time="..tm.." res="..summary_res[2].." price="..tostring(prc_bid), '\n')
					elseif ld_1 == 0 then
						summary_res[3] = summary_res[3] - (summary_res[1] + comis)*prc_bid
						filer_res:write(SEC.." SELL0: date="..dt.." time="..tm.." price="..tostring(prc_bid), '\n')
					end
					summary_res[5] = prc_bid
				else
					summary_res[5] = (prc_bid + prc_off) * 0.5
				end
				
				SetCell(tb_res, row_sum, 4, string.format('%.2f',tostring(summary_res[4])).."%")
				if summary_res[4] > 0 then  
					SetColor(tb_res, row_sum, 4, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
				elseif summary_res[4] < 0 then
					SetColor(tb_res, row_sum, 4, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
				else
					SetColor(tb_res, row_sum, 4, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
				end
				SetCell(tb_res, row_sum, 7, string.format('%.2f',tostring(summary_res[1])))
				ress = summary_res[2]
				if summary_res[1] ~= 0 then
					SetCell(tb_res, row_sum, 9, string.format('%.2f',tostring(ress)))
					SetCell(tb_res, row_sum, 11, string.format('%.2f',tostring(ress*100/prc_off)))
				else
					SetCell(tb_res, row_sum, 9, string.format('%.2f',tostring(summary_res[2])))
					SetCell(tb_res, row_sum, 11, string.format('%.2f',tostring(summary_res[4])))
				end
				if ress > 0 then
					SetColor(tb_res, row_sum, 9, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
					SetColor(tb_res, row_sum, 11, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
				elseif ress < 0 then
					SetColor(tb_res, row_sum, 9, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
					SetColor(tb_res, row_sum, 11, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
				else
					SetColor(tb_res, row_sum, 9, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
					SetColor(tb_res, row_sum, 11, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
				end

				SetCell(tb_res, row_sum, 13, string.format('%.2f',tostring(summary_res[3])))
				-- total(sec_list, last_deal, ds)
				tm_minute = os.sysdate().min
				qt = getQuoteLevel2(CLASS, SEC)
				if tonumber(qt.bid_count)>=qsummax and tonumber(qt.offer_count)>=qsummax  then
					prc_bid = tonumber(qt.bid[qt.bid_count-0].price)
					prc_off = tonumber(qt.offer[1].price)
					SetCell(tb_res, row, 4, string.format('%.2f',(prc_off/prc_bid-1)*100).."%")
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

	end
end
--  ============================================
function OnQuote(class_code, sec_code)
	if class_code==CLASS and SEC==sec_code and (tm<stime or tm>=etime) and tm>=start_time and tm<end_time then
		-- message("SEC="..SEC.." row="..row, 1)
		qt = getQuoteLevel2(CLASS, SEC)
		if tonumber(qt.bid_count)>=qsummax and tonumber(qt.offer_count)>=qsummax  then
			prc_bid = tonumber(qt.bid[qt.bid_count-0].price)
			prc_off = tonumber(qt.offer[1].price)
			qt_bid_sum = 0
			qt_of_sum = 0
			mbid_sum = 0
			moff_sum = 0
			resc = 0
			ir = 1
			for i=1,qsummax do 
				-- res = math.max(last_deal[i][2], 0)
				if last_deal[i][6] > 0 then
					if prc_off <= last_deal[i][6] then
						if last_deal[i][1] < 1 then
							ld_1 = last_deal[i][1]
							bidS = last_deal[i][6]
							if ld_1 < 0  then
								res = last_deal[i][3] + (ld_1 - comis) * bidS
								if math.abs(last_deal[i][5]) ~= 0 then
									last_deal[i][4] = last_deal[i][4] + (res - last_deal[i][2])*100/math.abs(last_deal[i][5])
									-- SetCell(tb_res, row_sum, 4, string.format('%.2f',tostring(summary_res[4])).."%")
								end
								last_deal[i][1] = 0
								last_deal[i][3] = last_deal[i][3] + (ld_1 - comis) * bidS
								last_deal[i][2] = res
								last_deal[i][5] = 0.
							elseif ld_1 == 0 then
								last_deal[i][1] = 1
								last_deal[i][3] = last_deal[i][3]-(last_deal[i][1]+comis)*bidS
								last_deal[i][5] = bidS
							end
						end
						last_deal[i][6] = 0. 
					end
				end
				if last_deal[i][7] < 0 then
					if prc_bid >= -last_deal[i][7] then
						if last_deal[i][1] > -dub_up then
							ld_1 = last_deal[i][1]
							offS = math.abs(last_deal[i][7])
							if ld_1 > 0 then
								res = last_deal[i][3]+(ld_1-comis)*offS
								if math.abs(last_deal[i][5]) ~= 0 then
									last_deal[i][4] = last_deal[i][4] + (res - last_deal[i][2])*100/math.abs(last_deal[i][5])
								end
								last_deal[i][1] = 0
								last_deal[i][3] = last_deal[i][3] + (ld_1 - comis) * offS
								last_deal[i][2] = res
								last_deal[i][5] = 0.
							elseif ld_1 == 0 then
								last_deal[i][1] = -dub_up
								last_deal[i][3] = last_deal[i][3]-(last_deal[i][1]+comis)*offS*dub_up
								last_deal[i][5] = -offS * dub_up
							end
						end
						last_deal[i][7] = 0.
					end
				end
				-- res = last_deal[i][3] + (last_deal[i][1] - comis) * (prc_bid+prc_off) / 2.0				
				
				qt_bid_sum = qt_bid_sum + tonumber(qt.bid[1+qt.bid_count-i].quantity)
				qt_of_sum = qt_of_sum + tonumber(qt.offer[i].quantity)
				
				if last_deal[i][1]==0 then
					price_p = price_part
				else
					price_p = price_partc
				end
				moff_sum = moff_sum + tonumber(qt.offer[i].quantity) * tonumber(qt.offer[i].price)
				mbid_sum = mbid_sum + tonumber(qt.bid[1+qt.bid_count-i].quantity) * tonumber(qt.bid[1+qt.bid_count-i].price)

				if last_deal[i][1]>=(1-dub_up) then
					if qt_bid_sum*dpart < qt_of_sum then
						prc_deal = (price_p * prc_bid + (1.0-price_p) * moff_sum / qt_of_sum)
						last_deal[i][7] = -(prc_deal - (prc_deal - prc_off)%PRICE_STEP)
					end
				end
				if last_deal[i][1]<=0 then
					if qt_bid_sum > qt_of_sum*dpart then
						prc_deal = (price_p * prc_off + (1.0-price_p) * mbid_sum / qt_bid_sum)
						last_deal[i][6] = prc_deal + (prc_bid - prc_deal)%PRICE_STEP
					end
				end
			end
		end
	end
end
--  ============================================
function set_sell_neg(tb_resc, row, SEC, last_deald, ic)
	local tb_res = tb_resc
	-- message(SEC.." "..vers, 1)
	SetCell(tb_res, row, 2*ic+4, string.format("%.0f", last_deald[1]))
	-- SCALE=getSecurityInfo(CLASS, SEC).scale
	-- price_format = '%.'..tostring(SCALE)..'f'
	price_format = '%.2f'
	qt = getQuoteLevel2(CLASS, SEC)
	percent = last_deald[4]
	if qt and qt.offer and tonumber(qt.offer_count) ~= 0 then
		if last_deald[1] < 0 then
			offS = tonumber(qt.offer[1].price)
			res = last_deald[3]+(last_deald[1])*offS-math.abs(last_deald[1])*comis*offS
		elseif last_deald[1] > 0 then
			bidS = tonumber(qt.bid[qt.bid_count-0].price)
			res = last_deald[3]+(last_deald[1])*bidS-math.abs(last_deald[1])*comis*bidS
		else
			res = last_deald[2]
		end
		if last_deald[1] ~= 0 then
			if math.abs(res - last_deald[2]) > math.abs(last_deald[5]) then
				eon = EXCH.."-pp"..tostring(price_part).."c"..tostring(price_partc).."-dp"..tostring(dpart).."c"..tostring(dpartc).."-ps"..tostring(ps).."-"..ver..".txt"
				efilename = path_name.."error-GLASS-"..eon
				filer_err=io.open(efilename, "a")
				filer_err:write("=== Error  "..eon.." ===", '\n')
				filer_err:write("=== math.abs(res - last_deald[2]) > math.abs(last_deald[5]) ===", '\n')
				filer_err:write(SEC, '\n')
				filer_err:write("res="..res, '\n')
				filer_err:write("bidS="..(qt.bid[qt.bid_count-0].price).." offS="..(qt.offer[1].price), '\n')
				filer_err:write(" ld_"..last_deald[1])
				filer_err:write(" res_"..last_deald[2])
				filer_err:write(" pos_"..last_deald[3])
				filer_err:write(" pospct_"..last_deald[4])
				filer_err:write(" prc_"..last_deald[5])
				filer_err:write('\n')
				filer_err:close()
			end
			if math.abs(last_deald[5]) ~= 0 then
				percent = last_deald[4] + (res - last_deald[2])*100/math.abs(last_deald[5])
			end
		end
		SetCell(tb_res, row, 2*ic+3, string.format(price_format, percent))
		if percent > 0 then
			SetColor(tb_res, row, 2*ic+3, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
		elseif percent < 0 then
			SetColor(tb_res, row, 2*ic+3, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
		else
			SetColor(tb_res, row, 2*ic+3, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
		end
	end
	return percent
end
--  ============================================
function prints(dfname,last_dealc)
	filer2=io.open(dfname, "w")
		filer2:write("sec_"..SEC)
		filer2:write(" ld_"..last_dealc[1])
		filer2:write(" res_"..last_dealc[2])
		filer2:write(" pos_"..last_dealc[3])
		filer2:write(" pospct_"..last_dealc[4])
		filer2:write(" prc_"..last_dealc[5])
		filer2:write('\n')
	filer2:close()
end
--  ============================================

function OnStop(s)
	stop_main(tb_res, ds)
end
--  ============================================
function stop_main(tb_res, ds)
	qt = getQuoteLevel2(CLASS, SEC)
	prc_bid = tonumber(qt.bid[qt.bid_count-0].price)
	prc_off = tonumber(qt.offer[1].price)
	res_1 = summary_res[2]
	if summary_res[1] > 0 then
		res = summary_res[3] + (summary_res[1] - comis) * prc_bid
		filer_res:write(SEC.." stop SELL: date="..dt.." time="..tm.." price="..tostring(prc_bid), '\n')
	elseif summary_res[1] < 0 then
		res = summary_res[3] + (summary_res[1] - comis) * prc_off
		filer_res:write(SEC.." stop BUY: date="..dt.." time="..tm.." price="..tostring(prc_off), '\n')
	else
		res = summary_res[2]
	end
	if math.abs(summary_res[5]) ~= 0 then
		summary_res[4] = summary_res[4] + (res - res_1)*100/math.abs(summary_res[5])
	end
	filer_res:write(SEC.." stop result="..tostring(res).."  pct="..tostring(summary_res[4]), '\n')
		if not IsWindowClosed(tb_res) then
			DestroyTable(tb_res)
		end
		if IsSubscribed_Level_II_Quotes(CLASS, SEC) then
			Unsubscribe_Level_II_Quotes(CLASS, SEC)
		end
	filer_res:close()
	is_run = false
end
--  ============================================
