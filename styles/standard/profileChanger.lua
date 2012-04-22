local stTable=lb.styles["standard"]
local optionsTable=nil
local frame=nil
stTable.profileChanger={}

function stTable.profileChanger.initializeProfileChangerTable()
	if optionsTable==nil then optionsTable=stTable.options end
	if optionsTable.profileChanger==nil then
		optionsTable.profileChanger={}
	 	optionsTable.profileChanger.rules={}
	 	for i = 1,6 do
	 		 stTable.profileChanger.addRule(stTable.profileChanger.createRoleRuleTable(i,"default"))
	 	end
	end
end

function stTable.profileChanger.addRule(ruleTable)
	if optionsTable==nil then return end
--remember to change this when you want to add a different type of rule
	if ruleTable.type=="role" then
		local rulet =stTable.profileChanger.getRoleRule(ruleTable.roleindex)
		if rulet~=nil then
			rulet.profile=ruleTable.profile
		else
			table.insert(optionsTable.profileChanger.rules,ruleTable)
		end
	else
		table.insert(optionsTable.profileChanger.rules,ruleTable)
	end
end
function stTable.profileChanger.removeRule(ruleTable)
	if optionsTable==nil then return end
--remember to change this when you want to add a different type of rule
	if ruleTable.type=="role" then
		for key,rulet in pairs(optionsTable.profileChanger.rules) do
			
			if rulet.roleindex==ruleTable.roleindex then
				table.remove(optionsTable.profileChanger.rules,key)
				return nil
--			else
--				table.remove(optionsTable.profileChanger.rules,key)
--				return nil
			end
		end
		
	else
		--table.remove(optionsTable.profileChanger.rules,ruleTable)
	end
end

function stTable.profileChanger.removeRoleRule(roleindex)
	if optionsTable==nil then return end
	for key,rulet in pairs(optionsTable.profileChanger.rules) do
		if rulet.roleindex==roleindex then
			table.remove(optionsTable.profileChanger.rules,key)
			return nil
		end
	end
end

function stTable.profileChanger.createRoleRuleTable(roleindex,profile)
	local rule={}
	rule.type="role"
	rule.roleindex=roleindex
	rule.profile=profile
	return rule
end


function stTable.profileChanger.getRoleRule(roleindex)
	if optionsTable==nil then return nil end
	for key,rule in pairs(optionsTable.profileChanger.rules) do
		if rule~=nil and rule.type~=nil then
			if rule.type=="role" then
				if rule.roleindex==roleindex then
					return rule
				end
			end
		end
	end
	return nil
end

function stTable.profileChanger.onRoleChange(newrole)
	if newrole==nil then return end
	if optionsTable==nil then return end
	for key,rule in pairs(optionsTable.profileChanger.rules) do
		if rule~=nil and rule.type~=nil then
			if rule.type=="role" then
				if rule.roleindex==newrole then
					if rule.profile ~=nil then 
						--print("profchanger")
						---print(rule.profile)
						stTable.force=true
						--print("||||||")
						stTable.changeProfile(rule.profile)
						--print("++++")
						stTable.layoutChanger.forceOnGroupChange()
						--print("........")
						stTable.force=false
						break
					end
				end
			end
		end
	end
end

function stTable.profileChanger.removeEveryRoleOfProfile(profilename)
	for key,rule in pairs(optionsTable.profileChanger.rules) do
		if rule~=nil and rule.type~=nil then
			if rule.type=="role" then
				if rule.profile ==profilename then 
					stTable.profileChanger.removeRoleRule(rule.roleindex)
				end
			end
		end
	end
end


function stTable.profileChanger.onPlayerReady()
	--print("opr")
	 stTable.profileChanger.onRoleChange(Inspect.TEMPORARY.Role())
end
function stTable.profileChanger.ActivateEvents()
	--table.insert(Event.SafesRaidManager.Player.Ready, {stTable.profileChanger.onPlayerReady, "LifeBinder", "profileChanger.onPlayerReady"})
	table.insert(Event.TEMPORARY.Role, {stTable.profileChanger.onRoleChange, "LifeBinder", "stTable.profileChanger.onRoleChange"})
end
table.insert(lb.OtherEvents,stTable.profileChanger.ActivateEvents)