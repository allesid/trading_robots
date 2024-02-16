-- LC - last close

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

path_name = "C:/Projects/trading_robots/LC/"
close_fm = 0.0 -- level higher or lower which makes deal: 
				-- this level buy = (H + L)/2 + (H - L) * close_fm = H*(0.5+close_fm) + L*(0.5-close_fm)
				-- this level sell =(H + L)/2 - (H - L) * close_fm = H*(0.5-close_fm) + L*(0.5+close_fm)
				-- [0 to 1[
stop_level = 0.9  -- H+stop_level*(H-L)*0.5
				
time_interval = INTERVAL_D1

ver = "v2"..SEC.."-TEST" -- "WORK"
--  ========    DATA    ====================
chart_tag = SEC
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

comis = 0.0005
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
PRICE_STEP = getSecurityInfo(CLASS, SEC).min_price_step
--  ============================================
		end_of_name_res = EXCH.."-ti"..tostring(time_interval).."-"..ver..".txt"
		sum_result_fn = path_name.."LC-Label-"..end_of_name_res
	filer_res=io.open(sum_result_fn, "w")
	filer_res:write("========================================", '\n')
	-- filer_res:write(SEC.."  "..tostring(dt).."  "..tostring(tm), '\n')

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
			["FONT_HEIGHT"]=8,
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
			["FONT_HEIGHT"]=8,
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
			["FONT_HEIGHT"]=8,
			["TRANSPARENT_BACKGROUND"]=1, -- «0» – прозрачность отключена, «1» – прозрачность включена
			["TRANSPARENCY"]= 0  -- Прозрачность метки в процентах. Значение должно быть в промежутке [0; 100]
			}
--==================================================
function OnInit(s)
end
--  ============================================

function main()

	DelAllLabels(chart_tag)	

	ds, error_desc = CreateDataSource(CLASS, SEC, time_interval) 
	sleep(100)
	if ds == nil then
		message(SEC.." error in CreateDataSource: "..error_desc, 2)
	else
		if ds:Size() == 0 then 
			ds:SetEmptyCallback()
			sleep(500)
			--message(SEC.." ds:Size() == "..ds:Size(), 2)
		end
	end
	ds_size = ds:Size()
	message(SEC.." ds:Size() == "..ds_size, 2)
	pos = 0
	res = 0
	ld = 0
	ld_1 = ld
	for i = 2, ds_size-1 do
		ld_1 = ld
		if ld == 1 then
			slb = ds:H(i-1)+stop_level*(ds:H(i-1)-ds:L(i-1))
			if ds:H(i) > slb then
				ld_1 = ld
				ld = 0
				res = pos + ld_1*slb
				pos=pos-(ld-ld_1)*slb-math.abs(ld-ld_1)*comis*slb
				STOPlabel["YVALUE"]=slb
				STOPlabel["DATE"]=ds:T(i).year*10000+ds:T(i).month*100+ds:T(i).day
				STOPlabel["TIME"]=ds:T(i).hour*10000+ds:T(i).min*100
				STOPlabel["HINT"]=string.format('%.2f',res).."  ld="..ld
				AddLabel(chart_tag, STOPlabel)
			end
		elseif ld == -1 then
			sls = ds:L(i-1)-stop_level*(ds:H(i-1)-ds:L(i-1))
			if ds:L(i) < sls then
				ld_1 = ld
				ld = 0
				res = pos + ld_1*sls
				pos=pos-(ld-ld_1)*sls-math.abs(ld-ld_1)*comis*sls
				STOPlabel["YVALUE"]=sls
				STOPlabel["DATE"]=ds:T(i).year*10000+ds:T(i).month*100+ds:T(i).day
				STOPlabel["TIME"]=ds:T(i).hour*10000+ds:T(i).min*100
				STOPlabel["HINT"]=string.format('%.2f',res).."  ld="..ld
				AddLabel(chart_tag, STOPlabel)
			end
		-- else
			-- res = pos + ld*ds:C(i+1)-math.abs(ld)*comis*ds:C(i+1)
			-- pos=pos+ld*ds:C(i+1)-math.abs(ld)*comis*ds:C(i+1)
		end

			lup = ds:H(i)*(0.5+close_fm) + ds:L(i)*(0.5-close_fm)
			ldn = ds:H(i)*(0.5-close_fm) + ds:L(i)*(0.5+close_fm)
			message(lup.."  "..ldn.."  "..res, 1)
			if ds:C(i) > lup and ds:L(i+1) < ds:C(i) then
				ld_1 = ld
				ld = 1
				res = pos + ld_1*ds:C(i)
				pos=pos-(ld-ld_1)*ds:C(i)-math.abs(ld-ld_1)*comis*ds:C(i)
				Blabel["YVALUE"]=ds:C(i)
				Blabel["DATE"]=ds:T(i+1).year*10000+ds:T(i+1).month*100+ds:T(i+1).day
				Blabel["TIME"]=ds:T(i+1).hour*10000+ds:T(i+1).min*100
				Blabel["HINT"]=string.format('%.2f',res).."  ld="..ld
				AddLabel(chart_tag, Blabel)
			elseif ds:C(i) < ldn and ds:H(i+1) > ds:C(i) then
				ld_1 = ld
				ld = -dub_up
				res = pos + ld_1*ds:C(i)
				pos=pos-(ld-ld_1)*ds:C(i)-math.abs(ld-ld_1)*comis*ds:C(i)
				Slabel["YVALUE"]=ds:C(i)
				Slabel["DATE"]=ds:T(i+1).year*10000+ds:T(i+1).month*100+ds:T(i+1).day
				Slabel["TIME"]=ds:T(i+1).hour*10000+ds:T(i+1).min*100
				Slabel["HINT"]=string.format('%.2f',res).."  ld="..ld
				AddLabel(chart_tag, Slabel)
			end
		
		message(res, 1)	
		filer_res:write("res="..res, '\n')
	end
	message("res="..res, 1)	
end
