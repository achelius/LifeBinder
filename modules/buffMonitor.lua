--
--Buff Monitor
--
local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitylist = _G.Inspect.Ability.List
local abilitydetail = _G.Inspect.Ability.Detail
local buffdetail=   _G.Inspect.Buff.Detail
local bufflist=   _G.Inspect.Buff.List
function initializeBuffMonitor()
    for g= 1, 5 do
       local lt=0
       local tp=0
        if g==1 then
            lt=(-6)*tempx*0.009009009
            tp=6*tempy*0.023255814
        elseif g==2 then
            lt=-24 *tempx*0.009009009
            tp=6 *tempy*0.023255814

        elseif g==3 then
            lt=-tempx+(25)*tempx*0.009009009
            tp=tempy-(20)*tempy*0.023255814

        elseif g==4 then
            lt=-tempx+(43)*tempx*0.009009009
            tp=tempy-(20)*tempy*0.023255814
        elseif g==5 then
            lt=-tempx+61*tempx*0.009009009
            tp=tempy-20*tempy*0.023255814
        end
        local iconheight=(16*tempy)*0.023255814
        local iconwidth=(16*tempx)*0.009009009
        rhb.groupHoTSpots[var][g][1]:SetTexture(rhb.groupHoTSpotsIcons[var][g][1],rhb.groupHoTSpotsIcons[var][g][2] )
        rhb.groupHoTSpots[var][g][1]:SetPoint("TOPRIGHT", rhb.groupBF[var], "TOPRIGHT", lt,  tp )
        rhb.groupHoTSpots[var][g][1]:SetHeight(iconwidth)
        rhb.groupHoTSpots[var][g][1]:SetWidth(iconheight)
        rhb.groupHoTSpots[var][g][1]:SetLayer(5)
        rhb.groupHoTSpots[var][g][1]:SetVisible(rhb.groupHoTSpotsIcons[var][g][0])

        rhb.groupHoTSpots[var][g][2]:SetPoint("CENTER", rhb.groupHoTSpots[var][g][1], "CENTER", 5, 5 )
        rhb.groupHoTSpots[var][g][2]:SetFontColor(1,1,1,1)
        rhb.groupHoTSpots[var][g][2]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
        rhb.groupHoTSpots[var][g][2]:SetLayer(7)
        if rhb.groupHoTSpotsIcons[var][g][3]==0 then  rhb.groupHoTSpots[var][g][2]:SetVisible(false) end

        rhb.groupHoTSpots[var][g][3]:SetPoint("CENTER", rhb.groupHoTSpots[var][g][1], "CENTER",7, 7 )
        rhb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
        rhb.groupHoTSpots[var][g][3]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
        rhb.groupHoTSpots[var][g][3]:SetLayer(6)
        if rhb.groupHoTSpotsIcons[var][g][3]==0 then  rhb.groupHoTSpots[var][g][3]:SetVisible(false) end
    end
end

function updateBuffMonitorTextures()
    for var=1,20 do
        for g= 1, 5 do

            if rhb.groupHoTSpotsIcons[var][g][4] then
                --just updated
                --print (rhb.groupHoTSpotsIcons[var][g][3])
                rhb.groupHoTSpots[var][g][4]=false
                rhb.groupHoTSpots[var][g][1]:SetTexture(rhb.groupHoTSpotsIcons[var][g][1],rhb.groupHoTSpotsIcons[var][g][2] )
                rhb.groupHoTSpots[var][g][1]:SetVisible(rhb.groupHoTSpotsIcons[var][g][0])
                --print (rhb.groupHoTSpots[var][g][1]:GetVisible())

                rhb.groupHoTSpots[var][g][2]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
                if (rhb.groupHoTSpotsIcons[var][g][3]==0 or rhb.groupHoTSpotsIcons[var][g][3]==nil) and {rhb.groupHoTSpotsIcons[var][g][0]} then
                    --print("nostack")
                    rhb.groupHoTSpots[var][g][2]:SetVisible(false)
                else
                    -- print("stack")
                    rhb.groupHoTSpots[var][g][2]:SetVisible(true)
                end

                rhb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
                rhb.groupHoTSpots[var][g][3]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
                rhb.groupHoTSpots[var][g][3]:SetLayer(2)
                if (rhb.groupHoTSpotsIcons[var][g][3]==0 or rhb.groupHoTSpotsIcons[var][g][3]==nil) and {rhb.groupHoTSpotsIcons[var][g][0]} then
                    rhb.groupHoTSpots[var][g][3]:SetVisible(false)
                else
                    rhb.groupHoTSpots[var][g][3]:SetVisible(true)
                end
            end
        end
    end
end
function updateBuffMonitorTexturesIndex(frameindex,slotindex)


            if rhb.groupHoTSpotsIcons[frameindex][slotindex][4] then
                --just updated
                --print (rhb.groupHoTSpotsIcons[frameindex][slotindex][3])
                rhb.groupHoTSpots[frameindex][slotindex][4]=false
                rhb.groupHoTSpots[frameindex][slotindex][1]:SetTexture(rhb.groupHoTSpotsIcons[frameindex][slotindex][1],rhb.groupHoTSpotsIcons[frameindex][slotindex][2] )
                rhb.groupHoTSpots[frameindex][slotindex][1]:SetVisible(rhb.groupHoTSpotsIcons[frameindex][slotindex][0])
                --print (rhb.groupHoTSpots[frameindex][slotindex][1]:GetVisible())

                rhb.groupHoTSpots[frameindex][slotindex][2]:SetText(tostring(rhb.groupHoTSpotsIcons[frameindex][slotindex][3]))
                if (rhb.groupHoTSpotsIcons[frameindex][slotindex][3]==0 or rhb.groupHoTSpotsIcons[frameindex][slotindex][3]==nil) and {rhb.groupHoTSpotsIcons[frameindex][slotindex][0]} then
                    --print("nostack")
                    rhb.groupHoTSpots[frameindex][slotindex][2]:SetVisible(false)
                else
                    -- print("stack")
                    rhb.groupHoTSpots[frameindex][slotindex][2]:SetVisible(true)
                end

                rhb.groupHoTSpots[frameindex][slotindex][3]:SetFontColor(0,0,0,1)
                rhb.groupHoTSpots[frameindex][slotindex][3]:SetText(tostring(rhb.groupHoTSpotsIcons[frameindex][slotindex][3]))
                rhb.groupHoTSpots[frameindex][slotindex][3]:SetLayer(2)
                if (rhb.groupHoTSpotsIcons[frameindex][slotindex][3]==0 or rhb.groupHoTSpotsIcons[frameindex][slotindex][3]==nil) and {rhb.groupHoTSpotsIcons[frameindex][slotindex][0]} then
                    rhb.groupHoTSpots[frameindex][slotindex][3]:SetVisible(false)
                else
                    rhb.groupHoTSpots[frameindex][slotindex][3]:SetVisible(true)
                end
            end

end
function resetBuffMonitorTextures()
    for var=1,20 do
        for g= 1, 5 do
            rhb.groupHoTSpotsIcons[var][g][0]=false
            --print (rhb.groupHoTSpotsIcons[var][g][0])
            rhb.groupHoTSpots[var][g][4]=false
            rhb.groupHoTSpots[var][g][1]:SetTexture(rhb.groupHoTSpotsIcons[var][g][1],rhb.groupHoTSpotsIcons[var][g][2] )
            rhb.groupHoTSpots[var][g][1]:SetVisible(rhb.groupHoTSpotsIcons[var][g][0])

            rhb.groupHoTSpots[var][g][2]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
            if (rhb.groupHoTSpotsIcons[var][g][3]==0 or rhb.groupHoTSpotsIcons[var][g][3]==nil) and {rhb.groupHoTSpotsIcons[var][g][0]} then
                rhb.groupHoTSpots[var][g][2]:SetVisible(false)
            else
                rhb.groupHoTSpots[var][g][2]:SetVisible(true)
            end

            rhb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
            rhb.groupHoTSpots[var][g][3]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
            rhb.groupHoTSpots[var][g][3]:SetLayer(2)

            if (rhb.groupHoTSpotsIcons[var][g][3]==0 or rhb.groupHoTSpotsIcons[var][g][3]==nil) and {rhb.groupHoTSpotsIcons[var][g][0]} then
                rhb.groupHoTSpots[var][g][3]:SetVisible(false)
            else
                rhb.groupHoTSpots[var][g][3]:SetVisible(true)
            end
        end
    end
end
function resetBuffMonitorTexturesForIndex(var)

        for g= 1, 5 do

            if rhb.groupHoTSpotsIcons[var][g][0] then

            rhb.groupHoTSpotsIcons[var][g][0]=false
            rhb.groupHoTSpotsIcons[var][g][4]=true
            --print (rhb.groupHoTSpotsIcons[var][g][0])
            rhb.groupHoTSpots[var][g][4]=false
            rhb.groupHoTSpots[var][g][1]:SetTexture(rhb.groupHoTSpotsIcons[var][g][1],rhb.groupHoTSpotsIcons[var][g][2] )
            rhb.groupHoTSpots[var][g][1]:SetVisible(rhb.groupHoTSpotsIcons[var][g][0])

            rhb.groupHoTSpots[var][g][2]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
            if (rhb.groupHoTSpotsIcons[var][g][3]==0 or rhb.groupHoTSpotsIcons[var][g][3]==nil) and {rhb.groupHoTSpotsIcons[var][g][0]} then
                rhb.groupHoTSpots[var][g][2]:SetVisible(false)
            else
                rhb.groupHoTSpots[var][g][2]:SetVisible(true)
            end

            rhb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
            rhb.groupHoTSpots[var][g][3]:SetText(tostring(rhb.groupHoTSpotsIcons[var][g][3]))
            rhb.groupHoTSpots[var][g][3]:SetLayer(2)

            if (rhb.groupHoTSpotsIcons[var][g][3]==0 or rhb.groupHoTSpotsIcons[var][g][3]==nil) and {rhb.groupHoTSpotsIcons[var][g][0]} then
                rhb.groupHoTSpots[var][g][3]:SetVisible(false)
            else
                rhb.groupHoTSpots[var][g][3]:SetVisible(true)
            end
            end
        end

end
function rhbUpdateSpellTextures()
    local abilities
    abtextures={}
    for v, k in pairs(rhbBuffList) do
        table.insert(abtextures,"Textures/buffhot.png")
    end
    abilities =abilitylist()
    abilitydets=abilitydetail(abilities)
    for d,c in pairs(rhbBuffList[rhbValues.set]) do
        --c={"Soothing Stream", "Healing Current","Healing Flood" }
        for s,a in pairs(c) do
            --a="Soothing Stream" ....
            found=false
            rhb.FullBuffsList[a]=true
            for v, k in pairs(abilitydets) do
                if a==k.name and a~=nil then
                    if k.icon ~=nil then
                        found=true
                        if rhb.IconsCache[a] == nil then
                            rhb.IconsCacheCount=rhb.IconsCacheCount+1
                            rhb.IconsCache[a]={"Rift",k.icon }
                        end
                    end
                end
            end
            if not found then
                rhb.NoIconsBuffList[a]=true
                --print (a)
            end

        end
    end
    createDebuffFullList()
end

function createDebuffFullList()
    rhb.FullDeBuffsList={}
    for slotindex,c in pairs(rhbDeBuffList[rhbValues.set]) do
        --c="Soothing Stream" ....
            rhb.FullDeBuffsList[c]=true
    end
end



function removeFromNoIconList(abilityname)
    if rhb.NoIconsBuffList[a]~=nil then
        rhb.NoIconsBuffList[a]=nil
        --print (a)
    end
end
function getTextureFromCache(abilityName)
    local texture= rhb.IconsCache[abilityName]
    if texture==nil then
        texture={"RiftHbot","Textures/buffhot.png"}
    end
    return texture
end
function hasTextureInCache(abilityName)
    if rhb.IconsCache[abilityName]==nil then
        return false
    else
        return true
    end

end
function addTextureToCache(abilityName,textureLocation,texturePath)
    if not hasTextureInCache(abilityName) then
        rhb.IconsCache[abilityName]={textureLocation,texturePath }
        rhb.IconsCacheCount=rhb.IconsCacheCount+1
        removeFromNoIconList(abilityName)
    end
end


function onBuffAdd(unit, buffs)
     buffs=buffdetail(unit,buffs)
     local frameindex=GetIndexFromID(unit)
     if frameindex==nil then return end
     local updatebuffs=false
     if rhb.PlayerID==nil then rhb.PlayerID=unitdetail("player").ID end

     for key,buffTable in pairs(buffs) do
        name=buffTable.name
        if buffTable.debuff==nil then
            if rhb.FullBuffsList[name]~=nil then
                if buffTable.caster== rhb.PlayerID then
                    local texture=nil
                    if hasTextureInCache(name) then
                        texture= getTextureFromCache(name)
                        --print("cache"..getTextureFromCache(name)[2])
                    else
                        addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(rhbBuffList[rhbValues.set]) do
                        --c={"Soothing Stream", "Healing Current","Healing Flood" }
                        for s,a in pairs(c) do
                            --a="Soothing Stream" ....
                            if a==name and a~=nil then
                                --print (frameindex)
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][0]=true
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][1]=texture[1]
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][2]=texture[2]
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][3]=buffTable.stack
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][4]=true
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][5]=buffTable.id
                                rhb.groupHoTSpotsIcons[frameindex][slotindex][6]=false
                                --print (rhb.groupHoTSpotsIcons[frameindex][slotindex][4])
                                updateBuffMonitorTexturesIndex(frameindex,slotindex)
                                updatebuffs=true
                            end


                        end
                    end
                end
            end
            if updatebuffs then
                --print(true)
                --updateBuffMonitorTextures()
            end
        else

            if rhbValues.CacheDebuffs then
                addDebuffToCache(buffTable)
            end
            if rhb.FullDeBuffsList[name]~=nil then

                    local texture=nil
                    if hasTextureInCache(name) then
                        texture= getTextureFromCache(name)
                        --print("cache"..getTextureFromCache(name)[2])
                    else
                        addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(rhbDeBuffList[rhbValues.set]) do
                        --c="Soothing Stream" ....
                        if c==name and c~=nil then
                            --print (frameindex)
                            rhb.groupHoTSpotsIcons[frameindex][5][0]=true
                            rhb.groupHoTSpotsIcons[frameindex][5][1]=texture[1]
                            rhb.groupHoTSpotsIcons[frameindex][5][2]=texture[2]
                            rhb.groupHoTSpotsIcons[frameindex][5][3]=buffTable.stack
                            rhb.groupHoTSpotsIcons[frameindex][5][4]=true
                            rhb.groupHoTSpotsIcons[frameindex][5][5]=buffTable.id
                            rhb.groupHoTSpotsIcons[frameindex][5][6]=true
                            --print (rhb.groupHoTSpotsIcons[frameindex][slotindex][4])
                            updateBuffMonitorTexturesIndex(frameindex,5)
                            updatebuffs=true



                        end
                    end

            end
            if updatebuffs then
                --print(true)
                --updateBuffMonitorTextures()
            end
        end
    end

end
function onBuffRemove(unit, buffs)
    --buffs=buffdetail(unit,buffs)
    --print ("remove")
    local frameindex=GetIndexFromID(unit)
    if frameindex==nil then return end
    local updatebuffs=false
    for buffID,placeholder in pairs(buffs) do
       -- for slotindex,c in pairs(rhbBuffList[rhbValues.set]) do
        for slotindex= 1, 5 do
            --print (tostring(slotindex)..tostring(buffID))
            if rhb.groupHoTSpotsIcons[frameindex][slotindex][5]== buffID then
                --print (frameindex)
                rhb.groupHoTSpotsIcons[frameindex][slotindex][0]=false
                rhb.groupHoTSpotsIcons[frameindex][slotindex][3]=nil
                rhb.groupHoTSpotsIcons[frameindex][slotindex][4]=true
                rhb.groupHoTSpotsIcons[frameindex][slotindex][5]=nil
                local buffs= bufflist(unit)

                local newbuffsdetails=buffdetail(unit,buffs)

                if rhb.groupHoTSpotsIcons[frameindex][slotindex][6] then
                    --was a debuff
                    for idb,BuffDet in pairs(newbuffsdetails) do
                        if BuffDet.debuff~=nil then
                            local lastdebuffID
                            for i,debuffname in pairs(rhbDeBuffList[rhbValues.set]) do
                                if debuffname==BuffDet.name then
                                    lastdebuffID=BuffDet.id
                                    break
                                end
                            end
                            if lastdebuffID~=nil then
                                onBuffAdd(unit,{lastdebuffID})
                            end
                        end
                    end

                else
                    --was a buff
                    for idb,BuffDet in pairs(newbuffsdetails) do
                        if BuffDet.debuff==nil then
                            local slotbuffs=  rhbBuffList[rhbValues.set][slotindex]

                            if slotbuffs~=nil then
                                local lastdebuffID

                                for i,buffname in pairs(slotbuffs) do

                                    if buffname==BuffDet.name then

                                        lastdebuffID=BuffDet.id
                                        break
                                    end
                                end
                                if lastdebuffID~=nil then

                                    onBuffAdd(unit,{lastdebuffID})
                                end

                            end

                        end
                    end
                end

                updateBuffMonitorTexturesIndex(frameindex,slotindex)
                --print ("rem"..rhb.groupHoTSpotsIcons[frameindex][slotindex][4])
                updatebuffs=true
            end
        end

       -- end
        for i,debuffname in pairs(rhbDeBuffList[rhbValues.set]) do
            --c={"Soothing Stream", "Healing Current","Healing Flood" }
            --print (tostring(slotindex)..tostring(buffID))
            if rhb.groupHoTSpotsIcons[frameindex][5][5]== buffID then
                --print (frameindex)
                rhb.groupHoTSpotsIcons[frameindex][5][0]=false
                rhb.groupHoTSpotsIcons[frameindex][5][3]=nil
                rhb.groupHoTSpotsIcons[frameindex][5][4]=true
                rhb.groupHoTSpotsIcons[frameindex][5][5]=nil
                --print ("rem"..rhb.groupHoTSpotsIcons[frameindex][slotindex][4])
                updateBuffMonitorTexturesIndex(frameindex,5)

                updatebuffs=true
            end

        end
        if updatebuffs then
            --print(true)
            --updateBuffMonitorTextures()
        end

    end
end


