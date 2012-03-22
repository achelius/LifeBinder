local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Frame
local unitLookup= _G.Inspect.Unit.Lookup

lastMode=-1 -- last view mode (solo =0 group=1 raid=0) needed to update hp after view mode change
local viewModeChanged=false -- true if view mode changes
local lastUnitUpdate =0
local function getThrottle() 
    local now =  timeFrame()
    local elapsed = now - lastUnitUpdate
    if (elapsed >= (.5)) then --half a second
        lastUnitUpdate = now
        return true
    end
end

function lbLoadVariables(addonidentifier)
if addonidentifier~="LifeBinder" then return end

 lastMode=-1
    if lbValues == nil then
        lbValues = {addonState = true, windowstate = true, lockedState = false, locmainx = 0, locmainy = 0, mainheight = 300, mainwidth = 500, font = 16, pet = false, texture = "health_g.png", set = 1, hotwatch = true, debuffwatch = true, rolewatch = true, showtooltips = true }


        lbValues.locmainx = ((UIParent:GetRight() / 2) - 150)
        lbValues.locmainy = ((UIParent:GetBottom() / 2) - 250)
    end
    if lbValues.CacheDebuffs==nil then
        lbValues.CacheDebuffs=false
    end



    if lbMacroText == nil then
        lbMacroText = {}
        lbMacroText[1]={{"target ##", "", "", "", ""} }
        lbMacroText[2]={{"target ##", "", "", "", ""} }
        lbMacroText[3]={{"target ##", "", "", "", ""} }
        lbMacroText[4]={{"target ##", "", "", "", ""} }
        lbMacroText[5]={{"target ##", "", "", "", ""} }
        lbMacroText[6]={{"target ##", "", "", "", ""} }
    end
    if lbMacroButton == nil then
        lbMacroButton ={}
        lbMacroButton[1]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        lbMacroButton[2]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        lbMacroButton[3]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        lbMacroButton[4]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        lbMacroButton[5]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        lbMacroButton[6]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
    end
    
    if lbBuffList == nil then
        lbBuffList ={}
        lbBuffList[1]={{{}},{{}},{{}},{{}}}
        lbBuffList[2]={{{}},{{}},{{}},{{}}}
        lbBuffList[3]={{{}},{{}},{{}},{{}}}
        lbBuffList[4]={{{}},{{}},{{}},{{}}}
        lbBuffList[5]={{{}},{{}},{{}},{{}}}
        lbBuffList[6]={{{}},{{}},{{}},{{}}}
    end
    if lbDeBuffList == nil then
        lbDeBuffList ={}
        lbDeBuffList[1]={ }
        lbDeBuffList[2]={ }
        lbDeBuffList[3]={ }
        lbDeBuffList[4]={ }
        lbDeBuffList[5]={ }
        lbDeBuffList[6]={ }
    end
    
    if lbSlotPositions==nil then
    	lbSlotPositions={}
    	for i = 1 , 6 do
    		lbSlotPositions[i]={}
    		for g = 1 , 8 do
    			lbSlotPositions[i][g]={}
    		end
    	end
    	
    end
    
    if lbCallingColors == nil then
        lbCallingColors = {{r = 1, g = 0, b = 0}, {r = 0, g = 1, b = 0}, {r = 0.6, g = 0.2, b = 0.8}, {r = 1, g = 1, b = 0}, {r = 1, g = 1, b = 1}}
    end
    if lbValues.hotwatch == nil then lbValues.hotwatch = true end
    if lbValues.debuffwatch == nil then lbValues.debuffwatch = true end
    if lbValues.rolewatch == nil then lbValues.rolewatch = true end
    if lbValues.showtooltips == nil then lbValues.showtooltips = true end



    lbValues.islocked=false
    lbValues.isincombat=false
    lbValues.set=nil
    lbloadSettings()
    
end

function lbloadSettings()
   
	lbCreateWindow()
    createOptionsWindow()
	--lbCreateAbilityList()
	--lbCreateOptions()
    print ("Welcome to LifeBinder v0.27! Type /lb help for commands.")

end



function UpdateFramesVisibility()
   local lbgroupfound = false
   local lbraidfound = false
   local lbsolofound = true
    for k, v in pairs(lb.UnitsTable) do
        if unitLookup(v) then
            if k < 6 then lbraidfound = false lbgroupfound = true end
            if k > 5 then lbraidfound = true lbgroupfound = false end
            lbsolofound = false
            lb.groupBF[k]:SetVisible(true)
            if not lbValues.isincombat then lb.groupMask[k]:SetVisible(true) end
        else
            lb.groupBF[k]:SetVisible(false)
            if not lbValues.isincombat then lb.groupMask[k]:SetVisible(false) end
        end
    end

    if lbsolofound then

        if lastMode~=0 then
            viewModeChanged=true
            lastMode=0
            --if not lbValues.isincombat then lb.groupMask[1].Event.LeftClick="/target @self" end
            --resetBuffMonitorTextures()
            --print("soloreset")
            setMouseActions()
        end

        for i= 1,20 do
            --name=string.format("group%.2d", i)
            --lb.UnitsTableStatus[name][5]=0 --Unit ID

        end
        lb.QueryTable = lb.SoloTable
        if processsolo == false then
            processMacroText(lb.UnitTable)
        end
        lb.groupBF[1]:SetVisible(true)
        if not lbValues.isincombat then lb.groupMask[1]:SetVisible(true) end

    end
    if lbgroupfound then
        if lastMode~=1 then
            viewModeChanged=true
            lastMode=1
            --print("groupreset")
            --resetBuffMonitorTextures()
            setMouseActions()
        end
        lb.QueryTable = lb.GroupTable
        if processgroup == false then
            processMacroText(lb.UnitsGroupTable)
        end
--        if not lbValues.isincombat then
--            lb.groupMask[1].Event.LeftClick="/target @group01"
--        end
        for i = 1, 5 do
            --name=string.format("group%.2d", i)
            --lb.UnitsTableStatus[name][5]=0 --Unit ID
        end
    end
    if lbraidfound then
        if lastMode~=2 then
            viewModeChanged=true
            lastMode=2
            if lastmode==0 then
--                if not lbValues.isincombat  then
--                    lb.groupMask[1].Event.LeftClick="/target @group01"
--                end
            end
            setMouseActions()
            --print("raidreset")
            --resetBuffMonitorTextures()
        end
        lb.QueryTable = lb.RaidTable
        for i= 1,20 do
            --name=string.format("group%.2d", i)
            --lb.UnitsTableStatus[name][5]=0 --Unit ID
        end
        if processraid == false then
            processMacroText(lb.UnitsTable)
        end
    end
end


function lbUnitUpdate()

   local timer = getThrottle()--throttle to limit cpu usage (period set to 0.25 sec)
    if not timer then return end
    if lbValues.playerName==nil then  lbValues.playerName=unitdetail("player").name end
    if lbValues.isincombat==nil or not lbValues.isincombat then UpdateFramesVisibility()end -- reads the group status and hide or show players frames
--    if (lb.MouseOverUnitLastCast~=nil) then
--        local unitIndex =GetIndexFromID( lb.MouseOverUnitLastCast)
--        if unitIndex~=nil then lb.groupReceivingSpell[unitIndex]:SetVisible(false) end
--    end
    local details = unitdetail(lb.QueryTable)
    local targetunit=unitdetail("player.target")
    for key,val in pairs(lb.UnitsTableStatus) do
        if key~= "player" then
        lb.UnitsTableStatus[key][8]=false
        end
    end
    for unitident, unitTable in pairs(details) do
        local j = stripnum(unitident)   --calculate key from unit identifier
       local name = unitTable.name

        if string.len(name) > 5 then name = string.sub(name, 1, 5).."" end --restrict names to 8 letters
        lb.groupName[j]:SetText(name)

        if unitTable == nil  then
--            print(tostring(unitTable))
--            if lb.UnitsTableStatus[unitident][5]~=0 then
--                lb.UnitsTableStatus[unitident][5]=0
--                resetBuffMonitorTexturesForIndex(j)
--            end
        else
            --print("1s:"..tostring(j)..tostring(lb.UnitsTableStatus[unitident][5]))

            lb.UnitsTableStatus[unitident][8]=true
            if lb.UnitsTableStatus[unitident][5]~=unitTable.id then
--                print("1:"..tostring(lb.UnitsTableStatus[unitident][5]))
--                print("2:"..unitTable.id)
--                print("3:"..unitident)
--                print("3.5:"..tostring(j))
--                print ("4:"..tostring(tostring(lb.UnitsTableStatus[unitident][5])==tostring(unitTable.id)))
                  lb.UnitsTableStatus[unitident][5]=unitTable.id
--                print("5:"..lb.UnitsTableStatus[unitident][5])
--                resetBuffMonitorTexturesForIndex(j)
--                print("6:"..lb.UnitsTableStatus[unitident][5])
--                print ("7:"..tostring(tostring(lb.UnitsTableStatus[unitident][5])==tostring(unitTable.id)))
            end
            if not lbValues.isincombat then
                lb.groupMask[j]:SetMouseoverUnit(unitTable.id)
            end
            if unitTable.calling then
                for i = 1, 4 do
                    if unitTable.calling == lb.Calling[i] then
                        lb.groupName[j]:SetFontColor(lbCallingColors[i].r, lbCallingColors[i].g, lbCallingColors[i].b, 1)
                    end
                end
            else
                lb.groupName[j]:SetFontColor(1, 1, 1, 1)
            end


            if lb.UnitsTableStatus[unitident][4] ~=  unitTable.role or viewModeChanged then
                lb.UnitsTableStatus[unitident][4] =  unitTable.role
                if unitTable.role then
                    lb.groupRole[j]:SetTexture("LifeBinder", "Textures/"..unitTable.role..".png")
                else
                    lb.groupRole[j]:SetTexture("LifeBinder", "Textures/".."blank.png")
                end
            end

            if lb.UnitsTableStatus[unitident][2] ~=  unitTable.offline or viewModeChanged then
                lb.UnitsTableStatus[unitident][2] =  unitTable.offline
                    if unitTable.offline then
                        lb.groupStatus[j]:SetText("Offline")
                        lb.groupHF[j]:SetWidth(1)
                    end
            end

            if targetunit~=nil then
                if unitident == targetunit.id  or viewModeChanged then
                    lb.UnitsTableStatus[unitident][6] =  true
                    if lb.UnitsTableStatus[unitident][6] then
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/aggroframe.png")
                    else
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/backframe.png")
                    end
                else
                    lb.UnitsTableStatus[unitident][6] =  false
                end
            end

            if lb.UnitsTableStatus[unitident][1] ~=  unitTable.aggro or viewModeChanged then
                lb.UnitsTableStatus[unitident][1] =  unitTable.aggro
                if unitTable.aggro then
                    lb.groupBF[j]:SetTexture("LifeBinder", "Textures/aggroframe.png")
                else
                    lb.groupBF[j]:SetTexture("LifeBinder", "Textures/backframe.png")
                end
            end
            if lb.UnitsTableStatus[unitident][3] ~=  unitTable.blocked or viewModeChanged then

                lb.UnitsTableStatus[unitident][3] =  unitTable.blocked
                if unitTable.blocked  then
                    lb.groupHF[j]:SetTexture("LifeBinder", "Textures/healthlos.png")
                else
                    lb.groupHF[j]:SetTexture("LifeBinder", "Textures/"..lbValues.texture)
                end
            end
            if viewModeChanged then
              local  healthtick = unitTable.health
              local  healthmax = unitTable.healthMax
                if healthtick and healthmax ~= nil then
                local  healthpercent = string.format("%s%%", (math.ceil(healthtick/healthmax * 100)))
                    lb.groupHF[j]:SetWidth((tempx - 5)*(healthtick/healthmax))
                    lb.groupStatus[j]:SetText(healthpercent)
                end
            end

        end

    end

   for key,val in pairs(lb.UnitsTableStatus) do

       if not lb.UnitsTableStatus[key][8] and key~="player" then
           lb.UnitsTableStatus[key][5]=0

           if lastMode==0 and key=="group01" then
           else
               local needreset=false

               for i = 1,5 do
                   if lb.groupHoTSpotsIcons[stripnum(key)][i][0] then
                       needreset=true
                   end
               end
               if needreset then
                   resetBuffMonitorTexturesForIndex(stripnum(key))
               end
               if castbarIndexVisible(stripnum(key)) then
                   resetCastbarIndex(stripnum(key))
               end

           end
       end
   end

    viewModeChanged=false
end
--Called by the event   Event.Unit.Detail.Aggro
function  lbAggroUpdate(units)
    local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        identif = GetIdentifierFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=stripnum(identif)
            if j~=nil then

                --if lb.UnitsTableStatus[identif][1] ~=  unitTable.aggro or viewModeChanged then
                    lb.UnitsTableStatus[identif][1] =  unitTable.aggro
                    if unitTable.aggro then
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/aggroframe.png")
                    else
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/backframe.png")
                    end
                --end
            end
        end
    end
end
--Called by the event   Event.Unit.Detail.Blocked
function  lbBlockedUpdate(units)
    local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        identif = GetIdentifierFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=stripnum(identif)
            if j~=nil then

                --if lb.UnitsTableStatus[identif][3] ~=  unitTable.blocked or viewModeChanged then
                    lb.UnitsTableStatus[identif][3] =  unitTable.blocked
                    print (identif .. tostring(unitTable.blocked))
                    if unitTable.blocked  then
                        lb.groupHF[j]:SetTexture("LifeBinder", "Textures/healthlos.png")
                     elseif unitTable.blocked==nil  then
                        lb.groupHF[j]:SetTexture("LifeBinder", "Textures/"..lbValues.texture)
                    else
                        lb.groupHF[j]:SetTexture("LifeBinder", "Textures/"..lbValues.texture)
                    end
                --end
            end
        end
    end
end
--Called by the event   Event.Unit.Detail.Health e Event.Unit.Detail.HealthMax
function  lbHpUpdate(units)

  --  timer = getThrottle2()--throttle to limit cpu usage (period set to 0.25 sec)
   -- if not timer then return end
    local details = unitdetail(units)
    for unitident, unitTable in pairs(details) do
        identif = GetIdentifierFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=stripnum(identif)
            if j~=nil then
                healthtick = unitTable.health
                healthmax = unitTable.healthMax
                if healthtick and healthmax ~= nil then
                    healthpercent = string.format("%s%%", (math.ceil(healthtick/healthmax * 100)))
                    lb.groupHF[j]:SetWidth((tempx - 5)*(healthtick/healthmax))
                    lb.groupStatus[j]:SetText(healthpercent)
                end
                if lb.UnitsTableStatus[identif][1] ~=  unitTable.aggro or viewModeChanged then
                    lb.UnitsTableStatus[identif][1] =  unitTable.aggro
                    if unitTable.aggro then
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/aggroframe.png")
                    else
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/backframe.png")
                    end
                end
            end
        end
    end
end

function GetIdentifierFromID(ID)
    for v,g in pairs(lb.UnitsTableStatus) do
        if g[5]==ID then
            return (v)
        end
    end
    return nil
end
function GetIndexFromID(ID)
    for v,g in pairs(lb.UnitsTableStatus) do
        if g[5]==ID then
            return (g[7])
        end
    end
    return nil
end
function stripnum(name)
    local j
    if name == "player" or name == "player.pet" then j = 1
    else j = tonumber(string.sub(name, string.find(name, "%d%d"))) end
    return j
end

function onRoleChanged(role)
    lbValues.set=role;
    --call abilities
    initializeSpecButtons()
    lbUpdateSpellTextures() --update textures cache and populate the lb.NoIconsBuffList table
    resetBuffMonitorTextures() --hide every buff slot
    setMouseActions()
    --lbUpdateRequiredSpellsList()

    createTableBuffs()--gui
    createTableDebuffs() --gui
    UpdateMouseAssociationsTextFieldsValues() --gui
end

function onAbilityAdded(abilities)
    if lbValues.set==nil then
        if lb.PlayerID==nil then lb.PlayerID=Inspect.Unit.Lookup("player") end
        onRoleChanged( Inspect.TEMPORARY.Role())
    end
end

function onSecureEnter()
    lbValues.isincombat=true
    lb.CombatStatus:SetTexture("LifeBinder", "Textures/buffhot2.png")
    lb.WindowFrameTop:SetTexture("LifeBinder", "none.jpg")
    hideSpecButtons()
end
function onSecureExit()
    lbValues.isincombat=false
    lb.CombatStatus:SetTexture("LifeBinder", "Textures/buffhot.png")
    lb.WindowFrameTop:SetTexture("LifeBinder", "Textures/header.png")
    showSpecButtons()
end

function onPlayerTargetChanged(unit)
    -- print (unit)
    if unit==false then  lb.LastTarget =nil end
    local found = false

    for i = 1 , 20 do
        local name=string.format("group%.2d", i)
         if lb.UnitsTableStatus[name][5]== unit then
             lb.UnitsTableStatus[name][6]=true
             lb.groupTarget[i]:SetVisible(true)
             found=true
             lb.LastTarget=unit
             --print(tostring(i)..name.."true")
         else
             lb.UnitsTableStatus[name][6]=false
             lb.groupTarget[i]:SetVisible(false)
             --print(tostring(i)..name.."false")
         end
    end
    if lastMode== 0 then
    if lb.UnitsTableStatus["player"][5]== unit then
        lb.UnitsTableStatus["player"][6]=true
        lb.groupTarget[1]:SetVisible(true)
        found=true
        lb.LastTarget=unit

        --print(tostring(i).."Playertrue")
    else
        lb.UnitsTableStatus["player"][6]=false
        lb.groupTarget[1]:SetVisible(false)
        --print(tostring(i).."Playerfalse")
    end
    end
    if not found then
        lb.LastTarget=nil
    end
end
function onMouseOverTargetChanged(unit)

     local newindex =GetIndexFromID(unit)
     local lastindex= GetIndexFromID(lb.MouseOverUnit)
     --if lastindex~=nil then lb.groupReceivingSpell[lastindex]:SetVisible(false) end
     if newindex~=nil then

        --print (GetIdentifierFromID(unit))

         --lb.groupReceivingSpell[newindex]:SetVisible(true)
        lb.MouseOverUnit=unit
     else
        --print (unit)
         lb.MouseOverUnit=nil
     end
end