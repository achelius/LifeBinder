function createOptionsWindow()
    lb.WindowOptions:SetPoint("CENTER", UIParent, "CENTER")
    lb.WindowOptions:SetWidth(850)
    lb.WindowOptions:SetHeight(600)
    lb.WindowOptions:SetLayer(10)
    lb.WindowOptions:SetVisible(false)
    lb.WindowOptions:SetCloseButtonVisible(true)
    lb.WindowOptions.Event.Close=function() ClearKeyFocus() end
    lb.OptionsLabel1=UI.CreateFrame("Text", "Name", lb.WindowOptions)
    lb.OptionsLabel1:SetPoint("TOPLEFT", lb.WindowOptions, "TOPLEFT", 30, 60)

    lb.OptionsLabel1:SetFontSize(lbValues.font)
    lb.OptionsLabel1:SetText("Warning: You are currently editing only current role options")
    lb.OptionsLabel1:SetLayer(10)

    lb.WindowOptionsTab:SetPoint("TOPLEFT", lb.WindowOptions, "TOPLEFT", 15, 50)
    lb.WindowOptionsTab:SetPoint("BOTTOMRIGHT", lb.WindowOptions, "BOTTOMRIGHT", -15, -15)

    --buffs
    for i = 1 ,4 do
        writeText("Slot "..tostring(i),"text",lb.WindowOptionsBuffs,10+((i-1)*190),50)
        lb.BuffsListView[i]:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 70)
        lb.BuffsListView[i]:SetWidth(140)
        lb.BuffsListView[i]:SetHeight(240)
        lb.BuffsListView[i]:SetLayer(1)
        lb.BuffsListView[i]:SetBorder(1, 1, 1, 1, 1)
        lb.BuffsListView[i]:SetContent(lb.BuffsList[i])
        lb.BuffsRemoveButtons[i]:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 310)
        lb.BuffsRemoveButtons[i]:SetText("Remove Buff")
        lb.BuffsRemoveButtons[i]:SetLayer(10)
        lb.BuffsRemoveButtons[i].Event.LeftClick= function()removeBuffFromSlot(i) end

        lb.BuffsMoveUpButtons[i]:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 10+((i)*190)-50, 110)
        lb.BuffsMoveUpButtons[i]:SetText("^")
        lb.BuffsMoveUpButtons[i]:SetWidth(50)
        lb.BuffsMoveUpButtons[i]:SetLayer(10)

        lb.BuffsMoveDownButtons[i]:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 10+((i)*190)-50, 140)
        lb.BuffsMoveDownButtons[i]:SetText("v")
        lb.BuffsMoveDownButtons[i]:SetWidth(50)
        lb.BuffsMoveDownButtons[i]:SetLayer(10)
        writeText("Buff Name","text",lb.WindowOptionsBuffs,10+((i-1)*190),350)
        lb.BuffListAddBuff[i]:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 370)
        lb.BuffListAddBuff[i]:SetWidth(140)
        lb.BuffListAddBuff[i]:SetHeight(20)
        lb.BuffListAddBuff[i]:SetBackgroundColor(0,0,0,1)
        lb.BuffListAddBuff[i]:SetLayer(10)

        lb.BuffListAddBuffButtons[i]:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 10+((i-1)*190), 390)
        lb.BuffListAddBuffButtons[i]:SetText("Add Buff")
        lb.BuffListAddBuffButtons[i].Event.LeftClick= function()addBuffToSlot(i) end
        lb.BuffListAddBuffButtons[i]:SetLayer(10)

    end

    ---debuff page

    lb.ChkDebuffCache:SetLayer(10)
    lb.ChkDebuffCache:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 10, 70)
    lb.ChkDebuffCache:SetText("Enable Debuff Caching")
    lb.ChkDebuffCache:SetChecked(lbValues.CacheDebuffs)
    lb.ChkDebuffCache.Event.CheckboxChange=function() lbValues.CacheDebuffs=lb.ChkDebuffCache:GetChecked() end
    writeText("Enables/disables debuff list caching, when a debuff is found it will be saved in memory \n to help find a specific boss debuff to show \n SAVING BUFFS EXPECIALLY WHEN THEY ARE MANY AT THE SAME TIME CAN SLOW YOUR SYSTEM AND ON LONG TERM THE FILE WILL BE LARGE SO ACTIVATE THIS ONLY WHEN YOU NEED","debuffcachingdescription",lb.WindowOptionsDebuffs,10,90)

    writeText("Visible debuff list","label",lb.WindowOptionsDebuffs,10,150)
    lb.DebuffsListView:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 10, 170)
    lb.DebuffsListView:SetWidth(140)
    lb.DebuffsListView:SetHeight(240)
    lb.DebuffsListView:SetLayer(1)
    lb.DebuffsListView:SetBorder(1, 1, 1, 1, 1)
    lb.DebuffsListView:SetContent(lb.DebuffsList)

    lb.DebuffsListAddTextbox:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 10, 410)
    lb.DebuffsListAddTextbox:SetWidth(140)
    lb.DebuffsListAddTextbox:SetBackgroundColor(0,0,0,1)
    lb.DebuffsListAddTextbox:SetLayer(1)

    lb.DebuffsListAdd:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 10, 430)
    lb.DebuffsListAdd:SetText("Add Debuff")
    lb.DebuffsListAdd:SetLayer(10)
    lb.DebuffsListAdd.Event.LeftClick= function()addDebuffFromTextbox()   end

    lb.DebuffsListRemove:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 10, 460)
    lb.DebuffsListRemove:SetText("Remove Debuff")
    lb.DebuffsListRemove:SetLayer(10)
    lb.DebuffsListRemove.Event.LeftClick= function()removeSelectedDebuffFromWatch() end

    lb.DebuffsListMoveUp:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 150, 250)
    lb.DebuffsListMoveUp:SetText("^")
    lb.DebuffsListMoveUp:SetWidth(50)
    lb.DebuffsListMoveUp:SetLayer(10)

    lb.DebuffsListMoveDown:SetPoint("TOPLEFT", lb.WindowOptionsBuffs, "TOPLEFT", 150, 270)
    lb.DebuffsListMoveDown:SetText("v")
    lb.DebuffsListMoveDown:SetWidth(50)
    lb.DebuffsListMoveDown:SetLayer(10)


    writeText("Visible debuff list","label",lb.WindowOptionsDebuffs,300,150)
    lb.DebuffsCacheListView:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 300, 170)
    lb.DebuffsCacheListView:SetWidth(140)
    lb.DebuffsCacheListView:SetHeight(240)
    lb.DebuffsCacheListView:SetLayer(1)
    lb.DebuffsCacheListView:SetBorder(1, 1, 1, 1, 1)
    lb.DebuffsCacheListView:SetContent(lb.DebuffsCacheList)
    lb.DebuffsCacheList.Event.ItemSelect=function(item,value,index) debuffCacheViewInfo(value) end

    lb.DebuffsCacheListName:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 500, 170)
    lb.DebuffsCacheListName:SetFontSize(20)
    lb.DebuffsCacheListName:SetText("")
    lb.DebuffsCacheListName:SetLayer(10)

    lb.DebuffsCacheListDesc:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 500, 200)
    lb.DebuffsCacheListDesc:SetWordwrap(true)
    lb.DebuffsCacheListDesc:SetFontSize(12)
    lb.DebuffsCacheListDesc:SetWidth(200)
    lb.DebuffsCacheListDesc:SetText("")
    lb.DebuffsCacheListDesc:SetLayer(10)

    --lb.DebuffsCacheListIcon:SetTexture("LifeBinder", "Textures/health_g.png")
    lb.DebuffsCacheListIcon:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 470,  170 )
    lb.DebuffsCacheListIcon:SetHeight(32)
    lb.DebuffsCacheListIcon:SetWidth(32)
    lb.DebuffsCacheListIcon:SetLayer(10)

    lb.DebuffsCacheListUpdate:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 300, 410)
    lb.DebuffsCacheListUpdate:SetText("Update List")
    lb.DebuffsCacheListUpdate:SetLayer(10)
    lb.DebuffsCacheListUpdate.Event.LeftClick= function() createTableDebuffs() end

    lb.DebuffsCacheListClear:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 300, 440)
    lb.DebuffsCacheListClear:SetText("Clear Cache")
    lb.DebuffsCacheListClear:SetLayer(10)
    lb.DebuffsCacheListClear.Event.LeftClick= function() DebuffCacheClear() createTableDebuffs() end

    lb.DebuffsCacheListCopyToCurrent:SetPoint("TOPLEFT", lb.WindowOptionsDebuffs, "TOPLEFT", 150, 200)
    lb.DebuffsCacheListCopyToCurrent:SetText("<< Insert")
    lb.DebuffsCacheListCopyToCurrent:SetLayer(10)
    lb.DebuffsCacheListCopyToCurrent.Event.LeftClick= function() addSelectedFromlbDebuffCacheListToLive() end

    ---mouse page
    lb.WindowOptionsMouseTabControl:SetPoint("TOPLEFT", lb.WindowOptionsMouse, "TOPLEFT", 15, 50)
    lb.WindowOptionsMouseTabControl:SetPoint("BOTTOMRIGHT", lb.WindowOptionsMouse, "BOTTOMRIGHT", -15, -150)
    writeText("Common commands:\n target ##          targets the unit\n  cast ##  Restorative Flames         cast the spell on the target","label",lb.WindowOptionsMouseTabControl,10,300)

    for i = 1 ,5 do
        local parent =  lb.WindowOptionsMouseTabs[i]
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
        lb.WindowOptionsMouseButtonUpdateCommands[i]:SetPoint("TOPLEFT", parent, "TOPLEFT", 490, 200)
        lb.WindowOptionsMouseButtonUpdateCommands[i]:SetText("Apply")
        lb.WindowOptionsMouseButtonUpdateCommands[i]:SetLayer(10)
        lb.WindowOptionsMouseButtonUpdateCommands[i].Event.LeftClick= function()setMouseAssociationField(i)   end
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
            lb.WindowOptionsMouseButtonCommands[i][g]:SetPoint("TOPLEFT", parent, "TOPLEFT", 150, g*45)
            lb.WindowOptionsMouseButtonCommands[i][g]:SetWidth(300)
            lb.WindowOptionsMouseButtonCommands[i][g]:SetHeight(35)
            --lb.WindowOptionsMouseButtonCommands[i][g]:SetFontSize(20)
            lb.WindowOptionsMouseButtonCommands[i][g]:SetBackgroundColor(0,0,0,1)

        end
    end

end

------------------------------------------------buffs---------------------------------------
function addBuffToSlot(slot)
    local set= lbValues.set
    if set==nil then return end
    local buffnames=lbBuffList[set]
    if buffnames==nil then lbBuffList[set]={} end
    local buffname= lb.BuffListAddBuff[slot]:GetText()
    if buffname~=nil and buffname~="" then
        if not(hasBuffOnSlot(slot,buffname)) then
            table.insert(lbBuffList[set][slot],buffname)
            createTableBuffsSlot(slot)
        end
    end
    lbUpdateSpellTextures()
    ClearKeyFocus()
end

function removeBuffFromSlot(slot)
    local set= lbValues.set
    if set==nil then return end
    local index = lb.BuffsList[slot]:GetSelectedIndex()
    if index~=nil and index>0 then
        table.remove(lbBuffList[set][slot],index)
        createTableBuffsSlot(slot)
    end
    ClearKeyFocus()
end

function hasBuffOnSlot(slot,name)
    local set= lbValues.set
    local buffnames=lbBuffList[set][slot]
        if buffnames==nil then buffnames={} end
        for i,spellname in pairs(buffnames) do
            if spellname==name then
                return true
            end
        end

    return false
end

function createTableBuffs()
    local set= lbValues.set
    if set==nil then return end
    local buffnames=lbBuffList[set]
    if buffnames==nil then buffnames={} end
    for slot, spells in pairs(buffnames) do
        lb.BuffsList[slot]:SetItems(spells)
        lb.BuffsList[slot]:GetItems()
    end
end

function createTableBuffsSlot(slot)
    local set= lbValues.set
    if set==nil then return end
    local buffnames=lbBuffList[set][slot]
    if buffnames==nil then lbBuffList[set][slot]={} end

    lb.BuffsList[slot]:SetItems(buffnames)
    lb.BuffsList[slot]:GetItems()

end


------------------------------------------------------------debuff----------------------


function addDebuffFromTextbox()
    local name=  lb.DebuffsListAddTextbox:GetText()
    if name==nil then return end
    addDebuffToWatch(name)
    lbUpdateSpellTextures()
    createTableDebuffs()
    ClearKeyFocus()
end

function addDebuffToWatch(debuffName)
    local set= lbValues.set
    if set==nil then return end
    if debuffName==nil then return end
    local debuffnames=lbDeBuffList[set]
    table.insert(debuffnames,debuffName)
    lbUpdateSpellTextures()
    createTableDebuffs()
end

function removeDebuffFromWatch(debuffName)
    local set= lbValues.set
    if set==nil then return end
    local debuffnames=lbDeBuffList[set]

    if selectedIndex==nil then return end
    for index,debname in pairs(debuffnames) do
        if debname==  debuffName then
            table.remove(debuffnames,index)
            return
        end
    end
    lbUpdateSpellTextures()
    createTableDebuffs()
end




function createTableDebuffs()
    local set= lbValues.set
    if set==nil then return end
    local debuffnames=lbDeBuffList[set]
    lb.DebuffsList:SetItems(debuffnames)
    lb.DebuffsList:GetItems()
    lb.DebuffsCacheList:SetItems(getDebuffCacheNames())
    lb.DebuffsCacheList:GetItems()
end

function debuffCacheViewInfo(value)
    local debuff= getDebuffFromCache(value)
    if debuff~=nil then
        --write informations
        lb.DebuffsCacheListName:SetText(value)
        lb.DebuffsCacheListDesc:SetText(debuff[2])
        lb.DebuffsCacheListIcon:SetTexture("Rift",debuff[3])
    else
        --hide informations

    end
end

function addSelectedFromlbDebuffCacheListToLive()
    local selected=lb.DebuffsCacheList:GetSelectedItem()
    if selected~=nil then
        addDebuffToWatch(selected)
        lbUpdateSpellTextures()
        createTableDebuffs()
    end

end

function removeSelectedDebuffFromWatch()
    local set= lbValues.set
    if set==nil then return end
    local debuffnames=lbDeBuffList[set]
    local selectedIndex=lb.DebuffsList:GetSelectedIndex()
    if selectedIndex==nil then return end
    table.remove(debuffnames,selectedIndex)
    lbUpdateSpellTextures()
    createTableDebuffs()
end


function lb.DebuffsListMoveUp.Event.LeftClick()
    local set= lbValues.set
    if set==nil then return end
    local debuffnames=lbDeBuffList[set]
    local selectedIndex=lb.DebuffsList:GetSelectedIndex()
    if selectedIndex~=nil then
        if selectedIndex~=1 then
            local dbname=lb.DebuffsList:GetSelectedItem()
            table.remove(debuffnames,selectedIndex)
            table.insert(debuffnames,selectedIndex-1,dbname )
            lbUpdateSpellTextures()
            createTableDebuffs()
            lb.DebuffsList:SetSelectedIndex(selectedIndex-1)
        end
    end
end

function lb.DebuffsListMoveDown.Event.LeftClick()
    local set= lbValues.set
    if set==nil then return end
    local debuffnames=lbDeBuffList[set]
    local selectedIndex=lb.DebuffsList:GetSelectedIndex()
    if selectedIndex~=nil then
        if selectedIndex~=#debuffnames then
            local dbname=lb.DebuffsList:GetSelectedItem()
            table.remove(debuffnames,selectedIndex)
            table.insert(debuffnames,selectedIndex+1,dbname )
            lbUpdateSpellTextures()
            createTableDebuffs()
            lb.DebuffsList:SetSelectedIndex(selectedIndex+1)
        end
    end
end
------------------------------------------------------------Mouse----------------------
function UpdateMouseAssociationsTextFieldsValues()
    local set= lbValues.set
    if set==nil then return end
    for i = 1 ,5 do
        for g= 1 , 4 do
            lb.WindowOptionsMouseButtonCommands[i][g]:SetText(lbMacroButton[set][i][g])
        end
    end
end

function setMouseAssociationField(buttonIndex)
    local set= lbValues.set
    if set==nil then return end
    for FieldIndex=1,4 do
        lbMacroButton[set][buttonIndex][FieldIndex]=lb.WindowOptionsMouseButtonCommands[buttonIndex][FieldIndex]:GetText()
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