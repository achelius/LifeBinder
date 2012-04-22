local stTable=lb.styles["standard"]
local optionsTable=nil

stTable.importer={}
--what it does
--loads the old settings automatically creating role profiles and default layouts based on the style options
--problems:
--how to detect old style options (probably reading the tables of the optionstable)
--create a list of the options to convert:

--mousebinds from 
--buff slots positions
--debuff slots positions
--slots associations


--creating something that stops future conversions
function stTable.importer.initializeImporter()
	if optionsTable==nil then optionsTable=stTable.options end
		--print(stTable.getLayoutTable().buffs)
	if optionsTable.frameHeight~=nil then
		--last version settings
		stTable.importer.copySettings()
	end
end

function stTable.importer.copySettings()
	local tempsettings={}
	lb.copyTable(optionsTable,tempsettings)
	for key,value in pairs(optionsTable) do
		optionsTable[key]=nil
	end
	print ("Deleted old settings")
	if optionsTable.profileChanger==nil then
		print("creating profiles changer table")
		optionsTable.profileChanger={}
	 	optionsTable.profileChanger.rules={}
	 	for i = 1,6 do
	 		table.insert(optionsTable.profileChanger.rules, stTable.profileChanger.createRoleRuleTable(i,"Role"..tostring(i)))
	 	end
	end
	--stTable.createProfile("default",nil,true)
	
	for i = 1,6 do
		local profname="Role"..tostring(i)
		local mouseBindsTable=lbMouseBinds[i] --mouse binds old table
		local debwhitelist=lbDebuffWhitelist[i] --debuff whitelist
		local debblacklist=lbDebuffBlackList[i] --debuff whitelist
		local debopt=lbDebuffOptions[i] --debuff whitelist
		local debslotopt=lbDebuffSlotOptions[i] --debuff slots options
		local bufslotopt=lbBuffSlotOptions[i] --buff slots options
		local buffassoc=lbSelectedBuffsList[i] --buff associations
		if optionsTable[profname]==nil then
			print("Creating profile"..tostring(profname))
			stTable.createProfile(profname,nil)--creates profile and activates it
		end
		
		local profileTable=stTable.getProfileTable(profname)
		local layoutTable=stTable.getLayoutTable(profname,"default")
		stTable.setMainWindowLocation(lbValues.locmainx,lbValues.locmainy,profname,"default")
		profileTable.common.mouseBinds={}
		lb.copyTable(mouseBindsTable,profileTable.common.mouseBinds)
		profileTable.common.debuffs={}
		profileTable.common.debuffs.priority={}
		lb.copyTable(debwhitelist,profileTable.common.debuffs.priority)
		profileTable.common.debuffs.blocked={}
		lb.copyTable(debblacklist,profileTable.common.debuffs.blocked)
		profileTable.common.debuffs.options={}
		if debopt~=nil then lb.copyTable(debopt,profileTable.common.debuffs.options) end 
		layoutTable.debuffs={}
		layoutTable.debuffs.slots={}
		lb.copyTable(debslotopt,layoutTable.debuffs.slots)
		layoutTable.buffs={}
		layoutTable.buffs.options={}
		lb.copyTable(bufslotopt,layoutTable.buffs.options)
		--parsing buff slots(only the first 4)
		print(#(bufslotopt))
		for i= 1,#(bufslotopt)  do
			layoutTable.buffs.options[i].names={}
			for key,value in pairs(buffassoc[i][1]) do
				layoutTable.buffs.options[i].names[key]={}
				lb.copyTable(value,layoutTable.buffs.options[i].names[key])
			end
		end
		
		local rolet = stTable.profileChanger.createRoleRuleTable(i,profname)
		stTable.profileChanger.addRule(rolet)
		
	end
	
	
	
	print ("import end")
end