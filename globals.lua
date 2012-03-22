lb = {}

lb.Context = UI.CreateContext("Context")
lb.Context:SetSecureMode("restricted")
lb.Window = UI.CreateFrame("Frame", "MainWindow", lb.Context)
lb.Window:SetSecureMode("restricted")
lb.WindowFrameTop = UI.CreateFrame("Texture", "Texture", lb.Window)
lb.WindowFrameTop:SetSecureMode("restricted")
lb.WindowDrag = UI.CreateFrame("Frame", "drag frame", lb.Window)

lb.CombatStatus= UI.CreateFrame("Texture", "Texture", lb.Window)
lb.CenterFrame = UI.CreateFrame("Frame", "Texture", lb.WindowFrameTop)
lb.CenterFrame:SetSecureMode("restricted")
lb.PlayerID=nil     -- set by buffmonitor on buff add event or addabilities event
lb.LastTarget=nil
lb.MouseOverUnit=nil  -- current mouseover unit ID
lb.MouseOverUnitLastCast=nil -- unit id of the moment one spell une spell has been casted
lb.groupMask = {}
lb.groupBF = {}
lb.groupTarget={}
lb.groupReceivingSpell={} -- frame for receiving spell overlay  (active when the unit is receiving a cast from me)
lb.groupHF = {}
lb.groupRF = {} -- Resource Frame

lb.groupName = {}
lb.groupStatus = {}
lb.groupRole = {}
lb.groupHoTSpots = {}
lb.groupHoTSpotsIcons = {}
lb.groupCastBar = {}
lb.IconsCache={}
lb.IconsCacheCount=0
lb.groupText = {}

lb.SoloTable = {}
lb.QueryTable = {}
lb.RaidTable = {}
lb.GroupTable = {}

lb.UnitBuffTable = {}
lb.FullBuffsList={}     -- used by buffmonitor
lb.FullDeBuffsList={}    -- used by buffmonitor
lb.NoIconsBuffList={} --list of buffs that doesn't have an icon because are not abilities, created by the function CompileBuffsList() in buffmonitor.lua
for i = 1, 20 do
    lb.groupHoTSpots[i]= {}
    lb.groupHoTSpotsIcons[i]= {}
	lb.groupBF[i] = UI.CreateFrame("Texture", "Border", lb.CenterFrame)
	lb.groupHF[i] = UI.CreateFrame("Texture", "Health", lb.groupBF[i])
	lb.groupRF[i] = UI.CreateFrame("Texture", "Resource", lb.groupBF[i])
    lb.groupTarget[i] = UI.CreateFrame("Texture", "Target", lb.groupBF[i])
    lb.groupReceivingSpell[i] = UI.CreateFrame("Texture", "ReceivingSpell", lb.groupBF[i])
    lb.groupCastBar[i] = UI.CreateFrame("Texture", "ReceivingSpell", lb.groupBF[i])
	lb.groupName[i] = UI.CreateFrame("Text", "Name", lb.groupBF[i])
	lb.groupStatus[i] = UI.CreateFrame("Text", "Status", lb.groupBF[i])
	lb.groupRole[i] = UI.CreateFrame("Texture", "Role", lb.groupBF[i])
	lb.groupMask[i] = UI.CreateFrame("Frame", "group"..i, lb.Window)
	lb.groupMask[i]:SetSecureMode("restricted")
	--lb.groupTooltip[i] = UI.CreateFrame("SimpleTooltip","groupT"..i, lb.CenterFrame)
	lb.RaidTable[string.format("group%.2d", i)] = true
	lb.UnitBuffTable[string.format("group%.2d", i)] = {}
	for g= 1,5 do
		lb.groupHoTSpots[i][g] = {}
        lb.groupHoTSpots[i][g][0]=true --icon
        lb.groupHoTSpots[i][g][1]=UI.CreateFrame("Texture", "HoT" .. tostring(g), lb.groupBF[i])
        lb.groupHoTSpots[i][g][2]=UI.CreateFrame("Text", "HoTText" .. tostring(g), lb.groupBF[i])
        lb.groupHoTSpots[i][g][3]=UI.CreateFrame("Text", "HoTTextShadow" .. tostring(g), lb.groupBF[i])

        lb.groupHoTSpotsIcons[i][g]={}
        lb.groupHoTSpotsIcons[i][g][0]=false
        lb.groupHoTSpotsIcons[i][g][1]="LifeBinder"
        lb.groupHoTSpotsIcons[i][g][2]="Textures/buffhot.png"
        lb.groupHoTSpotsIcons[i][g][3]=0 --stacks
        lb.groupHoTSpotsIcons[i][g][4]=false    --updated  (true if icon has just updated)
        lb.groupHoTSpotsIcons[i][g][5]=nil    --buff spell ID     (used for remove buff )
        lb.groupHoTSpotsIcons[i][g][6]=false    --is debuff    true if the debuff applied is a debuff
	end
end
for i = 1, 5 do
	lb.GroupTable[string.format("group%.2d", i)] = true

	lb.UnitBuffTable[string.format("group%.2d.pet", i)] = {}
end
lb.clickOffset = {x = 0, y = 0}
lb.resizeOffset = {x = 0, y = 0 }
lb.UnitBuffTable["player"] = {}
lb.UnitBuffTable["player.pet"] = {}
lb.UnitTable = {"player", "player.pet"}
lb.UnitsTable = {}
lb.SoloTable["player"] = true
lb.UnitsTableStatus={}
for i= 1,20 do
    local name=string.format("group%.2d", i)
    table.insert(lb.UnitsTable,name);
    lb.UnitsTableStatus[name]={}
    lb.UnitsTableStatus[name][1]=false --aggro
    lb.UnitsTableStatus[name][2]=false --offline
    lb.UnitsTableStatus[name][3]=false --not in los
    lb.UnitsTableStatus[name][4]="none" --role
    lb.UnitsTableStatus[name][5]=0 --Unit ID
    lb.UnitsTableStatus[name][6]=false --is target   (not used)
    lb.UnitsTableStatus[name][7]=i --Frame index  used for buff monitor
    lb.UnitsTableStatus[name][8]=false -- position change check
	lb.UnitsTableStatus[name][9]="none" --Calling
end
lb.UnitsTableStatus["player"]={}
lb.UnitsTableStatus["player"][1]=false --aggro
lb.UnitsTableStatus["player"][2]=false --offline
lb.UnitsTableStatus["player"][3]=false --not in los
lb.UnitsTableStatus["player"][4]="none" --role
lb.UnitsTableStatus["player"][5]=0 --Unit ID
lb.UnitsTableStatus["player"][6]=false  --is target
lb.UnitsTableStatus["player"][7]=1  --frame index    used for buff monitor
lb.UnitsTableStatus["player"][8]=false -- position change check
lb.UnitsTableStatus["player"][9]="none" --Calling
lb.UnitsGroupTable = {"group01", "group02", "group03", "group04", "group05"}
lb.Calling = {"warrior", "cleric", "mage", "rogue", "percentage"}
lb.Role = {"tank", "heal", "dps", "support" }
lb.ResizeButton = UI.CreateFrame("Texture", "ResizeButton", lb.Window)
lb.clickOffset = {x = 0, y = 0}
lb.resizeOffset = {x = 0, y = 0}
--options gui
lb.WindowOptions = UI.CreateFrame("SimpleWindow", "Options", lb.Context)
lb.WindowOptionsTab = UI.CreateFrame("SimpleTabView", "OptionsWindowFrame", lb.WindowOptions)
lb.WindowOptionsBuffs = UI.CreateFrame("Frame", "OptionsWindowA", lb.WindowOptionsTab)
lb.WindowOptionsDebuffs = UI.CreateFrame("Frame", "OptionsWindowB", lb.WindowOptionsTab)
lb.WindowOptionsMouse = UI.CreateFrame("Frame", "OptionsWindowC", lb.WindowOptionsTab)
lb.WindowOptionsTab:AddTab("Buffs",lb.WindowOptionsBuffs)
lb.WindowOptionsTab:AddTab("Debuffs",lb.WindowOptionsDebuffs)
lb.WindowOptionsTab:AddTab("Mouse",lb.WindowOptionsMouse)
--buff  gui
lb.BuffsListView={}
lb.BuffsList={}
lb.BuffsRemoveButtons={}
lb.BuffsMoveUpButtons={}
lb.BuffsMoveDownButtons={}
lb.BuffListAddBuff = {}
lb.BuffListAddBuffButtons = {}
for i = 1 , 4 do
    lb.BuffsListView[i] = UI.CreateFrame("SimpleScrollView", "List", lb.WindowOptionsBuffs)
    lb.BuffsList[i] = UI.CreateFrame("SimpleList", "List", lb.WindowOptionsBuffs)
    lb.BuffsRemoveButtons[i]= UI.CreateFrame("RiftButton", "RemoveBuffSlot"..tostring(i), lb.WindowOptionsBuffs)
    lb.BuffsMoveUpButtons[i]= UI.CreateFrame("RiftButton", "MoveUpBuffSlot"..tostring(i), lb.WindowOptionsBuffs)
    lb.BuffsMoveDownButtons[i]= UI.CreateFrame("RiftButton", "MoveDownBuffSlot"..tostring(i), lb.WindowOptionsBuffs)
    lb.BuffListAddBuff[i] = UI.CreateFrame("RiftTextfield", "BuffListAddBuffTextAres"..tostring(i), lb.WindowOptionsBuffs)
    lb.BuffListAddBuffButtons[i]= UI.CreateFrame("RiftButton", "BuffListAddBuffButtons"..tostring(i), lb.WindowOptionsBuffs)
end
--debuff gui
lb.ChkDebuffCache= UI.CreateFrame("SimpleCheckbox", "List", lb.WindowOptionsDebuffs)
lb.DebuffsListView = UI.CreateFrame("SimpleScrollView", "List", lb.WindowOptionsDebuffs)
lb.DebuffsList = UI.CreateFrame("SimpleList", "List", lb.WindowOptionsDebuffs)
lb.DebuffsListAddTextbox = UI.CreateFrame("RiftTextfield", "DebuffsListAddTextbox", lb.WindowOptionsDebuffs)
lb.DebuffsListRemove= UI.CreateFrame("RiftButton", "DebuffsListRemove", lb.WindowOptionsDebuffs)
lb.DebuffsListAdd= UI.CreateFrame("RiftButton", "DebuffsListAdd", lb.WindowOptionsDebuffs)
lb.DebuffsListMoveUp= UI.CreateFrame("RiftButton", "DebuffsListMoveUp", lb.WindowOptionsDebuffs)
lb.DebuffsListMoveDown= UI.CreateFrame("RiftButton", "DebuffsListMoveDown", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListView = UI.CreateFrame("SimpleScrollView", "List", lb.WindowOptionsDebuffs)
lb.DebuffsCacheList = UI.CreateFrame("SimpleList", "List", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListName = UI.CreateFrame("Text", "text", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListDesc = UI.CreateFrame("Text", "text", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListIcon = UI.CreateFrame("Texture", "text", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListUpdate= UI.CreateFrame("RiftButton", "DebuffsCacheListUpdate", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListClear= UI.CreateFrame("RiftButton", "ClearDebuffCache", lb.WindowOptionsDebuffs)
lb.DebuffsCacheListCopyToCurrent= UI.CreateFrame("RiftButton", "DebuffsCacheListCopyToCurrent", lb.WindowOptionsDebuffs)
--mouse gui
lb.WindowOptionsMouseTabControl = UI.CreateFrame("SimpleTabView", "OptionsMouseWindowFrame", lb.WindowOptionsMouse)
lb.WindowOptionsMouseTabs={}
lb.WindowOptionsMouseButtonCommands={}
lb.WindowOptionsMouseButtonUpdateCommands={}
lb.WindowOptionsMouseTabs[1] = UI.CreateFrame("Frame", "OptionsMouseWindowA", lb.WindowOptionsMouse)
lb.WindowOptionsMouseTabs[2] = UI.CreateFrame("Frame", "OptionsMouseWindowA", lb.WindowOptionsMouse)
lb.WindowOptionsMouseTabs[3] = UI.CreateFrame("Frame", "OptionsMouseWindowA", lb.WindowOptionsMouse)
lb.WindowOptionsMouseTabs[4] = UI.CreateFrame("Frame", "OptionsMouseWindowA", lb.WindowOptionsMouse)
lb.WindowOptionsMouseTabs[5] = UI.CreateFrame("Frame", "OptionsMouseWindowA", lb.WindowOptionsMouse)
lb.WindowOptionsMouseTabControl:AddTab("Left Click",lb.WindowOptionsMouseTabs[1])
lb.WindowOptionsMouseTabControl:AddTab("Right Click",lb.WindowOptionsMouseTabs[2])
lb.WindowOptionsMouseTabControl:AddTab("Middle Click",lb.WindowOptionsMouseTabs[3])
lb.WindowOptionsMouseTabControl:AddTab("Button4 Click",lb.WindowOptionsMouseTabs[4])
lb.WindowOptionsMouseTabControl:AddTab("Button5 Click",lb.WindowOptionsMouseTabs[5])

for i = 1 ,5 do
    local parent =  lb.WindowOptionsMouseTabs[i]
    lb.WindowOptionsMouseButtonCommands[i]={}
    lb.WindowOptionsMouseButtonUpdateCommands[i]=UI.CreateFrame("RiftButton", "WindowOptionsMouseButtonUpdateCommands"..tostring(i), lb.WindowOptionsMouseTabs[i])
    for g= 1 , 4 do
        lb.WindowOptionsMouseButtonCommands[i][g]= UI.CreateFrame("SimpleTextArea", "DebuffsListAddTextbox",parent)
    end
end
