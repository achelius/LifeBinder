local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Real
local unitLookup= _G.Inspect.Unit.Lookup
local updatebuffdurationindex=nil


lb = {}
lb.UnitsTableStatus={}
lb.frames={} --table containing all the unit frames tables
lb.playerFound=false
lb.clickOffset = {x = 0, y = 0}
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
local lastUpdatePlayerFrameCheck=0

local lastWaitPlayer=0

function lb.getLastWaitPlayerThrottle()
    local now =  timeFrame()
    local elapsed = now - lastWaitPlayer
    if (elapsed >= (1)) then
        lastdurationcheck = now
        return true
    end
end

local updateplayerthrottle=getUpdatePlayerFrameThrottle



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
	
	

	
	
	
	--raid frames initialization (definitions only, styles will be added later)
	for i = 1, 20 do
		
		local name=string.format("group%.2d", i)
		
		--lb.frames[i].groupTooltip = UI.CreateFrame("SimpleTooltip","groupT"..i, lb.CenterFrame)
		
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
		lb.UnitsTableStatus[i][11]=false --needs an update
		lb.UnitsTableStatus[i][12]=false --Frame Created
		lb.UnitsTableStatus[i][13]=false --Frame Creating (to avoid double initilizations)
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
	lb.WindowDrag.Event.LeftDown=lb.WindowDragEventLeftDown
	lb.WindowDrag.Event.LeftUp=lb.WindowDragEventLeftUp
	lb.WindowDrag.Event.LeftUpoutside=lb.WindowDragEventLeftUpoutside
	lb.WindowDrag.Event.MouseMove=lb.WindowDragEventMouseMove
	
    lb.CenterFrame:SetPoint("TOPLEFT", lb.WindowFrameTop, "BOTTOMLEFT", 0, 10)
    lb.CenterFrame:SetPoint("BOTTOMRIGHT", lb.Window, "BOTTOMRIGHT", 0, 0)
    lb.CenterFrame:SetLayer(1)
    lb.CombatStatus.Event.LeftClick=function() if not lbValues.isincombat then lb.WindowOptions:SetVisible(true)end end
    --initializeSpecButtons()
	
	--toggleLockedWindow(lbValues.islocked)
	lb.styles.applySelectedStyle()
end

function lb.WindowDragEventLeftDown()
    if not lbValues.isincombat then
        windowdragActive = true
        local mouseStatus = Inspect.Mouse()
        lb.clickOffset["x"] = mouseStatus.x - lbValues.locmainx
        lb.clickOffset["y"] = mouseStatus.y - lbValues.locmainy
    end
end

function lb.WindowDragEventLeftUp()
    windowdragActive = false
end
function lb.WindowDragEventLeftUpoutside()
    windowdragActive = false
end
function lb.WindowDragEventMouseMove(buttons,x,y)
    --print (tostring(x).."-"..tostring(y))
    if lbValues.isincombat then
        windowdragActive = false
        return
    end
    if windowdragActive == true then

        lbValues.locmainx = x - lb.clickOffset["x"]
        lbValues.locmainy = y- lb.clickOffset["y"]
        lb.Window:SetPoint("TOPLEFT", lb.Context, "TOPLEFT", lbValues.locmainx, lbValues.locmainy)
    end
end

function round (x)
    if x >= 0 then
        return math.floor (x + 0.5)
    end  -- if positive

    return math.ceil (x - 0.5)
end -- function round




-----------------------------------------------------------------------------------------------------------------------------------------------------------

function waitPlayerAvailable()
	local timer= lb.getLastWaitPlayerThrottle()
	if not timer then return end
	if lb.playerFound==true then return end
	
	lb.PlayerID=Inspect.Unit.Lookup("player")
	local unitdet=Inspect.Unit.Detail(lb.PlayerID)

	if lb.PlayerID ~=nil and unitdet~=nil then
		lb.playerFound=true
		lbValues.set=Inspect.TEMPORARY.Role();
		lb.remWaitPlayerHook()
		print ("preinit"..tostring(timeFrame()))
		lb.initialize() --autostart initialization
		print ("afterinit"..tostring(timeFrame()))
    	lb.createWindow() --into the file lifebinderMain.lua
    	
		
		
		
		lb.posData.initialize()--positional module initialized here to be sure to have player info
		
		lbUnitUpdate()
		lb.buffMonitor.updateSpellTextures()
		updatebuffdurationindex=_G.lb.buffMonitor.updateDurationsOfIndex
		
		lb.EnableHandlers()--add event handlers
	end
	
end

function lb.UpdatePlayerFrame()
 	now =  timeFrame()
    local elapsed = now - lastUpdatePlayerFrameCheck
    if (elapsed < (.25)) then --half a second
        return 
    else
    	
    	lastUpdatePlayerFrameCheck=now
    end
	
	if not lb.playerFound then return end
	local unitupd=false

	for i = 1,20 do
		local ut=lb.UnitsTableStatus[i]
		if ut[12] then updatebuffdurationindex(i) end
		if ut[11] then
			local queryName="player"
		    if lastMode~=0 then
		    	queryName=	string.format("group%.2d", i)
		    end
		 
			local detail =unitdetail(queryName)
			if detail ~=nil then
				
				if not ut[13] and not ut[12] then
					lb.createNewFrame(i)
				elseif ut[12] then
					lb.buffMonitor.resetBuffMonitorTexturesForIndex(i)
					
				end
				if detail.calling~=nil or detail.offline~=nil then
					unitupd=true
					lbUnitUpdateIndex(i)
					ut[11]=false
				end
			else
				if ut[12] then
					ut[11]=false
					lb.styles[lb.currentStyle].hideFrame(i)
				end
			end
		end
	end
	
	if unitupd and lastMode==1 then
		--it calls a full refresh while in group mode
		--lbUnitUpdate()
	end
end
function lb.createNewFrame(index)
	if lb.UnitsTableStatus[index][12] then return end
	lb.UnitsTableStatus[index][13]=true --Frame Creating
	lb.styles[lb.currentStyle].CreateFrame(index)
	lb.buffMonitor.initializeBuffMonitorFrameIndex(index)
	lb.buffMonitor.resetBuffMonitorTexturesForIndex(index)
	lb.mouseBinds.setMouseActionsForIndex(index)
	lb.UnitsTableStatus[index][13]=false --Frame Created
	lb.UnitsTableStatus[index][11]=true --set the frame for update
end
function lb.UpdateFramesVisibility()
   local lbgroupfound = false
   local lbraidfound = false
   local lbsolofound = true
   local gCount=LibSRM.GroupCount()
   if gCount==0 then
   		lbsolofound=true
   elseif gCount<6 then
   		lbgroupfound=true
   else
		lbraidfound=true   	
   end
    for k, v in pairs(lb.UnitsTable) do
        if unitLookup(v) then
            if k < 6 then lbraidfound = false lbgroupfound = true end
            if k > 5 then lbraidfound = true lbgroupfound = false end
            lbsolofound = false
            lb.frames[k].groupBF:SetVisible(true)
            if not lbValues.isincombat and lb.UnitsTableStatus[k][12]  then lb.frames[k].groupMask:SetVisible(true) end
        else
            lb.frames[k].groupBF:SetVisible(false)
            if not lbValues.isincombat and lb.UnitsTableStatus[k][12]  then lb.frames[k].groupMask:SetVisible(false) end
        end
    end

    if lbsolofound then
        if lastMode~=0 then
            viewModeChanged=true
            lastMode=0
            lb.mouseBinds.setMouseActions() -- sets macros for frames
        end
        lb.QueryTable = lb.SoloTable
        lb.frames[1].groupBF:SetVisible(true)
        if not lbValues.isincombat and lb.UnitsTableStatus[1][12] then lb.frames[1].groupMask:SetVisible(true) end

    end
    if lbgroupfound then
        if lastMode~=1 then
            viewModeChanged=true
            lastMode=1
            lb.mouseBinds.setMouseActions()-- sets macros for frames
        end
        lb.QueryTable = lb.GroupTable
    end
    if lbraidfound then
        if lastMode~=2 then
            viewModeChanged=true
            lastMode=2
            lb.mouseBinds.setMouseActions() --sets macros for frames
        end
        lb.QueryTable = lb.RaidTable
    end
end
function lbUnitUpdateIndex(index)
	if index==nil then return end
	if not lb.playerFound then return end
	if lbValues.playerName==nil then  lbValues.playerName=unitdetail("player").name end
--	if not lb.UnitsTableStatus[index][13] and not lb.UnitsTableStatus[index][12] then
--		lb.UnitsTableStatus[index][13]=true --Frame Creating
--		print("createframes"..tostring(index))
--		lb.styles[lb.currentStyle].CreateFrame(index)
--		lb.UnitsTableStatus[index][13]=false --Frame Created
--	end
	lb.UpdateFramesVisibility()
	
	if lbValues.isincombat then  
    	lb.ReloadWhileInCombat=true 
    else
    	lb.ReloadWhileInCombat=false 
    end
    local queryName="player"
    if lastMode~=0 then
    	queryName=	string.format("group%.2d", index)
    else
    	if index~=1 then
    		return
    	end	
    end
	local unitTable = unitdetail(queryName)
	
	
    if unitTable ~=nil then
    
    	local j =index
    	if lb.UnitsTableStatus[j][5]~=unitTable.id  then
    		if not lb.UnitsTableStatus[index][13] and not lb.UnitsTableStatus[index][12] then
				lb.createNewFrame(index)
			end
    	end
    	local name = unitTable.name
		if string.len(name) > 5 then name = string.sub(name, 1, 5).."" end --restrict names to 8 letters
		if  lb.UnitsTableStatus[j][11] then
			--the unit needs an update
			if lb.UnitsTableStatus[j][5]~=unitTable.id then
				  if Event.Unit.Detail.Coord~=nil then lb.posData.resetUnitPositionofIndex(j,unitTable.coordX,unitTable.coordY,unitTable.coordZ) end
				  lb.buffMonitor.resetBuffMonitorTexturesForIndex(j)
	              lb.UnitsTableStatus[j][5]=unitTable.id
	        end
			
			lb.frames[j].groupName:SetText(name)
			--mana
			lb.styles[lb.currentStyle].setManaBar(j,unitTable)
			local resource=0
			local resourcemax=1
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
			--------------------
	        lb.UnitsTableStatus[j][8]=true
	        
	        if not lbValues.isincombat then
	            lb.frames[j].groupMask:SetMouseoverUnit(unitTable.id)
	        else
	        	--reorganizeMasks()
	        end
	        if unitTable.calling==nil then
	        	if unitTable.offline ==nil or unitTable.offline ==false then
	            	lb.UnitsTableStatus[j][11]=true
	            end
	        else
	        	--print (tostring(j).."calling")
	        end
			if lb.UnitsTableStatus[j][9] ~=  unitTable.calling or viewModeChanged then
	            lb.UnitsTableStatus[j][9] =  unitTable.calling
	            
	        end
	        
	       -- if lb.UnitsTableStatus[j][4] ~=  unitTable.role or viewModeChanged then
	            lb.UnitsTableStatus[j][4] =  unitTable.role
	            lb.styles[lb.currentStyle].setRoleIcon(j,unitTable.calling,unitTable.role)
	        --end
	    		lb.UnitsTableStatus[j][3] =  unitTable.blocked
	            lb.styles[lb.currentStyle].setBlockedValue(j,lb.UnitsTableStatus[j][3],lb.UnitsTableStatus[j][10])
	            
	        --if lb.UnitsTableStatus[j][2] ~=  unitTable.offline or viewModeChanged then
	            lb.UnitsTableStatus[j][2] =  unitTable.offline
	                if unitTable.offline then
	                    lb.frames[j].groupStatus:SetText("(D/C)")
	                    lb.frames[j].groupHF:SetWidth(1)
						lb.frames[j].groupRF:SetWidth(1)
	                end
	        --end
	
	        if targetunit~=nil then
	            if unitident == targetunit.id  or viewModeChanged then
	                lb.UnitsTableStatus[j][6] =  true
	                if lb.UnitsTableStatus[j][6] then
	                    lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
	                else
	                    lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
	                end
	            else
	                lb.UnitsTableStatus[j][6] =  false
	            end
	        end
	
	       -- if lb.UnitsTableStatus[j][1] ~=  unitTable.aggro or viewModeChanged then
	            lb.UnitsTableStatus[j][1] =  unitTable.aggro
	            if unitTable.aggro then
	                lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
	            else
	                lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
	            end
	        --end
	       
	        
	        
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
    
     
    
    
    
    
    
end
function lbUnitUpdate()


	--waitPlayerAvailable()
--   local timer = getThrottle()--throttle to limit cpu usage (period set to 0.25 sec)
--    if not timer then return end
	if not lb.playerFound then return end
--	
    if lbValues.playerName==nil then  lbValues.playerName=unitdetail("player").name end
--    --if lbValues.isincombat==nil or not lbValues.isincombat then  lb.UpdateFramesVisibility()end -- reads the group status and hide or show players frames
    lb.UpdateFramesVisibility()
    for i = 1,20 do
    	lbUnitUpdateIndex(i)
    end
    
--    if lbValues.isincombat then  
--    	lb.ReloadWhileInCombat=true 
--    else
--    	lb.ReloadWhileInCombat=false 
--    end
----    if (lb.MouseOverUnitLastCast~=nil) then
----        local unitIndex =GetIndexFromID( lb.MouseOverUnitLastCast)
----        if unitIndex~=nil then lb.frames[unitIndex].groupAggro:SetVisible(false) end
----  end
--	
--    local details = unitdetail(lb.QueryTable)--lb.QueryTable)
--  	
--    local targetunit=unitdetail("player.target")
----    for key,val in pairs(lb.UnitsTableStatus) do
----        if key~= "player" then
----        	lb.UnitsTableStatus[key][8]=false
----        end
----    end
--  
--    for unitident, unitTable in pairs(details) do
--       local j=1
--       if lastMode==0 then unitident="player"end
--       if unitident~=1 then 
--       		j= stripnum(unitident)   --calculate key from unit identifier
--       else
--     
--       end
--       local name = unitTable.name
--
--        if string.len(name) > 5 then name = string.sub(name, 1, 5).."" end --restrict names to 8 letters
--        lb.frames[j].groupName:SetText(name)
--
--        if unitTable == nil  then
--
--        else
--
--            lb.UnitsTableStatus[j][8]=true
--            if lb.UnitsTableStatus[j][5]~=unitTable.id then
--				  if Event.Unit.Detail.Coord~=nil then lb.posData.resetUnitPositionofIndex(j,unitTable.coordX,unitTable.coordY,unitTable.coordZ) end
--				  lb.buffMonitor.resetBuffMonitorTexturesForIndex(j)
--				  
--                  lb.UnitsTableStatus[j][5]=unitTable.id
--            end
--            if not lbValues.isincombat then
--                lb.frames[j].groupMask:SetMouseoverUnit(unitTable.id)
--            else
--            	--reorganizeMasks()
--            end
--            if unitTable.calling==nil then
--           		 lb.UnitsTableStatus[j][11]=true
--            else
--            	--print (tostring(j).."calling")
--            end
--			if lb.UnitsTableStatus[j][9] ~=  unitTable.calling or viewModeChanged then
--                lb.UnitsTableStatus[j][9] =  unitTable.calling
--                lb.styles[lb.currentStyle].setManaBar(j,unitTable)
--            end
--            
--           -- if lb.UnitsTableStatus[j][4] ~=  unitTable.role or viewModeChanged then
--                lb.UnitsTableStatus[j][4] =  unitTable.role
--                if unitTable.role then
--                    lb.frames[j].groupRole:SetTexture("LifeBinder",  "Textures/icons/"..tostring(unitTable.calling).."-"..tostring(unitTable.role)..".png")--"Textures/"..unitTable.role..".png")
--                else
--                    lb.frames[j].groupRole:SetTexture("LifeBinder", "Textures/".."blank.png")
--                end
--            --end
--			lb.UnitsTableStatus[j][3] =  unitTable.blocked
--            lb.styles[lb.currentStyle].setBlockedValue(j,lb.UnitsTableStatus[j][3],lb.UnitsTableStatus[j][10])
--            if lb.UnitsTableStatus[j][2] ~=  unitTable.offline or viewModeChanged then
--                lb.UnitsTableStatus[j][2] =  unitTable.offline
--               	lb.UnitsTableStatus[j][11]=true 
--                    if unitTable.offline then
--                        lb.frames[j].groupStatus:SetText("(D/C)")
--                        lb.frames[j].groupHF:SetWidth(1)
--						lb.frames[j].groupRF:SetWidth(1)
--                    end
--            end
--            
--			  
--            if targetunit~=nil then
--                if unitident == targetunit.id  or viewModeChanged then
--                    lb.UnitsTableStatus[j][6] =  true
--                    if lb.UnitsTableStatus[j][6] then
--                        lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
--                    else
--                        lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
--                    end
--                else
--                    lb.UnitsTableStatus[j][6] =  false
--                end
--            end
--
--           -- if lb.UnitsTableStatus[j][1] ~=  unitTable.aggro or viewModeChanged then
--                lb.UnitsTableStatus[j][1] =  unitTable.aggro
--                if unitTable.aggro then
--                    lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
--                else
--                    lb.frames[j].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
--                end
--            --end
--           -- if lb.UnitsTableStatus[j][3] ~=  unitTable.blocked or viewModeChanged then
--             
--            --end
--            if viewModeChanged then
--              local  healthtick = unitTable.health
--              local  healthmax = unitTable.healthMax
--                if healthtick~=nil and healthmax ~= nil then
--                	lb.styles[lb.currentStyle].setHealthBarValue(j,healthtick,healthmax)
--                    lb.styles[lb.currentStyle].setHealthBarText(j,healthtick,healthmax)
--                end
--            end
--
--        end
--
--    end
--
--   for key,val in pairs(lb.UnitsTableStatus) do
--		
--       if not lb.UnitsTableStatus[key][8] then
--           lb.UnitsTableStatus[key][5]=0
--
--           if lastMode==0 and key=="group01" then
--           else
--               local needreset=false
--
--               for i = 1,5 do
--                   if lb.frames[0].buffs.groupSpotsIcons[key][i] then
--                       needreset=true
--                   end
--               end
--               if needreset then
--                   lb.buffMonitor.resetBuffMonitorTexturesForIndex(key)
--               end
--               if lb.styles[lb.currentStyle].isCastbarIndexVisible(key) then
--                   resetCastbarIndex(key)
--               end
--
--           end
--       end
--   end
--
--    viewModeChanged=false
end
--Called by the event   Event.Unit.Detail.Aggro


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









