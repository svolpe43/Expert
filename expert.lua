local recOn = false;
local recResult = 0;

function createFrame()
	textFrame = CreateFrame("frame","textFrame")
	textFrame:SetBackdrop({
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", 
	})
	textFrame:SetWidth(190)
	textFrame:SetHeight(120)
	textFrame:SetPoint("CENTER",UIParent)
	textFrame:EnableMouse(true)
	textFrame:SetMovable(true)
	textFrame:RegisterForDrag("LeftButton")
	textFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	textFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	textFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
	textFrame:SetFrameStrata("FULLSCREEN_DIALOG")

	TextLine1 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine1:SetPoint("TOPLEFT",textFrame,10,-10)
	TextLine1:SetText(string.format("Total Xp Gained"));

	TextLine2 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine2:SetPoint("TOPLEFT",textFrame,10,-25)
	TextLine2:SetText(string.format("Xp Left To Lvl"));

	TextLine3 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine3:SetPoint("TOPLEFT",textFrame,10,-40)
	TextLine3:SetText(string.format("Percent To 60"));

	TextLine4 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine4:SetPoint("TOPLEFT",textFrame,10,-55)
	TextLine4:SetText(string.format("Xp For Kill"));

	TextLine5 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine5:SetPoint("TOPLEFT",textFrame,10,-70)
	TextLine5:SetText(string.format("Kills To Lvl"));

	TextLine6 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine6:SetPoint("TOPLEFT",textFrame,10,-85)
	TextLine6:SetText(string.format("Xp/Hr Total"));

	TextLine7 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine7:SetPoint("TOPLEFT",textFrame,10,-100)
	TextLine7:SetText(string.format("Xp/Hr This Lvl"));

	TextLine11 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine11:SetPoint("TOPLEFT",textFrame,115,-10)
	TextLine11:SetText(string.format("..."));

	TextLine21 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine21:SetPoint("TOPLEFT",textFrame,115,-25)
	TextLine21:SetText(string.format("..."));

	TextLine31 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine31:SetPoint("TOPLEFT",textFrame,115,-40)
	TextLine31:SetText(string.format("..."));

	TextLine41 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine41:SetPoint("TOPLEFT",textFrame,115,-55)
	TextLine41:SetText(string.format("..."));

	TextLine51 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine51:SetPoint("TOPLEFT",textFrame,115,-70)
	TextLine51:SetText(string.format("..."));

	TextLine61 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine61:SetPoint("TOPLEFT",textFrame,115,-85)
	TextLine61:SetText(string.format("..."));

	TextLine71 = textFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	TextLine71:SetPoint("TOPLEFT",textFrame,115,-100)
	TextLine71:SetText(string.format("..."));
end

function stateFrame(state)
	if state == false then
		textFrame:Hide();
	end
	if state == true then
		textFrame:Show();
	end
end

function frametext(num, line)
	if num == 1 then
		TextLine1:SetText(line);
	end

	if num == 2 then
		TextLine2:SetText(line);
	end

	if num == 3 then
		TextLine3:SetText(line);
	end

	if num == 11 then
		TextLine11:SetText(line);
	end

	if num == 21 then
		TextLine21:SetText(line);
	end

	if num == 31 then
		TextLine31:SetText(line);
	end

	if num == 41 then
		TextLine41:SetText(line);
	end

	if num == 51 then
		TextLine51:SetText(line);
	end

	if num == 61 then
		TextLine61:SetText(line);
	end

	if num == 71 then
		TextLine71:SetText(line);
	end
end

function xp_up_to_lvl(lvl)
	total = 0;
	for i=1,lvl do
		total = total + xp_for_lvl(i);
	end
	return total;
end

function xp_for_unit_at_same_lvl(lvl)
	return 45 + (lvl * 5)
end

function xp_for_lvl(lvl)

	unit_xp_kill = xp_for_unit_at_same_lvl(lvl)
	offset = 5 * (lvl - 30)

	if lvl <= 28 then
		offset = 0
	elseif lvl == 29 then
		offset = 1
	elseif lvl == 30 then
		offset = 3
	elseif lvl == 31 then
		offset = 6
	end

	return ((8 * lvl) + offset) * unit_xp_kill
end

function total_xp_gained()
	return xp_up_to_lvl(UnitLevel("player") - 1) + UnitXP("player")
end

function percent_of_max_lvl()
	return (total_xp_gained()/xp_up_to_lvl(60)) * 100;
end

function xp_left_till_lvl()
	return  xp_for_lvl(UnitLevel("player")) - UnitXP("player")
end


createFrame();

SLASH_PHRASE1 = "/xp";
SlashCmdList["PHRASE"] = function(msg)
	if msg == "frame" then
		if isFrameOn == true then
			isFrameOn = false;
			stateFrame(false);
			DEFAULT_CHAT_FRAME:AddMessage("Frame OFF", 1.0, 0.0, 0.0);
		else
			isFrameOn = true;
			stateFrame(true);
			DEFAULT_CHAT_FRAME:AddMessage("Frame ON", 0.0, 1.0, 0.0);
		end
	end

	if msg == "" then
		DEFAULT_CHAT_FRAME:AddMessage("Expert v0.1", 0.0, 1.0, 0.0);
		DEFAULT_CHAT_FRAME:AddMessage("/xp frame - turn on and off frame window.", 0.0, 1.0, 0.0);
	end
end

local expGainEv = CreateFrame("Frame") 
expGainEv:RegisterEvent("CHAT_MSG_COMBAT_XP_GAIN") 
expGainEv:RegisterEvent("ADDON_LOADED")
expGainEv:RegisterEvent("TIME_PLAYED_MSG")
expGainEv:SetScript("OnEvent", function (self, event, arg1, arg2)

	if event == "ADDON_LOADED" and arg1 == "Expert" then
		if isChatOn == nil then
			isChatOn = false
		end
		if isFrameOn == nil then
			isFrameOn = true
		end

		if isFrameOn == true then
			stateFrame(true)
		else
			stateFrame(false)
		end
	end

	if event == "CHAT_MSG_COMBAT_XP_GAIN" then

		-- this will fire the TIME_PLAYED_MSG event caught above
		RequestTimePlayed()

		-- wait a bit then grab the xp so UnitXP updates
		C_Timer.After(0.5, function()
			frametext(11, string.format("%2.2f", xp_up_to_lvl(UnitLevel("player")) + UnitXP("player")));
			frametext(21, string.format("%2.2f", xp_left_till_lvl()));
			frametext(31, string.format("%2.3f", percent_of_max_lvl()));
			frametext(41, string.format("%2.2f", xp_for_unit_at_same_lvl(UnitLevel("player"))));
			frametext(51, string.format("%2.2f", xp_left_till_lvl()/xp_for_unit_at_same_lvl(UnitLevel("player"))));
		end)
	end

	if event == "TIME_PLAYED_MSG" then
		hours_total = arg1 / 3600
		hours_this_lvl = arg2 / 3600

		xp_per_hour_total = (xp_up_to_lvl(UnitLevel("player")) + UnitXP("player")) / hours_total
		xp_per_hour_this_lvl = UnitXP("player") / hours_this_lvl

		frametext(61, string.format("%2.2f", xp_per_hour_total));
		frametext(71, string.format("%2.2f", xp_per_hour_this_lvl));
	end
end)
