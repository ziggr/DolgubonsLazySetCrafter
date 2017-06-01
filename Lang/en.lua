DolgubonSetCrafter = DolgubonSetCrafter or {}

DolgubonSetCrafter.lang = "en"

DolgubonSetCrafter.localizedStrings = {}

DolgubonSetCrafter.localizedStrings.UIStrings = {}
DolgubonSetCrafter.localizedStrings.UIStrings.patternHeader       = "Select Pieces"
DolgubonSetCrafter.localizedStrings.UIStrings.comboboxHeader      = "Attributes"
DolgubonSetCrafter.localizedStrings.UIStrings.comboboxDefault     = "Select <<1>>"
DolgubonSetCrafter.localizedStrings.UIStrings.selectPrompt        = "Please select a <<1>>"
DolgubonSetCrafter.localizedStrings.UIStrings.style               = "Style"
DolgubonSetCrafter.localizedStrings.UIStrings.level               = "Level"
DolgubonSetCrafter.localizedStrings.UIStrings.CP                  = "CP"
DolgubonSetCrafter.localizedStrings.UIStrings.armourTrait         = "Armour Trait"
DolgubonSetCrafter.localizedStrings.UIStrings.weaponTrait         = "Weapon Trait"
DolgubonSetCrafter.localizedStrings.UIStrings.quality             = "Quality"
DolgubonSetCrafter.localizedStrings.UIStrings.gearSet             = "Set"
DolgubonSetCrafter.localizedStrings.UIStrings.addToQueue          = "Add to Queue"
DolgubonSetCrafter.localizedStrings.UIStrings.queueHeader         = "Crafting Queue"
DolgubonSetCrafter.localizedStrings.UIStrings.clearQueue          = "Clear Queue"
DolgubonSetCrafter.localizedStrings.UIStrings.resetToDefault      = "Clear Selections"
DolgubonSetCrafter.localizedStrings.UIStrings.notEnoughKnowledge  = "You do not have enough knowledge to make this attribute"
DolgubonSetCrafter.localizedStrings.UIStrings.notEnoughMats       = "You do not have enough materials to make this attribute"



DolgubonSetCrafter.localizedStrings.weaponNames = 
{
    "Axe", "Mace", "Sword", "Battle Axe", "Maul", "Greatsword", "Dagger", "Bow", "Fire Staff", "Ice Staff", "Lightning Staff", "Restoration Staff", "Shield"
}
DolgubonSetCrafter.localizedStrings.pieceNames = 
{
    "Chest","Feet","Hands","Head","Legs","Shoulders","Belt","Jerkin"
}
DolgubonSetCrafter.localizedStrings.armourTypes = 
{
    "Heavy", "Medium", "Light"
}
ZO_CreateStringId("SI_BINDING_NAME_SET_CRAFTER_OPEN", "Open/close the Set Crafter")

DolgubonSetCrafter.localizedStrings.optionStrings = {}
-- TODO List:
-- Settings Menu - not show at craft stations
-- Add multiple?
-- Number of items in queue
--[[
function FurC.LoadFrameInfo()
    local settings = FurC.settings["gui"]

    FurC_GUI:ClearAnchors()
    FurC_GUI:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, settings["lastX"], settings["lastY"])

    FurC_GUI:SetWidth(settings["width"])
    FurC_GUI:SetHeight(settings["height"])

    zo_callLater(function() FurC.UpdateInventoryScroll() end, 100)

end

function FurC.SaveFrameInfo()    
    local settings = FurC.settings["gui"]

    settings["lastX"]    = FurC_GUI:GetLeft()
    settings["lastY"]    = FurC_GUI:GetTop()
    settings["width"]    = FurC_GUI:GetWidth()
    settings["height"]    = FurC_GUI:GetHeight()

    FurC.UpdateInventoryScroll()

end

manavortex @manavortex 04:40
The suggestion was to clear the two "clear xx" buttons away in favour of a little x in a circle or so 
And it's resizeable because
 <TopLevelControl name="FurC_GUI" clampedToScreen="true"  movable="true" mouseEnabled="true" hidden="true" resizeHandleSize="10">
            <DimensionConstraints x="800" y="500" minX="850" minY="200" maxY="2000"/>
            <Anchor point="TOPRIGHT" relativeTo="GUI_ROOT" relativePoint="TOPRIGHT" offsetX="-25" offsetY="40" />
            <OnMoveStop>FurC.SaveFrameInfo("onMoveStop")</OnMoveStop>

            <OnResizeStop>FurC.OnResizeStop()</OnResizeStop>            
            <Controls> ... </Controls>
</TopLevelControl>]]
    


--NEW ADDON: Dolgubon's Lazy Set Crafter! Make sets of gear easily and quickly, at ANY quality!! Check out tinyurl.com/SetCrafter for more info!

--/Script BeginGroupElection(0, "Press F to start... well... something" ,nil)