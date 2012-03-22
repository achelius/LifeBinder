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

--Called by the event   Event.Unit.Detail.Health e Event.Unit.Detail.HealthMax
--[[function  lbHpUpdate(units)
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
]]

-- mana bar manager
--planned options:
--  showOnlyManaUsers   (true or false   default=true)
--[[function initializeResourceBar(unitTable.calling)
	if (unitTable.calling == "mage" or unitTable.calling == "cleric") then
		lb.groupRF[j]:SetTexture("LifeBinder", "textures/statusbars/resource_mana.png")
	elseif(unitID.calling == "warrior") then
		lb.groupRF[j]:SetTexture("LifeBinder", "textures/statusbars/resource_rage.png")
	elseif(unitID.calling == "rogue") then
		lb.groupRF[j]:SetTexture("LifeBinder", "textures/statusbars/resource_energy.png")
	else
		lb.groupRF[j]:SetTexture("LifeBinder", "textures/statusbars/resource_plain.png")
	end
end]]

function updateResourceBar(units)
	-- local timer = getThrottle()--throttle to limit cpu usage (period set to 0.25 sec)
	-- if not timer then return end
	
	local details = unitdetail(units)
	for unitident, unitTable in pairs(details) do
		identif = GetIdentifierFromID(unitTable.id)   --calculate key from unit identifier
		if identif~=nil then
			local j=stripnum(identif)
			if j~=nil then
				resource = 0
				resourceMax = 0
				
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
				resourcesRatio = resource/resourceMax
				lb.groupRF[j]:SetWidth((tempx)*(resourcesRatio))
				print ("Sigh")
			end
		end
	end
end

function resetManaBars()

end

function setManaBar(index,unitTable)
	if unitTable.calling then
		for i = 1, 4 do
			--initializeResourceBar(unitTable.calling) -- Set Resource Bar Color
			if (unitTable.calling == "mage" or unitTable.calling == "cleric") then
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/statusbars/resource_mana.png")
			elseif(unitTable.calling == "warrior") then
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/statusbars/resource_rage.png")
			elseif(unitTable.calling == "rogue") then
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/statusbars/resource_energy.png")
			else
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/statusbars/resource_plain.png")
			end
			
			
			if unitTable.calling == lb.Calling[i] then
				lb.groupName[index]:SetFontColor(lbCallingColors[i].r, lbCallingColors[i].g, lbCallingColors[i].b, 1)
			end
		end
	else
		lb.groupName[index]:SetFontColor(1, 1, 1, 1)
	end
end

function hideManaBar(index)

end

function showManaBar(index)

	lb.groupRF[j]:SetWidth((tempx)*(resourcesRatio))
end
