-- Dolgubon's Lazy Set Crafter
-- Created December 2016
-- Last Modified: December 23 2016
-- 
-- Created by Dolgubon (Joseph Heinzle)
-----------------------------------
--

-----------------------------------
--Addon Namespace creation
DolgubonSetCrafter = DolgubonSetCrafter or {}

------------------------------------
-- TRAIT DECLARATION
DolgubonSetCrafter.weaponTraits = {}
for i = 0, 8 do --create the weapon trait table
	--Takes the strings starting at SI_ITEMTRAITTYPE0 == no trait, # 897 to SI_ITEMTRAITTYPE8 === Divines, #905
	--Then saves the proper trait index used for crafting to it. The offset of 1 is due to ZOS; the offset of STURDY is so they start at 12
	DolgubonSetCrafter.weaponTraits[i + 1] = {[1]  = i + 1, [2] = GetString(SI_ITEMTRAITTYPE0 + i),}
end

DolgubonSetCrafter.armourTraits = {}
DolgubonSetCrafter.armourTraits[#DolgubonSetCrafter.armourTraits + 1] = {[1] = ITEM_TRAIT_TYPE_NONE + 1, [2] = GetString(SI_ITEMTRAITTYPE0)} -- No Trait to armour traits
for i = 0, 7 do --create the armour trait table
	--Takes the strings starting at SI_ITEMTRAITTYPE11 == Sturdy, # 908 to SI_ITEMTRAITTYPE18 === Divines, #915
	--Then saves the proper trait index used for crafting to it. The offset of 1 is due to ZOS; the offset of STURDY is so they start at 12
	DolgubonSetCrafter.armourTraits[#DolgubonSetCrafter.armourTraits + 1] = {[1] = i + 1 + ITEM_TRAIT_TYPE_ARMOR_STURDY, [2] = GetString(SI_ITEMTRAITTYPE11 + i)}
end
--Add a few missing traits to the tables - i.e., nirnhoned, and no trait

DolgubonSetCrafter.armourTraits[#DolgubonSetCrafter.armourTraits + 1] = {[1] = ITEM_TRAIT_TYPE_ARMOR_NIRNHONED + 1, [2] = GetString(SI_ITEMTRAITTYPE26)} -- Nirnhoned
DolgubonSetCrafter.weaponTraits[#DolgubonSetCrafter.weaponTraits + 1] = {[1] = ITEM_TRAIT_TYPE_WEAPON_NIRNHONED + 1, [2] = GetString(SI_ITEMTRAITTYPE25)}  -- Nirnhoned

--------------------------------------
--- STYLES
	
local bretonFlavour = GetItemLinkFlavorText(GetSmithingStyleItemLink(2 , 0))
local FlavourText = GetItemLinkFlavorText(GetSmithingStyleItemLink(3 , 0)) -- actually redguard

local excludedStyles =
{ -- Unique(10) Bandit(18) Maormer (32), Reach Winter (37) Tsaesci(38), Redoran(48), Hlaalu (49), Telvanni(51), Worm Cult(55), others are unused styles
	10, 18, 32, 37, 38, 48, 49, 51, 55
}

local function isStyleExcluded(index)
	for i = 1, #excludedStyles do
		if index == excludedStyles[i] then
			return true
		end
	end
	if index >59 then  return true end -- it is an 'Unused ##' style
	return false
end

--setup Style Table

local styles = {}
for i = 1, GetNumSmithingStyleItems() do
	if GetString("SI_ITEMSTYLE", i)~="" then
		d(GetString("SI_ITEMSTYLE", i)..i)
		if not isStyleExcluded(i) then
			
			styles[#styles + 1] = {i+1 ,GetString("SI_ITEMSTYLE", i),}
		end
	end
end
table.sort(styles, function (a,b) return a[2]<b[2] end)
-- Add Colours based on knowledge 
for i = 1, #styles do
	local colour = "|cFFFFFF"
	if not IsSmithingStyleKnown(styles[i][1]) then colour = "|c808080"  end
	styles[i][2] = colour..styles[i][2].."|r"
end
DolgubonSetCrafter.styleNames = styles

------------------------------------
-------- QUALITY

local qualityColours = {"FFFFFF","1aff1a","1a75ff","e600e6","ffff33"}


--Setup quality table
DolgubonSetCrafter.quality = {}

for i = 1, 5 do
	DolgubonSetCrafter.quality[i] = {[1] = i, [2] = "|c"..qualityColours[i]..GetString(SI_ITEMQUALITY0 + i).."|r"}
end

--------------------------------------
--------- CRAFTING REQUIREMENTS

-- This is a bit more esoteric, in how it's set up. Basically, crafting requirements mainly follow a few patterns
-- About 75% of them follow the pattern. Greaves are odd just because, but the other 8 follow a second pattern.
-- The second pattern only changes at the highest levels. The following reduces the pattern.

local requirementJumps = { -- At these material indexes, the material required changes, and the amount required jumps down
	[1] = 1,
	[2] = 8,
	[3] = 13,
	[4] = 18,
	[5] = 23,
	[6] = 26,
	[7] = 29,
	[8] = 32,
	[9] = 34,
	[10] = 40,
}

local additionalRequirements = -- Seperated by station. The additional amount of mats added to the base amount.
{
	[CRAFTING_TYPE_BLACKSMITHING] = 
	{ 2, 2, 2, 4, 4, 4, 1, 6, 4, 4, 4, 5, 4, 4,
	},
	[CRAFTING_TYPE_WOODWORKING] = 
	{ 2, 5, 2, 2, 2, 2,
	},
	[CRAFTING_TYPE_CLOTHIER] = 
	{ 6, 6, 4, 4, 4, 5, 4, 4, 6, 4, 4, 4, 5, 4, 4,

	},
}

local currentStep = 1
local baseRequirements = {}
for i = 1, 41 do
	if requirementJumps[currentStep] == i then
		currentStep = currentStep + 1
		baseRequirements[i] = currentStep
	else
		baseRequirements[i] = baseRequirements[i-1] + 1
	end
end

DolgubonSetCrafter.setIndexes = {}
local t = GetSetIndexes()
for i, value in pairs(t) do
	DolgubonSetCrafter.setIndexes[i] = {}
	DolgubonSetCrafter.setIndexes[i][2] = t[i][1]
	DolgubonSetCrafter.setIndexes[i][1] = i
	
end

table.remove(DolgubonSetCrafter.setIndexes,1)

table.sort(DolgubonSetCrafter.setIndexes, function(a,b) return a[2]<b[2] end)
table.insert(DolgubonSetCrafter.setIndexes,1, {[1] = 1, [2] = "No Set"})


