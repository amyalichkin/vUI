local vUI, GUI, Language, Assets, Settings = select(2, ...):get()

local UnitArmor = UnitArmor
local UnitLevel = UnitLevel
local Label = Language["Armor"]

local OnMouseUp = function()
	ToggleCharacter("PaperDollFrame")
end

local Update = function(self, event, unit)
	if (unit and unit ~= "player") then
		return
	end
	
	local Base, EffectiveArmor, Armor, PosBuff, NegBuff = UnitArmor("player")
	local Level = UnitLevel("player")
	local Reduction = EffectiveArmor / ((85 * Level) + 400)
	
	Reduction = 100 * (Reduction / (Reduction + 1))
	
	self.Text:SetFormattedText("|cFF%s%s:|r |cFF%s%.1f%%|r", Settings["data-text-label-color"], Label, Settings["data-text-value-color"], Reduction)
end

local OnEnable = function(self)
	self:RegisterEvent("UNIT_STATS")
	self:SetScript("OnEvent", Update)
	self:SetScript("OnMouseUp", OnMouseUp)
	
	self:Update(nil, "player")
end

local OnDisable = function(self)
	self:UnregisterEvent("UNIT_STATS")
	self:SetScript("OnEvent", nil)
	self:SetScript("OnMouseUp", nil)
	
	self.Text:SetText("")
end

vUI:AddDataText("Armor", OnEnable, OnDisable, Update)