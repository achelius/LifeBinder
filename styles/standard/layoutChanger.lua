local stTable=lb.styles["standard"]
local optionsTable=nil
local frame=nil
stTable.layoutChanger={}
local lastgroupcount=-1

function stTable.layoutChanger.initializeLayoutChangerTable()
	if optionsTable==nil then optionsTable=stTable.options end
	if stTable.getProfileTable().common.layoutChanger ==nil then
		stTable.getProfileTable().common.layoutChanger={}
		stTable.getProfileTable().common.layoutChanger.rules={}
		stTable.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(0,1,"default"))
		stTable.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(2,5,"default"))
		stTable.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(6,10,"default"))
		stTable.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(11,20,"default"))
	end
	
end

function stTable.layoutChanger.addRule(ruleTable)
	if optionsTable==nil then return end
	table.insert(stTable.getProfileTable().common.layoutChanger.rules,ruleTable)
end

function stTable.layoutChanger.createGroupCountRuleTable(mincount,maxcount,layout)
	local rule={}
	rule.type="groupcount"
	rule.mincount=mincount
	rule.maxcount=maxcount
	rule.layout=layout
	return rule
end

function stTable.layoutChanger.getRuleFromCount(profilename,groupcount)	
	if optionsTable==nil then return end
	for key,rule in pairs(stTable.getProfileTable(profilename).common.layoutChanger.rules) do
		if rule~=nil and rule.type~=nil then
			if rule.type=="groupcount" then
				if groupcount<=rule.maxcount and groupcount>=rule.mincount then
					return rule
				end
			end
		end
	end
	return nil
end

--/script lb.styles.standard.layoutChanger.onGroupCountChange(5)
--/script lb.styles.standard.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(1,1,default))
--/script lb.styles.standard.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(2,5,group5))
--/script lb.styles.standard.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(6,10,raid10))
--/script lb.styles.standard.layoutChanger.addRule(lb.styles.standard.layoutChanger.createGroupCountRuleTable(11,20,raid20))
function stTable.layoutChanger.onGroupCountChange(newcount)
	if optionsTable==nil then return end
--print("ongroupc change")
	for key,rule in pairs(stTable.getProfileTable().common.layoutChanger.rules) do
		if rule~=nil and rule.type~=nil then
			if rule.type=="groupcount" then
				--print ("newcount="..tostring(newcount))
				--dump (rule)
				--print("----")
				if newcount<=rule.maxcount and newcount>=rule.mincount then
					--print ("---")
					--print (newcount)
					if rule.layout~=nil then
						stTable.force=true
						--print ("---")
						stTable.changeLayout(stTable.options.selectedProfile,rule.layout)
						stTable.force=false
					end
					--print ("---")
					--return true
				end
			end
		end
	end
end


function stTable.layoutChanger.removeEveryRoleOfLayout(profilename,name)
	for key,rule in pairs(stTable.getProfileTable(profilename).common.layoutChanger.rules) do
		if rule~=nil and rule.type~=nil then
			if rule.type=="groupcount" then
				if rule.layout==name then
					rule.layout=nil
				end
				
			end
		end
	end
end

function stTable.layoutChanger.onGroupChange()
--print("group change")
	--print(LibSRM.GroupCount())
	if lastgroupcount~=LibSRM.GroupCount() then
		--print("passed")
		lastgroupcount=LibSRM.GroupCount()
	 	stTable.layoutChanger.onGroupCountChange(lastgroupcount)
	else
--		local rulet=stTable.layoutChanger.getRuleFromCount(optionsTable.selectedProfile,LibSRM.GroupCount())
--		if rulet~=nil then
--			if stTable.getProfileTable().selectedLayout~= then
--			
--			end
--		end
	end
end
function stTable.layoutChanger.forceOnGroupChange()
	lastgroupcount=-1
	--print("force layout change")
	stTable.layoutChanger.onGroupChange()
end
function stTable.layoutChanger.ActivateEvents()
	--table.insert(Event.SafesRaidManager.Player.Ready, {stTable.layoutChanger.onGroupChange, "LifeBinder", "layoutChanger.GroupJoin"})
	table.insert(Event.SafesRaidManager.Group.Join, {stTable.layoutChanger.onGroupChange, "LifeBinder", "layoutChanger.GroupJoin"})
	table.insert(Event.SafesRaidManager.Group.Leave, {stTable.layoutChanger.onGroupChange , "LifeBinder", "layoutChanger.GroupLeave"})
	--table.insert(Event.SafesRaidManager.Group.Change, {stTable.layoutChanger.onGroupChange , "LifeBinder", "layoutChanger.GroupLeave"})
	table.insert(Event.SafesRaidManager.Player.Join, {stTable.layoutChanger.onGroupChange , "LifeBinder", "layoutChanger.PlayerJoin"})
	table.insert(Event.SafesRaidManager.Player.Leave,{stTable.layoutChanger.onGroupChange, "LifeBinder", "layoutChanger.PlayerLeave"})
end
table.insert(lb.OtherEvents,stTable.layoutChanger.ActivateEvents)