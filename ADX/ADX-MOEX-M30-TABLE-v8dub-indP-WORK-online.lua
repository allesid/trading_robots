
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

-- CLASS="CETS"
-- TRADE_ACC   = "MB0094600602"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="MC0094600000"

CLASS="TQBR"
-- TRADE_ACC   = "L01-00000F00"   -- торговый счет
-- CLIENT_CODE = "54078"          -- код клиента
-- FIRM_ID="MC0094600000"

-- CLASS="SPBFUT"
-- TRADE_ACC   = "1500c6h"   -- торговый счет
-- CLIENT_CODE = "65425"          -- код клиента
-- FIRM_ID="SPBFUT"

-- dub_up = 1  -- if dub_up==0 => only UP; if dub_up==1 => Dub (or UP and DOWN) direction
--  ========    DATA    ====================
path_name = "C:/QuikKITFinance/data/ADX/"
vers = "v8dub-indP-WORK-online"
first_candle0 = 0
end_candle0 = 0
-- ma_per1, ma_per2 = 2, 350
ti = INTERVAL_M30 -- 
comis = 0.0005
ma_per0 = 2
max_ma_per = 350
tw = "TEST"   -- "WORK" for real trade or other string for tests
PARTTIME = 0.9
--------------------------------------------
sleep_int = math.max(ti * 250, 3000)

EXCH = ""
sec_pattern = ""
start_time = 0
end_time = 0
stime = 0
etime = 0
dub_up = 0

	money_limit=3000
	currency = "SUR" -- "USD" --
	position_code= "EQTV" -- "GLSP" --
len_SEC = 0
sec_list = {}
last_deal = {} -- [SEC][DEAL_variant]{last_deal, res, pos}
qt = {}
end_of_name = ""
data_file_name = ""
result_file_name = ""

ma_per = {}
price_format = '%.4f'
 is_run = true
tm_minute = 0
uniq_trans_id = 0 

--  ============================================
Blabel = {}
Slabel = {}
STOPlabel = {}
--  ============================================
function OnInit(s)
end
--  ============================================
function sell_now(tn, Trvol, SEC, price_format, PRICE_STEP)
	ops=getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).locked_sell
	if ops ~= 0 then
		message(SEC.." sell order already sets, ops="..tostring(ops), 2)
		return
	end
 --=====================  Постановка ордеров  ===========================	
	--=============== SELL =====================
	-- mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal 
	qt = getQuoteLevel2(CLASS, SEC)
	ofS = tonumber(qt.offer[1].price)
	price = ofS - PRICE_STEP
	
	if (tn - Trvol) > 0 then
		uniq_trans_id = uniq_trans_id  + 1
		trans_S["TRANS_ID"] = tostring(uniq_trans_id)
		trans_S["SECCODE"] = SEC
		trans_S["PRICE"] =  string.format(price_format, price) -- MakeStringPrice(price),
		trans_S["QUANTITY"] = string.format('%.0f', tn - Trvol)
if tw == "WORK" then
	resd = sendTransaction(trans_S)
		message(SEC.." resd:"..resd.." SELL price="..tostring(prc).." tn= "..tostring(tn).." qty="..trans_S["QUANTITY"], 1)
end
		-- message(SEC.." 1 resd= " .. tostring(resd), 1)
		-- message(SEC.." sell_now mpos= "..mpos.." tn= "..tn.." ops= "..ops.." price= "..price, 1)
		-- sell_price = bidS
	end
end
--  ============================================
function buy_now(tn, Trvol, SEC, price_format, PRICE_STEP)
	opb=getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).locked_buy/LOTS_VALUE
 	if opb ~= 0 then
		message(SEC.." buy order already sets, opb="..tostring(opb), 2)
		return
	end
--=====================  Постановка ордеров  ===========================	
		--=============== BUY =====================
	-- mpos=getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).currentbal - getMoneyEx(FIRM_ID,  CLIENT_CODE, position_code, currency, 365).locked 
	qt = getQuoteLevel2(CLASS, SEC)
	bidS = tonumber(qt.bid[qt.bid_count-0].price)
	price = bidS + PRICE_STEP
	if (Trvol-tn)>0 then -- 
		uniq_trans_id = uniq_trans_id  + 1
		trans_B["TRANS_ID"] = tostring(uniq_trans_id)
		trans_B["SECCODE"] = SEC
		trans_B["PRICE"] =  string.format(price_format,price) -- MakeStringPrice(price),
		trans_B["QUANTITY"] = string.format('%.0f', Trvol-tn)
if tw == "WORK" then
	resd = sendTransaction(trans_B)
		message(SEC.." resd:"..resd.." BUY price="..tostring(prc).." tn= "..tostring(tn).." qty="..trans_B["QUANTITY"], 1)
end
		-- message(SEC.." 21 resd= " .. tostring(resd), 1)
		-- message(SEC.." buy_now mpos= "..mpos.." tn= "..tn.." opb= "..opb.." prc= "..price, 1)
	end	
end
--  ============================================

function main()
	EXCH, sec_pattern, start_time, end_time, stime, etime, dub_up, TRADE_ACC, CLIENT_CODE, FIRM_ID = classes_data(CLASS)
	end_of_name = EXCH.."-M"..ti.."-"..vers
	trans_B = {
        ["ACTION"] = "NEW_ORDER",
        ["CLASSCODE"] = CLASS,
        ["SECCODE"] = "",
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
        ["SECCODE"] = "",
        ["ACCOUNT"] = TRADE_ACC,
        ["CLIENT_CODE"] = CLIENT_CODE,
        ["OPERATION"] = 'S',
        ["PRICE"] =  '1',
        ["QUANTITY"] = string.format('%.0f', 1),
        ["TRANS_ID"] = '2'
                }
	data_file_name = path_name.."data-ADX-"..end_of_name..".txt"
	result_file_name = path_name.."Result-ADX-"..end_of_name..".txt"
	Blabel, Slabel, STOPlabel = labels0(ti)
	
-- last_deal[SEC][1] - last_deal
-- last_deal[SEC][2] - result
-- last_deal[SEC][3] - position
-- last_deal[SEC][4] - res percent
-- last_deal[SEC][5] - last price
-- last_deal[SEC][6] - ld
-- last_deal[SEC][7] - ld2
-- last_deal[SEC][8] - open position in lots

	sec_list, last_deal = input_data(data_file_name, sec_pattern)
	dt = getTradeDate().date
	tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	filer=io.open(result_file_name, "a")
	filer:write("=========================================", '\n')
	tm = os.sysdate().hour * 100 + os.sysdate().min

	filer:write("Start: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')

tb_res = AllocTable()
ac_res = AddColumn(tb_res, 1, "SEC", true, QTABLE_CACHED_STRING_TYPE , 15)
ac_res = AddColumn(tb_res, 2, "CLASS", true, QTABLE_CACHED_STRING_TYPE , 12)
ac_res = AddColumn(tb_res, 3, "Name", true, QTABLE_CACHED_STRING_TYPE, 20)
ac_res = AddColumn(tb_res, 4, "date/time", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 5, "ldd", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 6, "res", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 7, "RES %", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 8, "ma_per", true, QTABLE_CACHED_STRING_TYPE, 10) 

CreateWindow(tb_res)
	SetWindowCaption(tb_res, "Result-ADX-"..EXCH.."-M"..ti.."-"..vers..".txt")
	ds = {}
	sl = {}
	for i, SEC in pairs(sec_list) do
		ds[SEC] = {}
		ds0, error_desc = CreateDataSource(CLASS, SEC, ti) 
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
				--message(SEC.." ds[SEC]:Size() == "..ds[SEC]:Size(), 2)
			end
			sl[i] = SEC
		end
		-- indx = ds[SEC]:Size()
		-- message(SEC.." Size="..ds[SEC]:Size(), 1)
		-- message(SEC.." First Date="..ds[SEC]:T(1).year..":"..ds[SEC]:T(1).month..":"..ds[SEC]:T(1).day, 1)
		-- message(SEC.." ti="..ti.." First Time="..ds[SEC]:T(1).hour..":"..ds[SEC]:T(1).min..":"..ds[SEC]:T(1).sec, 1)
		chart_tag = SEC
		DelAllLabels(chart_tag)
		if Subscribe_Level_II_Quotes(CLASS, SEC) then
			message("Loaded quotes SEC="..SEC, 1)
			sleep(100)
		else
			message("Bad SEC="..SEC, 2)
		end
		if getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365) ~= nil then
			message(SEC.." 0 tn= "..getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).currentbal, 2)
		else
			message(getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 0), 2)
			message(getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 1), 2)
			message(getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365), 2)
		end
	end
	sec_list = sl
	
	for q, SEC in pairs(sec_list) do
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 1, SEC)
		SetCell(tb_res, row, 2, CLASS)
		SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name)
	end
-- table length == #sec_list 
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 3, "AVE PCT:" )
		row = InsertRow(tb_res, -1)
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 3, "Current data" )
-- table length == #sec_list + 4
		
	for q, SEC in pairs(sec_list) do
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 1, SEC)
		SetCell(tb_res, row, 2, CLASS)
		SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name)
	end
-- table length == #sec_list * 2 + 3
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 3, "AVE PCT:" )
-- table length == #sec_list * 2 + 4

	ADXT = {}
	
	sumpct = 0
	for q, SEC in pairs(sec_list) do
		ma_per[SEC] = best_ma_per(q, max_ma_per, SEC, comis, tb_res, ds)
		sumpct = sumpct + ma_per[SEC]["profit"]
		-- -- message("ma_per calc", 1)
		idx=ds[SEC]:Size()
			pdi = 10
			mdi = 10
			adx = 10
		for j=2,idx-1 do
			pdi_1 = pdi
			mdi_1 = mdi
			adx_1 = adx
			adx, pdi, mdi = psdf(j, ds[SEC], adx_1, pdi_1, mdi_1, ma_per[SEC]["ma_per"])
		end
		ADXT[SEC] = {adx, pdi, mdi, idx}
		-- message(SEC.." 1 adx="..string.format('%.2f', adx).." pdi="..string.format('%.2f', pdi).." mdi="..string.format('%.2f', mdi).." tm="..string.format('%.0f', ds[SEC]:T(idx-1).hour*100+ds[SEC]:T(idx-1).min), 1)
	end
	SetCell(tb_res, #sec_list+1, 7, string.format(price_format, sumpct/#sec_list))

	while tm < start_time do
		sleep(5000)
		tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	end
	
	while tm < end_time do
		sumpct = 0
		sumpct0 = 0
		sumpct4 = 0
-- message(SEC.." 1 time="..tostring(tm).." ldd="..tostring(ldd).." ldd_1="..tostring(ldd_1).." ld[1]="..tostring(last_deal[SEC][1]).." ld="..tostring(ld).." ld2="..tostring(ld2), 1)

		for q, SEC in pairs(sec_list) do
			if last_deal[SEC][1] ~= 0 and last_deal[SEC][5] ~= 0 then
				cur_pct = ((last_deal[SEC][3] + last_deal[SEC][1] * ds[SEC]:C(ds[SEC]:Size())) / last_deal[SEC][5])*100
			else
				cur_pct = last_deal[SEC][4]
			end
			sumpct = sumpct + cur_pct
			SetCell(tb_res, #sec_list+3+q, 6, string.format(price_format, cur_pct))
			if ma_per[SEC]["ma_per"] ~= 0 then
				chart_tag = SEC
				idx=ds[SEC]:Size()
				-- message(SEC.." idx="..idx.." ADXT[iadxt][SEC][4]="..ADXT[iadxt][SEC][4], 1)
				if tonumber(idx) > tonumber(ADXT[SEC][4]) then
					-- ma_per[SEC] = best_ma_per(q, max_ma_per, SEC, comis, tb_res, ds)
					-- message(SEC.." idx="..idx.." ADXT[iadxt][SEC][4]="..ADXT[iadxt][SEC][4], 2)
					SetCell(tb_res, #sec_list+3+q, 8, tostring(ma_per[SEC]["ma_per"]))
					
					-- message(SEC.." it="..tostring(it), 1)
					ADXT[SEC][4] = idx
					pdi = 10
					mdi = 10
					adx = 10
					for j=2,idx-1 do
						adx, pdi, mdi = psdf(j, ds[SEC], adx, pdi, mdi, ma_per[SEC]["ma_per"])
					end
					ADXT[SEC][1] = adx
					ADXT[SEC][2] = pdi
					ADXT[SEC][3] = mdi
				-- message(SEC.." adx="..string.format('%.2f', adx).." pdi="..string.format('%.2f', pdi).." mdi="..string.format('%.2f', mdi).." tm="..string.format('%.0f', ds[SEC]:T(idx-1).hour*100+ds[SEC]:T(idx-1).min).." ma_per="..ma_per, 1)
				end
				if (tonumber(os.sysdate().hour*60)+tonumber(os.sysdate().min))%ti > ti*PARTTIME then
					adx, pdi, mdi = psdf(ds[SEC]:Size(), ds[SEC], ADXT[SEC][1], ADXT[SEC][2], ADXT[SEC][3], ma_per[SEC]["ma_per"])
					
					ldd_1 = last_deal[SEC][1]
					ldd = last_deal[SEC][1]
					ldd = calc_ld(adx, pdi, mdi, ADXT[SEC], ldd)
					-- message(SEC.." adx2="..string.format('%.2f', adx2).." pdi2="..string.format('%.2f', pdi2).." mdi2="..string.format('%.2f', mdi2).." tm="..string.format('%.0f', ds[SEC]:T(j).hour*100+ds[SEC]:T(j).min), 1)
					
					if ma_per[SEC]["ma_per"] == 0 then
						ldd = 0
					end
					
					if ldd ~= ldd_1 then
						prc_1 = last_deal[SEC][5]
						prc = ds[SEC]:C(ds[SEC]:Size())
						res_1 = last_deal[SEC][2]
						last_deal[SEC][2] = last_deal[SEC][3] + ldd_1 * prc
						last_deal[SEC][3] = last_deal[SEC][3] - (ldd-ldd_1) * prc - math.abs(ldd-ldd_1) * comis * prc
						last_deal[SEC][5] = prc
						last_deal[SEC][1] = ldd
						if ldd_1 ~= 0 and prc_1 ~= 0 then
							last_deal[SEC][4] = last_deal[SEC][4] + (last_deal[SEC][2] - res_1)*100/prc_1
						end
						if getSecurityInfo(CLASS, SEC) == nil  then
							message(SEC.." 8 SCALE is nil, miss sequrity", 2)
						else
							message(SEC.." 8 DEAL ldd="..tostring(ldd), 1)
							if getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365) ~= nil then
								LOTS_VALUE=getSecurityInfo(CLASS, SEC).lot_size
if tw == "WORK" then
	tn = getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).currentbal/LOTS_VALUE
else
	tn = ldd_1 * last_deal[SEC][8]
end
								Trvol = last_deal[SEC][1] * last_deal[SEC][8]
								-- message(SEC.." 8 LOTS_VALUE="..tostring(LOTS_VALUE).." tn="..tostring(tn).." Trvol="..tostring(Trvol), 2)
								if tn ~= Trvol then
									SCALE=getSecurityInfo(CLASS, SEC).scale
									PRICE_STEP=getSecurityInfo(CLASS, SEC).min_price_step
									price_format = '%.'..tostring(SCALE)..'f'
									-- message(SEC.." 8 SCALE="..tostring(SCALE).." PRICE_STEP="..tostring(PRICE_STEP).." price_format="..tostring(price_format), 2)
									if Trvol > tn then
										buy_now(tn, Trvol, SEC, price_format, PRICE_STEP, trans_B)
									elseif Trvol < tn then
										sell_now(tn, dub_up*Trvol, SEC, price_format, PRICE_STEP, trans_S)
									end
								end
							end
						end
						
						label(ldd, prc, idx, ds[SEC], last_deal[SEC][2], chart_tag)
						prints(sec_list, last_deal)
						tm = os.sysdate().hour * 100 + os.sysdate().min

						if ldd > ldd_1 then
							filer:write(SEC.." BYE  time="..tostring(tm).." lots="..tostring(ldd-ldd_1).." ldd="..tostring(ldd).." prc="..string.format('%.2f', prc).." res="..tostring(last_deal[SEC][2]).." pct="..tostring(last_deal[SEC][4]), '\n')
							message(SEC.." BYE  time="..tostring(tm).." lots="..tostring(ldd-ldd_1).." ldd="..tostring(ldd).." prc="..string.format('%.2f', prc).." res="..tostring(last_deal[SEC][2]).." pct="..tostring(last_deal[SEC][4]), 1)
						else
							filer:write(SEC.." SELL time="..tostring(tm).." lots="..tostring(ldd-ldd_1).." ldd="..tostring(ldd).." prc="..tostring(prc).." res="..tostring(last_deal[SEC][2]).." pct="..tostring(last_deal[SEC][4]), '\n')
							message(SEC.." SELL time="..tostring(tm).." lots="..tostring(ldd-ldd_1).." ldd="..tostring(ldd).." prc="..string.format('%.2f', prc).." res="..tostring(last_deal[SEC][2]).." pct="..tostring(last_deal[SEC][4]), 1)
						end
					end
				end  -- if tonumber(os.sysdate().min)%tih > tih*0.888 then
			end  -- if ma_per[SEC]["ma_per"] ~= 0 then
			sumpct4 = sumpct4 + last_deal[SEC][4]
			SetCell(tb_res, #sec_list+3+q, 4, string.format('%.0f', os.sysdate().hour * 10000 + os.sysdate().min*100 + os.sysdate().sec))
			SetCell(tb_res, #sec_list+3+q, 5, string.format('%.0f', last_deal[SEC][1]))
			SetCell(tb_res, #sec_list+3+q, 7, string.format(price_format, last_deal[SEC][4]))
			SetCell(tb_res, #sec_list+3+q, 8, tostring(ma_per[SEC]["ma_per"]))
			sumpct0 = sumpct0 + ma_per[SEC]["profit"]
		end  -- SEC
		SetCell(tb_res, #sec_list + 1, 7, string.format('%.2f', sumpct0/#sec_list))
		SetCell(tb_res, #sec_list * 2 + 4, 6, string.format('%.2f', sumpct/#sec_list))
		SetCell(tb_res, #sec_list * 2 + 4, 7, string.format('%.2f', sumpct4/#sec_list))
		tm = os.sysdate().hour * 100 + os.sysdate().min
		while tm < etime and tm >= stime do
			sleep(5000)
			tm = os.sysdate().hour * 100 + os.sysdate().min
		end
		if tm + sleep_int/60000 < end_time then
			sleep(sleep_int)
		else
			sleep(60000)
		end
	end
	prints(sec_list, last_deal)
end
--  ============================================
function calc_ld(adx, pdi, mdi, a, ld)
	if adx > a[1] then
		if pdi > mdi then
			ld = 1
		else
			if mdi > pdi then
				ld = -dub_up
			end
		end
	end
	return ld
end


--  ============================================
function label(ld, prc, j, dsl, res, chart_tag)
	if ld == 1 then
		Blabel["YVALUE"]=prc
		Blabel["DATE"]=dsl:T(j).year*10000+dsl:T(j).month*100+dsl:T(j).day
		Blabel["TIME"]=os.sysdate().hour * 10000 + os.sysdate().min * 100
		Blabel["HINT"]=string.format('%.2f',res).."  "..vers
		s = AddLabel(chart_tag, Blabel)
		-- message(chart_tag.." "..ld.." "..prc.." "..j, 1)
		-- message(tostring(s), 2)
	elseif ld == -1 then
		Slabel["YVALUE"]=prc
		Slabel["DATE"]=dsl:T(j).year*10000+dsl:T(j).month*100+dsl:T(j).day
		Slabel["TIME"]=os.sysdate().hour * 10000 + os.sysdate().min * 100
		Slabel["HINT"]=string.format('%.2f',res).."  "..vers
		s = AddLabel(chart_tag, Slabel)
		-- message(chart_tag.." "..ld.." "..prc.." "..j, 1)
		-- message(tostring(s), 2)
	else
		STOPlabel["YVALUE"]=prc
		STOPlabel["DATE"]=dsl:T(j).year*10000+dsl:T(j).month*100+dsl:T(j).day
		STOPlabel["TIME"]=os.sysdate().hour * 10000 + os.sysdate().min * 100
		STOPlabel["HINT"]=string.format('%.2f',res).."  "..vers
		s = AddLabel(chart_tag, STOPlabel)
		-- message(chart_tag.." "..ld.." "..prc.." "..j, 1)
		-- message(tostring(s), 2)
	end
end

--  ============================================
function psdf(j, ds0, adx0, pdi0, mdi0, ma_per)
	pdm = math.max(0, ds0:H(j) - ds0:H(j-1))
	mdm = math.max(0, ds0:L(j-1) - ds0:L(j))
	if pdm > mdm then
		mdm = 0
	elseif mdm > pdm then
		pdm = 0
	else
		pdm = 0
		mdm = 0
	end
	tr = math.max(math.abs(ds0:H(j) - ds0:L(j)), math.abs(ds0:H(j) - ds0:C(j-1)), math.abs(ds0:L(j) - ds0:C(j-1)))
	if tr ~= 0 then
		psd = 100*pdm/tr
		msd = 100*mdm/tr
	else
		psd = 0
		msd = 0
	end
	pdi = ((ma_per-1)*pdi0+2*psd)/(ma_per+1)
	mdi = ((ma_per-1)*mdi0+2*msd)/(ma_per+1)
	-- if (pdi+mdi) ~= 0 then
		dx = 100*math.abs(pdi-mdi)/(pdi+mdi)
	-- else
		-- dx = 0
	-- end
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
		filer2:write(" openps_"..last_deal[SEC][6])
		filer2:write('\n')
	end
	filer2:close()
end

--  ============================================
function stop_work(tb_res, sec_list, filer, last_deal)
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
	-- filer:write("Stop: summary result = "..string.format('%.2f', dvl_sum/#sec_list).." %", '\n')
	filer:close()
	prints(sec_list, last_deal)
end
--  ============================================
function OnStop(s)
	stop_work(tb_res, sec_list, filer, last_deal)
end

--  ============================================
function classes_data(CLASS)
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
	return EXCH, sec_pattern, start_time, end_time, stime, etime, dub_up, TRADE_ACC, CLIENT_CODE, FIRM_ID

end

--  ============================================
function labels0(tm)
	Blabel={
		["TEXT"]="<buy"..tostring(tm),
		["IMAGE_PATH STRING"]="",
		["ALIGNMENT"]="RIGHT",
		["YVALUE"]=0,
		["DATE"]=0,
		["TIME"]=0,
		["B"]=0,
		["R"]=0,
		["G"]=128,
		["FONT_FACE_NAME"]="Arial",
		["FONT_HEIGHT"]=8,
		["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
		["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
		}
	Slabel={
		["TEXT"]="<sell"..tostring(tm),
		["IMAGE_PATH STRING"]="",
		["ALIGNMENT"]="RIGHT",
		["YVALUE"]=0,
		["DATE"]=0,
		["TIME"]=0,
		["B"]=0,
		["R"]=255,
		["G"]=0,
		["FONT_FACE_NAME"]="Arial",
		["FONT_HEIGHT"]=8,
		["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
		["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
		}
	STOPlabel={
		["TEXT"]="<stop"..tostring(tm),
		["IMAGE_PATH STRING"]="",
		["ALIGNMENT"]="RIGHT",
		["YVALUE"]=0,
		["DATE"]=0,
		["TIME"]=0,
		["B"]=255,
		["R"]=0,
		["G"]=0,
		["FONT_FACE_NAME"]="Arial",
		["FONT_HEIGHT"]=8,
		["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
		["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
		}
	return Blabel, Slabel, STOPlabel
end

--  ============================================
function input_data(data_file_name)
	ld_pattern = "ld_(%-?%d)"
	res_pattern = "res_(%-?%d+[.]?%d*)"
	pos_pattern = "pos_(%-?%d+[.]?%d*)"
	pospct_pattern = "pospct_(%-?%d+[.]?%d*)"
	prc_pattern = "prc_(%d+[.]?%d*)"
	openps_pattern = "openps_(%d+)"
	filer1=io.open(data_file_name, "r")
	--message("1 "..tostring(filer1))
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
					
						last_deal[SEC][6] = tonumber(string.match(str, openps_pattern))
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
						last_deal[SEC][5] = 0   -- 
						last_deal[SEC][6] = 0   -- 
				end
				-- message(SEC, 1)
				str = filer1:read("*l")
			end
			message("Load vers: "..vers.." SEC= "..tostring(SEC).." len_SEC= "..tostring(len_SEC), 1)
		else
			message("No input data "..vers, 1)
		end
	end
	filer1:close()
	prints(sec_list, last_deal)
	return sec_list, last_deal
end

--  ============================================
function best_ma_per(i, max_ma_per, SEC, comis, tb_res, ds)

			-- message(SEC.."ti="..tih.." Size="..ds[SEC]:Size().." Date="..ds[SEC]:T(1).year..":"..ds[SEC]:T(1).month..":"..ds[SEC]:T(1).day, 1)
			-- message(SEC.."ti="..tih.." Time="..ds[SEC]:T(1).hour..":"..ds[SEC]:T(1).min..":"..ds[SEC]:T(1).sec, 1)
	local ldd = 0
	sumpct = 0
	ma_per_t = {profit=0, ma_per=0, ldd=0}
	profit_max_mp = -1000
	idx=ds[SEC]:Size()
	for ma_per=2, max_ma_per do
		SetCell(tb_res, i, 8, string.format('%.0f', ma_per))
		pdi = 0
		mdi = 0
		adx = 0
		-- message(SEC.." ds[SEC]:Size() == "..idx, 1)
		pos = 0
		res = 0
		ldd = 0
		respct = 0
		prc = 0
		for j=2,idx do
			-- message(SEC.."  "..j.."  "..j, 1)
			-- SetCell(tb_res, i, 4, string.format('%.0f', j))
			pdi_1 = pdi
			mdi_1 = mdi
			adx_1 = adx
			adx, pdi, mdi = psdf(j, ds[SEC], adx_1, pdi_1, mdi_1, ma_per)
			ldd_1 = ldd
			ldd = calc_ld(adx, pdi, mdi, {adx_1, pdi_1, mdi_1}, ldd)
			
			if ldd ~= ldd_1 then
				prc_1 = prc
				prc = ds[SEC]:C(j)
				res_1 = res
				res = pos + ldd_1 * prc - math.abs(ldd-ldd_1) * comis * prc
				pos = pos - (ldd-ldd_1) * prc - math.abs(ldd-ldd_1) * comis * prc
				if ldd_1 ~= 0 then
					respct = respct + (res - res_1)*100/prc_1
				end
			end
		end	 -- for j=2,idx do

		if ldd ~= 0 then
			prc_1 = prc
			prc = ds[SEC]:C(ds[SEC]:Size())
			res_1 = res
			res = pos + ldd * prc - math.abs(ldd) * comis * prc
			if ldd_1 ~= 0 then
				respct = respct + (res - res_1)*100/prc_1
			end
		end
		-- message(SEC.."  res="..res.."  ma_per="..ma_per, 1)
		if profit_max_mp < respct and respct ~= 0 then
			profit_max_mp = respct
			ma_per_t["profit"] = respct
			ma_per_t["ma_per"] = ma_per
			ma_per_t["ldd"] = ldd
		end -- for ma_per=2, max_ma_per do
		
		SetCell(tb_res, i, 4, string.format('%.0f', ds[SEC]:T(ma_per_t["ma_per"]+1).year * 10000 + ds[SEC]:T(ma_per_t["ma_per"]+1).month * 100 + ds[SEC]:T(ma_per_t["ma_per"]+1).day))
		SetCell(tb_res, i, 5, string.format('%.0f', ma_per_t["ldd"]))
		SetCell(tb_res, i, 7, string.format(price_format, ma_per_t["profit"]))
		SetCell(tb_res, i, 8, tostring(ma_per_t["ma_per"]))
	end -- for i, SEC in pairs(sec_list) do
	return ma_per_t
end

--  ============================================
--  ============================================
--  ============================================
--  ============================================
--  ============================================

