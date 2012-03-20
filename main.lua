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

function rhbloadSettings()
    lastMode=-1
    if rhbValues == nil then
        rhbValues = {addonState = true, windowstate = true, lockedState = false, locmainx = 0, locmainy = 0, mainheight = 300, mainwidth = 500, font = 16, pet = false, texture = "health_g.png", set = 1, hotwatch = true, debuffwatch = true, rolewatch = true, showtooltips = true }


        rhbValues.locmainx = ((UIParent:GetRight() / 2) - 150)
        rhbValues.locmainy = ((UIParent:GetBottom() / 2) - 250)
    end
    if rhbValues.CacheDebuffs==nil then
        rhbValues.CacheDebuffs=false
    end



    if rhbMacroText == nil then
        rhbMacroText = {}
        rhbMacroText[1]={{"target ##", "", "", "", ""} }
        rhbMacroText[2]={{"target ##", "", "", "", ""} }
        rhbMacroText[3]={{"target ##", "", "", "", ""} }
        rhbMacroText[4]={{"target ##", "", "", "", ""} }
        rhbMacroText[5]={{"target ##", "", "", "", ""} }
        rhbMacroText[6]={{"target ##", "", "", "", ""} }
    end
    if rhbMacroButton == nil then
        rhbMacroButton ={}
        rhbMacroButton[1]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        rhbMacroButton[2]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        rhbMacroButton[3]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        rhbMacroButton[4]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        rhbMacroButton[5]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
        rhbMacroButton[6]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
    end
    if rhbBuffList == nil then
        rhbBuffList ={}
        rhbBuffList[1]={{},{},{},{}}
        rhbBuffList[2]={{},{},{},{}}
        rhbBuffList[3]={{},{},{},{}}
        rhbBuffList[4]={{},{},{},{}}
        rhbBuffList[5]={{},{},{},{}}
        rhbBuffList[6]={{},{},{},{}}
    end
    if rhbDeBuffList == nil then
        rhbDeBuffList ={}
        rhbDeBuffList[1]={ }
        rhbDeBuffList[2]={ }
        rhbDeBuffList[3]={ }
        rhbDeBuffList[4]={ }
        rhbDeBuffList[5]={ }
        rhbDeBuffList[6]={ }
    end
    if rhbCallingColors == nil then
        rhbCallingColors = {{r = 1, g = 0, b = 0}, {r = 0, g = 1, b = 0}, {r = 0.6, g = 0.2, b = 0.8}, {r = 1, g = 1, b = 0}, {r = 1, g = 1, b = 1}}
    end
    if rhbValues.hotwatch == nil then rhbValues.hotwatch = true end
    if rhbValues.debuffwatch == nil then rhbValues.debuffwatch = true end
    if rhbValues.rolewatch == nil then rhbValues.rolewatch = true end
    if rhbValues.showtooltips == nil then rhbValues.showtooltips = true end



    rhbValues.islocked=false
    rhbValues.isincombat=false
    rhbValues.set=nil

	rhbCreateWindow()
    createOptionsWindow()
	--rhbCreateAbilityList()
	--rhbCreateOptions()
    print ("Welcome to Rift Hbot! Type /rhb for commands.")

end



function UpdateFramesVisibility()
   local rhbgroupfound = false
   local rhbraidfound = false
   local rhbsolofound = true
    for k, v in pairs(rhb.UnitsTable) do
        if unitLookup(v) then
            if k < 6 then rhbraidfound = false rhbgroupfound = true end
            if k > 5 then rhbraidfound = true rhbgroupfound = false end
            rhbsolofound = false
            rhb.groupBF[k]:SetVisible(true)
            if not rhbValues.isincombat then rhb.groupMask[k]:SetVisible(true) end
        else
            rhb.groupBF[k]:SetVisible(false)
            if not rhbValues.isincombat then rhb.groupMask[k]:SetVisible(false) end
        end
    end

    if rhbsolofound then

        if lastMode~=0 then
            viewModeChanged=true
            lastMode=0
            --if not rhbValues.isincombat then rhb.groupMask[1].Event.LeftClick="/target @self" end
            --resetBuffMonitorTextures()
            --print("soloreset")
            setMouseActions()
        end

        for i= 1,20 do
            --name=string.format("group%.2d", i)
            --rhb.UnitsTableStatus[name][5]=0 --Unit ID

        end
        rhb.QueryTable = rhb.SoloTable
        if processsolo == false then
            processMacroText(rhb.UnitTable)
        end
        rhb.groupBF[1]:SetVisible(true)
        if not rhbValues.isincombat then rhb.groupMask[1]:SetVisible(true) end

    end
    if rhbgroupfound then
        if lastMode~=1 then
            viewModeChanged=true
            lastMode=1
            --print("groupreset")
            --resetBuffMonitorTextures()
            setMouseActions()
        end
        rhb.QueryTable = rhb.GroupTable
        if processgroup == false then
            processMacroText(rhb.UnitsGroupTable)
        end
--        if not rhbValues.isincombat then
--            rhb.groupMask[1].Event.LeftClick="/target @group01"
--        end
        for i = 1, 5 do
            --name=string.format("group%.2d", i)
            --rhb.UnitsTableStatus[name][5]=0 --Unit ID
        end
    end
    if rhbraidfound then
        if lastMode~=2 then
            viewModeChanged=true
            lastMode=2
            if lastmode==0 then
--                if not rhbValues.isincombat  then
--                    rhb.groupMask[1].Event.LeftClick="/target @group01"
--                end
            end
            setMouseActions()
            --print("raidreset")
            --resetBuffMonitorTextures()
        end
        rhb.QueryTable = rhb.RaidTable
        for i= 1,20 do
            --name=string.format("group%.2d", i)
            --rhb.UnitsTableStatus[name][5]=0 --Unit ID
        end
        if processraid == false then
            processMacroText(rhb.UnitsTable)
        end
    end
end


function rhbUnitUpdate()

   local timer = getThrottle()--throttle to limit cpu usage (period set to 0.25 sec)
    if not timer then return end
    if rhbValues.playerName==nil then  rhbValues.playerName=unitdetail("player").name end
    if rhbValues.isincombat==nil or not rhbValues.isincombat then UpdateFramesVisibility()end -- reads the group status and hide or show players frames
--    if (rhb.MouseOverUnitLastCast~=nil) then
--        local unitIndex =GetIndexFromID( rhb.MouseOverUnitLastCast)
--        if unitIndex~=nil then rhb.groupReceivingSpell[unitIndex]:SetVisible(false) end
--    end
    local details = unitdetail(rhb.QueryTable)
    local targetunit=unitdetail("player.target")
    for key,val in pairs(rhb.UnitsTableStatus) do
        if key~= "player" then
        rhb.UnitsTableStatus[key][8]=false
        end
    end
    for unitident, unitTable in pairs(details) do
        local j = stripnum(unitident)   --calculate key from unit identifier
       local name = unitTable.name

        if string.len(name) > 5 then name = string.sub(name, 1, 5).."" end --restrict names to 8 letters
        rhb.groupName[j]:SetText(name)

        if unitTable == nil  then
--            print(tostring(unitTable))
--            if rhb.UnitsTableStatus[unitident][5]~=0 then
--                rhb.UnitsTableStatus[unitident][5]=0
--                resetBuffMonitorTexturesForIndex(j)
--            end
        else
            --print("1s:"..tostring(j)..tostring(rhb.UnitsTableStatus[unitident][5]))

            rhb.UnitsTableStatus[unitident][8]=true
            if rhb.UnitsTableStatus[unitident][5]~=unitTable.id then
--                print("1:"..tostring(rhb.UnitsTableStatus[unitident][5]))
--                print("2:"..unitTable.id)
--                print("3:"..unitident)
--                print("3.5:"..tostring(j))
--                print ("4:"..tostring(tostring(rhb.UnitsTableStatus[unitident][5])==tostring(unitTable.id)))
                  rhb.UnitsTableStatus[unitident][5]=unitTable.id
--                print("5:"..rhb.UnitsTableStatus[unitident][5])
--                resetBuffMonitorTexturesForIndex(j)
--                print("6:"..rhb.UnitsTableStatus[unitident][5])
--                print ("7:"..tostring(tostring(rhb.UnitsTableStatus[unitident][5])==tostring(unitTable.id)))
            end
            if not rhbValues.isincombat then
                rhb.groupMask[j]:SetMouseoverUnit(unitTable.id)
            end
            if unitTable.calling then
                for i = 1, 4 do
                    if unitTable.calling == rhb.Calling[i] then
                        rhb.groupName[j]:SetFontColor(rhbCallingColors[i].r, rhbCallingColors[i].g, rhbCallingColors[i].b, 1)
                    end
                end
            else
                rhb.groupName[j]:SetFontColor(1, 1, 1, 1)
            end


            if rhb.UnitsTableStatus[unitident][4] ~=  unitTable.role or viewModeChanged then
                rhb.UnitsTableStatus[unitident][4] =  unitTable.role
                if unitTable.role then
                    rhb.groupRole[j]:SetTexture("RiftHbot", "Textures/"..unitTable.role..".png")
                else
                    rhb.groupRole[j]:SetTexture("RiftHbot", "Textures/".."blank.png")
                end
            end

            if rhb.UnitsTableStatus[unitident][2] ~=  unitTable.offline or viewModeChanged then
                rhb.UnitsTableStatus[unitident][2] =  unitTable.offline
                    if unitTable.offline then
                        rhb.groupStatus[j]:SetText("Offline")
                        rhb.groupHF[j]:SetWidth(1)
                    end
            end

            if targetunit~=nil then
                if unitident == targetunit.id  or viewModeChanged then
                    rhb.UnitsTableStatus[unitident][6] =  true
                    if rhb.UnitsTableStatus[unitident][6] then
                        rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/aggroframe.png")
                    else
                        rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/backframe.png")
                    end
                else
                    rhb.UnitsTableStatus[unitident][6] =  false
                end
            end

            if rhb.UnitsTableStatus[unitident][1] ~=  unitTable.aggro or viewModeChanged then
                rhb.UnitsTableStatus[unitident][1] =  unitTable.aggro
                if unitTable.aggro then
                    rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/aggroframe.png")
                else
                    rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/backframe.png")
                end
            end
            if rhb.UnitsTableStatus[unitident][3] ~=  unitTable.blocked or viewModeChanged then

                rhb.UnitsTableStatus[unitident][3] =  unitTable.blocked
                if unitTable.blocked  then
                    rhb.groupHF[j]:SetTexture("RiftHbot", "Textures/healthlos.png")
                else
                    rhb.groupHF[j]:SetTexture("RiftHbot", "Textures/"..rhbValues.texture)
                end
            end
            if viewModeChanged then
              local  healthtick = unitTable.health
              local  healthmax = unitTable.healthMax
                if healthtick and healthmax ~= nil then
                local  healthpercent = string.format("%s%%", (math.ceil(healthtick/healthmax * 100)))
                    rhb.groupHF[j]:SetWidth((tempx - 5)*(healthtick/healthmax))
                    rhb.groupStatus[j]:SetText(healthpercent)
                end
            end

        end

    end

   for key,val in pairs(rhb.UnitsTableStatus) do

       if not rhb.UnitsTableStatus[key][8] and key~="player" then
           rhb.UnitsTableStatus[key][5]=0

           if lastMode==0 and key=="group01" then
           else
               local needreset=false

               for i = 1,5 do
                   if rhb.groupHoTSpotsIcons[stripnum(key)][i][0] then
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
function  rhbAggroUpdate(units)
    local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        identif = GetIdentifierFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=stripnum(identif)
            if j~=nil then

                --if rhb.UnitsTableStatus[identif][1] ~=  unitTable.aggro or viewModeChanged then
                    rhb.UnitsTableStatus[identif][1] =  unitTable.aggro
                    if unitTable.aggro then
                        rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/aggroframe.png")
                    else
                        rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/backframe.png")
                    end
                --end
            end
        end
    end
end
--Called by the event   Event.Unit.Detail.Blocked
function  rhbBlockedUpdate(units)
    local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        identif = GetIdentifierFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=stripnum(identif)
            if j~=nil then

                --if rhb.UnitsTableStatus[identif][3] ~=  unitTable.blocked or viewModeChanged then
                    rhb.UnitsTableStatus[identif][3] =  unitTable.blocked
                    print (identif .. tostring(unitTable.blocked))
                    if unitTable.blocked  then
                        rhb.groupHF[j]:SetTexture("RiftHbot", "Textures/healthlos.png")
                     elseif unitTable.blocked==nil  then
                        rhb.groupHF[j]:SetTexture("RiftHbot", "Textures/"..rhbValues.texture)
                    else
                        rhb.groupHF[j]:SetTexture("RiftHbot", "Textures/"..rhbValues.texture)
                    end
                --end
            end
        end
    end
end
--Called by the event   Event.Unit.Detail.Health e Event.Unit.Detail.HealthMax
function  rhbHpUpdate(units)

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
                    rhb.groupHF[j]:SetWidth((tempx - 5)*(healthtick/healthmax))
                    rhb.groupStatus[j]:SetText(healthpercent)
                end
                if rhb.UnitsTableStatus[identif][1] ~=  unitTable.aggro or viewModeChanged then
                    rhb.UnitsTableStatus[identif][1] =  unitTable.aggro
                    if unitTable.aggro then
                        rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/aggroframe.png")
                    else
                        rhb.groupBF[j]:SetTexture("RiftHbot", "Textures/backframe.png")
                    end
                end
            end
        end
    end
end

function GetIdentifierFromID(ID)
    for v,g in pairs(rhb.UnitsTableStatus) do
        if g[5]==ID then
            return (v)
        end
    end
    return nil
end
function GetIndexFromID(ID)
    for v,g in pairs(rhb.UnitsTableStatus) do
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
    rhbValues.set=role;
    --call abilities
    initializeSpecButtons()
    rhbUpdateSpellTextures() --update textures cache and populate the rhb.NoIconsBuffList table
    resetBuffMonitorTextures() --hide every buff slot
    setMouseActions()
    --rhbUpdateRequiredSpellsList()

    createTableBuffs()--gui
    createTableDebuffs() --gui
    UpdateMouseAssociationsTextFieldsValues() --gui
end

function onAbilityAdded(abilities)
    if rhbValues.set==nil then
        if rhb.PlayerID==nil then rhb.PlayerID=Inspect.Unit.Lookup("player") end
        onRoleChanged( Inspect.TEMPORARY.Role())
    end
end

function onSecureEnter()
    rhbValues.isincombat=true
    rhb.CombatStatus:SetTexture("RiftHbot", "Textures/buffhot2.png")
    rhb.WindowFrameTop:SetTexture("RiftHbot", "none.jpg")
    hideSpecButtons()
end
function onSecureExit()
    rhbValues.isincombat=false
    rhb.CombatStatus:SetTexture("RiftHbot", "Textures/buffhot.png")
    rhb.WindowFrameTop:SetTexture("RiftHbot", "Textures/header.png")
    showSpecButtons()
end

function onPlayerTargetChanged(unit)
    -- print (unit)
    if unit==false then  rhb.LastTarget =nil end
    local found = false

    for i = 1 , 20 do
        local name=string.format("group%.2d", i)
         if rhb.UnitsTableStatus[name][5]== unit then
             rhb.UnitsTableStatus[name][6]=true
             rhb.groupTarget[i]:SetVisible(true)
             found=true
             rhb.LastTarget=unit
             --print(tostring(i)..name.."true")
         else
             rhb.UnitsTableStatus[name][6]=false
             rhb.groupTarget[i]:SetVisible(false)
             --print(tostring(i)..name.."false")
         end
    end
    if lastMode== 0 then
    if rhb.UnitsTableStatus["player"][5]== unit then
        rhb.UnitsTableStatus["player"][6]=true
        rhb.groupTarget[1]:SetVisible(true)
        found=true
        rhb.LastTarget=unit

        --print(tostring(i).."Playertrue")
    else
        rhb.UnitsTableStatus["player"][6]=false
        rhb.groupTarget[1]:SetVisible(false)
        --print(tostring(i).."Playerfalse")
    end
    end
    if not found then
        rhb.LastTarget=nil
    end
end
function onMouseOverTargetChanged(unit)

     local newindex =GetIndexFromID(unit)
     local lastindex= GetIndexFromID(rhb.MouseOverUnit)
     --if lastindex~=nil then rhb.groupReceivingSpell[lastindex]:SetVisible(false) end
     if newindex~=nil then

        --print (GetIdentifierFromID(unit))

         --rhb.groupReceivingSpell[newindex]:SetVisible(true)
        rhb.MouseOverUnit=unit
     else
        --print (unit)
         rhb.MouseOverUnit=nil
     end
end