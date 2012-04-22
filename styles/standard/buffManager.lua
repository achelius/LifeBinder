
local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitylist = _G.Inspect.Ability.List
local abilitydetail = _G.Inspect.Ability.Detail
local buffdetail=   _G.Inspect.Buff.Detail
local bufflist=   _G.Inspect.Buff.List
local timeFrame=_G.Inspect.Time.Real

local stTable=lb.styles["standard"]
local optionsTable=nil
local frame=nil

local timeFrame=_G.Inspect.Time.Real
stTable.buffManager={}
stTable.FullBuffsList={}     -- used by buffmonitor
stTable.buffManager.slotscount=0
local lastdurationcheck=0

function stTable.buffManager.initializeBuffMonitorOptionsTable()
	if optionsTable==nil then optionsTable=stTable.options end
		--print(stTable.getLayoutTable().buffs)
	if stTable.getLayoutTable().buffs ==nil then
		stTable.getLayoutTable().buffs={}
		stTable.getLayoutTable().buffs.options={}
		lb.copyTable(lbPredefinedBuffSlotPos[1],stTable.getLayoutTable().buffs.options)
		for i = 1,4 do
			stTable.getLayoutTable().buffs.options[i].names={}
		end
       
	end
	lb.buffMonitor=stTable.buffManager --overrides the default buff monitor
end

function stTable.buffManager.initializeBuffMonitor()
--print ( stTable.buffManager.slotscount )
	if optionsTable==nil then optionsTable=stTable.options end
	stTable.buffManager.initializeBuffMonitorOptionsTable()
	stTable.buffManager.slotscount = #(stTable.getLayoutTable().buffs.options)
 	for var=1,20 do
 		stTable.buffManager.initializeBuffMonitorFrameIndex(var)
    end
end

function stTable.buffManager.initializeBuffMonitorFrameIndex(var)
--print ( stTable.buffManager.slotscount )
	if optionsTable==nil then optionsTable=stTable.options end
	stTable.buffManager.initializeBuffMonitorOptionsTable()
	stTable.buffManager.slotscount = #(stTable.getLayoutTable().buffs.options)
	
 		if lb.UnitsTableStatus[var][12]then
		    for g= 1,  stTable.buffManager.slotscount do
		       
		       local scalex=1--lbValues.mainwidth*0.009009009
		       local scaley=1--lbValues.mainheight*0.023255814
		       local lt=stTable.getLayoutTable().buffs.options[g][3]*scalex
		       local tp=stTable.getLayoutTable().buffs.options[g][4]*scaley
		       local Point1=stTable.getLayoutTable().buffs.options[g][1]
		       local Point2=stTable.getLayoutTable().buffs.options[g][2]
		       local acceptdebuffs=stTable.getLayoutTable().buffs.options[g][7]
		       local iconWidth=stTable.getLayoutTable().buffs.options[g][5]
		       local iconHeight=stTable.getLayoutTable().buffs.options[g][6]
		       if lb.frames[var].buffs==nil then lb.frames[var].buffs={} end
			   if lb.frames[var].buffs.groupSpots==nil then lb.frames[var].buffs.groupSpots= {} end
			   if lb.frames[var].buffs.groupSpotsIcons==nil then lb.frames[var].buffs.groupSpotsIcons= {} end
		        if lb.frames[var].buffs.groupSpots[g]==nil then lb.frames[var].buffs.groupSpots[g] = {} end
		        lb.frames[var].buffs.groupSpots[g][0]=true --icon
		        if lb.frames[var].buffs.groupSpots[g][1]==nil then lb.frames[var].buffs.groupSpots[g][1]=UI.CreateLbFrame("Texture", "HoT" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][2]==nil then lb.frames[var].buffs.groupSpots[g][2]=UI.CreateLbFrame("Text", "HoTText" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][3]==nil then lb.frames[var].buffs.groupSpots[g][3]=UI.CreateLbFrame("Text", "HoTTextShadow" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][4]==nil then lb.frames[var].buffs.groupSpots[g][4]=UI.CreateLbFrame("Text", "Duration" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][5]==nil then lb.frames[var].buffs.groupSpots[g][5]=UI.CreateLbFrame("Text", "DurationShadow" .. tostring(g), lb.frames[var].groupBF) end
		        lb.frames[var].buffs.groupSpotsIcons[g]={}
		        lb.frames[var].buffs.groupSpotsIcons[g][0]=false
		        lb.frames[var].buffs.groupSpotsIcons[g][1]="LifeBinder"
		        lb.frames[var].buffs.groupSpotsIcons[g][2]="Textures/buffhot.png"
		        lb.frames[var].buffs.groupSpotsIcons[g][3]=0 --stacks
		        lb.frames[var].buffs.groupSpotsIcons[g][4]=false    --updated  (true if icon has just updated)
		        lb.frames[var].buffs.groupSpotsIcons[g][5]=nil    --buff spell ID     (used for remove buff )
		        lb.frames[var].buffs.groupSpotsIcons[g][6]=false    --is debuff    true if the debuff applied is a debuff
		        lb.frames[var].buffs.groupSpotsIcons[g][7]=false    --is a priority buff
		        lb.frames[var].buffs.groupSpotsIcons[g][8]=acceptdebuffs    --accepts Debuffs (true is this slot accepts debuffs
		        lb.frames[var].buffs.groupSpotsIcons[g][9]=false    --has duration
		        lb.frames[var].buffs.groupSpotsIcons[g][10]=1    --buff duration
		        lb.frames[var].buffs.groupSpotsIcons[g][11]=0   --timeframe of the moment this buff was set
		        lb.frames[var].buffs.groupSpotsIcons[g][12]=0   --current duration displayed
		        local iconl=iconWidth
		        if iconHeight<iconWidth then
		        	iconl=iconHeight
		        end
		        local fontfile="fonts/AriBlk.ttf"
		        local fontsize=12
		        lb.frames[var].buffs.groupSpots[g][1]:SetTexture(lb.frames[var].buffs.groupSpotsIcons[g][1],lb.frames[var].buffs.groupSpotsIcons[g][2] )
		        lb.frames[var].buffs.groupSpots[g][1]:SetPoint(Point1, lb.frames[var].groupBF, Point2, lt,  tp )
		        lb.frames[var].buffs.groupSpots[g][1]:SetHeight(iconl)
		        lb.frames[var].buffs.groupSpots[g][1]:SetWidth(iconl)
		        lb.frames[var].buffs.groupSpots[g][1]:SetLayer(5)
		        lb.frames[var].buffs.groupSpots[g][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][0])
		
		        lb.frames[var].buffs.groupSpots[g][2]:SetPoint("CENTER", lb.frames[var].buffs.groupSpots[g][1], "CENTER", -5, -7 )
		        lb.frames[var].buffs.groupSpots[g][2]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].buffs.groupSpots[g][2]:SetFontColor(1,1,1,1)
		        lb.frames[var].buffs.groupSpots[g][2]:SetFontSize(fontsize)
		        lb.frames[var].buffs.groupSpots[g][2]:SetText(tostring(lb.frames[var].buffs.groupSpotsIcons[g][3]))
		        lb.frames[var].buffs.groupSpots[g][2]:SetLayer(7)
		        if lb.frames[var].buffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].buffs.groupSpots[g][2]:SetVisible(false) end
		
		        lb.frames[var].buffs.groupSpots[g][3]:SetPoint("CENTER", lb.frames[var].buffs.groupSpots[g][2], "CENTER",2, 2 )
		        lb.frames[var].buffs.groupSpots[g][3]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].buffs.groupSpots[g][3]:SetFontColor(0,0,0,1)
		        lb.frames[var].buffs.groupSpots[g][3]:SetFontSize(fontsize)
		        lb.frames[var].buffs.groupSpots[g][3]:SetText(tostring(lb.frames[var].buffs.groupSpotsIcons[g][3]))
		        lb.frames[var].buffs.groupSpots[g][3]:SetLayer(6)
		        if lb.frames[var].buffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].buffs.groupSpots[g][3]:SetVisible(false) end
		        
		        lb.frames[var].buffs.groupSpots[g][4]:SetPoint("CENTER", lb.frames[var].buffs.groupSpots[g][1], "CENTER",2, 7)
		        lb.frames[var].buffs.groupSpots[g][4]:SetFontColor(1,1,1,1)
		        lb.frames[var].buffs.groupSpots[g][4]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].buffs.groupSpots[g][4]:SetFontSize(fontsize)
		        lb.frames[var].buffs.groupSpots[g][4]:SetText("")
		        lb.frames[var].buffs.groupSpots[g][4]:SetLayer(7)
		        if lb.frames[var].buffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].buffs.groupSpots[g][4]:SetVisible(false) end
		        
		        lb.frames[var].buffs.groupSpots[g][5]:SetPoint("CENTER", lb.frames[var].buffs.groupSpots[g][4], "CENTER",2, 2)
		        lb.frames[var].buffs.groupSpots[g][5]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].buffs.groupSpots[g][5]:SetFontColor(0,0,0,1)
		       -- lb.frames[var].buffs.groupSpots[g][5]:SetBackgroundColor(1,0,0,1)
		        lb.frames[var].buffs.groupSpots[g][5]:SetFontSize(fontsize)
		        lb.frames[var].buffs.groupSpots[g][5]:SetText("")
		        lb.frames[var].buffs.groupSpots[g][5]:SetLayer(6)
		        if lb.frames[var].buffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].buffs.groupSpots[g][5]:SetVisible(false) end
		      
		        
		        lb.frames[var].buffs.groupSpots[g][4]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
			end
			if #(stTable.getLayoutTable().buffs.options)<#(lb.frames[var].buffs.groupSpots) then
			 	for i = #(stTable.getLayoutTable().buffs.options)+1,#(lb.frames[var].buffs.groupSpots) do
		 			if lb.frames[var].buffs.groupSpots[i]~=nil then
			 			lb.frames[var].buffs.groupSpots[i][1]:SetVisible(false)
			 		end
			 	end
			 end
		end
    
end




function stTable.buffManager.relocateBuffMonitorSlots()
--print ( stTable.buffManager.slotscount )
   local scalex=1--lbValues.mainwidth*0.009009009
	local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
		    for g= 1,  stTable.buffManager.slotscount do
		    
		       local lt=stTable.getLayoutTable().buffs.options[g][3]*scalex
		       local tp=stTable.getLayoutTable().buffs.options[g][4]*scaley
		       local Point1=stTable.getLayoutTable().buffs.options[g][1]
		       local Point2=stTable.getLayoutTable().buffs.options[g][2]
		       
		        
		        local iconwidth=stTable.getLayoutTable().buffs.options[g][5]*scalex
	            local iconheight=stTable.getLayoutTable().buffs.options[g][6]*scaley
		        local iconl=iconwidth
		        if iconheight<iconwidth then
		        	iconl=iconheight
		        end
		        lb.frames[var].buffs.groupSpots[g][1]:SetPoint(Point1, lb.frames[var].groupBF, Point2, lt,  tp )
		        lb.frames[var].buffs.groupSpots[g][1]:SetHeight(iconl)
		        lb.frames[var].buffs.groupSpots[g][1]:SetWidth(iconl)
		        lb.frames[var].buffs.groupSpots[g][1]:SetLayer(5)
	
		   
	    	end
    	end
    end
end

function stTable.buffManager.relocateSingleBuffMonitorSlot(index)
--print ( stTable.buffManager.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	--print("style")
 	for var=1,20 do
 		
	   if lb.UnitsTableStatus[var][12]then 
	       local lt=stTable.getLayoutTable().buffs.options[index][3]*scalex
	       local tp=stTable.getLayoutTable().buffs.options[index][4]*scaley
	       local Point1=stTable.getLayoutTable().buffs.options[index][1]
	       local Point2=stTable.getLayoutTable().buffs.options[index][2]
	       
	        
	        local iconwidth=stTable.getLayoutTable().buffs.options[index][5]*scalex
	        local iconheight=stTable.getLayoutTable().buffs.options[index][6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	        lb.frames[var].buffs.groupSpots[index][1]:SetPoint(Point1, lb.frames[var].groupBF, Point2, lt,  tp )
	        lb.frames[var].buffs.groupSpots[index][1]:SetHeight(iconl)
	        lb.frames[var].buffs.groupSpots[index][1]:SetWidth(iconl)
	        lb.frames[var].buffs.groupSpots[index][1]:SetLayer(5)

	   	end
    end
end

function stTable.buffManager.getBuffSlotTable(slotindex)
	return stTable.getLayoutTable().buffs.options[slotindex]
end
function stTable.buffManager.getBuffSlotNamesTable(slotindex)
	return stTable.getLayoutTable().buffs.options[slotindex].names
end

function stTable.buffManager.getBuffsSlotsCompleteTable()
	return stTable.getLayoutTable().buffs.options
end


function stTable.buffManager.showDummyBuffMonitorSlots()
--print ( stTable.buffManager.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	 		for g= 1, stTable.buffManager.slotscount  do
		        lb.frames[var].buffs.groupSpots[g][1]:SetBackgroundColor(0,0,0,1)
		        lb.frames[var].buffs.groupSpots[g][1]:SetVisible(true)
		    end  	   
	    end
    end
end
function stTable.buffManager.hideDummyBuffMonitorSlots()
--print ( stTable.buffManager.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	 		for g= 1,  #(lb.frames[var].buffs.groupSpots) do
		        lb.frames[var].buffs.groupSpots[g][1]:SetBackgroundColor(0,0,0,0)
		        lb.frames[var].buffs.groupSpots[g][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][0])
		    end  
		       
	    end
    end
end
function stTable.buffManager.showSingleDummyBuffMonitorSlot(index)
--print ( stTable.buffManager.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	        lb.frames[var].buffs.groupSpots[index][1]:SetBackgroundColor(0,0,0,1)
	        lb.frames[var].buffs.groupSpots[index][1]:SetVisible(true)
		end	        	   
    end
end
function stTable.buffManager.hideSingleDummyBuffMonitorSlot(index)
--print ( stTable.buffManager.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	        lb.frames[var].buffs.groupSpots[index][1]:SetBackgroundColor(0,0,0,0)
	        lb.frames[var].buffs.groupSpots[index][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[var][index][0])
	    end
    end
end

function stTable.buffManager.updateBuffMonitorTextures()
    for var=1,20 do
    	if lb.UnitsTableStatus[var][12]then
	        for g= 1,  stTable.buffManager.slotscount do
				stTable.buffManager.updateBuffMonitorTexturesIndex(var,g)
	            
	        end
	    end
    end
end
function stTable.buffManager.updateBuffMonitorTexturesIndex(frameindex,slotindex)

		if lb.UnitsTableStatus[frameindex][12]then
            if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4] then
                --just updated
                --print (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3])
                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4]=false
                lb.frames[frameindex].buffs.groupSpots[slotindex][1]:SetTexture(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][1],lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][2] )
                lb.frames[frameindex].buffs.groupSpots[slotindex][1]:SetVisible(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][0])
                --print (lb.frames[frameindex].buffs.groupSpots[slotindex][1]:GetVisible())

                lb.frames[frameindex].buffs.groupSpots[slotindex][2]:SetText(tostring(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]))
                if (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]==0 or lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]==nil) and {lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][0]} then
                    --print("nostack")
                    lb.frames[frameindex].buffs.groupSpots[slotindex][2]:SetVisible(false)
                else
                    -- print("stack")
                    lb.frames[frameindex].buffs.groupSpots[slotindex][2]:SetVisible(true)
                end

                lb.frames[frameindex].buffs.groupSpots[slotindex][3]:SetFontColor(0,0,0,1)
                lb.frames[frameindex].buffs.groupSpots[slotindex][3]:SetText(tostring(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]))
                
                if (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]==0 or lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]==nil) and {lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][0]} then
                    lb.frames[frameindex].buffs.groupSpots[slotindex][3]:SetVisible(false)
                else
                    lb.frames[frameindex].buffs.groupSpots[slotindex][3]:SetVisible(true)
                end
                --print()
                lb.frames[frameindex].buffs.groupSpots[slotindex][4]:SetText("")
                lb.frames[frameindex].buffs.groupSpots[slotindex][5]:SetText("")
                lb.frames[frameindex].buffs.groupSpots[slotindex][4]:SetVisible(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9])
                lb.frames[frameindex].buffs.groupSpots[slotindex][5]:SetVisible(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9])
            end
       end

end
function stTable.buffManager.resetBuffMonitorTextures()
    for var=1,20 do
    	
    	stTable.buffManager.resetBuffMonitorTexturesForIndex(var)
    end
end
function stTable.buffManager.resetBuffMonitorTexturesForIndex(var)
	if lb.UnitsTableStatus[var][12]then
		
        for g= 1,  stTable.buffManager.slotscount do
	
				
	            if lb.frames[var].buffs.groupSpotsIcons[g][0] then
	
		            lb.frames[var].buffs.groupSpotsIcons[g][0]=false
		            
		            --print (lb.frames[var].buffs.groupSpotsIcons[g][0])
		            lb.frames[var].buffs.groupSpotsIcons[g][4]=false
		            lb.frames[var].buffs.groupSpotsIcons[g][9]=false
		            lb.frames[var].buffs.groupSpotsIcons[g][3]=0
		            lb.frames[var].buffs.groupSpots[g][1]:SetTexture(lb.frames[var].buffs.groupSpotsIcons[g][1],lb.frames[var].buffs.groupSpotsIcons[g][2] )
		            
		            lb.frames[var].buffs.groupSpots[g][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][0])
		
		            lb.frames[var].buffs.groupSpots[g][2]:SetText(tostring(lb.frames[var].buffs.groupSpotsIcons[g][3]))
		            if (lb.frames[var].buffs.groupSpotsIcons[g][3]==0 or lb.frames[var].buffs.groupSpotsIcons[g][3]==nil) and {lb.frames[var].buffs.groupSpotsIcons[g][0]} then
		                lb.frames[var].buffs.groupSpots[g][2]:SetVisible(false)
		                lb.frames[var].buffs.groupSpots[g][3]:SetVisible(false)
		            else
		                lb.frames[var].buffs.groupSpots[g][2]:SetVisible(true)
		                lb.frames[var].buffs.groupSpots[g][3]:SetVisible(true)
		            end
		
		            lb.frames[var].buffs.groupSpots[g][3]:SetFontColor(0,0,0,1)
		            lb.frames[var].buffs.groupSpots[g][3]:SetText(tostring(lb.frames[var].buffs.groupSpotsIcons[g][3]))
		       
		            lb.frames[var].buffs.groupSpots[g][4]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
		            lb.frames[var].buffs.groupSpots[g][5]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
	            end
            
        end
	end
end
function stTable.buffManager.updateDurations()
	local elapsed = now - lastdurationcheck
    if (elapsed < (.5)) then --half a second
        return 
    else
    	lastdurationcheck = now
    end
	local timer=stTable.buffManager.getDurationThrottle()
	if not timer then return end
	local now =timeFrame()
	 for var=1,20 do
	 	if lb.UnitsTableStatus[var][12]then
		 	if lb.UnitsTableStatus[var][5]~=nil and lb.UnitsTableStatus[var][5]~=0 then
		        for g= 1,  stTable.buffManager.slotscount do
		        	
		        	
		        	if lb.frames[var].buffs.groupSpotsIcons[g][0] then
		        		
			            
			            if lb.frames[var].buffs.groupSpotsIcons[g][9] then
		        		--has duration
			        		local stTime=lb.frames[var].buffs.groupSpotsIcons[g][11]
			        		local duration =lb.frames[var].buffs.groupSpotsIcons[g][10]
			        		local timeval=round(duration-now+stTime)
			        		if lb.frames[var].buffs.groupSpotsIcons[g][12]~=timeval then
			        		if timeval<=3 then
			        				lb.frames[index].buffs.groupSpots[g][4]:SetFontColor(1,0,0,1)
			        			else
			        				lb.frames[index].buffs.groupSpots[g][4]:SetFontColor(1,1,1,1)
			        			end
			        			lb.frames[var].buffs.groupSpots[g][4]:SetText(tostring(timeval))
			        			lb.frames[var].buffs.groupSpots[g][5]:SetText(tostring(timeval))
			        		end
			        		lb.frames[var].buffs.groupSpotsIcons[g][12]=timeval
			        	else
			        		
			        	end
			        	if lb.frames[var].buffs.groupSpots[g][4]:GetVisible()~=lb.frames[var].buffs.groupSpotsIcons[g][9] then 
				            
				            lb.frames[var].buffs.groupSpots[g][4]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
				            lb.frames[var].buffs.groupSpots[g][5]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
			            end
		            end
		        end
		    end
	    end
    end
end

function stTable.buffManager.updateDurationsOfIndex(index)
	
	
	local frames= lb.frames[index]
	local buffcount=stTable.buffManager.slotscount
 	if lb.UnitsTableStatus[index][5]~=nil and lb.UnitsTableStatus[index][5]~=0 and  lb.UnitsTableStatus[index][12]  then
        for g= 1,  buffcount do
        	
          if frames.buffs.groupSpotsIcons[g]~=nil then	
        	if frames.buffs.groupSpotsIcons[g][0] then
        		
	           
	            if frames.buffs.groupSpotsIcons[g][9] then
        		--has duration
	        		local stTime=frames.buffs.groupSpotsIcons[g][11]
	        		local duration =frames.buffs.groupSpotsIcons[g][10]
	        		local timeval=round(duration-now+stTime)
	        		
	        		if frames.buffs.groupSpotsIcons[g][12]~=timeval then
	        			if timeval<=3 then
		        				frames.buffs.groupSpots[g][4]:SetFontColor(1,0,0,1)
		        		else
		        				frames.buffs.groupSpots[g][4]:SetFontColor(1,1,1,1)
		        		end
		        		if timeval<10 then
		        				frames.buffs.groupSpots[g][4]:SetText(tostring(timeval))
	        					frames.buffs.groupSpots[g][5]:SetText(tostring(timeval))
		        		else
		        				frames.buffs.groupSpots[g][4]:SetText("")
	        					frames.buffs.groupSpots[g][5]:SetText("")
		        		end
	        			frames.buffs.groupSpotsIcons[g][12]=timeval
	        		end
	        	else
	        		
	        	end
	        	 if frames.buffs.groupSpots[g][4]:GetVisible()~=frames.buffs.groupSpotsIcons[g][9] then 
		            
		            frames.buffs.groupSpots[g][4]:SetVisible(frames.buffs.groupSpotsIcons[g][9])
		            frames.buffs.groupSpots[g][5]:SetVisible(frames.buffs.groupSpotsIcons[g][9])
	            end
            end
          end
        end
    end
    
end

function stTable.buffManager.updateSpellTextures()
    local abilities
    abtextures={}
    --stTable.getLayoutTable().buffs.options[i].names
    abilities =abilitylist()
    abilitydets=abilitydetail(abilities)
    for d,c in pairs(stTable.getLayoutTable().buffs.options) do
        for s,a in pairs(c.names) do
            found=false
            stTable.FullBuffsList[s]=true
            for v, k in pairs(abilitydets) do
                if s==k.name and s~=nil then
                    if k.icon ~=nil then
                        found=true
                        lb.iconsCache.addTextureToCache(s,"Rift",k.icon) -- the function controls automatically if the icon is present in the cache
                    end
                end
            end
            if not found then
                lb.NoIconsBuffList[s]=true
                --print (a)
            end

        end
    end

end


function stTable.buffManager.onBuffAddTest(unit, buffTable,frameindex)
     
        
        local name=buffTable.name
        if buffTable.debuff==nil then
            if stTable.FullBuffsList[name]~=nil then
                
                    local texture=nil
                    if lb.iconsCache.hasTextureInCache(name) then
                        texture= lb.iconsCache.getTextureFromCache(name)
                        --print("cache"..lb.iconsCache.getTextureFromCache(name)[2])
                    else
                        lb.iconsCache.addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..lb.iconsCache.getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(stTable.getLayoutTable().buffs.options) do
                       if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex]~=nil then

	                        for s,a in pairs(c.names) do
	                        	--s=ability name
	                            --a=options
	                            if s==name and s~=nil then
	                            	local enable=false
	                            	if a["priority"] then
	                            		if a["castByMeOnly"] then --look if this buff is set as cast by me only or cast by everyone
			                            	if buffTable.caster== lb.PlayerID then
			                            		enable=true
			                            	end
			                           	else
			                           		enable=true
		                            	end
	                            	else
	                            		if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][7] then
	                            			enable=false
	                            		else
		                            		if a["castByMeOnly"]==true then --look if this buff is set as cast by me only or cast by everyone
				                            	if buffTable.caster== lb.PlayerID then
				                            		enable=true
				                            	end
				                           	else
				                           		enable=true
			                            	end
	                            		end
	                            		
	                            	end
	                            	
	                            	
	                                --print (frameindex)
	                                if enable then
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][0]=true
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][1]=texture[1]
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][2]=texture[2]
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]=buffTable.stack
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4]=true
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][5]=buffTable.id
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][6]=false
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][7]=(a["priority"]==true) --if nil => false
		                                
		                                if buffTable.duration~=nil then
		                                	lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9]=true
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][10]=round(buffTable.duration)
			                                if buffTable.duration~=nil and buffTable.remaining~=nil then
			                                	lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=timeFrame()-(buffTable.duration-buffTable.remaining)
			                                else
			                                	lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=timeFrame()
			                                end
			                                
		                                else
		                                	lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9]=false
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][10]=1
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=0
		                                end
		                                --print (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4])
		                                stTable.buffManager.updateBuffMonitorTexturesIndex(frameindex,slotindex)
		                                updatebuffs=true
	                                end
	                            end
	
	
	                        
                        end
                      end
                    end
                
            end
            if updatebuffs then
                --print(true)
                --stTable.buffManager.updateBuffMonitorTextures()
            end
        else
        	
        end
    

end


function stTable.buffManager.onBuffRemoveTest(unit, buffID,frameindex)
    --buffs=buffdetail(unit,buffs)
    --print ("remove")
    local updatebuffs=false
       -- for slotindex,c in pairs(lbSelectedBuffsList[lbValues.set]) do
	local buffcount=stTable.buffManager.slotscount
	        for slotindex= 1, buffcount do
	            if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][5]== buffID then
	                --print (frameindex)
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][0]=false
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]=nil
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4]=true
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][5]=nil
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][7]=false
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9]=false
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][10]=1
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=0
	                local buffs= bufflist(unit)
	                local newbuffsdetails=buffdetail(unit,buffs)
                    --was a buff
                    for idb,BuffDet in pairs(newbuffsdetails) do
                        if BuffDet.debuff==nil then
                            local slotbuffs= stTable.getLayoutTable().buffs.options[slotindex].names
                            if slotbuffs~=nil then
                                local nextBuff=nil
                                for buffname,buffopt in pairs(slotbuffs) do
                                    if buffname==BuffDet.name then
                                        nextBuff=BuffDet
                                    end
                                end
                                if nextBuff~=nil then

                                    stTable.buffManager.onBuffAddTest(unit,nextBuff,frameindex)
                                end

                            end

                        end
                    end
	                stTable.buffManager.updateBuffMonitorTexturesIndex(frameindex,slotindex)
	                updatebuffs=true
	            end
	        end
	return updatebuffs

end

function stTable.buffManager.onBuffChangeTest(unit, buffID,frameindex)
    local updatebuffs=false
	local buffcount=stTable.buffManager.slotscount
	        for slotindex= 1, buffcount do
	           
	            if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][5]== buffID then
	            	local newbuffsdetails=buffdetail(unit,buffID)
	            	if newbuffsdetails~=nil then
		                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]=newbuffsdetails.stack
		                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4]=true --flags that the buff needs an update
		                stTable.buffManager.updateBuffMonitorTexturesIndex(frameindex,slotindex)
		                
	                end
	                updatebuffs=true
	            end
	        end
	return updatebuffs
end

