			SetCell(tb_res, row, 4, string.format('%.2f', pdi))
			SetCell(tb_res, row, 5, string.format('%.2f', mdi))
			-- SetCell(tb_res, row, 9, string.format('%.2f', MA[SEC][8]))
			-- SetCell(tb_res, row, 10, string.format('%.2f', MA[SEC][9]))
			-- SetCell(tb_res, row, 11, string.format('%.2f', MA[SEC][10]))
			-- SetCell(tb_res, row, 12, string.format('%.2f', MA[SEC][11]))
			qt = getQuoteLevel2(CLASS, SEC)
						-- message("1 "..tostring((os.sysdate().hour*60 + os.sysdate().min)%time_interval), 2)
			if tonumber(qt.bid_count)>=3 and tonumber(qt.offer_count)>=3 then
				prc_bid = tonumber(qt.bid[qt.bid_count-0].price)
				prc_off = tonumber(qt.offer[1].price)
						-- message("2 "..tostring((os.sysdate().hour*60 + os.sysdate().min)%time_interval), 2)
				if prc_bid < prc_off and  prc_off < prc_bid*1.001 then  -- and tm%time_interval>2
					-- message(SEC.." idx= "..idx, 1)
					-- cclose = ds[SEC]:C(idx)
					-- message(SEC.." cclose= "..cclose, 1)

						-- message("3 "..tonumber((os.sysdate().hour*60 + os.sysdate().min)%time_interval), 2)
					if tonumber((os.sysdate().hour*60 + os.sysdate().min)%time_interval) >= 1 then
						ld_1 = last_deal[SEC][1]
						
						if mdi > pdi then
							if last_deal[SEC][1] < 1 then
								SetCell(tb_res, row, 8, "BUY")
								SetColor(tb_res, row, 8, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
								last_deal = position_up(SEC, last_deal, 1)
								filer:write(SEC.." BUY: date="..dt.." time="..tm.." res="..last_deal[SEC][2].." price="..prc_off, '\n')
								SetCell(tb_res, row, 6, string.format(price_format, prc_off))
							end
						elseif mdi < pdi then	
							if last_deal[SEC][1] > -dub_up then
								SetCell(tb_res, row, 8, "SELL")
								SetColor(tb_res, row, 8, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
								last_deal = position_dn(SEC, last_deal, 1)
								filer:write(SEC.." SELL: date="..dt.." time="..tm.." res="..last_deal[SEC][2].." price="..prc_bid, '\n')
								SetCell(tb_res, row, 6, string.format(price_format, prc_bid))
							end
						end
								
						if ld_1 ~= last_deal[SEC][1] then
							prints(sec_list, last_deal)
							--message("DEAL ".." : "..tostring(ld_1).." => "..tostring(last_deal[SEC][1]).." "..SEC.." "..time_interval.."min".." "..tostring(last_deal[SEC][5]), 1)
						end
						if not getSecurityInfo(CLASS, SEC) then
							message(SEC.." SCALE is nil, miss sequrity", 2)
						else
							if getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365) then
								LOTS_VALUE=getSecurityInfo(CLASS, SEC).lot_size
								tn=getDepoEx(FIRM_ID, CLIENT_CODE, SEC, TRADE_ACC, 365).currentbal/LOTS_VALUE
								if tn ~= last_deal[SEC][1] then
									SCALE=getSecurityInfo(CLASS, SEC).scale
									PRICE_STEP=getSecurityInfo(CLASS, SEC).min_price_step
									price_format = '%.'..tostring(SCALE)..'f'
									if last_deal[SEC][1] > tn then
										buy_now(tn, last_deal[SEC][1]*last_deal[SEC][6], SEC, price_format, PRICE_STEP)
									elseif last_deal[SEC][1] < tn then
										sell_now(tn, dub_up*last_deal[SEC][1]*last_deal[SEC][6], SEC, price_format, PRICE_STEP)
									end
									sleep(5000)
								end
							end
						end
					-- else
						-- message("3 "..tonumber((os.sysdate().hour*60 + os.sysdate().min)%time_interval), 2)
					end
					last_deal_aver(last_deal, sec_list, tb_res, last_row)
				end
			else
				SetCell(tb_res, row, 8, "no quote")
				-- SetColor(tb_res, row, 8, RGB(160,160,160),RGB(0,0,0), RGB(160,160,160), RGB(0,0,0))
			end
			
			
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
		last_deal[SEC][5] = prc
	return last_deal
end
--  ============================================
function position_up(SEC, last_deal, ldnums)
	qt = getQuoteLevel2(CLASS, SEC)
	if qt and qt.offer and tonumber(qt.offer_count) ~= 0 then
		ofS = tonumber(qt.offer[1].price)
		res = last_deal[SEC][3]+(last_deal[SEC][1])*ofS
		if last_deal[SEC][1] ~= 0 then
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
		if last_deal[SEC][1] ~= 0 then
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
	percent = tonumber(last_deal[SEC][4])
	if last_deal[SEC][5] > 0 then
		idx=ds[SEC]:Size()
		percent = percent +(last_deal[SEC][3]+last_deal[SEC][1]*ds[SEC]:C(idx)-last_deal[SEC][2])*100/last_deal[SEC][5]
	end
	SetCell(tb_res, row, 7, string.format('%.2f', percent))
	if percent > 0 then
		SetColor(tb_res, row, 7, RGB(160,255,160),RGB(0,0,0), RGB(160,255,160), RGB(0,0,0))
	elseif percent < 0 then
		SetColor(tb_res, row, 7, RGB(255,160,160),RGB(0,0,0), RGB(255,160,160), RGB(0,0,0))
	else
		SetColor(tb_res, row, 7, RGB(255,255,255), RGB(0,0,0), RGB(255,255,255), RGB(0,0,0))
	end
	return percent
end
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

--  ============================================
