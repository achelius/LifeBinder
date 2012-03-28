local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Frame
local unitLookup= _G.Inspect.Unit.Lookup

lb = {}
lb.initialized=false
--initializes the raid window
lb.PlayerID=nil     -- set by buffmonitor on buff add event or addabilities event
lb.LastTarget=nil --current group target (if it's in the group)
lb.currentTarget=nil --current target (the actual target)
lb.MouseOverUnit=nil  -- current mouseover unit ID
lb.MouseOverUnitLastCast=nil -- unit id of the moment one spell une spell has been casted
lb.ReloadWhileInCombat=false --true if lbUnitUpdate is called during combat
 --had to set these here because of dependencies problems
lb.styles={}
lb.WindowDrag = {}
--
function lb.initialize()
	if lbValues.AddonDisabled then return end
	lb.initialized=true
	lb.Context = UI.CreateContext("Context")
	lb.Context:SetSecureMode("restricted")
	lb.Window = UI.CreateFrame("Frame", "MainWindow", lb.Context)
	lb.Window:SetSecureMode("restricted")
	lb.WindowFrameTop = UI.CreateFrame("Texture", "Texture", lb.Window)
	lb.WindowFrameTop:SetSecureMode("restricted")
	lb.WindowDrag = UI.CreateFrame("Frame", "drag frame", lb.Window)
	lb.CombatStatus= UI.CreateFrame("Texture", "Texture", lb.Window)
	lb.CenterFrame = UI.CreateFrame("Frame", "Texture", lb.WindowFrameTop)
	lb.CenterFrame:SetSecureMode("restricted")
	lb.groupMask = {} --mouse click masks
	lb.groupBF = {} --frames backgrounds
	lb.groupTarget={} --targer outline (enabled only if frame is target)
	lb.groupReceivingSpell={} -- frame for receiving spell overlay  (active when the unit is receiving a cast from me)
	lb.groupHF = {} --HP frame
	lb.groupRF = {} -- Resource Frame
	lb.groupName = {} -- name of the player
	lb.groupStatus = {} -- status of the player (poison etc)
	lb.groupRole = {}	-- role icon
	lb.groupHoTSpots = {} -- hots frames
	lb.groupHoTSpotsIcons = {} --hots icons info
	lb.groupCastBar = {} --castbar frame
	
	--raid frames initialization (definitions only, styles will be added later)
	
	for i = 1, 20 do
	    lb.groupHoTSpots[i]= {}
	    lb.groupHoTSpotsIcons[i]= {}
		lb.groupBF[i] = UI.CreateFrame("Texture", "Border", lb.CenterFrame)
		lb.groupHF[i] = UI.CreateFrame("Texture", "Health", lb.groupBF[i])
		lb.groupRF[i] = UI.CreateFrame("Texture", "Resource", lb.groupBF[i])
	    lb.groupTarget[i] = UI.CreateFrame("Texture", "Target", lb.groupBF[i])
	    lb.groupReceivingSpell[i] = UI.CreateFrame("Texture", "ReceivingSpell", lb.groupBF[i])
	    lb.groupCastBar[i] = UI.CreateFrame("Texture", "ReceivingSpell", lb.groupBF[i])
		lb.groupName[i] = UI.CreateFrame("Text", "Name", lb.groupBF[i])
		lb.groupStatus[i] = UI.CreateFrame("Text", "Status", lb.groupBF[i])
		lb.groupRole[i] = UI.CreateFrame("Texture", "Role", lb.groupBF[i])
		lb.groupMask[i] = UI.CreateFrame("Frame", "group"..i, lb.Window)
		lb.groupMask[i]:SetSecureMode("restricted")
		--lb.groupTooltip[i] = UI.CreateFrame("SimpleTooltip","groupT"..i, lb.CenterFrame)
		
		for g= 1,10 do
			lb.groupHoTSpots[i][g] = {}
	        lb.groupHoTSpots[i][g][0]=true --icon
	        lb.groupHoTSpots[i][g][1]=UI.CreateFrame("Texture", "HoT" .. tostring(g), lb.groupBF[i])
	        lb.groupHoTSpots[i][g][2]=UI.CreateFrame("Text", "HoTText" .. tostring(g), lb.groupBF[i])
	        lb.groupHoTSpots[i][g][3]=UI.CreateFrame("Text", "HoTTextShadow" .. tostring(g), lb.groupBF[i])
	
	        lb.groupHoTSpotsIcons[i][g]={}
	        lb.groupHoTSpotsIcons[i][g][0]=false
	        lb.groupHoTSpotsIcons[i][g][1]="LifeBinder"
	        lb.groupHoTSpotsIcons[i][g][2]="Textures/buffhot.png"
	        lb.groupHoTSpotsIcons[i][g][3]=0 --stacks
	        lb.groupHoTSpotsIcons[i][g][4]=false    --updated  (true if icon has just updated)
	        lb.groupHoTSpotsIcons[i][g][5]=nil    --buff spell ID     (used for remove buff )
	        lb.groupHoTSpotsIcons[i][g][6]=false    --is debuff    true if the debuff applied is a debuff
	        lb.groupHoTSpotsIcons[i][g][7]=false    --is from whitelist
	        lb.groupHoTSpotsIcons[i][g][8]=false    --accepts Debuffs (true is this slot accepts debuffs
	        
		end
	end
	
	--other tables
	
	lb.QueryTable = {} --current table containing the current group identifiers
	lb.RaidTable = {} --table that contains al 20 identifiers
	lb.GroupTable = {} --table that contains the 5 group player identifiers
	for i = 1, 5 do
		--populating group table
		lb.GroupTable[string.format("group%.2d", i)] = true
	
	end
	lb.UnitTable = {"player"}
	lb.UnitsTable = {}
	lb.SoloTable={"player","player.pet"}
	lb.UnitsTableStatus={}
	for i= 1,20 do
	    local name=string.format("group%.2d", i)
	    table.insert(lb.UnitsTable,name);
	    lb.UnitsTableStatus[i]={}
	    lb.UnitsTableStatus[i][1]=false --aggro
	    lb.UnitsTableStatus[i][2]=false --offline
	    lb.UnitsTableStatus[i][3]=false --not in los
	    lb.UnitsTableStatus[i][4]="none" --role
	    lb.UnitsTableStatus[i][5]=0 --Unit ID
	    lb.UnitsTableStatus[i][6]=false --is target   (not used)
	    lb.UnitsTableStatus[i][7]=i --Frame index  used for buff monitor
	    lb.UnitsTableStatus[i][8]=false -- position change check
		lb.UnitsTableStatus[i][9]="none" --Calling
		lb.UnitsTableStatus[i][10]=false --out of range
		lb.RaidTable[string.format("group%.2d", i)] = true --populate raid query table
		
	end
	
	
	--constants
	lb.Calling = {"warrior", "cleric", "mage", "rogue", "percentage"}
	lb.Role = {"tank", "heal", "dps", "support" }
	lb.ResizeButton = UI.CreateFrame("Texture", "ResizeButton", lb.Window)
	lb.clickOffset = {x = 0, y = 0}
	lb.resizeOffset = {x = 0, y = 0}	
	
	
end




function lb.createWindow()
	if not lb.initialized then return end
	lb.Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", lbValues.locmainx, lbValues.locmainy)
	lb.Window:SetHeight(lbValues.mainheight)
	lb.Window:SetWidth(lbValues.mainwidth)
	lb.WindowFrameTop:SetTexture("LifeBinder", "Textures/header.png")
	lb.WindowFrameTop:SetPoint("TOPLEFT", lb.Window, "TOPLEFT", 0, 0)
	lb.WindowFrameTop:SetPoint("TOPRIGHT", lb.Window, "TOPRIGHT", 0, 0)
	lb.WindowFrameTop:SetHeight(30)
    lb.WindowFrameTop:SetWidth(200)
    lb.WindowFrameTop:SetMouseMasking("limited")
    lb.CombatStatus:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 7, 7)
    lb.CombatStatus:SetLayer(4)
    lb.CombatStatus:SetTexture("LifeBinder", "Textures/buffhot.png")
    lb.WindowDrag:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT")
    --lb.WindowDrag:SetPoint("TOPRIGHT", lb.WindowFrameTop, "TOPRIGHT")
    lb.WindowDrag:SetHeight(30)
    lb.WindowDrag:SetWidth(200)
    lb.WindowDrag:SetMouseMasking("limited")
    --lb.WindowDrag:SetBackgroundColor(0, 0, 0, 1)


    lb.CenterFrame:SetPoint("TOPLEFT", lb.WindowFrameTop, "BOTTOMLEFT", 0, 10)
    lb.CenterFrame:SetPoint("BOTTOMRIGHT", lb.Window, "BOTTOMRIGHT", 0, 0)
    lb.CenterFrame:SetLayer(1)
    lb.CombatStatus.Event.LeftClick=function() if not lbValues.isincombat then lb.WindowOptions:SetVisible(true)end end
    --initializeSpecButtons()
	
	--toggleLockedWindow(lbValues.islocked)
	
	
	lb.styles.applySelectedStyle()
end

--function lb.WindowDrag.Event:LeftDown()
--    if not lbValues.isincombat then
--        windowdragActive = true
--        local mouseStatus = Inspect.Mouse()
--        lb.clickOffset["x"] = mouseStatus.x - lbValues.locmainx
--        lb.clickOffset["y"] = mouseStatus.y - lbValues.locmainy
--    end
--end
--
--function lb.WindowDrag.Event:LeftUp()
--    windowdragActive = false
--end
--function lb.WindowDrag.Event:LeftUpoutside()
--    windowdragActive = false
--end
--function lb.WindowDrag.Event:MouseMove(x,y)
--    --print (tostring(x).."-"..tostring(y))
--    if lbValues.isincombat then
--        windowdragActive = false
--        return
--    end
--    if windowdragActive == true then
--
--        lbValues.locmainx = x - lb.clickOffset["x"]
--        lbValues.locmainy = y - lb.clickOffset["y"]
--        lb.Window:SetPoint("TOPLEFT", lb.Context, "TOPLEFT", lbValues.locmainx, lbValues.locmainy)
--    end
--end

function round (x)
    if x >= 0 then
        return math.floor (x + 0.5)
    end  -- if positive

    return math.ceil (x - 0.5)
end -- function round




-----------------------------------------------------------------------------------------------------------------------------------------------------------



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
            lb.mouseBinds.setMouseActions()
        end
        lb.QueryTable = lb.SoloTable
        lb.groupBF[1]:SetVisible(true)
        if not lbValues.isincombat then lb.groupMask[1]:SetVisible(true) end

    end
    if lbgroupfound then
        if lastMode~=1 then
            viewModeChanged=true
            lastMode=1
        
            lb.mouseBinds.setMouseActions()
        end
        lb.QueryTable = lb.GroupTable
    end
    if lbraidfound then
        if lastMode~=2 then
            viewModeChanged=true
            lastMode=2
            if lastmode==0 then
--            
            end
            lb.mouseBinds.setMouseActions()
        
        end
        lb.QueryTable = lb.RaidTable

      
    end
end
function waitPlayerAvailable()
	print ("wp")
	lb.PlayerID =Inspect.Unit.Lookup("player")
	local unitdet=Inspect.Unit.Detail(lb.PlayerID)
	print("hh"..Inspect.Unit.Lookup("player")) 
	if lb.PlayerID~=nil then
		if unitdet~=nil then
			print (unitdet.name)
		else
			print("nounit")
		end
	else
	print("noid")
	end 
	if lb.PlayerID ~=nil and unitdet~=nil then
		print ("unit found")
		print(lb.PlayerID)
		print(unitdet.name)
		remev()
		--RemoveEventHandler(Event.System.Update.Begin,WaitPlayerEventID)
		PlayerFound=true
		lb.posData.initialize()--positional module initialized here to be sure to have player info
		lbUnitUpdate()
		
	end

end

function lbUnitUpdate()
	--waitPlayerAvailable()
--   local timer = getThrottle()--throttle to limit cpu usage (period set to 0.25 sec)
--    if not timer then return end
	if not PlayerFound then return end
	
    if lbValues.playerName==nil then  lbValues.playerName=unitdetail("player").name end
    --if lbValues.isincombat==nil or not lbValues.isincombat then  UpdateFramesVisibility()end -- reads the group status and hide or show players frames
    UpdateFramesVisibility()
    if lbValues.isincombat then  
    	lb.ReloadWhileInCombat=true 
    else
    	lb.ReloadWhileInCombat=false 
    end
--    if (lb.MouseOverUnitLastCast~=nil) then
--        local unitIndex =GetIndexFromID( lb.MouseOverUnitLastCast)
--        if unitIndex~=nil then lb.groupReceivingSpell[unitIndex]:SetVisible(false) end
--  end
	
    local details = unitdetail(lb.QueryTable)--lb.QueryTable)
  
    local targetunit=unitdetail("player.target")
--    for key,val in pairs(lb.UnitsTableStatus) do
--        if key~= "player" then
--        	lb.UnitsTableStatus[key][8]=false
--        end
--    end
  
    for unitident, unitTable in pairs(details) do
       local j=1
       if lastMode==0 then unitident="player"end
       if unitident~=1 then 
       		j= stripnum(unitident)   --calculate key from unit identifier
       else
     
       end
       local name = unitTable.name

        if string.len(name) > 5 then name = string.sub(name, 1, 5).."" end --restrict names to 8 letters
        lb.groupName[j]:SetText(name)

        if unitTable == nil  then

        else

            lb.UnitsTableStatus[j][8]=true
            if lb.UnitsTableStatus[j][5]~=unitTable.id then
				  if Event.Unit.Detail.Coord~=nil then lb.posData.resetUnitPositionofIndex(j,unitTable.coordX,unitTable.coordY,unitTable.coordZ) end
                  lb.UnitsTableStatus[j][5]=unitTable.id
            end
            if not lbValues.isincombat then
                lb.groupMask[j]:SetMouseoverUnit(unitTable.id)
            else
            	--reorganizeMasks()
            end
            
			if lb.UnitsTableStatus[j][9] ~=  unitTable.calling or viewModeChanged then
                lb.UnitsTableStatus[j][9] =  unitTable.calling
                setManaBar(j,unitTable)
            end
            if lb.UnitsTableStatus[j][4] ~=  unitTable.role or viewModeChanged then
                lb.UnitsTableStatus[j][4] =  unitTable.role
                if unitTable.role then
                    lb.groupRole[j]:SetTexture("LifeBinder",  "Textures/icons/"..tostring(unitTable.calling).."-"..tostring(unitTable.role)..".png")--"Textures/"..unitTable.role..".png")
                else
                    lb.groupRole[j]:SetTexture("LifeBinder", "Textures/".."blank.png")
                end
            end

            if lb.UnitsTableStatus[j][2] ~=  unitTable.offline or viewModeChanged then
                lb.UnitsTableStatus[j][2] =  unitTable.offline
                    if unitTable.offline then
                        lb.groupStatus[j]:SetText("(D/C)")
                        lb.groupHF[j]:SetWidth(1)
						lb.groupRF[j]:SetWidth(1)
                    end
            end

            if targetunit~=nil then
                if unitident == targetunit.id  or viewModeChanged then
                    lb.UnitsTableStatus[j][6] =  true
                    if lb.UnitsTableStatus[j][6] then
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/aggroframe.png")
                    else
                        lb.groupBF[j]:SetTexture("LifeBinder", "Textures/backframe.png")
                    end
                else
                    lb.UnitsTableStatus[j][6] =  false
                end
            end

            if lb.UnitsTableStatus[j][1] ~=  unitTable.aggro or viewModeChanged then
                lb.UnitsTableStatus[j][1] =  unitTable.aggro
                if unitTable.aggro then
                    lb.groupBF[j]:SetTexture("LifeBinder", "Textures/aggroframe.png")
                else
                    lb.groupBF[j]:SetTexture("LifeBinder", "Textures/backframe.png")
                end
            end
            if lb.UnitsTableStatus[j][3] ~=  unitTable.blocked or viewModeChanged then
                lb.UnitsTableStatus[j][3] =  unitTable.blocked
                if unitTable.blocked  then
                    lb.groupHF[j]:SetTexture("LifeBinder", "Textures/healthlos.png")
                else
                    lb.groupHF[j]:SetTexture("LifeBinder", "Textures/"..lbValues.texture)
                end
            end
            if viewModeChanged then
              local  healthtick = unitTable.health
              local  healthmax = unitTable.healthMax
                if healthtick~=nil and healthmax ~= nil then
                	lb.styles[lb.currentStyle].setHealthBarValue(j,healthtick,healthmax)
                    lb.styles[lb.currentStyle].setHealthBarText(j,healthtick,healthmax)
                end
            end

        end

    end

   for key,val in pairs(lb.UnitsTableStatus) do
		
       if not lb.UnitsTableStatus[key][8] then
           lb.UnitsTableStatus[key][5]=0

           if lastMode==0 and key=="group01" then
           else
               local needreset=false

               for i = 1,5 do
                   if lb.groupHoTSpotsIcons[key][i][0] then
                       needreset=true
                   end
               end
               if needreset then
                   lb.buffMonitor.resetBuffMonitorTexturesForIndex(key)
               end
               if castbarIndexVisible(key) then
                   resetCastbarIndex(key)
               end

           end
       end
   end

    viewModeChanged=false
end
--Called by the event   Event.Unit.Detail.Aggro
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
function  lb.onBlockedUpdate(units)
    local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
					
                --if lb.UnitsTableStatus[identif][3] ~=  unitTable.blocked or viewModeChanged then
                    lb.UnitsTableStatus[j][3] =  unitTable.blocked
                    --print (identif .. tostring(unitTable.blocked))
                    dump(lb.UnitsTableStatus[j])
                    lb.styles[lb.currentStyle].setBlockedValue(j,lb.UnitsTableStatus[j][3],index,lb.UnitsTableStatus[j][10])
--                    if unitTable.blocked  then
--                        lb.groupHF[j]:SetTexture("LifeBinder", "Textures/healthlos.png")
--                     elseif unitTable.blocked==nil  then
--                        lb.groupHF[j]:SetTexture("LifeBinder", "Textures/"..lbValues.texture)
--                    else
--                        lb.groupHF[j]:SetTexture("LifeBinder", "Textures/"..lbValues.texture)
--                    end
                --end
            end
        end
    end
end
function onUnitRoleChanged(units)
	local details = unitdetail(units)

    for unitident, unitTable in pairs(details) do
        local identif = GetIndexFromID(unitTable.id)   --calculate key from unit identifier
        if identif~=nil then
            local j=identif
            if j~=nil then
				
                if lb.UnitsTableStatus[j][4] ~=  unitTable.role or viewModeChanged then
                lb.UnitsTableStatus[j][4] =  unitTable.role
                
                if unitTable.role then
                    lb.groupRole[j]:SetTexture("LifeBinder", "Textures/icons/"..tostring(unitTable.calling).."-"..tostring(unitTable.role)..".png")--"Textures/"..unitTable.role..".png")
                else
                    lb.groupRole[j]:SetTexture("LifeBinder", "Textures/".."blank.png")
                end
            end
            end
        end
    end
end

--Called by the event   Event.Unit.Detail.Health e Event.Unit.Detail.HealthMax
function  lb.onHpUpdate(units)

  --  timer = getThrottle2()--throttle to limit cpu usage (period set to 0.25 sec)
   -- if not timer then return end
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
                if lb.UnitsTableStatus[j][1] ~=  unitTable.aggro or viewModeChanged then
                    lb.UnitsTableStatus[j][1] =  unitTable.aggro
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

function getIdentifierFromIndex(index)
	
	local counter=1
	for id,ph in pairs(lb.QueryTable) do
		if counter==index then
			return id
		end
	end
	return nil
end

function lb.onRoleChanged(role)
    lbValues.set=role;
    --call abilities
    lb.buffMonitor.initializeBuffMonitor()--initializes buff monitor
    --initializeSpecButtons()
    lb.buffMonitor.updateSpellTextures() --update textures cache and populate the lb.NoIconsBuffList table
    lb.buffMonitor.resetBuffMonitorTextures() --hide every buff slot
    lb.mouseBinds.setMouseActions()
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
         if lb.UnitsTableStatus[i][5]== unit then
             lb.UnitsTableStatus[i][6]=true
             lb.groupTarget[i]:SetVisible(true)
             found=true
             lb.LastTarget=unit
             --print(tostring(i)..name.."true")
         else
             lb.UnitsTableStatus[i][6]=false
             lb.groupTarget[i]:SetVisible(false)
             --print(tostring(i)..name.."false")
         end
    end
    if lastMode== 0 then
    if lb.UnitsTableStatus[1][5]== unit then
        lb.UnitsTableStatus[1][6]=true
        lb.groupTarget[1]:SetVisible(true)
        found=true
        lb.LastTarget=unit

        --print(tostring(i).."Playertrue")
    else
        lb.UnitsTableStatus[1][6]=false
        lb.groupTarget[1]:SetVisible(false)
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






