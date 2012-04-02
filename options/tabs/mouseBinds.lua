lb.slotsGui.mouseBinds={}
local frame=nil
function lb.slotsGui.mouseBinds.createTable(parentFrame)
 	 local optionsFrame
	 optionsFrame = UI.CreateFrame("Frame", "OptionsWindowA", parentFrame)
	 
	 optionsFrame.CommandsList=UI.CreateFrame("AbilitiesList", "CommandsList",optionsFrame)
	 optionsFrame.CommandsList:CreateDragFrame(optionsFrame.CommandsList,optionsFrame,parentFrame)
	 optionsFrame.CommandsList.Event.DraggedOutItem= lb.slotsGui.mouseBinds.onCommandsListItemDrag
	 optionsFrame.CommandsListView=UI.CreateFrame("SimpleScrollView", "List", optionsFrame)
	 
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
	     list[counter]={ab.name,"Rift",ab.icon,"cast",ab.name,"-1","modifier"}
	     
	     counter=counter+1
	 end
	 table.sort(list, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 table.insert(list,1,{"Target","LifeBinder","Textures/targetmousebind.png","target","target","mousebutton","modifier"})
	 optionsFrame.CommandsList:SetItems(list)
	 
	 --initializing mouse buttons table
	 optionsFrame.ButtonsTable=UI.CreateFrame("SimpleTabView", "OptionsWindowFrame", optionsFrame)
	 optionsFrame.ButtonsTable:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 260, 50)
     optionsFrame.ButtonsTable:SetPoint("BOTTOMRIGHT", optionsFrame, "BOTTOMRIGHT", -10, -15)
     optionsFrame.ButtonsTable:SetLayer(30)
     optionsFrame.ButtonsTable.Tabs={}
     
     optionsFrame.tempBindsLists=lbMouseBinds[lbValues.set]
     for i = 1, 5 do
     	
     	optionsFrame.ButtonsTable.Tabs[i] = UI.CreateFrame("Frame", "BuffTab", optionsFrame.ButtonsTable)
	 	optionsFrame.ButtonsTable:AddTab("Mouse"..tostring(i),optionsFrame.ButtonsTable.Tabs[i])
	 	optionsFrame.ButtonsTable.Tabs[i].BindsLists={}
	 	optionsFrame.ButtonsTable.Tabs[i].BindsListsView={}
	 	for g = 1 , 7 do
	 		
		 	optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]=UI.CreateFrame("HorizontalIconsList", "BindsLists"..tostring(g),optionsFrame.ButtonsTable.Tabs[i])
		 	optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]:CreateDragFrame(optionsFrame.ButtonsTable.Tabs[i].BindsLists[g],optionsFrame.ButtonsTable.Tabs[i],parentFrame)
			optionsFrame.ButtonsTable.Tabs[i].BindsLists[g].Event.DraggedOutItem=function(item,x,y) lb.slotsGui.mouseBinds.BindsListItemDrag(i,g,item,x,y) end
		 	optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]=UI.CreateFrame("SimpleScrollView", "List", optionsFrame.ButtonsTable.Tabs[i])
		 	optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetPoint("TOPLEFT", optionsFrame.ButtonsTable.Tabs[i], "TOPLEFT",80, 40*(g-1)+10*g)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetWidth(450)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetHeight(40)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetLayer(10)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetBorder(1, 1, 1, 1, 1)
		     optionsFrame.ButtonsTable.Tabs[i].BindsListsView[g]:SetContent( optionsFrame.ButtonsTable.Tabs[i].BindsLists[g])
		     optionsFrame.ButtonsTable.Tabs[i].BindsLists[g]:SetItems(optionsFrame.tempBindsLists[i][g])
		     writeText(lb.slotsGui.mouseBinds.getModifierNameFromIndex(g),"text",optionsFrame.ButtonsTable.Tabs[i],10,40*(g-1)+10*g+10)
	 	end
	 	
     end
	  --initialize Apply Button
	 optionsFrame.ApplyButton=UI.CreateFrame("RiftButton", "ApplyButton", optionsFrame )
	 optionsFrame.ApplyButton:SetPoint("BOTTOMRIGHT", optionsFrame,"BOTTOMRIGHT",-5,-5)
	 optionsFrame.ApplyButton:SetText("Apply")
	 optionsFrame.ApplyButton.Event.LeftClick=function() lb.mouseBinds.setMouseActions()  end
	 frame=optionsFrame
	 return optionsFrame
end




function lb.slotsGui.mouseBinds.onCommandsListItemDrag(item,x,y)
	local tabindex=frame.ButtonsTable:GetActiveTab()
	for i = 1,7 do
		if lb.slotsGui.isPointInFrame(frame.ButtonsTable.Tabs[tabindex].BindsListsView[i],x,y) then
			local newitem={}
			for g = 1,#item do
				newitem[g]=item[g]
			end
			newitem[6]=tabindex 
			newitem[7]=lb.slotsGui.mouseBinds.getModifierNameFromIndex(i)
			table.insert(frame.tempBindsLists[tabindex][i],newitem)
			frame.ButtonsTable.Tabs[tabindex].BindsLists[i]:SetItems(frame.tempBindsLists[tabindex][i])
		end
	end
	
end


function lb.slotsGui.mouseBinds.BindsListItemDrag(buttonindex,modindex,item,x,y)
	local index=0
	for i = 1,#(frame.tempBindsLists[buttonindex][modindex]) do
		if frame.tempBindsLists[buttonindex][modindex][i][1]==item[1] then
			table.remove(frame.tempBindsLists[buttonindex][modindex],i)
			frame.ButtonsTable.Tabs[buttonindex].BindsLists[modindex]:SetItems(frame.tempBindsLists[buttonindex][modindex])
			return
		end
	end
end
function lb.slotsGui.mouseBinds.updateData()
	frame.tempBindsLists=lbMouseBinds[lbValues.set]
	local tabindex=frame.ButtonsTable:GetActiveTab()
	local list={}
	 local abs=Inspect.Ability.Detail(Inspect.Ability.List())
	 
	 local counter=1
	 for k,ab in pairs(abs) do
		local name=ab.name
		--list[counter]={"ability name","Rift",ab.icon,"type","command","mousebutton","modifier"}
		--modifier can be any combination of ctrl alt shift
		--the last two will be added to the 
	     list[counter]={ab.name,"Rift",ab.icon,"cast",ab.name,"-1","modifier"}
	     
	     counter=counter+1
	 end
	 table.sort(list, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 table.insert(list,1,{"Target","LifeBinder","Textures/targetmousebind.png","target","target","mousebutton","modifier"})
	 frame.CommandsList:SetItems(list)
	 for buttonindex= 1,5 do
		for modindex = 1,7 do
			frame.ButtonsTable.Tabs[buttonindex].BindsLists[modindex]:SetItems(frame.tempBindsLists[buttonindex][modindex])
		end
	 end
end
function lb.slotsGui.mouseBinds.getModifierNameFromIndex(index)
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

function lb.slotsGui.mouseBinds.getModifierIndexFromName(name)
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