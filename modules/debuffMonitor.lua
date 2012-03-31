--
--Debuff Monitor
--
local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitylist = _G.Inspect.Ability.List
local abilitydetail = _G.Inspect.Ability.Detail
local Debuffdetail=   _G.Inspect.Buff.Detail
local Debufflist=   _G.Inspect.Buff.List
local timeFrame=_G.Inspect.Time.Real
lb.debuffMonitor={}
lb.FullDebuffsList={}     -- used by Debuffmonitor
lb.NoIconsDebuffList={}
lb.debuffMonitor.slotscount=0
local lastdurationcheck=0



function lb.debuffMonitor.initializeDebuffMonitor()
--print ( lb.debuffMonitor.slotscount )
	lb.debuffMonitor.slotscount = #(lbDebuffSlotOptions[lbValues.set])
 	for var=1,20 do
 		lb.debuffMonitor.initializeDebuffMonitorFrameIndex(var)
    end
end

function lb.debuffMonitor.initializeDebuffMonitorFrameIndex(var)
--print ( lb.debuffMonitor.slotscount )
	lb.debuffMonitor.slotscount = #(lbDebuffSlotOptions[lbValues.set])
	
 		if lb.UnitsTableStatus[var][12]then
		    for g= 1,  lb.debuffMonitor.slotscount do
		       
		       local scalex=1--lbValues.mainwidth*0.009009009
		       local scaley=1--lbValues.mainheight*0.023255814
		       local lt=lbDebuffSlotOptions[lbValues.set][g][3]*scalex
		       local tp=lbDebuffSlotOptions[lbValues.set][g][4]*scaley
		       local Point1=lbDebuffSlotOptions[lbValues.set][g][1]
		       local Point2=lbDebuffSlotOptions[lbValues.set][g][2]
		       local acceptdeDebuffs=lbDebuffSlotOptions[lbValues.set][g][7]
		       local iconWidth=lbDebuffSlotOptions[lbValues.set][g][5]
		       local iconHeight=lbDebuffSlotOptions[lbValues.set][g][6]
		       if lb.frames[var].Debuffs==nil then lb.frames[var].Debuffs={} end
			   if lb.frames[var].Debuffs.groupSpots==nil then lb.frames[var].Debuffs.groupSpots= {} end
			   if lb.frames[var].Debuffs.groupSpotsIcons==nil then lb.frames[var].Debuffs.groupSpotsIcons= {} end
		        lb.frames[var].Debuffs.groupSpots[g] = {}
		        lb.frames[var].Debuffs.groupSpots[g][0]=true --icon
		        if lb.frames[var].Debuffs.groupSpots[g][1]==nil then lb.frames[var].Debuffs.groupSpots[g][1]=UI.CreateFrame("Texture", "HoT" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].Debuffs.groupSpots[g][2]==nil then lb.frames[var].Debuffs.groupSpots[g][2]=UI.CreateFrame("Text", "HoTText" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].Debuffs.groupSpots[g][3]==nil then lb.frames[var].Debuffs.groupSpots[g][3]=UI.CreateFrame("Text", "HoTTextShadow" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].Debuffs.groupSpots[g][4]==nil then lb.frames[var].Debuffs.groupSpots[g][4]=UI.CreateFrame("Text", "Duration" .. tostring(g), lb.frames[var].groupBF) end
		        if lb.frames[var].Debuffs.groupSpots[g][5]==nil then lb.frames[var].Debuffs.groupSpots[g][5]=UI.CreateFrame("Text", "DurationShadow" .. tostring(g), lb.frames[var].groupBF) end
		
		        lb.frames[var].Debuffs.groupSpotsIcons[g]={}
		        lb.frames[var].Debuffs.groupSpotsIcons[g][0]=false
		        lb.frames[var].Debuffs.groupSpotsIcons[g][1]="LifeBinder"
		        lb.frames[var].Debuffs.groupSpotsIcons[g][2]="Textures/buffhot2.png"
		        lb.frames[var].Debuffs.groupSpotsIcons[g][3]=0 --stacks
		        lb.frames[var].Debuffs.groupSpotsIcons[g][4]=false    --updated  (true if icon has just updated)
		        lb.frames[var].Debuffs.groupSpotsIcons[g][5]=nil    --Debuff spell ID     (used for remove Debuff )
		        lb.frames[var].Debuffs.groupSpotsIcons[g][6]=false    --is Debuff    true if the deDebuff applied is a deDebuff
		        lb.frames[var].Debuffs.groupSpotsIcons[g][7]=false    --is from whitelist
		        lb.frames[var].Debuffs.groupSpotsIcons[g][8]=acceptdeDebuffs    --accepts DeDebuffs (true is this slot accepts deDebuffs
		        lb.frames[var].Debuffs.groupSpotsIcons[g][9]=false    --has duration
		        lb.frames[var].Debuffs.groupSpotsIcons[g][10]=1    --Debuff duration
		        lb.frames[var].Debuffs.groupSpotsIcons[g][11]=0   --timeframe of the moment this Debuff was set
		        lb.frames[var].Debuffs.groupSpotsIcons[g][12]=0   --current duration displayed
		        
		        
		        local iconl=iconWidth
		        if iconHeight<iconWidth then
		        	iconl=iconHeight
		        end
		        local fontfile="fonts/AriBlk.ttf"
		        local fontsize=12
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetTexture(lb.frames[var].Debuffs.groupSpotsIcons[g][1],lb.frames[var].Debuffs.groupSpotsIcons[g][2] )
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetPoint(Point1, lb.frames[var].groupBF, Point2, lt,  tp )
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetHeight(iconl)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetWidth(iconl)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetLayer(5)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][0])
		
		        lb.frames[var].Debuffs.groupSpots[g][2]:SetPoint("CENTER", lb.frames[var].Debuffs.groupSpots[g][1], "CENTER", -5, -7 )
		        lb.frames[var].Debuffs.groupSpots[g][2]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].Debuffs.groupSpots[g][2]:SetFontColor(1,1,1,1)
		        lb.frames[var].Debuffs.groupSpots[g][2]:SetFontSize(fontsize)
		        lb.frames[var].Debuffs.groupSpots[g][2]:SetText(tostring(lb.frames[var].Debuffs.groupSpotsIcons[g][3]))
		        lb.frames[var].Debuffs.groupSpots[g][2]:SetLayer(7)
		        if lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].Debuffs.groupSpots[g][2]:SetVisible(false) end
		
		        lb.frames[var].Debuffs.groupSpots[g][3]:SetPoint("CENTER", lb.frames[var].Debuffs.groupSpots[g][2], "CENTER",2, 2 )
		        lb.frames[var].Debuffs.groupSpots[g][3]:SetFont("LifeBinder",fontfile)
		       --lb.frames[var].Debuffs.groupSpots[g][3]:SetBackgroundColor(1,0,0,1)
		        lb.frames[var].Debuffs.groupSpots[g][3]:SetFontColor(0,0,0,1)
		        lb.frames[var].Debuffs.groupSpots[g][3]:SetFontSize(fontsize)
		        lb.frames[var].Debuffs.groupSpots[g][3]:SetText(tostring(lb.frames[var].Debuffs.groupSpotsIcons[g][3]))
		        lb.frames[var].Debuffs.groupSpots[g][3]:SetLayer(6)
		        if lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].Debuffs.groupSpots[g][3]:SetVisible(false) end
		        
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetPoint("CENTER", lb.frames[var].Debuffs.groupSpots[g][1], "CENTER",2, 7)
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetFontColor(1,1,1,1)
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetFontSize(fontsize)
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetText("")
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetLayer(7)
		        if lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].Debuffs.groupSpots[g][4]:SetVisible(false) end
		        
		        lb.frames[var].Debuffs.groupSpots[g][5]:SetPoint("CENTER", lb.frames[var].Debuffs.groupSpots[g][4], "CENTER",2, 2)
		        lb.frames[var].Debuffs.groupSpots[g][5]:SetFont("LifeBinder",fontfile)
		        lb.frames[var].Debuffs.groupSpots[g][5]:SetFontColor(0,0,0,1)
		       -- lb.frames[var].Debuffs.groupSpots[g][5]:SetBackgroundColor(1,0,0,1)
		        lb.frames[var].Debuffs.groupSpots[g][5]:SetFontSize(fontsize)
		        lb.frames[var].Debuffs.groupSpots[g][5]:SetText("")
		        lb.frames[var].Debuffs.groupSpots[g][5]:SetLayer(6)
		        if lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 then  lb.frames[var].Debuffs.groupSpots[g][5]:SetVisible(false) end
		      
		        
		        lb.frames[var].Debuffs.groupSpots[g][4]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][9])
			end
		end
    
end





function lb.debuffMonitor.relocateDebuffMonitorSlots()
--print ( lb.debuffMonitor.slotscount )
   local scalex=1--lbValues.mainwidth*0.009009009
	local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
		    for g= 1,  lb.debuffMonitor.slotscount do
		    
		       local lt=lbDebuffSlotOptions[lbValues.set][g][3]*scalex
		       local tp=lbDebuffSlotOptions[lbValues.set][g][4]*scaley
		       local Point1=lbDebuffSlotOptions[lbValues.set][g][1]
		       local Point2=lbDebuffSlotOptions[lbValues.set][g][2]
		       
		        
		        local iconwidth=16*scalex
		        local iconheight=16*scaley
		        local iconl=iconwidth
		        if iconheight<iconwidth then
		        	iconl=iconheight
		        end
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetPoint(Point1, lb.frames[var].groupBF, Point2, lt,  tp )
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetHeight(iconl)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetWidth(iconl)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetLayer(5)
	
		   
	    	end
    	end
    end
end

function lb.debuffMonitor.relocateSingleDebuffMonitorSlot(index)
--print ( lb.debuffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
	   
	   if lb.UnitsTableStatus[var][12]then 
	       local lt=lbDebuffSlotOptions[lbValues.set][index][3]*scalex
	       local tp=lbDebuffSlotOptions[lbValues.set][index][4]*scaley
	       local Point1=lbDebuffSlotOptions[lbValues.set][index][1]
	       local Point2=lbDebuffSlotOptions[lbValues.set][index][2]
	       
	        
	        local iconwidth=16*scalex
	        local iconheight=16*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetPoint(Point1, lb.frames[var].groupBF, Point2, lt,  tp )
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetHeight(iconl)
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetWidth(iconl)
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetLayer(5)

	   	end
    end
end

function lb.debuffMonitor.showDummyDebuffMonitorSlots()
--print ( lb.debuffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	 		for g= 1,  lb.debuffMonitor.slotscount do
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetBackgroundColor(0,0,0,1)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetVisible(true)
		    end  	   
	    end
    end
end
function lb.debuffMonitor.hideDummyDebuffMonitorSlots()
--print ( lb.debuffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	 		for g= 1,  lb.debuffMonitor.slotscount do
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetBackgroundColor(0,0,0,0)
		        lb.frames[var].Debuffs.groupSpots[g][1]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][0])
		    end  	   
	    end
    end
end
function lb.debuffMonitor.showSingleDummDebuffMonitorSlot(index)
--print ( lb.debuffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetBackgroundColor(0,0,0,1)
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetVisible(true)
		end	        	   
    end
end
function lb.debuffMonitor.hideSingleDummyDebuffMonitorSlot(index)
--print ( lb.debuffMonitor.slotscount )
 local scalex=1--lbValues.mainwidth*0.009009009
 local scaley=1--lbValues.mainheight*0.023255814
 	for var=1,20 do
 		if lb.UnitsTableStatus[var][12]then
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetBackgroundColor(0,0,0,0)
	        lb.frames[var].Debuffs.groupSpots[index][1]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[var][index][0])
	    end
    end
end

function lb.debuffMonitor.updatedebuffMonitorTextures()
    for var=1,20 do
    	if lb.UnitsTableStatus[var][12]then
	        for g= 1,  lb.debuffMonitor.slotscount do
	
	            if lb.frames[var].Debuffs.groupSpotsIcons[g][4] then
	                --just updated
	                --print (lb.frames[var].Debuffs.groupSpotsIcons[g][3])
	                lb.frames[var].Debuffs.groupSpotsIcons[g][4]=false
	                lb.frames[var].Debuffs.groupSpots[g][1]:SetTexture(lb.frames[var].Debuffs.groupSpotsIcons[g][1],lb.frames[var].Debuffs.groupSpotsIcons[g][2] )
	                lb.frames[var].Debuffs.groupSpots[g][1]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][0])
	                --print (lb.frames[var].Debuffs.groupSpots[g][1]:GetVisible())
	
	                lb.frames[var].Debuffs.groupSpots[g][2]:SetText(tostring(lb.frames[var].Debuffs.groupSpotsIcons[g][3]))
	                if (lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 or lb.frames[var].Debuffs.groupSpotsIcons[g][3]==nil) and {lb.frames[var].Debuffs.groupSpotsIcons[g][0]} then
	                    --print("nostack")
	                    lb.frames[var].Debuffs.groupSpots[g][2]:SetVisible(false)
	                else
	                    -- print("stack")
	                    lb.frames[var].Debuffs.groupSpots[g][2]:SetVisible(true)
	                end
	
	                lb.frames[var].Debuffs.groupSpots[g][3]:SetFontColor(0,0,0,1)
	                lb.frames[var].Debuffs.groupSpots[g][3]:SetText(tostring(lb.frames[var].Debuffs.groupSpotsIcons[g][3]))
	                
	                if (lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 or lb.frames[var].Debuffs.groupSpotsIcons[g][3]==nil) and {lb.frames[var].Debuffs.groupSpotsIcons[g][0]} then
	                    lb.frames[var].Debuffs.groupSpots[g][3]:SetVisible(false)
	                else
	                    lb.frames[var].Debuffs.groupSpots[g][3]:SetVisible(true)
	                end
	                
	                lb.frames[var].Debuffs.groupSpots[g][4]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][9])
	                lb.frames[var].Debuffs.groupSpots[g][5]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][9])
	            end
	        end
	    end
    end
end
function lb.debuffMonitor.updatedebuffMonitorTexturesIndex(frameindex,slotindex)

		if lb.UnitsTableStatus[frameindex][12]then
            if lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4] then
                --just updated
                --print (lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3])
                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4]=false
                lb.frames[frameindex].Debuffs.groupSpots[slotindex][1]:SetTexture(lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][1],lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][2] )
                lb.frames[frameindex].Debuffs.groupSpots[slotindex][1]:SetVisible(lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][0])
                --print (lb.frames[frameindex].Debuffs.groupSpots[slotindex][1]:GetVisible())

                lb.frames[frameindex].Debuffs.groupSpots[slotindex][2]:SetText(tostring(lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]))
                if (lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]==0 or lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]==nil) and {lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][0]} then
                    --print("nostack")
                    lb.frames[frameindex].Debuffs.groupSpots[slotindex][2]:SetVisible(false)
                else
                    -- print("stack")
                    lb.frames[frameindex].Debuffs.groupSpots[slotindex][2]:SetVisible(true)
                end

                lb.frames[frameindex].Debuffs.groupSpots[slotindex][3]:SetFontColor(0,0,0,1)
                lb.frames[frameindex].Debuffs.groupSpots[slotindex][3]:SetText(tostring(lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]))
                
                if (lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]==0 or lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]==nil) and {lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][0]} then
                    lb.frames[frameindex].Debuffs.groupSpots[slotindex][3]:SetVisible(false)
                else
                    lb.frames[frameindex].Debuffs.groupSpots[slotindex][3]:SetVisible(true)
                end
                --print()
                lb.frames[frameindex].Debuffs.groupSpots[slotindex][4]:SetVisible(lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][9])
                lb.frames[frameindex].Debuffs.groupSpots[slotindex][5]:SetVisible(lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][9])
            end
       end

end
function lb.debuffMonitor.resetdebuffMonitorTextures()
    for var=1,20 do
    	
    	lb.debuffMonitor.resetDebuffMonitorTexturesForIndex(var)
    end
end
function lb.debuffMonitor.resetDebuffMonitorTexturesForIndex(var)
	if lb.UnitsTableStatus[var][12]then
		
        for g= 1,  lb.debuffMonitor.slotscount do
	
				
	            if lb.frames[var].Debuffs.groupSpotsIcons[g][0] then
	
		            lb.frames[var].Debuffs.groupSpotsIcons[g][0]=false
		            
		            --print (lb.frames[var].Debuffs.groupSpotsIcons[g][0])
		            lb.frames[var].Debuffs.groupSpotsIcons[g][4]=false
		            lb.frames[var].Debuffs.groupSpotsIcons[g][9]=false
		            lb.frames[var].Debuffs.groupSpotsIcons[g][3]=0
		            lb.frames[var].Debuffs.groupSpots[g][1]:SetTexture(lb.frames[var].Debuffs.groupSpotsIcons[g][1],lb.frames[var].Debuffs.groupSpotsIcons[g][2] )
		            
		            lb.frames[var].Debuffs.groupSpots[g][1]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][0])
		
		            lb.frames[var].Debuffs.groupSpots[g][2]:SetText(tostring(lb.frames[var].Debuffs.groupSpotsIcons[g][3]))
		            if (lb.frames[var].Debuffs.groupSpotsIcons[g][3]==0 or lb.frames[var].Debuffs.groupSpotsIcons[g][3]==nil) and {lb.frames[var].Debuffs.groupSpotsIcons[g][0]} then
		                lb.frames[var].Debuffs.groupSpots[g][2]:SetVisible(false)
		                lb.frames[var].Debuffs.groupSpots[g][3]:SetVisible(false)
		            else
		                lb.frames[var].Debuffs.groupSpots[g][2]:SetVisible(true)
		                lb.frames[var].Debuffs.groupSpots[g][3]:SetVisible(true)
		            end
		
		            lb.frames[var].Debuffs.groupSpots[g][3]:SetFontColor(0,0,0,1)
		            lb.frames[var].Debuffs.groupSpots[g][3]:SetText(tostring(lb.frames[var].Debuffs.groupSpotsIcons[g][3]))
		       
		            lb.frames[var].Debuffs.groupSpots[g][4]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][9])
		            lb.frames[var].Debuffs.groupSpots[g][5]:SetVisible(lb.frames[var].Debuffs.groupSpotsIcons[g][9])
	            end
            
        end
	end
end
function lb.debuffMonitor.updateDurations()
	local elapsed = now - lastdurationcheck
    if (elapsed < (.5)) then --half a second
        return 
    else
    	lastdurationcheck = now
    end
	local timer=lb.debuffMonitor.getDurationThrottle()
	if not timer then return end
	local now =timeFrame()
	 for var=1,20 do
	 	lb.debuffMonitor.updateDurationsOfIndex(i)
    end
end

function lb.debuffMonitor.updateDurationsOfIndex(index)
	
	
	local frames= lb.frames[index]
	local Debuffcount=lb.debuffMonitor.slotscount
 	if lb.UnitsTableStatus[index][5]~=nil and lb.UnitsTableStatus[index][5]~=0 and  lb.UnitsTableStatus[index][12]  then
        for g= 1,  Debuffcount do
        	
          if frames.Debuffs.groupSpotsIcons[g]~=nil then	
        	if frames.Debuffs.groupSpotsIcons[g][0] then
        		
	          
	            if frames.Debuffs.groupSpotsIcons[g][9] then
        		--has duration
	        		local stTime=frames.Debuffs.groupSpotsIcons[g][11]
	        		local duration =frames.Debuffs.groupSpotsIcons[g][10]
	        		local timeval=round(duration-now+stTime)
	        		
	        		if frames.Debuffs.groupSpotsIcons[g][12]~=timeval then
--	        			if timeval<=3 then
--		        				frames.Debuffs.groupSpots[g][4]:SetFontColor(1,0,0,1)
--		        		else
--		        				frames.Debuffs.groupSpots[g][4]:SetFontColor(1,1,1,1)
--		        		end
		        		if timeval<10 then
		        				frames.Debuffs.groupSpots[g][4]:SetText(tostring(timeval))
	        					frames.Debuffs.groupSpots[g][5]:SetText(tostring(timeval))
		        		else
		        				frames.Debuffs.groupSpots[g][4]:SetText("")
	        					frames.Debuffs.groupSpots[g][5]:SetText("")
		        		end
	        			frames.Debuffs.groupSpotsIcons[g][12]=timeval
	        		end
	        	else
	        		
	        	end
	        	 if frames.Debuffs.groupSpots[g][4]:GetVisible()~=frames.Debuffs.groupSpotsIcons[g][9] then 
		            
		            frames.Debuffs.groupSpots[g][4]:SetVisible(frames.Debuffs.groupSpotsIcons[g][9])
		            frames.Debuffs.groupSpots[g][5]:SetVisible(frames.Debuffs.groupSpotsIcons[g][9])
	            end
            end
          end
        end
    end
    
end

function lb.debuffMonitor.updateSpellTextures()
    local abilities
    abtextures={}
   
--    for v, k in pairs(lbSelectedDebuffsList) do
--        table.insert(abtextures,"Textures/Debuffhot.png")
--    end
    abilities =abilitylist()
    local abilitydets=abilitydetail(abilities)
    for dbName,c in pairs(lbDebuffWhitelist[lbValues.set]) do
        --print("txt"..tostring(s))
        found=false
        lb.FullDebuffsList[dbName ]=true
        for v, k in pairs(abilitydets) do
            if dbName==k.name and dbName~=nil then
                if k.icon ~=nil then
                    found=true
                    lb.iconsCache.addTextureToCache(dbName,"Rift",k.icon) -- the function controls automatically if the icon is present in the cache
                end
            end
        end
        if not found then
            lb.NoIconsDebuffList[dbName]=true
            --print (a)
        end
	
    end
    
end



function lb.debuffMonitor.onBuffAdd(unit, DebuffTable,frameindex)

        local name=DebuffTable.name
       -- print (name)
        if DebuffTable.debuff==nil then
            
        else
        	--adding deDebuff to the cache (if enabled)
        	if lbValues.CacheDeDebuffs then
                addDeDebuffToCache(DebuffTable)
            end
			--is a deDebuff so now we check if it's in a whitelist
			local debWCount = #(lbDebuffWhitelist[lbValues.set])
			local debBCount = #(lbDebuffBlackList[lbValues.set])
			--print (name)
			--dump(lbDebuffWhitelist[lbValues.set])
            if lbDebuffWhitelist[lbValues.set][name]~=nil then
				-- it's into the whitelist
                    local texture=nil
                    if lb.iconsCache.hasTextureInCache(name) then
                        texture= lb.iconsCache.getTextureFromCache(name)
                        --print("cache"..lb.iconsCache.getTextureFromCache(name)[2])
                    else
                        lb.iconsCache.addTextureToCache(name,"Rift",DebuffTable.icon)
                        texture={"Rift", DebuffTable.icon}
                        --print("added"..lb.iconsCache.getTextureFromCache(name)[2])
                    end
					local frame =lb.frames[frameindex]
					--now i search from the first deDebuff enable slot without a whitelisted deDebuff
					--used values
--			        lb.frames[var].Debuffs.groupSpotsIcons[g][6]=false    --is deDebuff    true if the deDebuff applied is a deDebuff
--			        lb.frames[var].Debuffs.groupSpotsIcons[g][7]=false    --is from whitelist
--			        lb.frames[var].Debuffs.groupSpotsIcons[g][8]=false    --accepts DeDebuffs (true is this slot accepts deDebuffs
					--print (#(frame.Debuffs.groupSpotsIcons))
					local slotscount=#(frame.Debuffs.groupSpotsIcons)
					for i = 1 , slotscount do
						--searching into the slots
						--print (frame.Debuffs.groupSpotsIcons[i][8])
						if frame.Debuffs.groupSpotsIcons[i][8] then
							--this slot accepts deDebuffs so i search if there is something
							if not frame.Debuffs.groupSpotsIcons[i][0] then
								--slot is empty so i add here my deDebuff
								--print(i)
								--print ("free")
								lb.frames[frameindex].Debuffs.groupSpotsIcons[i][0]=true
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][1]=texture[1]
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][2]=texture[2]
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][3]=DebuffTable.stack
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][4]=true
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][5]=DebuffTable.id
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][6]=true
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][7]=true
	                            if DebuffTable.duration~=nil then
	                            	lb.frames[frameindex].Debuffs.groupSpotsIcons[i][9]=true
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][10]=round(DebuffTable.duration)
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][11]=timeFrame()
	                            else
	                            	lb.frames[frameindex].Debuffs.groupSpotsIcons[i][9]=false
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][10]=1
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][11]=0
	                            end
	                            --print (lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4])
	                            lb.debuffMonitor.updatedebuffMonitorTexturesIndex(frameindex,i)
	                            updateDebuffs=true
	                            break
							else
								--print ("nonfree")
								-- the slot is full but now i check if is a low priority deDebuff
								if not frame.Debuffs.groupSpotsIcons[i][7] then
									lb.frames[frameindex].Debuffs.groupSpotsIcons[i][0]=true
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][1]=texture[1]
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][2]=texture[2]
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][3]=DebuffTable.stack
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][4]=true
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][5]=DebuffTable.id
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][6]=true
		                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][7]=true
		                            if DebuffTable.duration~=nil then
		                            	lb.frames[frameindex].Debuffs.groupSpotsIcons[i][9]=true
		                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][10]=round(DebuffTable.duration)
		                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][11]=timeFrame()
		                            else
		                            	lb.frames[frameindex].Debuffs.groupSpotsIcons[i][9]=false
		                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][10]=1
		                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][11]=0
		                            end
		                            --print (lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4])
		                            lb.debuffMonitor.updatedebuffMonitorTexturesIndex(frameindex,i)
		                            updateDebuffs=true
		                            break
								end
							end
							
						end
					end
                  
			else
				--it's not in the whitelist so i check if it's on the blacklist
				if lbDebuffBlackList[name]~=nil then
					--I don't do anything because it's on the blacklist
				else
					local enable=false
					if lbDebuffOptions[lbValues.set].showCurableOnly then
						if DebuffTable.poison and lbDebuffOptions[lbValues.set].poison then
							enable=true
						end
						if DebuffTable.curse and lbDebuffOptions[lbValues.set].curse then
							enable=true
						end
						if DebuffTable.disease and lbDebuffOptions[lbValues.set].disease then
							enable=true
						end 
					else
						enable=true
					end
					if enable then
						--It's not on the blacklist so is a low priority deDebuff, it will be shown if an allowing-deDebuff slot is empty
						local texture=nil
	                    if lb.iconsCache.hasTextureInCache(name) then
	                        texture= lb.iconsCache.getTextureFromCache(name)
	                        --print("cache"..lb.iconsCache.getTextureFromCache(name)[2])
	                    else
	                        lb.iconsCache.addTextureToCache(name,"Rift",DebuffTable.icon)
	                        texture={"Rift", DebuffTable.icon}
	                        --print("added"..lb.iconsCache.getTextureFromCache(name)[2])
	                    end
						local slotscount=#(lb.frames[frameindex].Debuffs.groupSpotsIcons)
						for i = 1 , slotscount do
							
							--searching into the slots
							
							if not lb.frames[frameindex].Debuffs.groupSpotsIcons[i][0] then
								--slot is empty so i add here my Debuff
								--print(i)
								--print ("free")
								lb.frames[frameindex].Debuffs.groupSpotsIcons[i][0]=true
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][1]=texture[1]
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][2]=texture[2]
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][3]=DebuffTable.stack
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][4]=true
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][5]=DebuffTable.id
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][6]=true
	                            lb.frames[frameindex].Debuffs.groupSpotsIcons[i][7]=false
	                            if DebuffTable.duration~=nil then
	                            	lb.frames[frameindex].Debuffs.groupSpotsIcons[i][9]=true
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][10]=round(DebuffTable.duration)
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][11]=timeFrame()
	                            else
	                            	lb.frames[frameindex].Debuffs.groupSpotsIcons[i][9]=false
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][10]=1
	                                lb.frames[frameindex].Debuffs.groupSpotsIcons[i][11]=0
	                            end
	                            --print (lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4])
	                            lb.debuffMonitor.updatedebuffMonitorTexturesIndex(frameindex,i)
	                            updateDebuffs=true
	                            break
	
							end
								
							
						end
					end
				end
				
            end
            if updateDebuffs then
                --print(true)
                --lb.debuffMonitor.updatedebuffMonitorTextures()
            end
        end
    

end
function lb.debuffMonitor.onDebuffRemove(unit, debuffID,frameindex)
    --Debuffs=Debuffdetail(unit,Debuffs)
    --print ("remove")

    local Debuffcount=lb.debuffMonitor.slotscount

       -- for slotindex,c in pairs(lbSelectedDebuffsList[lbValues.set]) do
       
	        for slotindex= 1, Debuffcount do
	           
	            if lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][5]== debuffID then
	                --print (frameindex)
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][0]=false
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][3]=nil
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4]=true
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][5]=nil
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][9]=false
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][10]=1
	                lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][11]=0
					--print ("removedDebuff"..tostring(frameindex).."--"..tostring(slotindex))
	                lb.debuffMonitor.updatedebuffMonitorTexturesIndex(frameindex,slotindex)
	                --print ("rem"..lb.frames[frameindex].Debuffs.groupSpotsIcons[slotindex][4])
	                updateDebuffs=true
	            end
	        end
		
       -- end
      
        if updateDebuffs then
            --print(true)
            --lb.debuffMonitor.updatedebuffMonitorTextures()
        end
        return updateDebuffs

end


