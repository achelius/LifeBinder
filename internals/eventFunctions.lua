local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Real
local unitLookup= _G.Inspect.Unit.Lookup
local buffdetail=   _G.Inspect.Buff.Detail
local bufflist=   _G.Inspect.Buff.List



--Called by the event   Event.Unit.Detail.OutOfRange   (oor flag)
function lb.onOutOfRange(unit,status)
	if unit==nil then return end
	local index= GetIndexFromID(unit)
	--print (tostring(unit) ..tostring(status))
	if index~=nil then
		--print(index)
		lb.styles[lb.currentStyle].setBlockedValue(index,lb.UnitsTableStatus[index][3],status)
	end
end


--Called by the event   Event.Unit.Detail.Aggro   (aggro flag)
function  lb.onAggroUpdate(units)
    local details = unitdetail(units)
	
    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
                --if lb.UnitsTableStatus[j][1] ~=  unitTable.aggro or viewModeChanged then
                    lb.UnitsTableStatus[j][1] =  unitTable.aggro
                    if unitTable.aggro then
                        lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
                    else
                        lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
                    end
                --end
            end
        end
    end
end


--Called by the event   Event.Unit.Detail.Blocked   (los flag)
function  lb.onBlockedUpdate(units)
    local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
					if unitTable.offline==nil or unitTable.offline==false then
	                --if lb.UnitsTableStatus[identif][3] ~=  unitTable.blocked or viewModeChanged then
	                    lb.UnitsTableStatus[j][3] =  unitTable.blocked
	                    --print (identif .. tostring(unitTable.blocked))
	                    --dump(lb.UnitsTableStatus[j])
	                    lb.styles[lb.currentStyle].setBlockedValue(j,lb.UnitsTableStatus[j][3],index,lb.UnitsTableStatus[j][10])
                    end
--                   
            end
        end
    end
end

--called by the event Event.Unit.Detail.Offline
function lb.onOfflineUpdate(units)
	local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
                    
                    lb.UnitsTableStatus[j][2]=unitTable.offline
                    lb.UnitsTableStatus[j][11] =  true
                    
            end
        end
    end
end

--called by the event Event.Unit.Detail.Role
function lb.onUnitRoleChanged(units)
	local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
				
                if lb.UnitsTableStatus[j][4] ~=  unitTable.role or viewModeChanged then
                lb.UnitsTableStatus[j][4] =  unitTable.role
                
                  
	            lb.styles[lb.currentStyle].setRoleIcon(j,unitTable.calling,unitTable.role)
            end
            end
        end
    end
end

--Called by the event   Event.Unit.Detail.Health and Event.Unit.Detail.HealthMax
function  lb.onHpUpdate(units)


    local details = unitdetail(units)
    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
                local healthtick = unitTable.health
                local healthmax = unitTable.healthMax
                if healthtick~=nil and healthmax ~= nil then
                    
                    lb.styles[lb.currentStyle].setHealthBarValue(j,healthtick,healthmax)
                    lb.styles[lb.currentStyle].setHealthBarText(j,healthtick,healthmax)
                    
                end
--                if lb.UnitsTableStatus[j][1] ~=  unitTable.aggro or viewModeChanged then
--                    lb.UnitsTableStatus[j][1] =  unitTable.aggro
--                    if unitTable.aggro then
--                        lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
--                    else
--                        lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
--                    end
--                end
            end
        end
    end
end

function lb.onPlayerTargetChanged(unit)
    -- print (unit)
    if unit==false then 
     	lb.LastTarget =nil
     	lb.currentTarget=nil
     	
    else
    	lb.currentTarget=unit
    end
    
    local found = false

    for i = 1 , 20 do
        local name=string.format("group%.2d", i)
        if lb.UnitsTableStatus[i][12] then
	         if lb.UnitsTableStatus[i][5]== unit then
	             lb.UnitsTableStatus[i][6]=true
	             lb.frames[i].groupTarget:SetVisible(true)
	             found=true
	             lb.LastTarget=unit
	             --print(tostring(i)..name.."true")
	         else
	             lb.UnitsTableStatus[i][6]=false
	             lb.frames[i].groupTarget:SetVisible(false)
	             --print(tostring(i)..name.."false")
	         end
	    end
    end
    if lastMode== 0 then
	    if lb.UnitsTableStatus[1][5]== unit then
	        lb.UnitsTableStatus[1][6]=true
	        lb.frames[1].groupTarget:SetVisible(true)
	        found=true
	        lb.LastTarget=unit
	
	        --print(tostring(i).."Playertrue")
	    else
	        lb.UnitsTableStatus[1][6]=false
	        lb.frames[1].groupTarget:SetVisible(false)
	        --print(tostring(i).."Playerfalse")
	    end
    end
    if not found then
        lb.LastTarget=nil
    end
end
function lb.onMouseOverTargetChanged(unit)

     local newindex =GetIndexFromID(unit)
     local lastindex= GetIndexFromID(lb.MouseOverUnit)
     --if lastindex~=nil then lb.frames[lastindex].groupAggro:SetVisible(false) end
     if newindex~=nil then

        --print (GetIdentifierFromID(unit))

         --lb.frames[newindex].groupAggro:SetVisible(true)
        lb.MouseOverUnit=unit
     else
        --print (unit)
         lb.MouseOverUnit=nil
     end
end

function lb.onRoleChanged(role)
    lbValues.set=role;
    --call abilities
    lb.autosetDebuffOptions(Inspect.TEMPORARY.Role())
    lb.buffMonitor.resetBuffMonitorTextures() --hide every buff slot
    lb.buffMonitor.initializeBuffMonitor()--initializes buff monitor
    --initializeSpecButtons()
   
    lb.buffMonitor.updateSpellTextures() --update textures cache and populate the lb.NoIconsBuffList table
    
    lb.mouseBinds.setMouseActions()
    if lb.slotsGui.initialized then
    	lb.slotsGui.updateOptions()
    end
    --lbUpdateRequiredSpellsList()

    --createTableBuffs()--gui
    --createTableDebuffs() --gui
    --UpdateMouseAssociationsTextFieldsValues() --gui
    --lb.slotsGui.initialize()
   -- hideAll()
end

function lb.onAbilityAdded(abilities)

    if lbValues.set==nil then
    
        if lb.PlayerID==nil then lb.PlayerID=Inspect.Unit.Lookup("player") end
        lb.onRoleChanged( Inspect.TEMPORARY.Role())
        
    end
end

function lb.onSecureEnter()
    lbValues.isincombat=true
    lb.CombatStatus:SetTexture("LifeBinder", "Textures/buffhot2.png")
    lb.WindowFrameTop:SetTexture("LifeBinder", "none.jpg")
   -- lb.specButtons.hideAll()
end
function lb.onSecureExit()
    lbValues.isincombat=false
    lb.CombatStatus:SetTexture("LifeBinder", "Textures/buffhot.png")
    lb.WindowFrameTop:SetTexture("LifeBinder", "Textures/header.png")
    --lb.specButtons.showAll()
    if lb.ReloadWhileInCombat then
    	lbUnitUpdate()
    end
end

function lb.onBuffAdd(unit,buffs)
	 local frameindex=GetIndexFromID(unit)
     if frameindex==nil then return end
     local updatebuffs=false
     if lb.PlayerID==nil then lb.PlayerID=unitdetail("player").ID end
 	 buffs=buffdetail(unit,buffs)
 	  for key,buffTable in pairs(buffs) do
 	  		local name=buffTable.name
        	if buffTable.debuff==nil then
        		lb.buffMonitor.onBuffAddTest(unit,buffTable,frameindex)
        	else
        		lb.debuffMonitor.onBuffAdd(unit,buffTable,frameindex)
        	end
 	  end
end

function lb.onBuffRemove(unit,buffs)
	 local frameindex=GetIndexFromID(unit)
	 
     if frameindex==nil then return end
     local updatebuffs=false
     if lb.PlayerID==nil then lb.PlayerID=unitdetail("player").ID end
 	  for buffID,ph in pairs(buffs) do
 	  		
        		
        	local isbuff=lb.buffMonitor.onBuffRemoveTest(unit,buffID,frameindex)
        	
        		
        		if not isbuff then lb.debuffMonitor.onDebuffRemove(unit,buffID,frameindex) end
        	
 	  end
end