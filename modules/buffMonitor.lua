--
--Buff Monitor
--
local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitylist = _G.Inspect.Ability.List
local abilitydetail = _G.Inspect.Ability.Detail
local buffdetail=   _G.Inspect.Buff.Detail
local bufflist=   _G.Inspect.Buff.List
local timeFrame=_G.Inspect.Time.Real
lb.buffMonitor={}
lb.FullBuffsList={}     -- used by buffmonitor
lb.FullDeBuffsList={}    -- used by buffmonitor
lb.buffMonitor.slotscount=0
local lastdurationcheck=0



function lb.buffMonitor.initializeBuffMonitor()
--print ( lb.buffMonitor.slotscount )
	lb.buffMonitor.slotscount = #(lbBuffSlotOptions[lbValues.set])
 	for var=1,20 do
 		lb.buffMonitor.initializeBuffMonitorFrameIndex(var)
    end
end

function lb.buffMonitor.initializeBuffMonitorFrameIndex(var)
--print ( lb.buffMonitor.slotscount )
	lb.buffMonitor.slotscount = #(lbBuffSlotOptions[lbValues.set])
	
 		if lb.UnitsTableStatus[var][12]then
		    for g= 1,  lb.buffMonitor.slotscount do
		       
		       local scalex=1--lbValues.mainwidth*0.009009009
		       local scaley=1--lbValues.mainheight*0.023255814
		       local lt=lbBuffSlotOptions[lbValues.set][g][3]*scalex
		       local tp=lbBuffSlotOptions[lbValues.set][g][4]*scaley
		       local Point1=lbBuffSlotOptions[lbValues.set][g][1]
		       local Point2=lbBuffSlotOptions[lbValues.set][g][2]
		       local acceptdebuffs=lbBuffSlotOptions[lbValues.set][g][7]
		       local iconWidth=lbBuffSlotOptions[lbValues.set][g][5]
		       local iconHeight=lbBuffSlotOptions[lbValues.set][g][6]
		       if lb.frames[var].buffs==nil then lb.frames[var].buffs={} end
			   if lb.frames[var].buffs.groupSpots==nil then lb.frames[var].buffs.groupSpots= {} end
			   if lb.frames[var].buffs.groupSpotsIcons==nil then lb.frames[var].buffs.groupSpotsIcons= {} end
		        lb.frames[var].buffs.groupSpots[g] = {}
		        lb.frames[var].buffs.groupSpots[g][0]=true --icon
		        if lb.frames[var].buffs.groupSpots[g][1]==nil then lb.frames[var].buffs.groupSpots[g][1]=UI.CreateFrame("Texture", "HoT" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][2]==nil then lb.frames[var].buffs.groupSpots[g][2]=UI.CreateFrame("Text", "HoTText" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][3]==nil then lb.frames[var].buffs.groupSpots[g][3]=UI.CreateFrame("Text", "HoTTextShadow" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][4]==nil then lb.frames[var].buffs.groupSpots[g][4]=UI.CreateFrame("Text", "Duration" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].buffs.groupSpots[g][5]==nil then lb.frames[var].buffs.groupSpots[g][5]=UI.CreateFrame("Text", "DurationShadow" .. tostring(g), lb.frames[var].groupBF) end
		
		        lb.frames[var].buffs.groupSpotsIcons[g]={}
		        lb.frames[var].buffs.groupSpotsIcons[g][0]=false
		        lb.frames[var].buffs.groupSpotsIcons[g][1]="LifeBinder"
		        lb.frames[var].buffs.groupSpotsIcons[g][2]="Textures/buffhot.png"
		        lb.frames[var].buffs.groupSpotsIcons[g][3]=0 --stacks
		        lb.frames[var].buffs.groupSpotsIcons[g][4]=false    --updated  (true if icon has just updated)
		        lb.frames[var].buffs.groupSpotsIcons[g][5]=nil    --buff spell ID     (used for remove buff )
		        lb.frames[var].buffs.groupSpotsIcons[g][6]=false    --is debuff    true if the debuff applied is a debuff
		        lb.frames[var].buffs.groupSpotsIcons[g][7]=false    --is from whitelist
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
		       --lb.frames[var].buffs.groupSpots[g][3]:SetBackgroundColor(1,0,0,1)
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
		end
    
end





function lb.buffMonitor.relocateBuffMonitorSlots()
--print ( lb.buffMonitor.slotscount )
   local scalex=1--lbValues.mainwidth*0.009009009
	local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
		    for g= 1,  lb.buffMonitor.slotscount do
		    
		       local lt=lbBuffSlotOptions[lbValues.set][g][3]*scalex
		       local tp=lbBuffSlotOptions[lbValues.set][g][4]*scaley
		       local Point1=lbBuffSlotOptions[lbValues.set][g][1]
		       local Point2=lbBuffSlotOptions[lbValues.set][g][2]
		       
		        
		        local iconwidth=16*scalex
		        local iconheight=16*scaley
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

function lb.buffMonitor.relocateSingleBuffMonitorSlot(index)
--print ( lb.buffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
	   
	   if lb.UnitsTableStatus[var][12]then 
	       local lt=lbBuffSlotOptions[lbValues.set][index][3]*scalex
	       local tp=lbBuffSlotOptions[lbValues.set][index][4]*scaley
	       local Point1=lbBuffSlotOptions[lbValues.set][index][1]
	       local Point2=lbBuffSlotOptions[lbValues.set][index][2]
	       
	        
	        local iconwidth=16*scalex
	        local iconheight=16*scaley
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

function lb.buffMonitor.showDummyBuffMonitorSlots()
--print ( lb.buffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	 		for g= 1,  lb.buffMonitor.slotscount do
		        lb.frames[var].buffs.groupSpots[g][1]:SetBackgroundColor(0,0,0,1)
		        lb.frames[var].buffs.groupSpots[g][1]:SetVisible(true)
		    end  	   
	    end
    end
end
function lb.buffMonitor.hideDummyBuffMonitorSlots()
--print ( lb.buffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	 		for g= 1,  lb.buffMonitor.slotscount do
		        lb.frames[var].buffs.groupSpots[g][1]:SetBackgroundColor(0,0,0,0)
		        lb.frames[var].buffs.groupSpots[g][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][0])
		    end  	   
	    end
    end
end
function lb.buffMonitor.showSingleDummyBuffMonitorSlot(index)
--print ( lb.buffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	        lb.frames[var].buffs.groupSpots[index][1]:SetBackgroundColor(0,0,0,1)
	        lb.frames[var].buffs.groupSpots[index][1]:SetVisible(true)
		end	        	   
    end
end
function lb.buffMonitor.hideSingleDummyBuffMonitorSlot(index)
--print ( lb.buffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	        lb.frames[var].buffs.groupSpots[index][1]:SetBackgroundColor(0,0,0,0)
	        lb.frames[var].buffs.groupSpots[index][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[var][index][0])
	    end
    end
end

function lb.buffMonitor.updateBuffMonitorTextures()
    for var=1,20 do
    	if lb.UnitsTableStatus[var][12]then
	        for g= 1,  lb.buffMonitor.slotscount do
	
	            if lb.frames[var].buffs.groupSpotsIcons[g][4] then
	                --just updated
	                --print (lb.frames[var].buffs.groupSpotsIcons[g][3])
	                lb.frames[var].buffs.groupSpotsIcons[g][4]=false
	                lb.frames[var].buffs.groupSpots[g][1]:SetTexture(lb.frames[var].buffs.groupSpotsIcons[g][1],lb.frames[var].buffs.groupSpotsIcons[g][2] )
	                lb.frames[var].buffs.groupSpots[g][1]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][0])
	                --print (lb.frames[var].buffs.groupSpots[g][1]:GetVisible())
	
	                lb.frames[var].buffs.groupSpots[g][2]:SetText(tostring(lb.frames[var].buffs.groupSpotsIcons[g][3]))
	                if (lb.frames[var].buffs.groupSpotsIcons[g][3]==0 or lb.frames[var].buffs.groupSpotsIcons[g][3]==nil) and {lb.frames[var].buffs.groupSpotsIcons[g][0]} then
	                    --print("nostack")
	                    lb.frames[var].buffs.groupSpots[g][2]:SetVisible(false)
	                else
	                    -- print("stack")
	                    lb.frames[var].buffs.groupSpots[g][2]:SetVisible(true)
	                end
	
	                lb.frames[var].buffs.groupSpots[g][3]:SetFontColor(0,0,0,1)
	                lb.frames[var].buffs.groupSpots[g][3]:SetText(tostring(lb.frames[var].buffs.groupSpotsIcons[g][3]))
	                
	                if (lb.frames[var].buffs.groupSpotsIcons[g][3]==0 or lb.frames[var].buffs.groupSpotsIcons[g][3]==nil) and {lb.frames[var].buffs.groupSpotsIcons[g][0]} then
	                    lb.frames[var].buffs.groupSpots[g][3]:SetVisible(false)
	                else
	                    lb.frames[var].buffs.groupSpots[g][3]:SetVisible(true)
	                end
	                
	                lb.frames[var].buffs.groupSpots[g][4]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
	                lb.frames[var].buffs.groupSpots[g][5]:SetVisible(lb.frames[var].buffs.groupSpotsIcons[g][9])
	            end
	        end
	    end
    end
end
function lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,slotindex)

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
                lb.frames[frameindex].buffs.groupSpots[slotindex][4]:SetVisible(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9])
                lb.frames[frameindex].buffs.groupSpots[slotindex][5]:SetVisible(lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9])
            end
       end

end
function lb.buffMonitor.resetBuffMonitorTextures()
    for var=1,20 do
    	
    	lb.buffMonitor.resetBuffMonitorTexturesForIndex(var)
    end
end
function lb.buffMonitor.resetBuffMonitorTexturesForIndex(var)
	if lb.UnitsTableStatus[var][12]then
		
        for g= 1,  lb.buffMonitor.slotscount do
	
				
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
function lb.buffMonitor.updateDurations()
	local elapsed = now - lastdurationcheck
    if (elapsed < (.5)) then --half a second
        return 
    else
    	lastdurationcheck = now
    end
	local timer=lb.buffMonitor.getDurationThrottle()
	if not timer then return end
	local now =timeFrame()
	 for var=1,20 do
	 	if lb.UnitsTableStatus[var][12]then
		 	if lb.UnitsTableStatus[var][5]~=nil and lb.UnitsTableStatus[var][5]~=0 then
		        for g= 1,  lb.buffMonitor.slotscount do
		        	
		        	
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

function lb.buffMonitor.updateDurationsOfIndex(index)
	
	
	local frames= lb.frames[index]
	local buffcount=lb.buffMonitor.slotscount
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
function lb.buffMonitor.updateSpellTextures()
    local abilities
    abtextures={}
   
--    for v, k in pairs(lbSelectedBuffsList) do
--        table.insert(abtextures,"Textures/buffhot.png")
--    end
    abilities =abilitylist()
    abilitydets=abilitydetail(abilities)
    for d,c in pairs(lbSelectedBuffsList[lbValues.set]) do
        --c={"Soothing Stream", "Healing Current","Healing Flood" }
       
        for j,m in pairs(c) do
       
	        for s,a in pairs(m) do
	      
	            --a="Soothing Stream" ....
	            --print("txt"..tostring(s))
	            found=false
	            lb.FullBuffsList[s]=true
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
    lb.buffMonitor.createDebuffFullList()
end

function lb.buffMonitor.createDebuffFullList()
    lb.FullDeBuffsList={}
    for slotindex,c in pairs(lbDeBuffList[lbValues.set]) do
        --c="Soothing Stream" ....
            lb.FullDeBuffsList[c]=true
    end
end

function lb.buffMonitor.onBuffAdd(unit, buffs)
     buffs=buffdetail(unit,buffs)
     local frameindex=GetIndexFromID(unit)
     if frameindex==nil then return end
     local updatebuffs=false
     if lb.PlayerID==nil then lb.PlayerID=unitdetail("player").ID end

     for key,buffTable in pairs(buffs) do
        name=buffTable.name
        if buffTable.debuff==nil then
            if lb.FullBuffsList[name]~=nil then
                
                    local texture=nil
                    if lb.iconsCache.hasTextureInCache(name) then
                        texture= lb.iconsCache.getTextureFromCache(name)
                        --print("cache"..lb.iconsCache.getTextureFromCache(name)[2])
                    else
                        lb.iconsCache.addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..lb.iconsCache.getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(lbSelectedBuffsList[lbValues.set]) do
                       if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex]~=nil then
                         for j,m in pairs(c) do
	                        for s,a in pairs(m) do
	                        	--s=ability name
	                            --a=options
	                            if s==name and s~=nil then
	                            	local enable=false
	                            	if a["castByMeOnly"]==true then --look if this buff is set as cast by me only or cast by everyone
		                            	if buffTable.caster== lb.PlayerID then
		                            		enable=true
		                            	end
		                           	else
		                           		enable=true
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
		                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][7]=false
		                                if buffTable.duration~=nil then
		                                	lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9]=true
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][10]=round(buffTable.duration)
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=timeFrame()
		                                else
		                                	lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9]=false
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][10]=1
			                                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=0
		                                end
		                                --print (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4])
		                                lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,slotindex)
		                                updatebuffs=true
	                                end
	                            end
	
	
	                        end
                        end
                      end
                    end
                
            end
            if updatebuffs then
                --print(true)
                --lb.buffMonitor.updateBuffMonitorTextures()
            end
        else
        	--adding debuff to the cache (if enabled)
        	if lbValues.CacheDebuffs then
                addDebuffToCache(buffTable)
            end
			--is a debuff so now we check if it's in a whitelist
			local debWCount = #(lbDeBuffList[lbValues.set])
			local debBCount = #(lbDeBuffListBlackList[lbValues.set])
			--print (name)
			--dump(lbDeBuffList[lbValues.set])
            if lbDeBuffList[lbValues.set][name]~=nil then
				-- it's into the whitelist
                    local texture=nil
                    if lb.iconsCache.hasTextureInCache(name) then
                        texture= lb.iconsCache.getTextureFromCache(name)
                        --print("cache"..lb.iconsCache.getTextureFromCache(name)[2])
                    else
                        lb.iconsCache.addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..lb.iconsCache.getTextureFromCache(name)[2])
                    end
					local frame =lb.frames[frameindex]
					--now i search from the first debuff enable slot without a whitelisted debuff
					--used values
--			        lb.frames[var].buffs.groupSpotsIcons[g][6]=false    --is debuff    true if the debuff applied is a debuff
--			        lb.frames[var].buffs.groupSpotsIcons[g][7]=false    --is from whitelist
--			        lb.frames[var].buffs.groupSpotsIcons[g][8]=false    --accepts Debuffs (true is this slot accepts debuffs
					--print (#(frame.buffs.groupSpotsIcons))
					local slotscount=#(frame.buffs.groupSpotsIcons)
					for i = 1 , slotscount do
						--searching into the slots
						--print (frame.buffs.groupSpotsIcons[i][8])
						if frame.buffs.groupSpotsIcons[i][8] then
							--this slot accepts debuffs so i search if there is something
							if not frame.buffs.groupSpotsIcons[i][0] then
								--slot is empty so i add here my debuff
								--print(i)
								--print ("free")
								lb.frames[frameindex].buffs.groupSpotsIcons[i][0]=true
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][1]=texture[1]
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][2]=texture[2]
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][3]=buffTable.stack
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][4]=true
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][5]=buffTable.id
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][6]=true
	                            lb.frames[frameindex].buffs.groupSpotsIcons[i][7]=true
	                            if buffTable.duration~=nil then
	                            	lb.frames[frameindex].buffs.groupSpotsIcons[i][9]=true
	                                lb.frames[frameindex].buffs.groupSpotsIcons[i][10]=round(buffTable.duration)
	                                lb.frames[frameindex].buffs.groupSpotsIcons[i][11]=timeFrame()
	                            else
	                            	lb.frames[frameindex].buffs.groupSpotsIcons[i][9]=false
	                                lb.frames[frameindex].buffs.groupSpotsIcons[i][10]=1
	                                lb.frames[frameindex].buffs.groupSpotsIcons[i][11]=0
	                            end
	                            --print (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4])
	                            lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,i)
	                            updatebuffs=true
	                            break
							else
								--print ("nonfree")
								-- the slot is full but now i check if is a low priority debuff
								if not frame.buffs.groupSpotsIcons[i][7] then
									lb.frames[frameindex].buffs.groupSpotsIcons[i][0]=true
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][1]=texture[1]
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][2]=texture[2]
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][3]=buffTable.stack
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][4]=true
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][5]=buffTable.id
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][6]=true
		                            lb.frames[frameindex].buffs.groupSpotsIcons[i][7]=true
		                            if buffTable.duration~=nil then
		                            	lb.frames[frameindex].buffs.groupSpotsIcons[i][9]=true
		                                lb.frames[frameindex].buffs.groupSpotsIcons[i][10]=round(buffTable.duration)
		                                lb.frames[frameindex].buffs.groupSpotsIcons[i][11]=timeFrame()
		                            else
		                            	lb.frames[frameindex].buffs.groupSpotsIcons[i][9]=false
		                                lb.frames[frameindex].buffs.groupSpotsIcons[i][10]=1
		                                lb.frames[frameindex].buffs.groupSpotsIcons[i][11]=0
		                            end
		                            --print (lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4])
		                            lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,i)
		                            updatebuffs=true
		                            break
								end
							end
							
						end
					end
                  
			else
				--it's not in the whitelist so i check if it's on the blacklist
				if lbDeBuffListBlackList[name]~=nil then
					--I don't do anything because it's on the blacklist
				else
					--It's not on the blacklist so is a low priority debuff, it will be shown if an allowing-debuff slot is empty
					
				end
				
            end
            if updatebuffs then
                --print(true)
                --lb.buffMonitor.updateBuffMonitorTextures()
            end
        end
    end

end
function lb.buffMonitor.onBuffRemove(unit, buffs)
    --buffs=buffdetail(unit,buffs)
    --print ("remove")
    local frameindex=GetIndexFromID(unit)
    local buffcount=lb.buffMonitor.slotscount
    if frameindex==nil then return end
    local updatebuffs=false
    for buffID,placeholder in pairs(buffs) do
       -- for slotindex,c in pairs(lbSelectedBuffsList[lbValues.set]) do
       
	        for slotindex= 1, buffcount do
	           
	            if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][5]== buffID then
	                --print (frameindex)
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][0]=false
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][3]=nil
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4]=true
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][5]=nil
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][9]=false
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][10]=1
	                lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][11]=0
	                local buffs= bufflist(unit)
	
	                local newbuffsdetails=buffdetail(unit,buffs)
	
	                if lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][6] then
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
	                                lb.buffMonitor.onBuffAdd(unit,{lastdebuffID})
	                            end
	                        end
	                    end
	
	                else
	                    --was a buff
	                    for idb,BuffDet in pairs(newbuffsdetails) do
	                        if BuffDet.debuff==nil then
	                            local slotbuffs=  lbSelectedBuffsList[lbValues.set][slotindex]
	
	                            if slotbuffs~=nil then
	                                local lastdebuffID
	
	                                for i,buffname in pairs(slotbuffs) do
	
	                                    if buffname==BuffDet.name then
	
	                                        lastdebuffID=BuffDet.id
	                                        break
	                                    end
	                                end
	                                if lastdebuffID~=nil then
	
	                                    lb.buffMonitor.onBuffAdd(unit,{lastdebuffID})
	                                end
	
	                            end
	
	                        end
	                    end
	                end
	
	                lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,slotindex)
	                --print ("rem"..lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4])
	                updatebuffs=true
	            end
	        end
		
       -- end
       
        for i,debuffname in pairs(lbDeBuffList[lbValues.set]) do
            --c={"Soothing Stream", "Healing Current","Healing Flood" }
            --print (tostring(slotindex)..tostring(buffID))
            if lb.frames[frameindex].buffs.groupSpotsIcons[5][5]== buffID then
                --print (frameindex)
                lb.frames[frameindex].buffs.groupSpotsIcons[5][0]=false
                lb.frames[frameindex].buffs.groupSpotsIcons[5][3]=nil
                lb.frames[frameindex].buffs.groupSpotsIcons[5][4]=true
                lb.frames[frameindex].buffs.groupSpotsIcons[5][5]=nil
--                lb.frames[frameindex].buffs.groupSpotsIcons[5][9]=false
--                lb.frames[frameindex].buffs.groupSpotsIcons[5][10]=1
--                lb.frames[frameindex].buffs.groupSpotsIcons[5][11]=0
                --print ("rem"..lb.frames[frameindex].buffs.groupSpotsIcons[slotindex][4])
                lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,5)

                updatebuffs=true
            end

        end
        if updatebuffs then
            --print(true)
            --lb.buffMonitor.updateBuffMonitorTextures()
        end

    end
end


