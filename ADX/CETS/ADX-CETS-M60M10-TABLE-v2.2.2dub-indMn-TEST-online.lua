
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
--  ========    DATA    ====================
path_name = "C:/QuikKITFinance/data/ADX/CETS/"
vers = "v2.2.2dub-indMn-TEST-online"
first_candle0 = 0
end_candle0 = 0
-- ma_per1, ma_per2 = 2, 350
tih = INTERVAL_H1 -- time_interval_high
til = INTERVAL_M10 -- time_interval_low
comis = 0.0005
max_ma_per = 50
--------------------------------------------
sleep_int = math.max(tih * 250, 3000)

EXCH = ""
sec_pattern = ""
start_time = 0
end_time = 0
stime = 0
etime = 0
dub_up = 0

	money_limit=205
	currency = "SUR" -- "USD" --
	position_code= "EQTV" -- "GLSP" --
len_SEC = 0
sec_list = {}
last_deal = {} -- [SEC][DEAL_variant]{last_deal, res, pos}
qt = {}
end_of_name = ""
data_file_name = ""
result_file_name = ""

-- ma_per = 14
price_format = '%.4f'
 is_run = true
tm_minute = 0
--  ============================================
Blabel = {}
Slabel = {}
STOPlabel = {}
--  ============================================
function OnInit(s)
end
--  ============================================

function main()
	EXCH, sec_pattern, start_time, end_time, stime, etime, dub_up, TRADE_ACC, CLIENT_CODE, FIRM_ID = classes_data(CLASS)
	end_of_name = EXCH.."-M"..tih.."M"..til.."-"..vers
	data_file_name = path_name.."data-ADX-"..end_of_name..".txt"
	result_file_name = path_name.."Result-ADX-"..end_of_name..".txt"
	Blabel, Slabel, STOPlabel = labels0(til)
	tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	while tm < start_time do
		sleep(5000)
		tm = os.sysdate().hour * 100 + os.sysdate().min * 1
	end
	
-- last_deal[SEC][1] - last_deal
-- last_deal[SEC][2] - result
-- last_deal[SEC][3] - position
-- last_deal[SEC][4] - res percent
-- last_deal[SEC][5] - last price

	sec_list, last_deal = input_data(data_file_name, sec_pattern)
	dt = getTradeDate().date
	filer=io.open(result_file_name, "a")
	filer:write("=========================================", '\n')
	tm = os.sysdate().hour * 100 + os.sysdate().min

	filer:write("Start: date="..dt.." time="..tm.." data_file_name="..data_file_name, '\n')

tb_res = AllocTable()
ac_res = AddColumn(tb_res, 1, "SEC", true, QTABLE_CACHED_STRING_TYPE , 15)
ac_res = AddColumn(tb_res, 2, "CLASS", true, QTABLE_CACHED_STRING_TYPE , 12)
ac_res = AddColumn(tb_res, 3, "Name", true, QTABLE_CACHED_STRING_TYPE, 20)
ac_res = AddColumn(tb_res, 4, "ld  ld2", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 5, "ldd", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 6, "res", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 7, "RES %", true, QTABLE_CACHED_STRING_TYPE, 12)
ac_res = AddColumn(tb_res, 8, "ma_per", true, QTABLE_CACHED_STRING_TYPE, 10) 

CreateWindow(tb_res)
	SetWindowCaption(tb_res, "Result-ADX-"..EXCH.."-M"..tih.."M"..til.."-"..vers..".txt")
	ds = {}
	sl = {}
	ti_t = {tih, til}
	for q, t in pairs(ti_t) do
		ds[t] = {}
		for i, SEC in pairs(sec_list) do
			ds[t][SEC] = {}
			ds0, error_desc = CreateDataSource(CLASS, SEC, t) 
			sleep(100)
			if ds0 == nil then
				message(SEC.." error in CreateDataSource: "..error_desc, 2)
				sec_list[i] = nil
				filer:write(SEC.." 1 error: "..error_desc, '\n')
			else
				ds[t][SEC] = ds0
				if ds[t][SEC]:Size() == 0 then 
					ds[t][SEC]:SetEmptyCallback()
					sleep(500)
					--message(SEC.." ds[SEC]:Size() == "..ds[SEC]:Size(), 2)
				end
				sl[i] = SEC
			end
			-- indx = ds[t][SEC]:Size()
			message(SEC.." ti="..t.." Size="..ds[t][SEC]:Size(), 1)
			message(SEC.." First Date="..ds[t][SEC]:T(1).year..":"..ds[t][SEC]:T(1).month..":"..ds[t][SEC]:T(1).day, 1)
			message(SEC.." ti="..t.."First Time="..ds[t][SEC]:T(1).hour..":"..ds[t][SEC]:T(1).min..":"..ds[t][SEC]:T(1).sec, 1)
			-- chart_tag = SEC
			-- DelAllLabels(chart_tag)
		end
	end
	sec_list = sl
	dt = getTradeDate().date
 	tm = os.sysdate().hour * 100 + os.sysdate().min
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
		SetCell(tb_res, row, 3, "GLOBAL MAX:" )
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 3, "GLOB res_min:" )
		row = InsertRow(tb_res, -1)
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 3, "Current data" )
-- table length == #sec_list + 5
		
	for q, SEC in pairs(sec_list) do
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 1, SEC)
		SetCell(tb_res, row, 2, CLASS)
		SetCell(tb_res, row, 3, getSecurityInfo(CLASS, SEC).short_name)
	end
-- table length == #sec_list * 2 + 5
		row = InsertRow(tb_res, -1)
		SetCell(tb_res, row, 3, "AVE PCT:" )
-- table length == #sec_list * 2 + 6

	ma_per = best_ma_per(max_ma_per, sec_list, comis, tb_res, ti_t, ds)
	message("ma_per calc", 1)
	ADXT = {}
	for q, t in pairs(ti_t) do
		ADXT[t] = {}
		for q, SEC in pairs(sec_list) do
			idx=ds[t][SEC]:Size()
			pdi = 50
			mdi = 50
			adx = 50
			for j=2,idx-1 do
				pdi_1 = pdi
				mdi_1 = mdi
				adx_1 = adx
				adx, pdi, mdi = psdf(j, ds[t][SEC], adx_1, pdi_1, mdi_1, ma_per[SEC]["ma_per_r"])
			end
			ADXT[t][SEC] = {adx, pdi, mdi, idx}
			message(SEC.." adx="..string.format('%.2f', adx).." pdi="..string.format('%.2f', pdi).." mdi="..string.format('%.2f', mdi).." tm="..string.format('%.0f', ds[t][SEC]:T(idx-1).hour*100+ds[t][SEC]:T(idx-1).min), 1)
		end
	end
	
	it = 0
	while tm < end_time do
		sumpct = 0
		if it >= #sec_list then
			ma_per = best_ma_per(max_ma_per, sec_list, comis, tb_res, ti_t, ds)
			message(CLASS.." it="..tostring(it).." #sec_list="..tostring(#sec_list).." "..vers, 1)
			it = 0
			for q, SEC in pairs(sec_list) do
				SetCell(tb_res, #sec_list+5+q, 8, string.format('%.0f', ma_per[SEC]["ma_per_r"]))
			end
		end
		for q, SEC in pairs(sec_list) do
			chart_tag = SEC
			ld = last_deal[SEC][6]
			ld2 =last_deal[SEC][7]
			for q0, t in pairs(ti_t) do
				idx=ds[t][SEC]:Size()
				-- message(SEC.." idx="..idx.." ADXT[SEC][4]="..ADXT[SEC][4], 1)
				if tonumber(idx) > tonumber(ADXT[t][SEC][4]) then
					-- message(SEC.." idx="..idx.." ADXT[SEC][4]="..ADXT[SEC][4], 2)
					if t == ti_t[1] then
						it = it + 1
					end
					
					-- message(SEC.." it="..tostring(it), 1)
					ADXT[t][SEC][4] = idx
					pdi = 50
					mdi = 50
					adx = 50
					for j=2,idx-1 do
						adx, pdi, mdi = psdf(j, ds[t][SEC], adx, pdi, mdi, ma_per[SEC]["ma_per_r"])
					end
					ADXT[t][SEC][1] = adx
					ADXT[t][SEC][2] = pdi
					ADXT[t][SEC][3] = mdi
				-- message(SEC.." adx="..string.format('%.2f', adx).." pdi="..string.format('%.2f', pdi).." mdi="..string.format('%.2f', mdi).." tm="..string.format('%.0f', ds[t][SEC]:T(idx-1).hour*100+ds[t][SEC]:T(idx-1).min).." ma_per="..ma_per, 1)
				end
			end
			adx, pdi, mdi = psdf(ds[ti_t[1]][SEC]:Size(), ds[ti_t[1]][SEC], ADXT[ti_t[1]][SEC][1], ADXT[ti_t[1]][SEC][2], ADXT[ti_t[1]][SEC][3], ma_per[SEC]["ma_per_r"])
			ld_1 = ld
			if adx > ADXT[ti_t[1]][SEC][1] then
				if pdi > ADXT[ti_t[1]][SEC][2] then
					ld = 1
				end
			elseif adx < ADXT[ti_t[1]][SEC][1] then
				if mdi > ADXT[ti_t[1]][SEC][3] then
					ld = -dub_up
				end
			end
			last_deal[SEC][6] = ld
			adx2, pdi2, mdi2 = psdf(ds[ti_t[2]][SEC]:Size(), ds[ti_t[2]][SEC], ADXT[ti_t[2]][SEC][1], ADXT[ti_t[2]][SEC][2], ADXT[ti_t[2]][SEC][3], ma_per[SEC]["ma_per_r"])
			-- message(SEC.." adx2="..string.format('%.2f', adx2).." pdi2="..string.format('%.2f', pdi2).." mdi2="..string.format('%.2f', mdi2).." tm="..string.format('%.0f', ds[ti_t[2]][SEC]:T(j2).hour*100+ds[ti_t[2]][SEC]:T(j2).min), 1)
			if adx2 > adx2_1 then
				if pdi2 > pdi2_1 then
					ld2 = 1
				end
			elseif adx2 < adx2_1 then
				if mdi2 > mdi2_1 then
					ld2 = -dub_up
				end
			end
			last_deal[SEC][7] = ld2
			
			ldd_1 = last_deal[SEC][1]
			if ld > 0 then
				if ldd == -1 then
					ldd = 0
				end
				if ld2 == -dub_up then
					ldd = 1
				end
			elseif ld == -dub_up then
				if ldd == 1 then
					ldd = 0
				end
				if ld2 > 0 then
					ldd = -dub_up
				end
			else
				if ld2 > 0 then
					ldd = -dub_up
				end
			end
			
			if ldd ~= ldd_1 then
				prc = ds[ti_t[2]][SEC]:C(ds[ti_t[2]][SEC]:Size())
				last_deal[SEC][2] = last_deal[SEC][3] + ldd_1 * prc
				last_deal[SEC][3] = last_deal[SEC][3] - (ldd-ldd_1) * prc - math.abs(ldd-ldd_1) * comis * prc
				last_deal[SEC][4] = last_deal[SEC][2]*100/prc
				last_deal[SEC][5] = prc
				last_deal[SEC][1] = ldd
				label(last_deal[SEC][1], prc, idx, ds[ti_t[2]][SEC], last_deal[SEC][2], chart_tag)
				prints(sec_list, last_deal)
			end
-- last_deal[SEC][1] - last_deal
-- last_deal[SEC][2] - result
-- last_deal[SEC][3] - position
-- last_deal[SEC][4] - res percent
-- last_deal[SEC][5] - last price
		-- respct = res*100/ds[SEC]:O(idx+first_candle0)
			SetCell(tb_res, #sec_list+5+q, 4, string.format('%.0f', ld).." "..string.format('%.0f', ld2))
			SetCell(tb_res, #sec_list+5+q, 5, string.format('%.0f', last_deal[SEC][1]))
			SetCell(tb_res, #sec_list+5+q, 6, string.format(price_format, last_deal[SEC][2]))
			SetCell(tb_res, #sec_list+5+q, 7, string.format(price_format,last_deal[SEC][4]))
			-- SetCell(tb_res, q, 8, string.format('%.0f', ma_per[SEC]["ma_per_r"]))
			if last_deal[SEC][5] == 0 then
				sumpct = sumpct + last_deal[SEC][3] / ds[ti_t[2]][SEC]:C(ds[ti_t[2]][SEC]:Size()) + last_deal[SEC][1]
			else
				sumpct = sumpct + (last_deal[SEC][3] + last_deal[SEC][1] * ds[ti_t[2]][SEC]:C(ds[ti_t[2]][SEC]:Size())) / last_deal[SEC][5]
			end
		end
		SetCell(tb_res, #sec_list * 2 + 5, 7, string.format('%.2f', sumpct * 100 / #sec_list))
		-- for i, SEC in pairs(sec_list) do
		-- SetCell(tb_res, row, 4, string.format(price_format, curr_min_s))
		-- SetCell(tb_res, row, 5, string.format(price_format, res_min_s))
		-- SetCell(tb_res, q, 6, "sumpct1=")
		-- SetCell(tb_res, q, 7, string.format(price_format,sumpct/#sec_list))
		tm = os.sysdate().hour * 100 + os.sysdate().min
		if tm + sleep_int/60000 < end_time then
			sleep(sleep_int)
		else
			sleep(60000)
		end
	end
	prints(sec_list, last_deal)
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
		filer2:write(" ld1_"..last_deal[SEC][6])
		filer2:write(" ld2_"..last_deal[SEC][7])
		filer2:write('\n')
	end
	filer2:close()
end

--  ============================================
function OnStop(s)
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
	is_run = false
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
	ld1_pattern = "ld1_(%-?%d)"
	ld2_pattern = "ld2_(%-?%d)"
	res_pattern = "res_(%-?%d+[.]?%d*)"
	pos_pattern = "pos_(%-?%d+[.]?%d*)"
	pospct_pattern = "pospct_(%-?%d+[.]?%d*)"
	prc_pattern = "prc_(%d+[.]?%d*)"
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
						
						last_deal[SEC][6] = tonumber(string.match(str, ld1_pattern))
						if last_deal[SEC][6] then
						else
							message("Bad ld1 input: SEC="..SEC,2)
							last_deal[SEC][6] = 0
						end
						
						last_deal[SEC][7] = tonumber(string.match(str, ld2_pattern))
						if last_deal[SEC][7] then
						else
							message("Bad ld2 input: SEC="..SEC,2)
							last_deal[SEC][7] = 0
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
						last_deal[SEC][7] = 0   -- 
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
	return sec_list, last_deal
end

--  ============================================
function best_ma_per(max_ma_per, sec_list, comis, tb_res, ti_t, ds)

			-- message(SEC.."ti="..t.." Size="..ds[t][SEC]:Size().." Date="..ds[t][SEC]:T(1).year..":"..ds[t][SEC]:T(1).month..":"..ds[t][SEC]:T(1).day, 1)
			-- message(SEC.."ti="..t.." Time="..ds[t][SEC]:T(1).hour..":"..ds[t][SEC]:T(1).min..":"..ds[t][SEC]:T(1).sec, 1)
	first_candle_h = {}
	first_candle_l = {}
	-- message("ti_t= "..tostring(ti_t[1]), 1) -- [SEC]:T(1).year
	-- for k, v in pairs(ds) do
		-- message("k="..tostring(k).."  v="..tostring(v), 1) -- [SEC]:T(1).year
	-- end
	for q, SEC in pairs(sec_list) do
		date_h = ds[ti_t[1]][SEC]:T(1).year * 10000 + ds[ti_t[1]][SEC]:T(1).month * 100 + ds[ti_t[1]][SEC]:T(1).day
		date_l = ds[ti_t[2]][SEC]:T(1).year * 10000 + ds[ti_t[2]][SEC]:T(1).month * 100 + ds[ti_t[2]][SEC]:T(1).day
		j = 1
		first_candle_l[SEC] = 1
		first_candle_h[SEC] = 1
		if date_h < date_l then
			while date_h < date_l do
				j = j + 1
				date_h = ds[ti_t[1]][SEC]:T(j).year * 10000 + ds[ti_t[1]][SEC]:T(j).month * 100 + ds[ti_t[1]][SEC]:T(j).day
			end
			first_candle_h[SEC] = j
		elseif date_h > date_l then
			while date_h > date_l do
				j = j + 1
				date_h = ds[ti_t[2]][SEC]:T(j).year * 10000 + ds[ti_t[2]][SEC]:T(j).month * 100 + ds[ti_t[2]][SEC]:T(j).day
			end
			first_candle_l[SEC] = j
		end
		
		time_h = ds[ti_t[1]][SEC]:T(first_candle_h[SEC]).hour * 10000 + ds[ti_t[1]][SEC]:T(first_candle_h[SEC]).min * 100 + ds[ti_t[1]][SEC]:T(first_candle_h[SEC]).sec
		time_l = ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).hour * 10000 + ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).min * 100 + ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).sec
		if time_h < time_l then
			while time_h < time_l do
				first_candle_h[SEC] = first_candle_h[SEC] + 1
				time_h = ds[ti_t[1]][SEC]:T(first_candle_h[SEC]).hour * 10000 + ds[ti_t[1]][SEC]:T(first_candle_h[SEC]).min * 100 + ds[ti_t[1]][SEC]:T(first_candle_h[SEC]).sec
			end
			if time_h ~= time_l then
				while time_h > time_l do
					first_candle_l[SEC] = first_candle_l[SEC] + 1
					time_l = ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).hour * 10000 + ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).min * 100 + ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).sec
				end
			end
		elseif time_h > time_l then
			while time_h > time_l do
				first_candle_l[SEC] = first_candle_l[SEC] + 1
				time_l = ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).hour * 10000 + ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).min * 100 + ds[ti_t[2]][SEC]:T(first_candle_l[SEC]).sec
			end
		end
		-- SetCell(tb_res, q, 4, string.format('%.0f', date_h))
		-- SetCell(tb_res, q, 5, string.format('%.0f', date_l))
		-- SetCell(tb_res, q, 6, string.format('%.0f', time_h))
		-- SetCell(tb_res, q, 7, string.format('%.0f', time_l))
	end
	ma_per_t = {}
	sumpct_d = 0
	sumpct_p = 0
	drawdown_p = 0
	drawdown_d = -100

	for i, SEC in pairs(sec_list) do
		message("Table SEC="..SEC, 1)
		sumpct = 0
		res_min_s = 0
		res_max_s = 0
		ma_per_t[SEC] = {profit_d=0, ma_per_d=0, profit_p=-100, ma_per_p=0, ma_per_r=0, drawdown_p=0, drawdown_d=-100}
		drawdown_min_mp = -100
		profit_max_mp = -100
		for ma_per=2, max_ma_per do
			SetCell(tb_res, i, 8, string.format('%.0f', ma_per))
			chart_tag = SEC
			idx=ds[ti_t[1]][SEC]:Size()
			pdi = 0
			mdi = 0
			adx = 0
			pdi2 = 0
			mdi2 = 0
			adx2 = 0
			-- message(SEC.." ds[SEC]:Size() == "..idx, 1)
			pos = 0
			res = 0
			ld = 0
			ld2 = 0
			res_min = 0
			res_max = 0
			drawdown = 0
			j2 = first_candle_l[SEC]
			ldd = 0
			respct = 0
			for j=first_candle_h[SEC],idx do
				-- message(SEC.."  "..j.."  "..j2, 1)
				-- SetCell(tb_res, i, 4, string.format('%.0f', j))
				pdi_1 = pdi
				mdi_1 = mdi
				adx_1 = adx
				adx, pdi, mdi = psdf(j, ds[ti_t[1]][SEC], adx_1, pdi_1, mdi_1, ma_per)
				ld_1 = ld
				if adx > adx_1 then
					if pdi > pdi_1 then
						ld = 1
					end
				elseif adx < adx_1 then
					if mdi > mdi_1 then
						ld = -dub_up
					end
				end
				
				time_h_p = tonumber(ds[ti_t[1]][SEC]:T(j).hour * 60 + ds[ti_t[1]][SEC]:T(j).min + ti_t[1])
				time_l = tonumber(ds[ti_t[2]][SEC]:T(j2).hour) * 60 + tonumber(ds[ti_t[2]][SEC]:T(j2).min)
					-- SetCell(tb_res, i, 6, string.format('%.0f', time_l))
					-- message(SEC.."  "..j.."  "..j2.."  "..time_l.."  "..time_h_p, 1)
				-- js = j2 + ti_t[1] / ti_t[2]
				while time_l < time_h_p and time_l < end_time do --  and js < j2
					-- SetCell(tb_res, i, 5, string.format('%.0f', time_l))
					-- SetCell(tb_res, i, 6, string.format('%.0f', time_h_p))
					-- SetCell(tb_res, i, 7, string.format('%.0f', time_h_p))
					pdi2_1 = pdi2
					mdi2_1 = mdi2
					adx2_1 = adx2
					adx2, pdi2, mdi2 = psdf(j2, ds[ti_t[2]][SEC], adx2_1, pdi2_1, mdi2_1, ma_per)
					if adx2 > adx2_1 then
						if pdi2 > pdi2_1 then
							ld2 = 1
						end
					elseif adx2 < adx2_1 then
						if mdi2 > mdi2_1 then
							ld2 = -dub_up
						end
					end
					ldd_1 = ldd
					if ld > 0 then
						if ldd == -1 then
							ldd = 0
						end
						if ld2 == -dub_up then
							ldd = 1
						end
					elseif ld == -dub_up then
						if ldd == 1 then
							ldd = 0
						end
						if ld2 > 0 then
							ldd = -dub_up
						end
					else
						if ld2 > 0 then
							ldd = -dub_up
						end
					end
				
					prc = ds[ti_t[1]][SEC]:C(j2)
					if ldd ~= ldd_1 then
						res = pos + ldd_1 * prc
						pos = pos - (ldd-ldd_1) * prc - math.abs(ldd-ldd_1) * comis * prc
					end
					if pos ~= 0 then
						respct = res*100/prc
					else
						respct = 0
					end
					if res_min > respct then
						res_min = respct
					end
					if res_max < respct then
						res_max = respct
					end
					dd = respct - res_max
					if drawdown > dd then
						drawdown = dd
						-- message(SEC.."  "..j.."  "..j2.."  "..drawdown, 1)
						-- sleep(50)
					end
					j2 = j2 + 1
					time_l = tonumber(ds[ti_t[2]][SEC]:T(j2).hour) * 100 + tonumber(ds[ti_t[2]][SEC]:T(j2).min)
					-- SetCell(tb_res, i, 5, string.format('%.0f', j2))
					-- SetCell(tb_res, i, 6, string.format('%.0f', time_h_p))
					-- SetCell(tb_res, i, 7, string.format('%.2f', time_l))
-- if j2 > 15 then
    -- return
-- end 
				end  -- while time_l < time_h_p do
					-- message(SEC.."  "..j.."  "..j2.."  "..time_l.."  "..time_h_p, 1)
			end	 -- for j=first_candle_h[SEC],idx do
			-- SetCell(tb_res, i, 4, string.format('%.0f', j2))
			-- SetCell(tb_res, i, 5, string.format('%.0f', time_l))
			-- SetCell(tb_res, i, 6, string.format('%.0f', time_h_p))
			-- SetCell(tb_res, i, 7, string.format('%.2f', respct))

			prc = ds[ti_t[1]][SEC]:C(ds[ti_t[1]][SEC]:Size())
			if ldd ~= 0 then
				res = pos + ldd * prc
			end
			if res_min > respct then
				res_min = respct
			end
			if res_max < respct then
				res_max = respct
			end
			dd = respct - res_max
			if drawdown > dd then
				drawdown = dd
			end
			if pos ~= 0 then
				respct = res*100/prc
			else
				respct = 0
				drawdown = -100
			end
			if drawdown_min_mp < drawdown then
				drawdown_min_mp = drawdown
			-- message(SEC.."  "..ma_per.."  "..drawdown_min_mp, 1)
				ma_per_t[SEC]["drawdown_d"] = drawdown
				ma_per_t[SEC]["profit_d"] = respct
				ma_per_t[SEC]["ma_per_d"] = ma_per
				ldd_d = ldd
			end
			if pos == 0 then
				drawdown = 0
			end
			if profit_max_mp < respct then
				profit_max_mp = respct
				ma_per_t[SEC]["drawdown_p"] = drawdown
				ma_per_t[SEC]["profit_p"] = respct
				ma_per_t[SEC]["ma_per_p"] = ma_per
				ldd_p = ldd
			end
			
			-- rowc = Insertrowc(tb_res, -1)
			-- SetCell(tb_res, rowc, 1, SEC)
			-- SetCell(tb_res, rowc, 2, CLASS)
			-- SetCell(tb_res, rowc, 3, getSecurityInfo(CLASS, SEC).short_name)
			-- SetCell(tb_res, rowc, 4, string.format(price_format, curr_min))
			-- SetCell(tb_res, rowc, 5, string.format(price_format, res_min))
			-- SetCell(tb_res, rowc, 6, string.format(price_format, res_max))
			-- SetCell(tb_res, rowc, 7, string.format(price_format,respct))
			-- SetCell(tb_res, rowc, 8, string.format('%.0f', ma_per))
	
		end -- for ma_per=2, max_ma_per do
		sumpct_d = sumpct_d + ma_per_t[SEC]["profit_d"]
		sumpct_p = sumpct_p + ma_per_t[SEC]["profit_p"]
		-- SetCell(tb_res, i, 4, string.format('%.0f', j2))
		-- SetCell(tb_res, i, 5, string.format('%.0f', time_l))
		-- SetCell(tb_res, i, 6, string.format('%.0f', time_h_p))
		-- SetCell(tb_res, i, 7, string.format('%.2f', respct))
		if drawdown_p > ma_per_t[SEC]["drawdown_p"] then
			drawdown_p = ma_per_t[SEC]["drawdown_p"]
		end
		if drawdown_d < ma_per_t[SEC]["drawdown_d"] then
			drawdown_d = ma_per_t[SEC]["drawdown_d"]
		end
		
		if ma_per_t[SEC]["ma_per_p"] < ma_per_t[SEC]["ma_per_d"] then
			ma_per_t[SEC]["ma_per_r"] = ma_per_t[SEC]["ma_per_p"]
			SetCell(tb_res, i, 5, string.format('%.0f', ldd_p))
		else
			ma_per_t[SEC]["ma_per_r"] = ma_per_t[SEC]["ma_per_d"]
			SetCell(tb_res, i, 5, string.format('%.0f', ldd_d))
		end

		SetCell(tb_res, i, 6, string.format(price_format, ma_per_t[SEC]["profit_p"]))
		SetCell(tb_res, i, 7, string.format(price_format, ma_per_t[SEC]["profit_d"]))
		SetCell(tb_res, i, 8, string.format('%.0f', ma_per_t[SEC]["ma_per_r"]))
	end -- for i, SEC in pairs(sec_list) do
	row0 = #sec_list+1
	row1 = #sec_list+2
	row2 = #sec_list+3
	SetCell(tb_res, row0, 6, string.format(price_format, sumpct_p/#sec_list))
	SetCell(tb_res, row0, 7, string.format(price_format, sumpct_d/#sec_list))
	SetCell(tb_res, row1, 5, string.format(price_format, drawdown_p))
	SetCell(tb_res, row1, 7, string.format(price_format, sumpct_p))
	SetCell(tb_res, row2, 5, string.format(price_format, drawdown_d))
	SetCell(tb_res, row2, 7, string.format(price_format, sumpct_d))
	return ma_per_t
end

--  ============================================
--  ============================================
--  ============================================
--  ============================================
--  ============================================

