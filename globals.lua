rhb = {}

rhb.Context = UI.CreateContext("Context")
rhb.Context:SetSecureMode("restricted")
rhb.Window = UI.CreateFrame("Frame", "MainWindow", rhb.Context)
rhb.Window:SetSecureMode("restricted")
rhb.WindowFrameTop = UI.CreateFrame("Texture", "Texture", rhb.Window)
rhb.WindowFrameTop:SetSecureMode("restricted")
rhb.WindowDrag = UI.CreateFrame("Frame", "drag frame", rhb.Window)

rhb.CombatStatus= UI.CreateFrame("Texture", "Texture", rhb.Window)
rhb.CenterFrame = UI.CreateFrame("Frame", "Texture", rhb.WindowFrameTop)
rhb.CenterFrame:SetSecureMode("restricted")
rhb.PlayerID=nil     -- set by buffmonitor on buff add event or addabilities event
rhb.LastTarget=nil
rhb.MouseOverUnit=nil  -- current mouseover unit ID
rhb.MouseOverUnitLastCast=nil -- unit id of the moment one spell une spell has been casted
rhb.groupMask = {}
rhb.groupBF = {}
rhb.groupTarget={}
rhb.groupReceivingSpell={} -- frame for receiving spell overlay  (active when the unit is receiving a cast from me)
rhb.groupHF = {}

rhb.groupName = {}
rhb.groupStatus = {}
rhb.groupRole = {}
rhb.groupHoTSpots = {}
rhb.groupHoTSpotsIcons = {}
rhb.groupCastBar = {}
rhb.IconsCache={}
rhb.IconsCacheCount=0
rhb.groupText = {}

rhb.SoloTable = {}
rhb.QueryTable = {}
rhb.RaidTable = {}
rhb.GroupTable = {}

rhb.UnitBuffTable = {}
rhb.FullBuffsList={}     -- used by buffmonitor
rhb.FullDeBuffsList={}    -- used by buffmonitor
rhb.NoIconsBuffList={} --list of buffs that doesn't have an icon because are not abilities, created by the function CompileBuffsList() in buffmonitor.lua
for i = 1, 20 do
    rhb.groupHoTSpots[i]= {}
    rhb.groupHoTSpotsIcons[i]= {}
	rhb.groupBF[i] = UI.CreateFrame("Texture", "Border", rhb.CenterFrame)
	rhb.groupHF[i] = UI.CreateFrame("Texture", "Health", rhb.groupBF[i])
    rhb.groupTarget[i] = UI.CreateFrame("Texture", "Target", rhb.groupBF[i])
    rhb.groupReceivingSpell[i] = UI.CreateFrame("Texture", "ReceivingSpell", rhb.groupBF[i])
    rhb.groupCastBar[i] = UI.CreateFrame("Texture", "ReceivingSpell", rhb.groupBF[i])
	rhb.groupName[i] = UI.CreateFrame("Text", "Name", rhb.groupBF[i])
	rhb.groupStatus[i] = UI.CreateFrame("Text", "Status", rhb.groupBF[i])
	rhb.groupRole[i] = UI.CreateFrame("Texture", "Role", rhb.groupBF[i])
	rhb.groupMask[i] = UI.CreateFrame("Frame", "group"..i, rhb.Window)
	rhb.groupMask[i]:SetSecureMode("restricted")
	--rhb.groupTooltip[i] = UI.CreateFrame("SimpleTooltip","groupT"..i, rhb.CenterFrame)
	rhb.RaidTable[string.format("group%.2d", i)] = true
	rhb.UnitBuffTable[string.format("group%.2d", i)] = {}
	for g= 1,5 do
		rhb.groupHoTSpots[i][g] = {}
        rhb.groupHoTSpots[i][g][0]=true --icon
        rhb.groupHoTSpots[i][g][1]=UI.CreateFrame("Texture", "HoT" .. tostring(g), rhb.groupBF[i])
        rhb.groupHoTSpots[i][g][2]=UI.CreateFrame("Text", "HoTText" .. tostring(g), rhb.groupBF[i])
        rhb.groupHoTSpots[i][g][3]=UI.CreateFrame("Text", "HoTTextShadow" .. tostring(g), rhb.groupBF[i])

        rhb.groupHoTSpotsIcons[i][g]={}
        rhb.groupHoTSpotsIcons[i][g][0]=false
        rhb.groupHoTSpotsIcons[i][g][1]="RiftHbot"
        rhb.groupHoTSpotsIcons[i][g][2]="Textures/buffhot.png"
        rhb.groupHoTSpotsIcons[i][g][3]=0 --stacks
        rhb.groupHoTSpotsIcons[i][g][4]=false    --updated  (true if icon has just updated)
        rhb.groupHoTSpotsIcons[i][g][5]=nil    --buff spell ID     (used for remove buff )
        rhb.groupHoTSpotsIcons[i][g][6]=false    --is debuff    true if the debuff applied is a debuff
	end
end
for i = 1, 5 do
	rhb.GroupTable[string.format("group%.2d", i)] = true

	rhb.UnitBuffTable[string.format("group%.2d.pet", i)] = {}
end
rhb.clickOffset = {x = 0, y = 0}
rhb.resizeOffset = {x = 0, y = 0 }
rhb.UnitBuffTable["player"] = {}
rhb.UnitBuffTable["player.pet"] = {}
rhb.UnitTable = {"player", "player.pet"}
rhb.UnitsTable = {}
rhb.SoloTable["player"] = true
rhb.UnitsTableStatus={}
for i= 1,20 do
    local name=string.format("group%.2d", i)
    table.insert(rhb.UnitsTable,name);
    rhb.UnitsTableStatus[name]={}
    rhb.UnitsTableStatus[name][1]=false --aggro
    rhb.UnitsTableStatus[name][2]=false --offline
    rhb.UnitsTableStatus[name][3]=false --not in los
    rhb.UnitsTableStatus[name][4]="none" --role
    rhb.UnitsTableStatus[name][5]=0 --Unit ID
    rhb.UnitsTableStatus[name][6]=false --is target   (not used)
    rhb.UnitsTableStatus[name][7]=i --Frame index  used for buff monitor
    rhb.UnitsTableStatus[name][8]=false -- position change check
end
rhb.UnitsTableStatus["player"]={}
rhb.UnitsTableStatus["player"][1]=false --aggro
rhb.UnitsTableStatus["player"][2]=false --offline
rhb.UnitsTableStatus["player"][3]=false --not in los
rhb.UnitsTableStatus["player"][4]="none" --role
rhb.UnitsTableStatus["player"][5]=0 --Unit ID
rhb.UnitsTableStatus["player"][6]=false  --is target
rhb.UnitsTableStatus["player"][7]=1  --frame index    used for buff monitor
rhb.UnitsTableStatus["player"][8]=false -- position change check
rhb.UnitsGroupTable = {"group01", "group02", "group03", "group04", "group05"}
rhb.Calling = {"warrior", "cleric", "mage", "rogue", "percentage"}
rhb.Role = {"tank", "heal", "dps", "support" }
rhb.ResizeButton = UI.CreateFrame("Texture", "ResizeButton", rhb.Window)
rhb.clickOffset = {x = 0, y = 0}
rhb.resizeOffset = {x = 0, y = 0}
--options gui
rhb.WindowOptions = UI.CreateFrame("SimpleWindow", "Options", rhb.Context)
rhb.WindowOptionsTab = UI.CreateFrame("SimpleTabView", "OptionsWindowFrame", rhb.WindowOptions)
rhb.WindowOptionsBuffs = UI.CreateFrame("Frame", "OptionsWindowA", rhb.WindowOptionsTab)
rhb.WindowOptionsDebuffs = UI.CreateFrame("Frame", "OptionsWindowB", rhb.WindowOptionsTab)
rhb.WindowOptionsMouse = UI.CreateFrame("Frame", "OptionsWindowC", rhb.WindowOptionsTab)
rhb.WindowOptionsTab:AddTab("Buffs",rhb.WindowOptionsBuffs)
rhb.WindowOptionsTab:AddTab("Debuffs",rhb.WindowOptionsDebuffs)
rhb.WindowOptionsTab:AddTab("Mouse",rhb.WindowOptionsMouse)
--buff  gui
rhb.BuffsListView={}
rhb.BuffsList={}
rhb.BuffsRemoveButtons={}
rhb.BuffsMoveUpButtons={}
rhb.BuffsMoveDownButtons={}
rhb.BuffListAddBuff = {}
rhb.BuffListAddBuffButtons = {}
for i = 1 , 4 do
    rhb.BuffsListView[i] = UI.CreateFrame("SimpleScrollView", "List", rhb.WindowOptionsBuffs)
    rhb.BuffsList[i] = UI.CreateFrame("SimpleList", "List", rhb.WindowOptionsBuffs)
    rhb.BuffsRemoveButtons[i]= UI.CreateFrame("RiftButton", "RemoveBuffSlot"..tostring(i), rhb.WindowOptionsBuffs)
    rhb.BuffsMoveUpButtons[i]= UI.CreateFrame("RiftButton", "MoveUpBuffSlot"..tostring(i), rhb.WindowOptionsBuffs)
    rhb.BuffsMoveDownButtons[i]= UI.CreateFrame("RiftButton", "MoveDownBuffSlot"..tostring(i), rhb.WindowOptionsBuffs)
    rhb.BuffListAddBuff[i] = UI.CreateFrame("RiftTextfield", "BuffListAddBuffTextAres"..tostring(i), rhb.WindowOptionsBuffs)
    rhb.BuffListAddBuffButtons[i]= UI.CreateFrame("RiftButton", "BuffListAddBuffButtons"..tostring(i), rhb.WindowOptionsBuffs)
end
--debuff gui
rhb.ChkDebuffCache= UI.CreateFrame("SimpleCheckbox", "List", rhb.WindowOptionsDebuffs)
rhb.DebuffsListView = UI.CreateFrame("SimpleScrollView", "List", rhb.WindowOptionsDebuffs)
rhb.DebuffsList = UI.CreateFrame("SimpleList", "List", rhb.WindowOptionsDebuffs)
rhb.DebuffsListAddTextbox = UI.CreateFrame("RiftTextfield", "DebuffsListAddTextbox", rhb.WindowOptionsDebuffs)
rhb.DebuffsListRemove= UI.CreateFrame("RiftButton", "DebuffsListRemove", rhb.WindowOptionsDebuffs)
rhb.DebuffsListAdd= UI.CreateFrame("RiftButton", "DebuffsListAdd", rhb.WindowOptionsDebuffs)
rhb.DebuffsListMoveUp= UI.CreateFrame("RiftButton", "DebuffsListMoveUp", rhb.WindowOptionsDebuffs)
rhb.DebuffsListMoveDown= UI.CreateFrame("RiftButton", "DebuffsListMoveDown", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListView = UI.CreateFrame("SimpleScrollView", "List", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheList = UI.CreateFrame("SimpleList", "List", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListName = UI.CreateFrame("Text", "text", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListDesc = UI.CreateFrame("Text", "text", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListIcon = UI.CreateFrame("Texture", "text", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListUpdate= UI.CreateFrame("RiftButton", "DebuffsCacheListUpdate", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListClear= UI.CreateFrame("RiftButton", "ClearDebuffCache", rhb.WindowOptionsDebuffs)
rhb.DebuffsCacheListCopyToCurrent= UI.CreateFrame("RiftButton", "DebuffsCacheListCopyToCurrent", rhb.WindowOptionsDebuffs)
--mouse gui
rhb.WindowOptionsMouseTabControl = UI.CreateFrame("SimpleTabView", "OptionsMouseWindowFrame", rhb.WindowOptionsMouse)
rhb.WindowOptionsMouseTabs={}
rhb.WindowOptionsMouseButtonCommands={}
rhb.WindowOptionsMouseButtonUpdateCommands={}
rhb.WindowOptionsMouseTabs[1] = UI.CreateFrame("Frame", "OptionsMouseWindowA", rhb.WindowOptionsMouse)
rhb.WindowOptionsMouseTabs[2] = UI.CreateFrame("Frame", "OptionsMouseWindowA", rhb.WindowOptionsMouse)
rhb.WindowOptionsMouseTabs[3] = UI.CreateFrame("Frame", "OptionsMouseWindowA", rhb.WindowOptionsMouse)
rhb.WindowOptionsMouseTabs[4] = UI.CreateFrame("Frame", "OptionsMouseWindowA", rhb.WindowOptionsMouse)
rhb.WindowOptionsMouseTabs[5] = UI.CreateFrame("Frame", "OptionsMouseWindowA", rhb.WindowOptionsMouse)
rhb.WindowOptionsMouseTabControl:AddTab("Left Click",rhb.WindowOptionsMouseTabs[1])
rhb.WindowOptionsMouseTabControl:AddTab("Right Click",rhb.WindowOptionsMouseTabs[2])
rhb.WindowOptionsMouseTabControl:AddTab("Middle Click",rhb.WindowOptionsMouseTabs[3])
rhb.WindowOptionsMouseTabControl:AddTab("Button4 Click",rhb.WindowOptionsMouseTabs[4])
rhb.WindowOptionsMouseTabControl:AddTab("Button5 Click",rhb.WindowOptionsMouseTabs[5])

for i = 1 ,5 do
    local parent =  rhb.WindowOptionsMouseTabs[i]
    rhb.WindowOptionsMouseButtonCommands[i]={}
    rhb.WindowOptionsMouseButtonUpdateCommands[i]=UI.CreateFrame("RiftButton", "WindowOptionsMouseButtonUpdateCommands"..tostring(i), rhb.WindowOptionsMouseTabs[i])
    for g= 1 , 4 do
        rhb.WindowOptionsMouseButtonCommands[i][g]= UI.CreateFrame("SimpleTextArea", "DebuffsListAddTextbox",parent)
    end
end





