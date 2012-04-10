local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Real
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
    if lb.PlayerID==nil then
        lb.MouseOverUnitLastCast=nil
        return
    end
    for unitid,ph in pairs(units) do
        --print(unitid)
        if unitid==lb.PlayerID then
            --print("cbchanged")
            local unitIndex =lb.GetIndexFromID( lb.MouseOverUnitLastCast)
            if unitIndex~=nil then  end
            local details= castbardetail(lb.PlayerID)
            --if details==nil then return end
            if details==nil then

                local unitIndex =lb.GetIndexFromID( lb.MouseOverUnitLastCast)
                if unitIndex~=nil then  lb.styles[lb.currentStyle].setCastbarVisible(unitIndex,false) end
                lb.MouseOverUnitLastCast=nil

                return
            else
                local unitIndex =lb.GetIndexFromID( lb.MouseOverUnitLastCast)
                if unitIndex~=nil then  lb.styles[lb.currentStyle].setCastbarVisible(unitIndex,false) end
                --print(details.abilityName)
            end
            if (lb.MouseOverUnit~=nil) then
                lb.MouseOverUnitLastCast=lb.MouseOverUnit
            else
                lb.MouseOverUnitLastCast=lb.LastTarget
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
    --print("fetching".. tostring(lb.MouseOverUnitLastCast==nil))

    if lb.MouseOverUnitLastCast==nil then return end
    if lb.PlayerID==nil then
        lb.MouseOverUnitLastCast=nil
        return
    end
    --print("fetching2")
    local details= castbardetail(lb.PlayerID)
    --if details==nil then return end
    --print (tostring(details))
    if details==nil then
        -- print ("endvis")
        local unitIndex =lb.GetIndexFromID( lb.MouseOverUnitLastCast)
        if unitIndex~=nil then  lb.styles[lb.currentStyle].setCastbarVisible(unitIndex,false) end
        lb.MouseOverUnitLastCast=nil

        return
    else
        local unitIndex =lb.GetIndexFromID( lb.MouseOverUnitLastCast)
        --print ("show" ..tostring(unitIndex ))

        if unitIndex~=nil then
            
            lb.styles[lb.currentStyle].setCastbarVisible(unitIndex,true)
            lb.styles[lb.currentStyle].setCastBarValue(unitIndex,(details.duration-details.remaining)*10,details.duration*10)

        end

    end


end

function castbarIndexVisible(index)
    local vis =lb.groupCastBar[index]:GetVisible()
    if vis==true then
        return true
    else
        return false
    end
end

function resetCastbarIndex(index)
    
    lb.styles[lb.currentStyle].setCastbarVisible(unitIndex,false)
     lb.styles[lb.currentStyle].setCastBarValue(unitIndex,0*10,1*10)

end
