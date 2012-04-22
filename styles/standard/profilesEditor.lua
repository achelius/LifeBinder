lb.optionsGui.profilesEditor={}
local frame=nil
local selectedProfile=nil
local selectedLayout=nil
local init=false
local gcnames={"solo","group5","group10","group20"}
local gcvalues={1,5,10,20}
function lb.optionsGui.profilesEditor.createTable(parentFrame)
 	local optionsFrame
	optionsFrame = UI.CreateLbFrame("Frame", "OptionsWindowA", parentFrame)
	frame=optionsFrame

	
     
    optionsFrame.tabControl=UI.CreateLbFrame("SimpleTabView", "ProfileOptions",optionsFrame)
	optionsFrame.tabControl:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",10,10)
	optionsFrame.tabControl:SetPoint("BOTTOMRIGHT",optionsFrame,"BOTTOMRIGHT",-10,-10)
    optionsFrame.tabs={}
   	optionsFrame.tabs[1]=UI.CreateLbFrame("Frame", "ManageProfilesFrame",optionsFrame)
   	optionsFrame.tabControl:AddTab("Manage",optionsFrame.tabs[1])
	
	optionsFrame.poptions={}
	optionsFrame.poptions.tabs={}
	optionsFrame.poptions.tabControl=UI.CreateLbFrame("SimpleTabView", "ProfileOptions",optionsFrame.tabs[1])
	optionsFrame.poptions.tabControl:SetPoint("TOPLEFT",optionsFrame.tabs[1],"TOPLEFT",200,10)
	optionsFrame.poptions.tabControl:SetPoint("BOTTOMRIGHT",optionsFrame.tabs[1],"BOTTOMRIGHT",-10,-10)
---++++++++++++++++++++++++++++++++++++++++++++initializing manage profile tab
	writeText("Profiles list:","text",optionsFrame.tabs[1],10,10)
	optionsFrame.profilesList=UI.CreateLbFrame("SimpleList", "profilesList",optionsFrame.tabs[1])
	optionsFrame.profilesList.Event.ItemSelect=lb.optionsGui.profilesEditor.onProfileSelect
	optionsFrame.profilesListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.tabs[1])
	optionsFrame.profilesListView:SetPoint("TOPLEFT", optionsFrame.tabs[1], "TOPLEFT",10, 40)
    optionsFrame.profilesListView:SetWidth(190)
    optionsFrame.profilesListView:SetHeight(350)
    optionsFrame.profilesListView:SetLayer(1)
    optionsFrame.profilesListView:SetBorder(2, 2, 2, 2, 2)
    optionsFrame.profilesListView:SetBackgroundColor(0, 0, 0, 1)
    optionsFrame.profilesListView:SetContent(optionsFrame.profilesList)
----------------------------------------------initializing manage profile tab 1 (profile associations)
	
	optionsFrame.poptions.tabs[1]=UI.CreateLbFrame("Frame", "ProfileOptionsFrame",parentFrame)
	
	--optionsFrame.poptions.tabs[1]:SetBackgroundColor(1,1,1,1)
	optionsFrame.poptions.tabControl:AddTab("Associations",optionsFrame.poptions.tabs[1])
	writeText("Roles list:","text",optionsFrame.poptions.tabs[1],10,10)
	optionsFrame.poptions.tabs[1].roleCheckboxes={}
	for i = 1,6 do
		optionsFrame.poptions.tabs[1].roleCheckboxes[i]=UI.CreateLbFrame("SimpleCheckbox", "ChkProfileRule",optionsFrame.poptions.tabs[1])
		optionsFrame.poptions.tabs[1].roleCheckboxes[i]:SetPoint("TOPLEFT",optionsFrame.poptions.tabs[1],"TOPLEFT",20,40+i*25)
		optionsFrame.poptions.tabs[1].roleCheckboxes[i]:SetText("Role "..tostring(i))
		optionsFrame.poptions.tabs[1].roleCheckboxes[i].Event.CheckboxChange=function () lb.optionsGui.profilesEditor.onChkRoleCheckedChanged(i) end
	end
	
----------------------------------------------initializing manage profile tab 2 (layouts)
	
	optionsFrame.poptions.tabs[2]=UI.CreateLbFrame("Frame", "ProfileOptionsFrame",parentFrame)
	optionsFrame.poptions.tabControl:AddTab("Layouts",optionsFrame.poptions.tabs[2])
	writeText("Layouts list:","text",optionsFrame.poptions.tabs[2],10,10)
	optionsFrame.poptions.tabs[2].layoutCheckboxes={}
	optionsFrame.poptions.tabs[2].layoutsList=UI.CreateLbFrame("SimpleList", "layoutsList",optionsFrame.poptions.tabs[2])
	optionsFrame.poptions.tabs[2].layoutsList.Event.ItemSelect=lb.optionsGui.profilesEditor.onLayoutSelect
	optionsFrame.poptions.tabs[2].layoutsListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.poptions.tabs[2])
	optionsFrame.poptions.tabs[2].layoutsListView:SetPoint("TOPLEFT", optionsFrame.poptions.tabs[2], "TOPLEFT",10, 40)
    optionsFrame.poptions.tabs[2].layoutsListView:SetWidth(100)
    optionsFrame.poptions.tabs[2].layoutsListView:SetHeight(250)
    optionsFrame.poptions.tabs[2].layoutsListView:SetLayer(1)
    optionsFrame.poptions.tabs[2].layoutsListView:SetBorder(2, 2, 2, 2, 2)
    optionsFrame.poptions.tabs[2].layoutsListView:SetBackgroundColor(0, 0, 0, 1)
    optionsFrame.poptions.tabs[2].layoutsListView:SetContent(optionsFrame.poptions.tabs[2].layoutsList)
    writeText("Choose the group types that activate this layout","text",optionsFrame.poptions.tabs[2],140,20)
	for i = 1,#(gcnames) do
		optionsFrame.poptions.tabs[2].layoutCheckboxes[i]=UI.CreateLbFrame("SimpleCheckbox", "ChklayoutRule",optionsFrame.poptions.tabs[2])
		optionsFrame.poptions.tabs[2].layoutCheckboxes[i]:SetPoint("TOPLEFT",optionsFrame.poptions.tabs[2],"TOPLEFT",140,60+i*25)
		optionsFrame.poptions.tabs[2].layoutCheckboxes[i]:SetText(gcnames[i])
		optionsFrame.poptions.tabs[2].layoutCheckboxes[i]:SetEnabled(false)
		optionsFrame.poptions.tabs[2].layoutCheckboxes[i].Event.CheckboxChange=function () lb.optionsGui.profilesEditor.onChklayoutRuleCheckedChanged(i) end
	end
	
	
	----------------------------------------------initializing manage profile tab 3 (copy)
	
	optionsFrame.poptions.tabs[3]=UI.CreateLbFrame("Frame", "ProfileOptionsFrame",parentFrame)
	optionsFrame.poptions.tabControl:AddTab("Create",optionsFrame.poptions.tabs[3])
	
	
---++++++++++++++++++++++++++++++++++++++++++++ initializing create profile tab
	optionsFrame.tabs[2]=UI.CreateLbFrame("Frame", "ManageProfilesFrame",optionsFrame)
   	optionsFrame.tabControl:AddTab("Create profile",optionsFrame.tabs[2])
	
	
	
	lb.optionsGui.profilesEditor.updateData()
	return optionsFrame
end

function lb.optionsGui.profilesEditor.onChkRoleCheckedChanged(roleindex)
	if init then return end
	--print (roleindex)
	--print (frame.poptions.tabs[1].roleCheckboxes[roleindex]:GetChecked())
	if frame.poptions.tabs[1].roleCheckboxes[roleindex]:GetChecked() then
		local rolet = lb.styles[lb.currentStyle].profileChanger.createRoleRuleTable(roleindex,selectedProfile)
		lb.styles[lb.currentStyle].profileChanger.addRule(rolet)
	else
		lb.styles[lb.currentStyle].profileChanger.removeRoleRule(roleindex)
	end
	
end



function lb.optionsGui.profilesEditor.onProfileSelect(item, value, index)
	
	selectedProfile=value
	lb.optionsGui.profilesEditor.compileTableProfiles(selectedProfile)
	frame.poptions.tabControl:SetVisible(true)
end

function lb.optionsGui.profilesEditor.compileTableProfiles(profilename)
	init=true
	for i = 1,6 do
		local rulet= lb.styles[lb.currentStyle].profileChanger.getRoleRule(i)
		--print("-----" .. tostring(i))
		--dump(rulet)
		if rulet~=nil then
		 	if rulet.profile~=profilename and rulet.profile~=nil then
		 		frame.poptions.tabs[1].roleCheckboxes[i]:SetEnabled(false)
		 		frame.poptions.tabs[1].roleCheckboxes[i]:SetChecked(false)
		 	else
		 		frame.poptions.tabs[1].roleCheckboxes[i]:SetEnabled(true)
		 		frame.poptions.tabs[1].roleCheckboxes[i]:SetChecked(true)
		 	end
		else
			frame.poptions.tabs[1].roleCheckboxes[i]:SetEnabled(true)
			frame.poptions.tabs[1].roleCheckboxes[i]:SetChecked(false)
		end
	end
	--print("gino")
	local layouts=lb.styles[lb.currentStyle].getLayoutsList(profilename)
	selectedLayout=nil
	frame.poptions.tabs[2].layoutsList:SetItems(layouts)
	
	init=false
end

function lb.optionsGui.profilesEditor.onLayoutSelect(item, value, index)
	init=true
	if selectedProfile==nil then return end
	selectedLayout=value
	lb.optionsGui.profilesEditor.compileTableLayouts(selectedProfile,value)
	init=false
end

function lb.optionsGui.profilesEditor.compileTableLayouts(profilename,layoutname)
	init=true
	for i = 1,#(gcnames) do
		local rulet= lb.styles[lb.currentStyle].layoutChanger.getRuleFromCount(profilename,gcvalues[i])
		if rulet~=nil then
		 	if rulet.layout~=layoutname and rulet.layout~=nil then
		 		frame.poptions.tabs[2].layoutCheckboxes[i]:SetEnabled(false)
		 		frame.poptions.tabs[2].layoutCheckboxes[i]:SetChecked(false)
		 	else
		 		frame.poptions.tabs[2].layoutCheckboxes[i]:SetEnabled(true)
		 		if rulet.layout~=nil then
		 			frame.poptions.tabs[2].layoutCheckboxes[i]:SetChecked(true)	
		 		else
		 			frame.poptions.tabs[2].layoutCheckboxes[i]:SetChecked(false)
		 		end
		 		
		 	end
		else
			frame.poptions.tabs[2].layoutCheckboxes[i]:SetEnabled(true)
			frame.poptions.tabs[2].layoutCheckboxes[i]:SetChecked(false)
		end
	end
	init=false
end

function lb.optionsGui.profilesEditor.onChklayoutRuleCheckedChanged(ruleindex)
	if init then return end
	if selectedLayout==nil then return end
	local rule= lb.styles[lb.currentStyle].layoutChanger.getRuleFromCount(profilename,gcvalues[ruleindex])
	if frame.poptions.tabs[2].layoutCheckboxes[ruleindex]:GetChecked() then
		rule.layout=selectedLayout
	else
		rule.layout=nil
	end
end



function lb.optionsGui.profilesEditor.updateData()
	local plist=lb.styles[lb.currentStyle].getProfilesList()
	frame.profilesList:SetItems(plist)
	frame.poptions.tabControl:SetVisible(false)
end
