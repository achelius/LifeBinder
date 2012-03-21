local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Frame
local castbardetail=_G.Inspect.Unit.Castbar
local lastUnitUpdate2 = 0
local function getThrottle2()
    local now =timeFrame()
    local elapsed = now - lastUnitUpdate2
    if (elapsed >= (.1)) then --tenth of a second
        lastUnitUpdate2 = now
        return true
    end
end
function onCastbarChanged(units)
    if rhb.PlayerID==nil then
        rhb.MouseOverUnitLastCast=nil
        return
    end
    for unitid,ph in pairs(units) do
        --print(unitid)
        if unitid==rhb.PlayerID then
            --print("cbchanged")
            local unitIndex =GetIndexFromID( rhb.MouseOverUnitLastCast)
            if unitIndex~=nil then rhb.groupReceivingSpell[unitIndex]:SetVisible(false) end
            local details= castbardetail(rhb.PlayerID)
            --if details==nil then return end
            if details==nil then

                local unitIndex =GetIndexFromID( rhb.MouseOverUnitLastCast)
                if unitIndex~=nil then rhb.groupReceivingSpell[unitIndex]:SetVisible(false) setCastbarVisible(unitIndex,false) end
                rhb.MouseOverUnitLastCast=nil

                return
            else
                local unitIndex =GetIndexFromID( rhb.MouseOverUnitLastCast)
                if unitIndex~=nil then rhb.groupReceivingSpell[unitIndex]:SetVisible(false) setCastbarVisible(unitIndex,false) end
                --print(details.abilityName)
            end
            if (rhb.MouseOverUnit~=nil) then
                rhb.MouseOverUnitLastCast=rhb.MouseOverUnit
            else
                rhb.MouseOverUnitLastCast=rhb.LastTarget
            end
        end
    end
    --print (details.abilityName)
    --print (details.duration)
    -- print (details.remaining)
end

function castbarUpdate()
    local timer = getThrottle2()--throttle to limit cpu usage (period set to 0.25 sec)
    if not timer then return end
    --print("fetching".. tostring(rhb.MouseOverUnitLastCast==nil))

    if rhb.MouseOverUnitLastCast==nil then return end
    if rhb.PlayerID==nil then
        rhb.MouseOverUnitLastCast=nil
        return
    end
    --print("fetching2")
    local details= castbardetail(rhb.PlayerID)
    --if details==nil then return end
    --print (tostring(details))
    if details==nil then
        -- print ("endvis")
        local unitIndex =GetIndexFromID( rhb.MouseOverUnitLastCast)
        if unitIndex~=nil then rhb.groupReceivingSpell[unitIndex]:SetVisible(false) setCastbarVisible(unitIndex,false) end
        rhb.MouseOverUnitLastCast=nil

        return
    else
        local unitIndex =GetIndexFromID( rhb.MouseOverUnitLastCast)
        --print ("show" ..tostring(unitIndex ))

        if unitIndex~=nil then
            rhb.groupReceivingSpell[unitIndex]:SetVisible(true)
            setCastbarVisible(unitIndex,true)
            setCastBarValue(unitIndex,(details.duration-details.remaining)*10,details.duration*10)

        end

    end


end

function castbarIndexVisible(index)
    local vis =rhb.groupReceivingSpell[index]:GetVisible()
    if vis==true then
        return true
    else
        return false
    end
end

function resetCastbarIndex(index)
    rhb.groupReceivingSpell[index]:SetVisible(false)
    setCastbarVisible(index,false)
    setCastBarValue(index,(0)*10,1*10)

end
function setCastBarValue(index,value,max)
    if value==nil then value=0 end
    local cwidth=(value/max)*tempx
    rhb.groupCastBar[index]:SetWidth(cwidth)
end

function setCastbarVisible(index,value)
    rhb.groupCastBar[index]:SetVisible(value)
end