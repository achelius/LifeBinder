local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Frame

local lastUnitUpdate = 0

local function getThrottle()
    local now =  timeFrame()
    local elapsed = now - lastUnitUpdate
    if (elapsed >= (1.0)) then -- 1 second since all abilities are on a 1.5s GCD (except pyro at 1s GCD)
        lastUnitUpdate = now
        return true
    end
end



-- mana bar manager


function updateResourceBar(units)
	-- local timer = getThrottle()--throttle to limit cpu usage (period set to 0.25 sec)
	-- if not timer then return end
	
	local details = unitdetail(units)
	for unitident, unitTable in pairs(details) do
		local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
		if identif~=nil then
			local j=identif
			if j~=nil then
				local resource = 0
				local resourceMax = 1
				
				if(unitTable.calling == "mage" or unitTable.calling == "cleric") then
					if ( unitTable.mana and unitTable.manaMax ) then
						resource = unitTable.mana
						resourceMax = unitTable.manaMax
					end
				elseif(unitTable.calling == "warrior")then
					if ( unitTable.power ) then
						resource = unitTable.power
						resourceMax = 100
					end
				elseif(unitTable.calling == "rogue")then
					if ( unitTable.energy ) then
						resource = unitTable.energy
						resourceMax = unitTable.energyMax
					end
				end
				
				lb.styles[lb.currentStyle].setManaBarValue(j,resource,resourceMax)
				
			end
		end
	end
end

function resetManaBars()

end



function hideManaBar(index)

end

function showManaBar(index)

	lb.groupRF[j]:SetWidth((lbValues.mainwidth)*(resourcesRatio))
end
