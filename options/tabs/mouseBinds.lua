lb.optionsGui.mouseBinds={}
local frame=nil
function lb.optionsGui.mouseBinds.createTable(parentFrame)
 	 local optionsFrame
	 optionsFrame = UI.CreateLbFrame("Frame", "OptionsWindowA", parentFrame)
	 frame=optionsFrame
	 optionsFrame.CommandsList=UI.CreateLbFrame("AbilitiesList", "CommandsList",optionsFrame)
	 optionsFrame.CommandsList:CreateDragFrame(optionsFrame.CommandsList,optionsFrame,parentFrame)
	 optionsFrame.CommandsList.Event.DraggedOutItem= lb.optionsGui.mouseBinds.onCommandsListItemDrag
	 optionsFrame.CommandsListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame)
	 
	 optionsFrame.CommandsListView:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",5, 20)
     optionsFrame.CommandsListView:SetWidth(250)
     optionsFrame.CommandsListView:SetHeight(450)
     optionsFrame.CommandsListView:SetLayer(1)
     optionsFrame.CommandsListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.CommandsListView:SetContent( optionsFrame.CommandsList)
	 --initializing abilities list
	 local list={}
	 local abs=Inspect.Ability.Detail(Inspect.Ability.List())
	 
	 local counter=1
	 for k,ab in pairs(abs) do
		local name=ab.name
		--list[counter]={"ability name","Rift",ab.icon,"type","command","mousebutton","modifier"}
		--modifier can be any combination of ctrl alt shift
		--the last two will be added to the 
	     list[counter]={ab.name,"Rift",ab.icon,"cast",ab.name,"-1","modifier",ab.description}
	     
	     counter=counter+1
	 end
	 table.sort(list, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 table.insert(list,1,{"Target","LifeBinder","Textures/card29.png","target","target","mousebutton","modifier","Targets the unit"})
	 table.insert(list,2,{"Assist","LifeBinder","Textures/card29a.png","assist","assist","mousebutton","modifier","Assists the unit"})
	 table.insert(list,3,{"Focus","LifeBinder","Textures/card29b.png","focus","focus","mousebutton","modifier","Focus the unit"})
	 if Command.Unit~=nil then table.insert(list,4,{"Menu [beta]","LifeBinder","Textures/card29c.png","menu","menu","mousebutton","modifier","Shows the unit menu while out of combat"}) end
	 optionsFrame.CommandsList:SetItems(list)
	 writeText("Drag the ability from the list to the mouse button / modifier combination you want","text",optionsFrame,260,5)
	 writeText("Double modifiers are called first, then single modifier and finally the no modifier one","text",optionsFrame,260,25)
	 writeText("Remember to press apply when you finished editing","text",optionsFrame,260,45)
	 --initializing mouse buttons table
	 optionsFrame.ButtonsTable=UI.CreateLbFrame("SimpleTabView", "OptionsWindowFrame", optionsFrame)
	 optionsFrame.ButtonsTable:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 260, 60)
     optionsFrame.ButtonsTable:SetPoint("BOTTOMRIGHT", optionsFrame, "BOTTOMRIGHT", -10, -15)
     optionsFrame.ButtonsTable:SetLayer(30)
     optionsFrame.ButtonsTable.Tabs={}
     
     optionsFrame.tempBindsLists=lb.mouseBinds.getMouseBindsTable()
     
	 local mouseBindButtonNames = { "Left", "Right", "Middle", "M4", "M5" }
	 
	 for i = 1, 5 do
     	optionsFrame.ButtonsTable.Tabs[i] = UI.CreateLbFrame("Frame", "BuffTab", optionsFrame.ButtonsTable)
	 	--optionsFrame.ButtonsTable:AddTab("Mouse"..tostring(i),optionsFrame.ButtonsTable.Tabs[i])
		optionsFrame.ButtonsTable:AddTab(mouseBindButtonNames[i],optionsFrame.ButtonsTable.Tabs[i])
	 	optionsFrame.ButtonsTable.Tabs[i].BindsLists={}
	 	optionsFrame.ButtonsTable.Tabs[i].BindsListsView={}
	 	
		for g = 1 , 7 do
		 	optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]=UI.CreateLbFrame("HorizontalIconsList", "BindsLists"..tostring(g),optionsFrame.ButtonsTable.Tabs[i])
		 	optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]:CreateDragFrame(optionsFrame.ButtonsTable.Tabs[i].BindsLists[g],optionsFrame.ButtonsTable.Tabs[i],parentFrame)
		 	optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]:CreateTooltipFrame(optionsFrame.ButtonsTable.Tabs[i].BindsLists[g],optionsFrame.ButtonsTable.Tabs[i],parentFrame)
			optionsFrame.ButtonsTable.Tabs[i].BindsLists[g].Event.DraggedOutItem=function(item,x,y) lb.optionsGui.mouseBinds.BindsListItemDrag(i,g,item,x,y) end
		 	optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.ButtonsTable.Tabs[i])
		 	optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetPoint("TOPLEFT", optionsFrame.ButtonsTable.Tabs[i], "TOPLEFT",80, 40*(g-1)+10*g)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetWidth(450)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetHeight(40)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetLayer(10)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetBorder(1, 1, 1, 1, 1)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetContent( optionsFrame.ButtonsTable.Tabs[i].BindsLists[g])
		     optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]:SetItems(optionsFrame.tempBindsLists[i][g])
		     writeText(lb.optionsGui.mouseBinds.getModifierNameFromIndex(g),"text",optionsFrame.ButtonsTable.Tabs[i],10,40*(g-1)+10*g+10)
	 	end
	 	
     end
	  --initialize Apply Button
	 optionsFrame.ApplyButton=UI.CreateLbFrame("RiftButton", "ApplyButton", optionsFrame )
	 optionsFrame.ApplyButton:SetPoint("BOTTOMRIGHT", optionsFrame,"BOTTOMRIGHT",-5,-5)
	 optionsFrame.ApplyButton:SetText("Apply")
	 optionsFrame.ApplyButton.Event.LeftClick=function() if not lb.isincombat then lb.mouseBinds.setMouseActions() else print("you must be out of combat to change mouse binds!") end end
	 
	 return optionsFrame
end




function lb.optionsGui.mouseBinds.onCommandsListItemDrag(item,x,y)
	local tabindex=frame.ButtonsTable:GetActiveTab()
	for i = 1,7 do
		if lb.optionsGui.isPointInFrame(frame.ButtonsTable.Tabs[tabindex].BindsListsView[i],x,y) then
			local newitem={}
			for g = 1,#item do
				newitem[g]=item[g]
			end
			newitem[6]=tabindex 
			newitem[7]=lb.optionsGui.mouseBinds.getModifierNameFromIndex(i)
			table.insert(frame.tempBindsLists[tabindex][i],newitem)
			frame.ButtonsTable.Tabs[tabindex].BindsLists[i]:SetItems(frame.tempBindsLists[tabindex][i])
		end
	end
	
end


function lb.optionsGui.mouseBinds.BindsListItemDrag(buttonindex,modindex,item,x,y)
	local index=0
	for i = 1,#(frame.tempBindsLists[buttonindex][modindex]) do
		if frame.tempBindsLists[buttonindex][modindex][i][1]==item[1] then
			table.remove(frame.tempBindsLists[buttonindex][modindex],i)
			frame.ButtonsTable.Tabs[buttonindex].BindsLists[modindex]:SetItems(frame.tempBindsLists[buttonindex][modindex])
			return
		end
	end
end
function lb.optionsGui.mouseBinds.updateData()
	frame.tempBindsLists=lb.mouseBinds.getMouseBindsTable()
	local tabindex=frame.ButtonsTable:GetActiveTab()
	local list={}
	 local abs=Inspect.Ability.Detail(Inspect.Ability.List())
	 
	 local counter=1
	 for k,ab in pairs(abs) do
		local name=ab.name
		--list[counter]={"ability name","Rift",ab.icon,"type","command","mousebutton","modifier","description"}
		--modifier can be any combination of ctrl alt shift
		--the last two will be added to the 
	     list[counter]={ab.name,"Rift",ab.icon,"cast",ab.name,"-1","modifier",ab.description}
	     
	     counter=counter+1
	 end
	 table.sort(list, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	table.insert(list,1,{"Target","LifeBinder","Textures/card29.png","target","target","mousebutton","modifier","Targets the unit"})
	 table.insert(list,2,{"Assist","LifeBinder","Textures/card29a.png","assist","assist","mousebutton","modifier","Assists the unit"})
	 table.insert(list,3,{"Focus","LifeBinder","Textures/card29b.png","focus","focus","mousebutton","modifier","Focus the unit"})
	 if Command.Unit~=nil then table.insert(list,4,{"Menu [beta]","LifeBinder","Textures/card29c.png","menu","menu","mousebutton","modifier","Shows the unit menu while out of combat"}) end
	 frame.CommandsList:SetItems(list)
	 for buttonindex= 1,5 do
		for modindex = 1,7 do
			frame.ButtonsTable.Tabs[buttonindex].BindsLists[modindex]:SetItems(frame.tempBindsLists[buttonindex][modindex])
		end
	 end
end
function lb.optionsGui.mouseBinds.getModifierNameFromIndex(index)
	if index==1 then
		return "None"
	elseif index==2 then
		return "alt"
	elseif index==3 then
		return "ctrl"
	elseif index==4 then
		return "shift"
	elseif index==5 then
		return "alt+ctrl"
	elseif index==6 then
		return "shift+alt"		
	elseif index==7 then
		return "shift+ctrl"
	end
end

function lb.optionsGui.mouseBinds.getModifierIndexFromName(name)
	if name=="None" then
		return 1
	elseif name=="alt" then
		return 2
	elseif name=="ctrl" then
		return 3
	elseif name=="shift" then
		return 4
	elseif name=="alt+ctrl" then
		return 5
	elseif name=="shift+alt" then
		return 6		
	elseif name=="shift+ctrl" then
		return 7
	end
end