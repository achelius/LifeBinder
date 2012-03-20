function createOptionsWindow()
    rhb.WindowOptions:SetPoint("CENTER", UIParent, "CENTER")
    rhb.WindowOptions:SetWidth(850)
    rhb.WindowOptions:SetHeight(600)
    rhb.WindowOptions:SetLayer(10)
    rhb.WindowOptions:SetVisible(false)
    rhb.WindowOptions:SetCloseButtonVisible(true)
    rhb.WindowOptions.Event.Close=function() ClearKeyFocus() end
    rhb.OptionsLabel1=UI.CreateFrame("Text", "Name", rhb.WindowOptions)
    rhb.OptionsLabel1:SetPoint("TOPLEFT", rhb.WindowOptions, "TOPLEFT", 30, 60)

    rhb.OptionsLabel1:SetFontSize(rhbValues.font)
    rhb.OptionsLabel1:SetText("Warning: You are currently editing only current role options")
    rhb.OptionsLabel1:SetLayer(10)

    rhb.WindowOptionsTab:SetPoint("TOPLEFT", rhb.WindowOptions, "TOPLEFT", 15, 50)
    rhb.WindowOptionsTab:SetPoint("BOTTOMRIGHT", rhb.WindowOptions, "BOTTOMRIGHT", -15, -15)

    --buffs
    for i = 1 ,4 do
        writeText("Slot "..tostring(i),"text",rhb.WindowOptionsBuffs,10+((i-1)*190),50)
        rhb.BuffsListView[i]:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 70)
        rhb.BuffsListView[i]:SetWidth(140)
        rhb.BuffsListView[i]:SetHeight(240)
        rhb.BuffsListView[i]:SetLayer(1)
        rhb.BuffsListView[i]:SetBorder(1, 1, 1, 1, 1)
        rhb.BuffsListView[i]:SetContent(rhb.BuffsList[i])
        rhb.BuffsRemoveButtons[i]:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 310)
        rhb.BuffsRemoveButtons[i]:SetText("Remove Buff")
        rhb.BuffsRemoveButtons[i]:SetLayer(10)
        rhb.BuffsRemoveButtons[i].Event.LeftClick= function()removeBuffFromSlot(i) end

        rhb.BuffsMoveUpButtons[i]:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 10+((i)*190)-50, 110)
        rhb.BuffsMoveUpButtons[i]:SetText("^")
        rhb.BuffsMoveUpButtons[i]:SetWidth(50)
        rhb.BuffsMoveUpButtons[i]:SetLayer(10)

        rhb.BuffsMoveDownButtons[i]:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 10+((i)*190)-50, 140)
        rhb.BuffsMoveDownButtons[i]:SetText("v")
        rhb.BuffsMoveDownButtons[i]:SetWidth(50)
        rhb.BuffsMoveDownButtons[i]:SetLayer(10)
        writeText("Buff Name","text",rhb.WindowOptionsBuffs,10+((i-1)*190),350)
        rhb.BuffListAddBuff[i]:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 370)
        rhb.BuffListAddBuff[i]:SetWidth(140)
        rhb.BuffListAddBuff[i]:SetHeight(20)
        rhb.BuffListAddBuff[i]:SetBackgroundColor(0,0,0,1)
        rhb.BuffListAddBuff[i]:SetLayer(10)

        rhb.BuffListAddBuffButtons[i]:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 390)
        rhb.BuffListAddBuffButtons[i]:SetText("Add Buff")
        rhb.BuffListAddBuffButtons[i].Event.LeftClick= function()addBuffToSlot(i) end
        rhb.BuffListAddBuffButtons[i]:SetLayer(10)

    end

    ---debuff page

    rhb.ChkDebuffCache:SetLayer(10)
    rhb.ChkDebuffCache:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 10, 70)
    rhb.ChkDebuffCache:SetText("Enable Debuff Caching")
    rhb.ChkDebuffCache:SetChecked(rhbValues.CacheDebuffs)
    rhb.ChkDebuffCache.Event.CheckboxChange=function() rhbValues.CacheDebuffs=rhb.ChkDebuffCache:GetChecked() end
    writeText("Enables/disables debuff list caching, when a debuff is found it will be saved in memory \n to help find a specific boss debuff to show \n SAVING BUFFS EXPECIALLY WHEN THEY ARE MANY AT THE SAME TIME CAN SLOW YOUR SYSTEM AND ON LONG TERM THE FILE WILL BE LARGE SO ACTIVATE THIS ONLY WHEN YOU NEED","debuffcachingdescription",rhb.WindowOptionsDebuffs,10,90)

    writeText("Visible debuff list","label",rhb.WindowOptionsDebuffs,10,150)
    rhb.DebuffsListView:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 10, 170)
    rhb.DebuffsListView:SetWidth(140)
    rhb.DebuffsListView:SetHeight(240)
    rhb.DebuffsListView:SetLayer(1)
    rhb.DebuffsListView:SetBorder(1, 1, 1, 1, 1)
    rhb.DebuffsListView:SetContent(rhb.DebuffsList)

    rhb.DebuffsListAddTextbox:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 10, 410)
    rhb.DebuffsListAddTextbox:SetWidth(140)
    rhb.DebuffsListAddTextbox:SetBackgroundColor(0,0,0,1)
    rhb.DebuffsListAddTextbox:SetLayer(1)

    rhb.DebuffsListAdd:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 10, 430)
    rhb.DebuffsListAdd:SetText("Add Debuff")
    rhb.DebuffsListAdd:SetLayer(10)
    rhb.DebuffsListAdd.Event.LeftClick= function()addDebuffFromTextbox()   end

    rhb.DebuffsListRemove:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 10, 460)
    rhb.DebuffsListRemove:SetText("Remove Debuff")
    rhb.DebuffsListRemove:SetLayer(10)
    rhb.DebuffsListRemove.Event.LeftClick= function()removeSelectedDebuffFromWatch() end

    rhb.DebuffsListMoveUp:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 150, 250)
    rhb.DebuffsListMoveUp:SetText("^")
    rhb.DebuffsListMoveUp:SetWidth(50)
    rhb.DebuffsListMoveUp:SetLayer(10)

    rhb.DebuffsListMoveDown:SetPoint("TOPLEFT", rhb.WindowOptionsBuffs, "TOPLEFT", 150, 270)
    rhb.DebuffsListMoveDown:SetText("v")
    rhb.DebuffsListMoveDown:SetWidth(50)
    rhb.DebuffsListMoveDown:SetLayer(10)


    writeText("Visible debuff list","label",rhb.WindowOptionsDebuffs,300,150)
    rhb.DebuffsCacheListView:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 300, 170)
    rhb.DebuffsCacheListView:SetWidth(140)
    rhb.DebuffsCacheListView:SetHeight(240)
    rhb.DebuffsCacheListView:SetLayer(1)
    rhb.DebuffsCacheListView:SetBorder(1, 1, 1, 1, 1)
    rhb.DebuffsCacheListView:SetContent(rhb.DebuffsCacheList)
    rhb.DebuffsCacheList.Event.ItemSelect=function(item,value,index) debuffCacheViewInfo(value) end

    rhb.DebuffsCacheListName:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 500, 170)
    rhb.DebuffsCacheListName:SetFontSize(20)
    rhb.DebuffsCacheListName:SetText("")
    rhb.DebuffsCacheListName:SetLayer(10)

    rhb.DebuffsCacheListDesc:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 500, 200)
    rhb.DebuffsCacheListDesc:SetWordwrap(true)
    rhb.DebuffsCacheListDesc:SetFontSize(12)
    rhb.DebuffsCacheListDesc:SetWidth(200)
    rhb.DebuffsCacheListDesc:SetText("")
    rhb.DebuffsCacheListDesc:SetLayer(10)

    --rhb.DebuffsCacheListIcon:SetTexture("RiftHbot", "Textures/health_g.png")
    rhb.DebuffsCacheListIcon:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 470,  170 )
    rhb.DebuffsCacheListIcon:SetHeight(32)
    rhb.DebuffsCacheListIcon:SetWidth(32)
    rhb.DebuffsCacheListIcon:SetLayer(10)

    rhb.DebuffsCacheListUpdate:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 300, 410)
    rhb.DebuffsCacheListUpdate:SetText("Update List")
    rhb.DebuffsCacheListUpdate:SetLayer(10)
    rhb.DebuffsCacheListUpdate.Event.LeftClick= function() createTableDebuffs() end

    rhb.DebuffsCacheListClear:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 300, 440)
    rhb.DebuffsCacheListClear:SetText("Clear Cache")
    rhb.DebuffsCacheListClear:SetLayer(10)
    rhb.DebuffsCacheListClear.Event.LeftClick= function() DebuffCacheClear() createTableDebuffs() end

    rhb.DebuffsCacheListCopyToCurrent:SetPoint("TOPLEFT", rhb.WindowOptionsDebuffs, "TOPLEFT", 150, 200)
    rhb.DebuffsCacheListCopyToCurrent:SetText("<< Insert")
    rhb.DebuffsCacheListCopyToCurrent:SetLayer(10)
    rhb.DebuffsCacheListCopyToCurrent.Event.LeftClick= function() addSelectedFromDebuffCacheListToLive() end

    ---mouse page
    rhb.WindowOptionsMouseTabControl:SetPoint("TOPLEFT", rhb.WindowOptionsMouse, "TOPLEFT", 15, 50)
    rhb.WindowOptionsMouseTabControl:SetPoint("BOTTOMRIGHT", rhb.WindowOptionsMouse, "BOTTOMRIGHT", -15, -150)
    writeText("Common commands:\n target ##          targets the unit\n  cast ##  Restorative Flames         cast the spell on the target","label",rhb.WindowOptionsMouseTabControl,10,300)

    for i = 1 ,5 do
        local parent =  rhb.WindowOptionsMouseTabs[i]
        local PageName=""
        if i==1 then
            PageName="LEFT CLICK"
        elseif i==2 then
            PageName="RIGHT CLICK"
        elseif i==3 then
            PageName="MIDDLE CLICK"
        elseif i==4 then
            PageName="BUTTON4 CLICK"
        elseif i==5 then
            PageName="BUTTON5 CLICK"
        end
        writeText(PageName,"label",parent,150,20)
        rhb.WindowOptionsMouseButtonUpdateCommands[i]:SetPoint("TOPLEFT", parent, "TOPLEFT", 490, 200)
        rhb.WindowOptionsMouseButtonUpdateCommands[i]:SetText("Apply")
        rhb.WindowOptionsMouseButtonUpdateCommands[i]:SetLayer(10)
        rhb.WindowOptionsMouseButtonUpdateCommands[i].Event.LeftClick= function()setMouseAssociationField(i)   end
        for g= 1 , 4 do
            local textareaname=""

            if g==1 then
                textareaname="NONE"
            elseif g==2 then
                textareaname="ALT"
            elseif g==3 then
                textareaname="CTRL"
            elseif g==4 then
                textareaname="SHIFT"
            end
            writeText(textareaname,"label",parent,110,g*45)
            rhb.WindowOptionsMouseButtonCommands[i][g]:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, g*45)
            rhb.WindowOptionsMouseButtonCommands[i][g]:SetWidth(300)
            rhb.WindowOptionsMouseButtonCommands[i][g]:SetHeight(35)
            --rhb.WindowOptionsMouseButtonCommands[i][g]:SetFontSize(20)
            rhb.WindowOptionsMouseButtonCommands[i][g]:SetBackgroundColor(0,0,0,1)

        end
    end

end

------------------------------------------------buffs---------------------------------------
function addBuffToSlot(slot)
    local set= rhbValues.set
    if set==nil then return end
    local buffnames=rhbBuffList[set]
    if buffnames==nil then rhbBuffList[set]={} end
    local buffname= rhb.BuffListAddBuff[slot]:GetText()
    if buffname~=nil and buffname~="" then
        if not(hasBuffOnSlot(slot,buffname)) then
            table.insert(rhbBuffList[set][slot],buffname)
            createTableBuffsSlot(slot)
        end
    end
    rhbUpdateSpellTextures()
    ClearKeyFocus()
end

function removeBuffFromSlot(slot)
    local set= rhbValues.set
    if set==nil then return end
    local index = rhb.BuffsList[slot]:GetSelectedIndex()
    if index~=nil and index>0 then
        table.remove(rhbBuffList[set][slot],index)
        createTableBuffsSlot(slot)
    end
    ClearKeyFocus()
end

function hasBuffOnSlot(slot,name)
    local set= rhbValues.set
    local buffnames=rhbBuffList[set][slot]
        if buffnames==nil then buffnames={} end
        for i,spellname in pairs(buffnames) do
            if spellname==name then
                return true
            end
        end

    return false
end

function createTableBuffs()
    local set= rhbValues.set
    if set==nil then return end
    local buffnames=rhbBuffList[set]
    if buffnames==nil then buffnames={} end
    for slot, spells in pairs(buffnames) do
        rhb.BuffsList[slot]:SetItems(spells)
        rhb.BuffsList[slot]:GetItems()
    end
end

function createTableBuffsSlot(slot)
    local set= rhbValues.set
    if set==nil then return end
    local buffnames=rhbBuffList[set][slot]
    if buffnames==nil then rhbBuffList[set][slot]={} end

    rhb.BuffsList[slot]:SetItems(buffnames)
    rhb.BuffsList[slot]:GetItems()

end


------------------------------------------------------------debuff----------------------


function addDebuffFromTextbox()
    local name=  rhb.DebuffsListAddTextbox:GetText()
    if name==nil then return end
    addDebuffToWatch(name)
    rhbUpdateSpellTextures()
    createTableDebuffs()
    ClearKeyFocus()
end

function addDebuffToWatch(debuffName)
    local set= rhbValues.set
    if set==nil then return end
    if debuffName==nil then return end
    local debuffnames=rhbDeBuffList[set]
    table.insert(debuffnames,debuffName)
    rhbUpdateSpellTextures()
    createTableDebuffs()
end

function removeDebuffFromWatch(debuffName)
    local set= rhbValues.set
    if set==nil then return end
    local debuffnames=rhbDeBuffList[set]

    if selectedIndex==nil then return end
    for index,debname in pairs(debuffnames) do
        if debname==  debuffName then
            table.remove(debuffnames,index)
            return
        end
    end
    rhbUpdateSpellTextures()
    createTableDebuffs()
end




function createTableDebuffs()
    local set= rhbValues.set
    if set==nil then return end
    local debuffnames=rhbDeBuffList[set]
    rhb.DebuffsList:SetItems(debuffnames)
    rhb.DebuffsList:GetItems()
    rhb.DebuffsCacheList:SetItems(getDebuffCacheNames())
    rhb.DebuffsCacheList:GetItems()
end

function debuffCacheViewInfo(value)
    local debuff= getDebuffFromCache(value)
    if debuff~=nil then
        --write informations
        rhb.DebuffsCacheListName:SetText(value)
        rhb.DebuffsCacheListDesc:SetText(debuff[2])
        rhb.DebuffsCacheListIcon:SetTexture("Rift",debuff[3])
    else
        --hide informations

    end
end

function addSelectedFromDebuffCacheListToLive()
    local selected=rhb.DebuffsCacheList:GetSelectedItem()
    if selected~=nil then
        addDebuffToWatch(selected)
        rhbUpdateSpellTextures()
        createTableDebuffs()
    end

end

function removeSelectedDebuffFromWatch()
    local set= rhbValues.set
    if set==nil then return end
    local debuffnames=rhbDeBuffList[set]
    local selectedIndex=rhb.DebuffsList:GetSelectedIndex()
    if selectedIndex==nil then return end
    table.remove(debuffnames,selectedIndex)
    rhbUpdateSpellTextures()
    createTableDebuffs()
end


function rhb.DebuffsListMoveUp.Event.LeftClick()
    local set= rhbValues.set
    if set==nil then return end
    local debuffnames=rhbDeBuffList[set]
    local selectedIndex=rhb.DebuffsList:GetSelectedIndex()
    if selectedIndex~=nil then
        if selectedIndex~=1 then
            local dbname=rhb.DebuffsList:GetSelectedItem()
            table.remove(debuffnames,selectedIndex)
            table.insert(debuffnames,selectedIndex-1,dbname )
            rhbUpdateSpellTextures()
            createTableDebuffs()
            rhb.DebuffsList:SetSelectedIndex(selectedIndex-1)
        end
    end
end

function rhb.DebuffsListMoveDown.Event.LeftClick()
    local set= rhbValues.set
    if set==nil then return end
    local debuffnames=rhbDeBuffList[set]
    local selectedIndex=rhb.DebuffsList:GetSelectedIndex()
    if selectedIndex~=nil then
        if selectedIndex~=#debuffnames then
            local dbname=rhb.DebuffsList:GetSelectedItem()
            table.remove(debuffnames,selectedIndex)
            table.insert(debuffnames,selectedIndex+1,dbname )
            rhbUpdateSpellTextures()
            createTableDebuffs()
            rhb.DebuffsList:SetSelectedIndex(selectedIndex+1)
        end
    end
end
------------------------------------------------------------Mouse----------------------
function UpdateMouseAssociationsTextFieldsValues()
    local set= rhbValues.set
    if set==nil then return end
    for i = 1 ,5 do
        for g= 1 , 4 do
            rhb.WindowOptionsMouseButtonCommands[i][g]:SetText(rhbMacroButton[set][i][g])
        end
    end
end

function setMouseAssociationField(buttonIndex)
    local set= rhbValues.set
    if set==nil then return end
    for FieldIndex=1,4 do
        rhbMacroButton[set][buttonIndex][FieldIndex]=rhb.WindowOptionsMouseButtonCommands[buttonIndex][FieldIndex]:GetText()
    end
    setMouseActions()
end


------------------------------------------------------------Utility----------------------



function writeText(text,name,parent,left,top)
    local tp=UI.CreateFrame("Text", name, parent)
    tp:SetPoint("TOPLEFT", parent, "TOPLEFT", left, top)
    tp:SetText(text)

end

context = UI.CreateContext("Fluff Context")
focushack = UI.CreateFrame("RiftTextfield", "focus hack", context)
focushack:SetVisible(false)
function ClearKeyFocus()
    focushack:SetKeyFocus(true)
    focushack:SetKeyFocus(false)
end