local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Real

local lastUnitUpdate = 0

-- mana bar manager
lb.manaBars={}

--update mana bars throttled every .5 seconds (trying throttling options if it's necessary)
function lb.manaBars.updateResourceBar(units)
	--now is set by the updateplayerframe cycle
	local elapsed = now - lastUnitUpdate
    if (elapsed < (.5)) then --half a second
        return 
    else
    	lastUnitUpdate = now
    end
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