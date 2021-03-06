function loadVariables(addonidentifier)
	if (addonidentifier ~= "LifeBinder") then return end
	
 	lastMode=-1
    if lbValues == nil then
        lbValues = {
	        addonState = true, 
	        windowstate = true, 
	        lockedState = false, 
	        font = 16, 
	        pet = false, 
	        texture = "bars/health.png", 
	        set = 1, 
	        hotwatch = true,
	        debuffwatch = true, 
	        rolewatch = true, 
	        showtooltips = true,
	        CacheDebuffs=false,
	        CurrentStyle="standard",
	        AddonDisabled=false,
        }


        lbValues.locmainx = ((UIParent:GetRight() / 2) - 150)
        lbValues.locmainy = ((UIParent:GetBottom() / 2) - 250)
    end
    if lbValues.CacheDebuffs==nil then
        lbValues.CacheDebuffs=false
    end
     if lbValues.CurrentStyle==nil then
        lbValues.CurrentStyle="standard"
    end
	if lbValues.AddonDisabled==nil then
        lbValues.AddonDisabled=false
    end
    if lbValues.MaxRange==nil then
        lbValues.MaxRange=35*35
    end
	if lbDebuffCacheList==nil then
		lbDebuffCacheList={}
	end

    if lbMouseBinds == nil then
        lbMouseBinds ={}
        for i = 1,6 do
        	lbMouseBinds[i]={}
        	for g= 1,5 do
        		lbMouseBinds[i][g]={}
        		for h= 1,7 do
        			lbMouseBinds[i][g][h]={}	
        		end
        	end
        end
    end
   if lbCustomNamesList==nil then
       lbCustomNamesList={}
   end
   if lbSelectedBuffsList == nil then
        lbSelectedBuffsList ={}
        lbSelectedBuffsList[1]=
        {
        	{
        		--it's a subtable, because, who knows how i will change in the future, it can be The one table that controls them all, the one ring table
        		{ --buff names set for that slot

        		}
        	},
        	{{}},
        	{{}},
        	{{}},
        	{{}},
        	{{}},
        	{{}},
        	{{}},
        }
        
        lbSelectedBuffsList[2]={{{}},{{}},{{}},{{}},{{}},{{}},{{}},{{}}}
        lbSelectedBuffsList[3]={{{}},{{}},{{}},{{}},{{}},{{}},{{}},{{}}}
        lbSelectedBuffsList[4]={{{}},{{}},{{}},{{}},{{}},{{}},{{}},{{}}}
        lbSelectedBuffsList[5]={{{}},{{}},{{}},{{}},{{}},{{}},{{}},{{}}}
        lbSelectedBuffsList[6]={{{}},{{}},{{}},{{}},{{}},{{}},{{}},{{}}}
    end
    if lbDebuffWhitelist == nil then
        lbDebuffWhitelist ={}
        for i = 1,6 do
        	lbDebuffWhitelist[i]={
				["Aura of Decay"] = {castByMe = false},
				Cocooned = {castByMe = false},
				["Heat Index"] = {castByMe = false},
				["Hot Tar"] = {castByMe = false},
				["Poisonous Spray"] = {castByMe = false},
				["Timeless Void"] = {castByMe = false}	
			}
        end
    end
    if lbDebuffBlackList == nil then
        lbDebuffBlackList ={}
        for i = 1,6 do
        	lbDebuffBlackList[i]={["Critter Killer"] = {castByMe = false},["Looking for Group Cooldown"] = {castByMe = false}}
        end
    end
    if lbDebuffOptions == nil then
        lbDebuffOptions ={}        
    end
    --slot position info, separated from the slot options because i only load this once 
    --can be more or less slots, but default will be 8 and the style will be X style
    if lbBuffSlotOptions==nil then
    	lbBuffSlotOptions={}
    	for i = 1 , 6 do
    		lbBuffSlotOptions[i]={}
    		for g = 1 , #(lbPredefinedBuffSlotPos[1]) do
    			lbBuffSlotOptions[i][g]={}
    			for h=1,#(lbPredefinedBuffSlotPos[1][g]) do 
    				lbBuffSlotOptions[i][g][h]=lbPredefinedBuffSlotPos[1][g][h] --set the slot to the x style definition for that slot
    			end
    		end
    	end
    end
    
     if lbDebuffSlotOptions==nil then
    	lbDebuffSlotOptions={}
    	for i = 1 , 6 do
    		lbDebuffSlotOptions[i]={}
    		for g = 1 , #(lbPredefinedDebuffSlotPos[1]) do
    			lbDebuffSlotOptions[i][g]={}
    			for h=1,#(lbPredefinedDebuffSlotPos[1][g]) do 
    				lbDebuffSlotOptions[i][g][h]=lbPredefinedDebuffSlotPos[1][g][h] --set the slot to the x style definition for that slot
    			end
    		end
    	end
    	
    end
   
    --Buffs List (deprecated)
    if lbBuffList == nil then
        lbBuffList ={}
        lbBuffList[1]={ }
        lbBuffList[2]={ }
        lbBuffList[3]={ }
        lbBuffList[4]={ }
        lbBuffList[5]={ }
        lbBuffList[6]={ }
    end
    
    if lbCallingColors == nil then
        lbCallingColors = {{r = 1, g = 0, b = 0}, {r = 0, g = 1, b = 0}, {r = 0.6, g = 0.2, b = 0.8}, {r = 1, g = 1, b = 0}, {r = 1, g = 1, b = 1}}
    end
    if lbValues.hotwatch == nil then lbValues.hotwatch = true end
    if lbValues.debuffwatch == nil then lbValues.debuffwatch = true end
    if lbValues.rolewatch == nil then lbValues.rolewatch = true end
    if lbValues.showtooltips == nil then lbValues.showtooltips = true end

	if lbStylesOptions==nil then
		lbStylesOptions={}
	end
	
    lbValues.islocked=false
    lb.isincombat=false
    lbValues.set=nil
    lb.EnableStarterCycle() --start wait for player cycle
   
end




