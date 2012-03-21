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
        lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
        lb.groupHoTSpots[var][g][1]:SetPoint("TOPRIGHT", lb.groupBF[var], "TOPRIGHT", lt,  tp )
        lb.groupHoTSpots[var][g][1]:SetHeight(iconwidth)
        lb.groupHoTSpots[var][g][1]:SetWidth(iconheight)
        lb.groupHoTSpots[var][g][1]:SetLayer(5)
        lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])

        lb.groupHoTSpots[var][g][2]:SetPoint("CENTER", lb.groupHoTSpots[var][g][1], "CENTER", 5, 5 )
        lb.groupHoTSpots[var][g][2]:SetFontColor(1,1,1,1)
        lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
        lb.groupHoTSpots[var][g][2]:SetLayer(7)
        if lb.groupHoTSpotsIcons[var][g][3]==0 then  lb.groupHoTSpots[var][g][2]:SetVisible(false) end

        lb.groupHoTSpots[var][g][3]:SetPoint("CENTER", lb.groupHoTSpots[var][g][1], "CENTER",7, 7 )
        lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
        lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
        lb.groupHoTSpots[var][g][3]:SetLayer(6)
        if lb.groupHoTSpotsIcons[var][g][3]==0 then  lb.groupHoTSpots[var][g][3]:SetVisible(false) end
    end
end

function updateBuffMonitorTextures()
    for var=1,20 do
        for g= 1, 5 do

            if lb.groupHoTSpotsIcons[var][g][4] then
                --just updated
                --print (lb.groupHoTSpotsIcons[var][g][3])
                lb.groupHoTSpots[var][g][4]=false
                lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
                lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])
                --print (lb.groupHoTSpots[var][g][1]:GetVisible())

                lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
                if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                    --print("nostack")
                    lb.groupHoTSpots[var][g][2]:SetVisible(false)
                else
                    -- print("stack")
                    lb.groupHoTSpots[var][g][2]:SetVisible(true)
                end

                lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
                lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
                lb.groupHoTSpots[var][g][3]:SetLayer(2)
                if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                    lb.groupHoTSpots[var][g][3]:SetVisible(false)
                else
                    lb.groupHoTSpots[var][g][3]:SetVisible(true)
                end
            end
        end
    end
end
function updateBuffMonitorTexturesIndex(frameindex,slotindex)


            if lb.groupHoTSpotsIcons[frameindex][slotindex][4] then
                --just updated
                --print (lb.groupHoTSpotsIcons[frameindex][slotindex][3])
                lb.groupHoTSpots[frameindex][slotindex][4]=false
                lb.groupHoTSpots[frameindex][slotindex][1]:SetTexture(lb.groupHoTSpotsIcons[frameindex][slotindex][1],lb.groupHoTSpotsIcons[frameindex][slotindex][2] )
                lb.groupHoTSpots[frameindex][slotindex][1]:SetVisible(lb.groupHoTSpotsIcons[frameindex][slotindex][0])
                --print (lb.groupHoTSpots[frameindex][slotindex][1]:GetVisible())

                lb.groupHoTSpots[frameindex][slotindex][2]:SetText(tostring(lb.groupHoTSpotsIcons[frameindex][slotindex][3]))
                if (lb.groupHoTSpotsIcons[frameindex][slotindex][3]==0 or lb.groupHoTSpotsIcons[frameindex][slotindex][3]==nil) and {lb.groupHoTSpotsIcons[frameindex][slotindex][0]} then
                    --print("nostack")
                    lb.groupHoTSpots[frameindex][slotindex][2]:SetVisible(false)
                else
                    -- print("stack")
                    lb.groupHoTSpots[frameindex][slotindex][2]:SetVisible(true)
                end

                lb.groupHoTSpots[frameindex][slotindex][3]:SetFontColor(0,0,0,1)
                lb.groupHoTSpots[frameindex][slotindex][3]:SetText(tostring(lb.groupHoTSpotsIcons[frameindex][slotindex][3]))
                lb.groupHoTSpots[frameindex][slotindex][3]:SetLayer(2)
                if (lb.groupHoTSpotsIcons[frameindex][slotindex][3]==0 or lb.groupHoTSpotsIcons[frameindex][slotindex][3]==nil) and {lb.groupHoTSpotsIcons[frameindex][slotindex][0]} then
                    lb.groupHoTSpots[frameindex][slotindex][3]:SetVisible(false)
                else
                    lb.groupHoTSpots[frameindex][slotindex][3]:SetVisible(true)
                end
            end

end
function resetBuffMonitorTextures()
    for var=1,20 do
        for g= 1, 5 do
            lb.groupHoTSpotsIcons[var][g][0]=false
            --print (lb.groupHoTSpotsIcons[var][g][0])
            lb.groupHoTSpots[var][g][4]=false
            lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
            lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])

            lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                lb.groupHoTSpots[var][g][2]:SetVisible(false)
            else
                lb.groupHoTSpots[var][g][2]:SetVisible(true)
            end

            lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
            lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
            lb.groupHoTSpots[var][g][3]:SetLayer(2)

            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                lb.groupHoTSpots[var][g][3]:SetVisible(false)
            else
                lb.groupHoTSpots[var][g][3]:SetVisible(true)
            end
        end
    end
end
function resetBuffMonitorTexturesForIndex(var)

        for g= 1, 5 do

            if lb.groupHoTSpotsIcons[var][g][0] then

            lb.groupHoTSpotsIcons[var][g][0]=false
            lb.groupHoTSpotsIcons[var][g][4]=true
            --print (lb.groupHoTSpotsIcons[var][g][0])
            lb.groupHoTSpots[var][g][4]=false
            lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
            lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])

            lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                lb.groupHoTSpots[var][g][2]:SetVisible(false)
            else
                lb.groupHoTSpots[var][g][2]:SetVisible(true)
            end

            lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
            lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
            lb.groupHoTSpots[var][g][3]:SetLayer(2)

            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                lb.groupHoTSpots[var][g][3]:SetVisible(false)
            else
                lb.groupHoTSpots[var][g][3]:SetVisible(true)
            end
            end
        end

end
function lbUpdateSpellTextures()
    local abilities
    abtextures={}
    for v, k in pairs(lbBuffList) do
        table.insert(abtextures,"Textures/buffhot.png")
    end
    abilities =abilitylist()
    abilitydets=abilitydetail(abilities)
    for d,c in pairs(lbBuffList[lbValues.set]) do
        --c={"Soothing Stream", "Healing Current","Healing Flood" }
        for s,a in pairs(c) do
            --a="Soothing Stream" ....
            found=false
            lb.FullBuffsList[a]=true
            for v, k in pairs(abilitydets) do
                if a==k.name and a~=nil then
                    if k.icon ~=nil then
                        found=true
                        if lb.IconsCache[a] == nil then
                            lb.IconsCacheCount=lb.IconsCacheCount+1
                            lb.IconsCache[a]={"Rift",k.icon }
                        end
                    end
                end
            end
            if not found then
                lb.NoIconsBuffList[a]=true
                --print (a)
            end

        end
    end
    createDebuffFullList()
end

function createDebuffFullList()
    lb.FullDeBuffsList={}
    for slotindex,c in pairs(lbDeBuffList[lbValues.set]) do
        --c="Soothing Stream" ....
            lb.FullDeBuffsList[c]=true
    end
end



function removeFromNoIconList(abilityname)
    if lb.NoIconsBuffList[a]~=nil then
        lb.NoIconsBuffList[a]=nil
        --print (a)
    end
end
function getTextureFromCache(abilityName)
    local texture= lb.IconsCache[abilityName]
    if texture==nil then
        texture={"LifeBinder","Textures/buffhot.png"}
    end
    return texture
end
function hasTextureInCache(abilityName)
    if lb.IconsCache[abilityName]==nil then
        return false
    else
        return true
    end

end
function addTextureToCache(abilityName,textureLocation,texturePath)
    if not hasTextureInCache(abilityName) then
        lb.IconsCache[abilityName]={textureLocation,texturePath }
        lb.IconsCacheCount=lb.IconsCacheCount+1
        removeFromNoIconList(abilityName)
    end
end


function onBuffAdd(unit, buffs)
     buffs=buffdetail(unit,buffs)
     local frameindex=GetIndexFromID(unit)
     if frameindex==nil then return end
     local updatebuffs=false
     if lb.PlayerID==nil then lb.PlayerID=unitdetail("player").ID end

     for key,buffTable in pairs(buffs) do
        name=buffTable.name
        if buffTable.debuff==nil then
            if lb.FullBuffsList[name]~=nil then
                if buffTable.caster== lb.PlayerID then
                    local texture=nil
                    if hasTextureInCache(name) then
                        texture= getTextureFromCache(name)
                        --print("cache"..getTextureFromCache(name)[2])
                    else
                        addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(lbBuffList[lbValues.set]) do
                        --c={"Soothing Stream", "Healing Current","Healing Flood" }
                        for s,a in pairs(c) do
                            --a="Soothing Stream" ....
                            if a==name and a~=nil then
                                --print (frameindex)
                                lb.groupHoTSpotsIcons[frameindex][slotindex][0]=true
                                lb.groupHoTSpotsIcons[frameindex][slotindex][1]=texture[1]
                                lb.groupHoTSpotsIcons[frameindex][slotindex][2]=texture[2]
                                lb.groupHoTSpotsIcons[frameindex][slotindex][3]=buffTable.stack
                                lb.groupHoTSpotsIcons[frameindex][slotindex][4]=true
                                lb.groupHoTSpotsIcons[frameindex][slotindex][5]=buffTable.id
                                lb.groupHoTSpotsIcons[frameindex][slotindex][6]=false
                                --print (lb.groupHoTSpotsIcons[frameindex][slotindex][4])
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

            if lbValues.CacheDebuffs then
                addDebuffToCache(buffTable)
            end
            if lb.FullDeBuffsList[name]~=nil then

                    local texture=nil
                    if hasTextureInCache(name) then
                        texture= getTextureFromCache(name)
                        --print("cache"..getTextureFromCache(name)[2])
                    else
                        addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(lbDeBuffList[lbValues.set]) do
                        --c="Soothing Stream" ....
                        if c==name and c~=nil then
                            --print (frameindex)
                            lb.groupHoTSpotsIcons[frameindex][5][0]=true
                            lb.groupHoTSpotsIcons[frameindex][5][1]=texture[1]
                            lb.groupHoTSpotsIcons[frameindex][5][2]=texture[2]
                            lb.groupHoTSpotsIcons[frameindex][5][3]=buffTable.stack
                            lb.groupHoTSpotsIcons[frameindex][5][4]=true
                            lb.groupHoTSpotsIcons[frameindex][5][5]=buffTable.id
                            lb.groupHoTSpotsIcons[frameindex][5][6]=true
                            --print (lb.groupHoTSpotsIcons[frameindex][slotindex][4])
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
       -- for slotindex,c in pairs(lbBuffList[lbValues.set]) do
        for slotindex= 1, 5 do
            --print (tostring(slotindex)..tostring(buffID))
            if lb.groupHoTSpotsIcons[frameindex][slotindex][5]== buffID then
                --print (frameindex)
                lb.groupHoTSpotsIcons[frameindex][slotindex][0]=false
                lb.groupHoTSpotsIcons[frameindex][slotindex][3]=nil
                lb.groupHoTSpotsIcons[frameindex][slotindex][4]=true
                lb.groupHoTSpotsIcons[frameindex][slotindex][5]=nil
                local buffs= bufflist(unit)

                local newbuffsdetails=buffdetail(unit,buffs)

                if lb.groupHoTSpotsIcons[frameindex][slotindex][6] then
                    --was a debuff
                    for idb,BuffDet in pairs(newbuffsdetails) do
                        if BuffDet.debuff~=nil then
                            local lastdebuffID
                            for i,debuffname in pairs(lbDeBuffList[lbValues.set]) do
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
                            local slotbuffs=  lbBuffList[lbValues.set][slotindex]

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
                --print ("rem"..lb.groupHoTSpotsIcons[frameindex][slotindex][4])
                updatebuffs=true
            end
        end

       -- end
        for i,debuffname in pairs(lbDeBuffList[lbValues.set]) do
            --c={"Soothing Stream", "Healing Current","Healing Flood" }
            --print (tostring(slotindex)..tostring(buffID))
            if lb.groupHoTSpotsIcons[frameindex][5][5]== buffID then
                --print (frameindex)
                lb.groupHoTSpotsIcons[frameindex][5][0]=false
                lb.groupHoTSpotsIcons[frameindex][5][3]=nil
                lb.groupHoTSpotsIcons[frameindex][5][4]=true
                lb.groupHoTSpotsIcons[frameindex][5][5]=nil
                --print ("rem"..lb.groupHoTSpotsIcons[frameindex][slotindex][4])
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


