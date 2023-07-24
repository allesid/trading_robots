-- package.cpath = "C:\\QuikKITFinance\\lua-c-dll\\.Build\\x64\\Release-Lua53\\"
t = require("luacdll")
message("==========================", 1)
-- message(tostring(t))
for k,v in pairs(t) do
	message(tostring(k).." v="..tostring(v),1)
end

-- message(tostring(t.GetCurrentThreadId()), 1)

-- function main()
	-- for i = 1, 10 do
		-- r = t.MultTwoNumbers(i, i+1)
		-- r1 = t.MultAllNumbers(i, i+1,i+2, i+3, i+6, i+4,i, i+5)
		-- message (tostring(r).."  "..tostring(r1), 1)
	-- end
-- end

SEC="SBER"
CLASS="TQBR"
bid_count = 0
offer_count = 0
fl = 1
is_run = true

PRICE_STEP=getSecurityInfo(CLASS, SEC).min_price_step
message("    PRICE_STEP="..PRICE_STEP, 1)

if Subscribe_Level_II_Quotes(CLASS, SEC) then
	-- sleep(100)
	qt = getQuoteLevel2(CLASS, SEC)
	message(tostring(qt), 2)
	message(qt.bid_count.."  "..qt.offer_count, 2)
	if tonumber(qt.bid_count) ~= 0 and tonumber(qt.offer_count) ~= 0 then
		bid_count = qt.bid_count
		offer_count = qt.offer_count
		tb = qt.bid
		tof = qt.offer
		message("Glass loaded", 1)
		message("    bid_count="..bid_count, 1)
		message("    offer_count="..offer_count, 1)
	else
		fl = 0
	end
	message("1 "..fl, 2)
else
	fl = 0
	message("2 "..fl, 2)
end
if fl == 0 then
	-- bid = tonumber(qt.bid[qt.bid_count-0].price)
	-- of = tonumber(qt.offer[1].price)

	-- bid_count = 3
	-- offer_count = 2
	tb = {{price=1.1, quantity=1},{price=2.2, quantity=2},{price=3.3, quantity=3}}
	tof = {{price=4.4, quantity=4},{price=5.5, quantity=5},{price=6.6, quantity=6}}

	-- qt = {bid_count=#tb, offer_count=#tof, bid=tb, offer=tof}

	bid_count = #tb
	offer_count = #tof
	
	message("Glass example", 1)

end

function main()
	i = 0
	while is_run do
		sleep(50)
		if fl == 0 then
			local tm1 = os.sysdate().sec + os.sysdate().ms*0.001 + os.sysdate().mcs*0.000001
			-- message("time1, sec : "..string.format('%.6f', tm1), 1)
			out = {t.GetTable(tof, tb, offer_count, bid_count,PRICE_STEP)}
			-- message("time1, sec : "..string.format('%.6f', tm1), 1)
			local tm2 = os.sysdate().sec + os.sysdate().ms*0.001 + os.sysdate().mcs*0.000001 - tm1
			-- message("time, sec : "..string.format('%.4f', tm).."  "..string.format('%.1f', out[1]).."  "..string.format('%.1f',out[2]), 1)
			message("time2, sec : "..string.format('%.6f', tm2), 1)
			-- .."  len_out="..tostring(#out).."  out="..tostring(out[#out]), 1)
			-- for k,v in pairs(out) do
				-- message("k="..tostring(k).."  v="..tostring(v), 1)
				-- for k1,v1 in pairs(v) do
					-- message("  k1="..tostring(k1).."  v1="..tostring(v1), 1)
					-- for k2,v2 in pairs(v1) do
						-- message("    k2="..tostring(k2).."  v2="..tostring(v2), 1)
					-- end
				-- end
			-- end
		end
	end
end

function OnQuote(class, secr)
	if class == CLASS and secr == SEC then
		local tm0 = os.sysdate().sec + os.sysdate().ms*0.001 + os.sysdate().mcs*0.000001
		qt = getQuoteLevel2(class, secr)
		-- message(tostring(qt), 2)
		-- message(qt.bid_count.."  "..qt.offer_count, 2)
		-- if tonumber(qt.bid_count) ~= 0 and tonumber(qt.offer_count) ~= 0 then
			out = {t.GetTable(qt.offer, qt.bid, qt.offer_count, qt.bid_count,PRICE_STEP)}
		-- end
		local tm = os.sysdate().sec + os.sysdate().ms*0.001 + os.sysdate().mcs*0.000001 - tm0
		message("time, sec : "..string.format('%.4f', tm), 1)
		-- message("time, sec : "..string.format('%.6f', tm).."  "..tostring(#out).."  "..tostring(out[#out]).."  "..tostring(out[#out-1]), 1)
		-- for k,v in pairs(out) do
			-- message(tostring(k).."  "..tostring(v), 1)
		-- end
	end
end