--
--Buff Monitor
--
local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitylist = _G.Inspect.Ability.List
local abilitydetail = _G.Inspect.Ability.Detail
local buffdetail=   _G.Inspect.Buff.Detail
local bufflist=   _G.Inspect.Buff.List
local timeFrame=_G.Inspect.Time.Frame
lb.buffMonitor={}
lb.FullBuffsList={}     -- used by buffmonitor
lb.FullDeBuffsList={}    -- used by buffmonitor
local lastdurationcheck=0

function lb.buffMonitor.getDurationThrottle()
    local now =  timeFrame()
    local elapsed = now - lastdurationcheck
    if (elapsed >= (.5)) then --half a second
        lastdurationcheck = now
        return true
    end
end

function lb.buffMonitor.initializeBuffMonitor()
--print (#(lbBuffSlotPositions[lbValues.set]) )
	
 	for var=1,20 do
	    for g= 1, #(lbBuffSlotPositions[lbValues.set]) do
	       local scalex=lbValues.mainwidth*0.009009009
	       local scaley=lbValues.mainheight*0.023255814
	       local lt=lbBuffSlotPositions[lbValues.set][g][3]*scalex
	       local tp=lbBuffSlotPositions[lbValues.set][g][4]*scaley
	       local Point1=lbBuffSlotPositions[lbValues.set][g][1]
	       local Point2=lbBuffSlotPositions[lbValues.set][g][2]
	       
	        
	        local iconwidth=16--*scalex
	        local iconheight=16--*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	        local fontfile="fonts/AriBlk.ttf"
	        local fontsize=12
	        lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
	        lb.groupHoTSpots[var][g][1]:SetPoint(Point1, lb.groupBF[var], Point2, lt,  tp )
	        lb.groupHoTSpots[var][g][1]:SetHeight(iconl)
	        lb.groupHoTSpots[var][g][1]:SetWidth(iconl)
	        lb.groupHoTSpots[var][g][1]:SetLayer(5)
	        lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])
	
	        lb.groupHoTSpots[var][g][2]:SetPoint("CENTER", lb.groupHoTSpots[var][g][1], "CENTER", -5, -7 )
	        lb.groupHoTSpots[var][g][2]:SetFont("LifeBinder",fontfile)
	        lb.groupHoTSpots[var][g][2]:SetFontColor(1,1,1,1)
	        lb.groupHoTSpots[var][g][2]:SetFontSize(fontsize)
	        lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
	        lb.groupHoTSpots[var][g][2]:SetLayer(7)
	        if lb.groupHoTSpotsIcons[var][g][3]==0 then  lb.groupHoTSpots[var][g][2]:SetVisible(false) end
	
	        lb.groupHoTSpots[var][g][3]:SetPoint("CENTER", lb.groupHoTSpots[var][g][2], "CENTER",2, 2 )
	        lb.groupHoTSpots[var][g][3]:SetFont("LifeBinder",fontfile)
	       --lb.groupHoTSpots[var][g][3]:SetBackgroundColor(1,0,0,1)
	        lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
	        lb.groupHoTSpots[var][g][3]:SetFontSize(fontsize)
	        lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
	        lb.groupHoTSpots[var][g][3]:SetLayer(6)
	        if lb.groupHoTSpotsIcons[var][g][3]==0 then  lb.groupHoTSpots[var][g][3]:SetVisible(false) end
	        
	        lb.groupHoTSpots[var][g][4]:SetPoint("CENTER", lb.groupHoTSpots[var][g][1], "CENTER",0, 7)
	        lb.groupHoTSpots[var][g][4]:SetFontColor(1,1,1,1)
	        lb.groupHoTSpots[var][g][4]:SetFont("LifeBinder",fontfile)
	        lb.groupHoTSpots[var][g][4]:SetFontSize(fontsize)
	        lb.groupHoTSpots[var][g][4]:SetText("12")
	        lb.groupHoTSpots[var][g][4]:SetLayer(7)
	        
	        lb.groupHoTSpots[var][g][5]:SetPoint("CENTER", lb.groupHoTSpots[var][g][4], "CENTER",2, 2)
	        lb.groupHoTSpots[var][g][5]:SetFont("LifeBinder",fontfile)
	        lb.groupHoTSpots[var][g][5]:SetFontColor(0,0,0,1)
	       -- lb.groupHoTSpots[var][g][5]:SetBackgroundColor(1,0,0,1)
	        lb.groupHoTSpots[var][g][5]:SetFontSize(fontsize)
	        lb.groupHoTSpots[var][g][5]:SetText("12")
	        lb.groupHoTSpots[var][g][5]:SetLayer(6)
	      
	        
	        lb.groupHoTSpots[var][g][4]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
    	end
    end
end

function lb.buffMonitor.relocateBuffMonitorSlots()
--print (#(lbBuffSlotPositions[lbValues.set]) )
   local scalex=lbValues.mainwidth*0.009009009
	local scaley=lbValues.mainheight*0.023255814
 	for var=1,20 do
	    for g= 1, #(lbBuffSlotPositions[lbValues.set]) do
	    
	       local lt=lbBuffSlotPositions[lbValues.set][g][3]*scalex
	       local tp=lbBuffSlotPositions[lbValues.set][g][4]*scaley
	       local Point1=lbBuffSlotPositions[lbValues.set][g][1]
	       local Point2=lbBuffSlotPositions[lbValues.set][g][2]
	       
	        
	        local iconwidth=16*scalex
	        local iconheight=16*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	        lb.groupHoTSpots[var][g][1]:SetPoint(Point1, lb.groupBF[var], Point2, lt,  tp )
	        lb.groupHoTSpots[var][g][1]:SetHeight(iconl)
	        lb.groupHoTSpots[var][g][1]:SetWidth(iconl)
	        lb.groupHoTSpots[var][g][1]:SetLayer(5)

	   
    	end
    end
end
function lb.buffMonitor.relocateSingleBuffMonitorSlot(index)
--print (#(lbBuffSlotPositions[lbValues.set]) )
 local scalex=lbValues.mainwidth*0.009009009
 local scaley=lbValues.mainheight*0.023255814
 	for var=1,20 do
	   
	      
	       local lt=lbBuffSlotPositions[lbValues.set][index][3]*scalex
	       local tp=lbBuffSlotPositions[lbValues.set][index][4]*scaley
	       local Point1=lbBuffSlotPositions[lbValues.set][index][1]
	       local Point2=lbBuffSlotPositions[lbValues.set][index][2]
	       
	        
	        local iconwidth=16*scalex
	        local iconheight=16*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	        lb.groupHoTSpots[var][index][1]:SetPoint(Point1, lb.groupBF[var], Point2, lt,  tp )
	        lb.groupHoTSpots[var][index][1]:SetHeight(iconl)
	        lb.groupHoTSpots[var][index][1]:SetWidth(iconl)
	        lb.groupHoTSpots[var][index][1]:SetLayer(5)

	   
    end
end

function lb.buffMonitor.updateBuffMonitorTextures()
    for var=1,20 do
        for g= 1, 10 do

            if lb.groupHoTSpotsIcons[var][g][4] then
                --just updated
                --print (lb.groupHoTSpotsIcons[var][g][3])
                lb.groupHoTSpotsIcons[var][g][4]=false
                lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
                lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])
                --print (lb.groupHoTSpots[var][g][1]:GetVisible())

                lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
                if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                    --print("nostack")
                    lb.groupHoTSpots[var][g][2]:SetVisible(false)
                else
                    -- print("stack")
                    lb.groupHoTSpots[var][g][2]:SetVisible(true)
                end

                lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
                lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
                
                if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                    lb.groupHoTSpots[var][g][3]:SetVisible(false)
                else
                    lb.groupHoTSpots[var][g][3]:SetVisible(true)
                end
                
                lb.groupHoTSpots[var][g][4]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
                lb.groupHoTSpots[var][g][5]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
            end
        end
    end
end
function lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,slotindex)


            if lb.groupHoTSpotsIcons[frameindex][slotindex][4] then
                --just updated
                --print (lb.groupHoTSpotsIcons[frameindex][slotindex][3])
                lb.groupHoTSpotsIcons[frameindex][slotindex][4]=false
                lb.groupHoTSpots[frameindex][slotindex][1]:SetTexture(lb.groupHoTSpotsIcons[frameindex][slotindex][1],lb.groupHoTSpotsIcons[frameindex][slotindex][2] )
                lb.groupHoTSpots[frameindex][slotindex][1]:SetVisible(lb.groupHoTSpotsIcons[frameindex][slotindex][0])
                --print (lb.groupHoTSpots[frameindex][slotindex][1]:GetVisible())

                lb.groupHoTSpots[frameindex][slotindex][2]:SetText(tostring(lb.groupHoTSpotsIcons[frameindex][slotindex][3]))
                if (lb.groupHoTSpotsIcons[frameindex][slotindex][3]==0 or lb.groupHoTSpotsIcons[frameindex][slotindex][3]==nil) and {lb.groupHoTSpotsIcons[frameindex][slotindex][0]} then
                    --print("nostack")
                    lb.groupHoTSpots[frameindex][slotindex][2]:SetVisible(false)
                else
                    -- print("stack")
                    lb.groupHoTSpots[frameindex][slotindex][2]:SetVisible(true)
                end

                lb.groupHoTSpots[frameindex][slotindex][3]:SetFontColor(0,0,0,1)
                lb.groupHoTSpots[frameindex][slotindex][3]:SetText(tostring(lb.groupHoTSpotsIcons[frameindex][slotindex][3]))
                
                if (lb.groupHoTSpotsIcons[frameindex][slotindex][3]==0 or lb.groupHoTSpotsIcons[frameindex][slotindex][3]==nil) and {lb.groupHoTSpotsIcons[frameindex][slotindex][0]} then
                    lb.groupHoTSpots[frameindex][slotindex][3]:SetVisible(false)
                else
                    lb.groupHoTSpots[frameindex][slotindex][3]:SetVisible(true)
                end
                --print()
                lb.groupHoTSpots[frameindex][slotindex][4]:SetVisible(lb.groupHoTSpotsIcons[frameindex][slotindex][9])
                lb.groupHoTSpots[frameindex][slotindex][5]:SetVisible(lb.groupHoTSpotsIcons[frameindex][slotindex][9])
            end

end
function lb.buffMonitor.resetBuffMonitorTextures()
    for var=1,20 do
        for g= 1, 10 do
            lb.groupHoTSpotsIcons[var][g][0]=false
            --print (lb.groupHoTSpotsIcons[var][g][0])
            lb.groupHoTSpotsIcons[var][g][4]=false
            lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
            lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])

            lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                lb.groupHoTSpots[var][g][2]:SetVisible(false)
            else
                lb.groupHoTSpots[var][g][2]:SetVisible(true)
            end

            lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
            lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
            

            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
                lb.groupHoTSpots[var][g][3]:SetVisible(false)
            else
                lb.groupHoTSpots[var][g][3]:SetVisible(true)
            end
            lb.groupHoTSpots[var][g][4]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
            lb.groupHoTSpots[var][g][5]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
        end
    end
end
function lb.buffMonitor.resetBuffMonitorTexturesForIndex(var)

        for g= 1, 10 do

            if lb.groupHoTSpotsIcons[var][g][0] then

	            lb.groupHoTSpotsIcons[var][g][0]=false
	            lb.groupHoTSpotsIcons[var][g][4]=true
	            --print (lb.groupHoTSpotsIcons[var][g][0])
	            lb.groupHoTSpotsIcons[var][g][4]=false
	            lb.groupHoTSpots[var][g][1]:SetTexture(lb.groupHoTSpotsIcons[var][g][1],lb.groupHoTSpotsIcons[var][g][2] )
	            lb.groupHoTSpots[var][g][1]:SetVisible(lb.groupHoTSpotsIcons[var][g][0])
	
	            lb.groupHoTSpots[var][g][2]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
	            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
	                lb.groupHoTSpots[var][g][2]:SetVisible(false)
	            else
	                lb.groupHoTSpots[var][g][2]:SetVisible(true)
	            end
	
	            lb.groupHoTSpots[var][g][3]:SetFontColor(0,0,0,1)
	            lb.groupHoTSpots[var][g][3]:SetText(tostring(lb.groupHoTSpotsIcons[var][g][3]))
	            
	
	            if (lb.groupHoTSpotsIcons[var][g][3]==0 or lb.groupHoTSpotsIcons[var][g][3]==nil) and {lb.groupHoTSpotsIcons[var][g][0]} then
	                lb.groupHoTSpots[var][g][3]:SetVisible(false)
	            else
	                lb.groupHoTSpots[var][g][3]:SetVisible(true)
	            end
	            lb.groupHoTSpots[var][g][4]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
	            lb.groupHoTSpots[var][g][5]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
            end
        end

end
function lb.buffMonitor.updateDurations()
	local timer=lb.buffMonitor.getDurationThrottle()
	if not timer then return end
	local now =timeFrame()
	 for var=1,20 do
	 	if lb.UnitsTableStatus[var][5]~=nil and lb.UnitsTableStatus[var][5]~=0 then
	        for g= 1, 10 do
	        	
	        	
	        	if lb.groupHoTSpotsIcons[var][g][0] then
	        		
		            
		            if lb.groupHoTSpotsIcons[var][g][9] then
	        		--has duration
		        		local stTime=lb.groupHoTSpotsIcons[var][g][11]
		        		local duration =lb.groupHoTSpotsIcons[var][g][10]
		        		local timeval=round(duration-now+stTime)
		        		if lb.groupHoTSpotsIcons[var][g][12]~=timeval then
		        		if timeval<=3 then
		        				lb.groupHoTSpots[index][g][4]:SetFontColor(1,0,0,1)
		        			else
		        				lb.groupHoTSpots[index][g][4]:SetFontColor(1,1,1,1)
		        			end
		        			lb.groupHoTSpots[var][g][4]:SetText(tostring(timeval))
		        			lb.groupHoTSpots[var][g][5]:SetText(tostring(timeval))
		        		end
		        		lb.groupHoTSpotsIcons[var][g][12]=timeval
		        	else
		        		
		        	end
		        	if lb.groupHoTSpots[var][g][4]:GetVisible()~=lb.groupHoTSpotsIcons[var][g][9] then 
			            
			            lb.groupHoTSpots[var][g][4]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
			            lb.groupHoTSpots[var][g][5]:SetVisible(lb.groupHoTSpotsIcons[var][g][9])
		            end
	            end
	        end
	    end
    end
end

function lb.buffMonitor.updateDurationsOfIndex(index)
	
	local now =timeFrame()
	
 	if lb.UnitsTableStatus[index][5]~=nil and lb.UnitsTableStatus[index][5]~=0 then
        for g= 1, 10 do
        	
        	
        	if lb.groupHoTSpotsIcons[index][g][0] then
        		
	           
	            if lb.groupHoTSpotsIcons[index][g][9] then
        		--has duration
	        		local stTime=lb.groupHoTSpotsIcons[index][g][11]
	        		local duration =lb.groupHoTSpotsIcons[index][g][10]
	        		local timeval=round(duration-now+stTime)
	        		
	        		if lb.groupHoTSpotsIcons[index][g][12]~=timeval then
	        			if timeval<=3 then
		        				lb.groupHoTSpots[index][g][4]:SetFontColor(1,0,0,1)
		        		else
		        				lb.groupHoTSpots[index][g][4]:SetFontColor(1,1,1,1)
		        		end
		        		if timeval<10 then
		        				lb.groupHoTSpots[index][g][4]:SetText(tostring(timeval))
	        					lb.groupHoTSpots[index][g][5]:SetText(tostring(timeval))
		        		else
		        				lb.groupHoTSpots[index][g][4]:SetText("")
	        					lb.groupHoTSpots[index][g][5]:SetText("")
		        		end
	        			lb.groupHoTSpotsIcons[index][g][12]=timeval
	        		end
	        	else
	        		
	        	end
	        	 if lb.groupHoTSpots[index][g][4]:GetVisible()~=lb.groupHoTSpotsIcons[index][g][9] then 
		            
		            lb.groupHoTSpots[index][g][4]:SetVisible(lb.groupHoTSpotsIcons[index][g][9])
		            lb.groupHoTSpots[index][g][5]:SetVisible(lb.groupHoTSpotsIcons[index][g][9])
	            end
            end
        end
    end
    
end
function lb.buffMonitor.updateSpellTextures()
    local abilities
    abtextures={}
    for v, k in pairs(lbSelectedBuffsList) do
        table.insert(abtextures,"Textures/buffhot.png")
    end
    abilities =abilitylist()
    abilitydets=abilitydetail(abilities)
    for d,c in pairs(lbSelectedBuffsList[lbValues.set]) do
        --c={"Soothing Stream", "Healing Current","Healing Flood" }
         
        for j,m in pairs(c) do
        
	        for s,a in pairs(m) do
	            --a="Soothing Stream" ....
	            --print("txt"..tostring(a))
	            found=false
	           
	            lb.FullBuffsList[a]=true
	            for v, k in pairs(abilitydets) do
	                if a==k.name and a~=nil then
	                    if k.icon ~=nil then
	                        found=true
	                        lb.iconsCache.addTextureToCache(a,"Rift",k.icon) -- the function controls automatically if the icon is present in the cache
	                    end
	                end
	            end
	            if not found then
	                lb.NoIconsBuffList[a]=true
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
                if buffTable.caster== lb.PlayerID then
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
                        --c={"Soothing Stream", "Healing Current","Healing Flood" }
                         for j,m in pairs(c) do
	                        for s,a in pairs(m) do
	                            --a="Soothing Stream" ....
	                            if a==name and a~=nil then
	                                --print (frameindex)
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][0]=true
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][1]=texture[1]
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][2]=texture[2]
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][3]=buffTable.stack
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][4]=true
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][5]=buffTable.id
	                                lb.groupHoTSpotsIcons[frameindex][slotindex][6]=false
	                                if buffTable.duration~=nil then
	                                	lb.groupHoTSpotsIcons[frameindex][slotindex][9]=true
		                                lb.groupHoTSpotsIcons[frameindex][slotindex][10]=round(buffTable.duration)
		                                lb.groupHoTSpotsIcons[frameindex][slotindex][11]=timeFrame()
	                                else
	                                	lb.groupHoTSpotsIcons[frameindex][slotindex][9]=false
		                                lb.groupHoTSpotsIcons[frameindex][slotindex][10]=1
		                                lb.groupHoTSpotsIcons[frameindex][slotindex][11]=0
	                                end
	                                --print (lb.groupHoTSpotsIcons[frameindex][slotindex][4])
	                                lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,slotindex)
	                                updatebuffs=true
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

            if lbValues.CacheDebuffs then
                addDebuffToCache(buffTable)
            end
            if lb.FullDeBuffsList[name]~=nil then

                    local texture=nil
                    if lb.iconsCache.hasTextureInCache(name) then
                        texture= lb.iconsCache.getTextureFromCache(name)
                        --print("cache"..lb.iconsCache.getTextureFromCache(name)[2])
                    else
                        lb.iconsCache.addTextureToCache(name,"Rift",buffTable.icon)
                        texture={"Rift", buffTable.icon}
                        --print("added"..lb.iconsCache.getTextureFromCache(name)[2])
                    end

                    for slotindex,c in pairs(lbDeBuffList[lbValues.set]) do
                        --c="Soothing Stream" ....
                        if c==name and c~=nil then
                            --print (frameindex)
                            lb.groupHoTSpotsIcons[frameindex][5][0]=true
                            lb.groupHoTSpotsIcons[frameindex][5][1]=texture[1]
                            lb.groupHoTSpotsIcons[frameindex][5][2]=texture[2]
                            lb.groupHoTSpotsIcons[frameindex][5][3]=buffTable.stack
                            lb.groupHoTSpotsIcons[frameindex][5][4]=true
                            lb.groupHoTSpotsIcons[frameindex][5][5]=buffTable.id
                            lb.groupHoTSpotsIcons[frameindex][5][6]=true
                            if buffTable.duration~=nil then
                            	lb.groupHoTSpotsIcons[frameindex][slotindex][9]=true
                                lb.groupHoTSpotsIcons[frameindex][slotindex][10]=round(buffTable.duration)
                                lb.groupHoTSpotsIcons[frameindex][slotindex][11]=timeFrame()
                            else
                            	lb.groupHoTSpotsIcons[frameindex][slotindex][9]=false
                                lb.groupHoTSpotsIcons[frameindex][slotindex][10]=1
                                lb.groupHoTSpotsIcons[frameindex][slotindex][11]=0
                            end
                            --print (lb.groupHoTSpotsIcons[frameindex][slotindex][4])
                            lb.buffMonitor.updateBuffMonitorTexturesIndex(frameindex,5)
                            updatebuffs=true



                        end
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
    if frameindex==nil then return end
    local updatebuffs=false
    for buffID,placeholder in pairs(buffs) do
       -- for slotindex,c in pairs(lbSelectedBuffsList[lbValues.set]) do
        for slotindex= 1, 10 do
            --print (tostring(slotindex)..tostring(buffID))
            if lb.groupHoTSpotsIcons[frameindex][slotindex][5]== buffID then
                --print (frameindex)
                lb.groupHoTSpotsIcons[frameindex][slotindex][0]=false
                lb.groupHoTSpotsIcons[frameindex][slotindex][3]=nil
                lb.groupHoTSpotsIcons[frameindex][slotindex][4]=true
                lb.groupHoTSpotsIcons[frameindex][slotindex][5]=nil
                lb.groupHoTSpotsIcons[frameindex][slotindex][9]=false
                lb.groupHoTSpotsIcons[frameindex][slotindex][10]=1
                lb.groupHoTSpotsIcons[frameindex][slotindex][11]=0
                local buffs= bufflist(unit)

                local newbuffsdetails=buffdetail(unit,buffs)

                if lb.groupHoTSpotsIcons[frameindex][slotindex][6] then
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
                --print ("rem"..lb.groupHoTSpotsIcons[frameindex][slotindex][4])
                updatebuffs=true
            end
        end

       -- end
        for i,debuffname in pairs(lbDeBuffList[lbValues.set]) do
            --c={"Soothing Stream", "Healing Current","Healing Flood" }
            --print (tostring(slotindex)..tostring(buffID))
            if lb.groupHoTSpotsIcons[frameindex][5][5]== buffID then
                --print (frameindex)
                lb.groupHoTSpotsIcons[frameindex][5][0]=false
                lb.groupHoTSpotsIcons[frameindex][5][3]=nil
                lb.groupHoTSpotsIcons[frameindex][5][4]=true
                lb.groupHoTSpotsIcons[frameindex][5][5]=nil
--                lb.groupHoTSpotsIcons[frameindex][5][9]=false
--                lb.groupHoTSpotsIcons[frameindex][5][10]=1
--                lb.groupHoTSpotsIcons[frameindex][5][11]=0
                --print ("rem"..lb.groupHoTSpotsIcons[frameindex][slotindex][4])
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


