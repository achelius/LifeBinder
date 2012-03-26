--lb = {}
--
--lb.Context = UI.CreateContext("Context")
--lb.Context:SetSecureMode("restricted")
--lb.Window = UI.CreateFrame("Frame", "MainWindow", lb.Context)
--lb.Window:SetSecureMode("restricted")
--lb.WindowFrameTop = UI.CreateFrame("Texture", "Texture", lb.Window)
--lb.WindowFrameTop:SetSecureMode("restricted")
--lb.WindowDrag = UI.CreateFrame("Frame", "drag frame", lb.Window)
--
--lb.CombatStatus= UI.CreateFrame("Texture", "Texture", lb.Window)
--lb.CenterFrame = UI.CreateFrame("Frame", "Texture", lb.WindowFrameTop)
--lb.CenterFrame:SetSecureMode("restricted")
--lb.PlayerID=nil     -- set by buffmonitor on buff add event or addabilities event
--lb.LastTarget=nil
--lb.MouseOverUnit=nil  -- current mouseover unit ID
--lb.MouseOverUnitLastCast=nil -- unit id of the moment one spell une spell has been casted

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
