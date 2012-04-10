lb.optionsGui.buffAssociations={}
local frame=nil
local lastIndex=-1
 local scalex=1-- lb.styles[lb.currentStyle].getFrameWidth()*0.009009009
 local scaley=1--lb.styles[lb.currentStyle].getFrameHeight()*0.023255814
 local checkedinit=false --used to suppress checkedchange event when not needed
function lb.optionsGui.buffAssociations.createTable(parentFrame)

	 local optionsFrame
	 optionsFrame = UI.CreateLbFrame("Frame", "BuffAssociationsTab", parentFrame)
	 frame=optionsFrame
	 --initializing unitframe
	 optionsFrame.UnitFrame = UI.CreateLbFrame("Texture", "UnitFrame",  optionsFrame  )
	 optionsFrame.UnitFrame:SetPoint("TOPLEFT",optionsFrame , "TOPLEFT", 20, 50)
	 writeText("Select the slot and drag the buff from the list into the slot square","text",optionsFrame,10,10)
	 optionsFrame.UnitFrame:SetWidth(lb.styles[lb.currentStyle].getFrameWidth()*lb.optionsGui.PreviewScale[1])
	 optionsFrame.UnitFrame:SetHeight(lb.styles[lb.currentStyle].getFrameHeight()*lb.optionsGui.PreviewScale[2])
	 optionsFrame.UnitFrame:SetVisible(true)
	 optionsFrame.UnitFrame:SetTexture("LifeBinder", lb.styles[lb.currentStyle].getHealthFrameTexture())
	 optionsFrame.UnitFrame:SetLayer(1)
	 --initializing buff slots
	  optionsFrame.buffSlots={}
	 
	 for i =1 ,#(lbBuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotOptions[lbValues.set][i]
	 	optionsFrame.buffSlots[i]={}
	 	optionsFrame.buffSlots[i].Frame= UI.CreateLbFrame("Texture", "UnitFrame",  optionsFrame.UnitFrame )
	 	optionsFrame.buffSlots[i].Frame:SetPoint(slotinfo[1],optionsFrame.UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.optionsGui.PreviewScale[1], slotinfo[4]*scaley*lb.optionsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	optionsFrame.buffSlots[i].Frame:SetWidth(iconl*lb.optionsGui.PreviewScale[1])
	 	optionsFrame.buffSlots[i].Frame:SetHeight(iconl*lb.optionsGui.PreviewScale[2])
	 	optionsFrame.buffSlots[i].Frame:SetBackgroundColor(0,1,0.2,1)
	 	optionsFrame.buffSlots[i].Frame:SetLayer(3)
		optionsFrame.buffSlots[i].Frame.Event.LeftUp=function () lb.optionsGui.buffAssociations.onSlotLeftUp(i) end
	 	optionsFrame.buffSlots[i].Text= UI.CreateLbFrame("Text", "UnitFrame", optionsFrame.buffSlots[i].Frame )
	 	optionsFrame.buffSlots[i].Text:SetPoint("CENTER", optionsFrame.buffSlots[i].Frame ,"CENTER",0,0)
	 	optionsFrame.buffSlots[i].Text:SetText(tostring(i))
	 	
	 	optionsFrame.buffSlots[i].X=slotinfo[3]*scalex*lb.optionsGui.PreviewScale[1]
	 	optionsFrame.buffSlots[i].Y=slotinfo[4]*scaley*lb.optionsGui.PreviewScale[2]
	 end
	 
	 --initializing sidetable
	 optionsFrame.SideTable=UI.CreateLbFrame("SimpleTabView", "OptionsWindowFrame", optionsFrame)
	 optionsFrame.SideTable:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 600, 50)
     optionsFrame.SideTable:SetPoint("BOTTOMRIGHT", optionsFrame, "BOTTOMRIGHT", -15, -15)
     optionsFrame.SideTable:SetLayer(35)
     optionsFrame.SideTable.Tabs={}
     
	 
	 --initialize abilities list
	 optionsFrame.SideTable.Tabs[1] = UI.CreateLbFrame("Frame", "BuffTab", optionsFrame.SideTable)
	 optionsFrame.SideTable:AddTab("Abilities",optionsFrame.SideTable.Tabs[1])
	 optionsFrame.AbilitiesList=UI.CreateLbFrame("AbilitiesList", "BuffsList", optionsFrame.SideTable.Tabs[1])
	 optionsFrame.AbilitiesList:CreateDragFrame(optionsFrame.AbilitiesList,optionsFrame.SideTable.Tabs[1],parentFrame)
	 optionsFrame.AbilitiesList.Event.DraggedOutItem= lb.optionsGui.buffAssociations.onAbilitiesItemDrag
	 optionsFrame.AbilitiesListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.SideTable.Tabs[1])
	 optionsFrame.AbilitiesListView:SetPoint("TOPLEFT", optionsFrame.SideTable.Tabs[1], "TOPLEFT",10, 20)
     optionsFrame.AbilitiesListView:SetWidth(300)
     optionsFrame.AbilitiesListView:SetHeight(350)
     optionsFrame.AbilitiesListView:SetLayer(1)
     optionsFrame.AbilitiesListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.AbilitiesListView:SetContent( optionsFrame.AbilitiesList)
     
     
	   
	 -- custom names
	 optionsFrame.SideTable.Tabs[2] = UI.CreateLbFrame("Frame", "CustomNamesTab", optionsFrame.SideTable)
	 optionsFrame.SideTable:AddTab("Custom Names",optionsFrame.SideTable.Tabs[2])
	 	 optionsFrame.CustomNamesList=UI.CreateLbFrame("AbilitiesList", "CustomNamesList",optionsFrame.SideTable.Tabs[2])
	 optionsFrame.CustomNamesList:CreateDragFrame(optionsFrame.CustomNamesList,optionsFrame.SideTable.Tabs[2],parentFrame)
	 optionsFrame.CustomNamesList.Event.DraggedOutItem=lb.optionsGui.buffAssociations.onAbilitiesItemDrag
	 optionsFrame.CustomNamesListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.SideTable.Tabs[2])
	 optionsFrame.CustomNamesListView:SetPoint("TOPLEFT", optionsFrame.SideTable.Tabs[2], "TOPLEFT",10, 20)
     optionsFrame.CustomNamesListView:SetWidth(200)
     optionsFrame.CustomNamesListView:SetHeight(300)
     optionsFrame.CustomNamesListView:SetLayer(1)
     optionsFrame.CustomNamesListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.CustomNamesListView:SetContent( optionsFrame.CustomNamesList)
     optionsFrame.SideTable.Tabs[2].txtNewCustomName=UI.CreateLbFrame("RiftTextfield", "txtNewCustomName", optionsFrame.SideTable.Tabs[2])
	 optionsFrame.SideTable.Tabs[2].txtNewCustomName:SetPoint("TOPLEFT", optionsFrame.SideTable.Tabs[2], "TOPLEFT",10, 360)
	 optionsFrame.SideTable.Tabs[2].txtNewCustomName:SetWidth(100)
	 optionsFrame.SideTable.Tabs[2].txtNewCustomName:SetHeight(30)
	 optionsFrame.SideTable.Tabs[2].txtNewCustomName:SetBackgroundColor(0,0,0,1)
	   --initialize add Button
	 optionsFrame.SideTable.Tabs[2].addCustomNameButton=UI.CreateLbFrame("RiftButton", "ApplyButton", optionsFrame.SideTable.Tabs[2])
	 optionsFrame.SideTable.Tabs[2].addCustomNameButton:SetPoint("TOPLEFT", optionsFrame.SideTable.Tabs[2],"TOPLEFT",120,360)
	 optionsFrame.SideTable.Tabs[2].addCustomNameButton:SetText("Add")
	 optionsFrame.SideTable.Tabs[2].addCustomNameButton:SetWidth(100)
	 optionsFrame.SideTable.Tabs[2].addCustomNameButton.Event.LeftClick=lb.optionsGui.buffAssociations.addCustomName
	    --initialize remove Button
	 optionsFrame.SideTable.Tabs[2].removeCustomNameButton=UI.CreateLbFrame("RiftButton", "ApplyButton", optionsFrame.SideTable.Tabs[2])
	 optionsFrame.SideTable.Tabs[2].removeCustomNameButton:SetPoint("TOPLEFT", optionsFrame.SideTable.Tabs[2],"TOPLEFT",10,320)
	 optionsFrame.SideTable.Tabs[2].removeCustomNameButton:SetText("Remove")
	 optionsFrame.SideTable.Tabs[2].removeCustomNameButton:SetWidth(200)
	 optionsFrame.SideTable.Tabs[2].removeCustomNameButton.Event.LeftClick=lb.optionsGui.buffAssociations.removeCustomName
     
     
     
     
	 
	 ----initializing slot details list
	 optionsFrame.SlotDetailsList=UI.CreateLbFrame("AbilitiesList", "BuffsList", optionsFrame)
	 optionsFrame.SlotDetailsList:CreateDragFrame(optionsFrame.SlotDetailsList,optionsFrame,parentFrame)
	 optionsFrame.SlotDetailsList.Event.DraggedOutItem= lb.optionsGui.buffAssociations.onSlotDetailItemDrag
	 optionsFrame.SlotDetailsListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame)
	 optionsFrame.SlotDetailsListView:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",10, 270)
     optionsFrame.SlotDetailsListView:SetWidth(250)
     optionsFrame.SlotDetailsListView:SetHeight(220)
     optionsFrame.SlotDetailsListView:SetLayer(1)
     optionsFrame.SlotDetailsListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.SlotDetailsListView:SetContent( optionsFrame.SlotDetailsList)
	 optionsFrame.SlotDetailsListView:SetVisible(false)
	 ----initializing  slot details options
	 optionsFrame.SlotDetailsList.Event.ItemSelect=lb.optionsGui.buffAssociations.onSlotAssociationSelected
	 optionsFrame.SlotDetailsOptions={}
	 --cast by me only
	 optionsFrame.SlotDetailsOptions.CastByMeOnly=UI.CreateLbFrame("SimpleCheckbox", "SlotDetailsOptions.CastByMeOnlyCastByme", optionsFrame)
	 optionsFrame.SlotDetailsOptions.CastByMeOnly:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",270, 270)
	 optionsFrame.SlotDetailsOptions.CastByMeOnly:SetText("Cast By Me only")
	 optionsFrame.SlotDetailsOptions.CastByMeOnly:SetVisible(false)
	 optionsFrame.SlotDetailsOptions.CastByMeOnly.Event.CheckboxChange=lb.optionsGui.buffAssociations.onCHKCastByMeChanged
	 --priority buff
	 optionsFrame.SlotDetailsOptions.PriorityBuff=UI.CreateLbFrame("SimpleCheckbox", "SlotDetailsOptions.PriorityBuffPriority", optionsFrame)
	 optionsFrame.SlotDetailsOptions.PriorityBuff:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",270, 300)
	 optionsFrame.SlotDetailsOptions.PriorityBuff:SetText("Has priority")
	 optionsFrame.SlotDetailsOptions.PriorityBuff:SetVisible(false)
	 optionsFrame.SlotDetailsOptions.PriorityBuff.Event.CheckboxChange=lb.optionsGui.buffAssociations.onCHKPriorityChanged
	 
	 lb.optionsGui.buffAssociations.populateList()
	 
	 return optionsFrame
end


function lb.optionsGui.buffAssociations.populateList()
	local list={}
	 local abs=Inspect.Ability.Detail(Inspect.Ability.List())
	 local counter=1
	 for k,ab in pairs(abs) do
		local name=ab.name
		
	     list[counter]={name,"Rift",ab.icon}
	     list[counter][8]=ab.description
	     counter=counter+1
	 end
	 table.sort(list, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 frame.AbilitiesList:SetItems(list)
	  --custom names
	 local CNList={}
	 
	 local CNcounter=1
	 local cnl= lb.customNames.getCustomNames()
	 for k,ab in pairs(cnl) do
		local name=ab
		local texture=lb.iconsCache.getTextureFromCache(name)
		if texture[1]=="LifeBinder" then
			local dbval= getDebuffFromCache(name)
			if dbval ~=nil then
				texture[1]=dbval[2]
				texture[2]=dbval[3]
			end
		end
	     CNList[CNcounter]={name,texture[1],texture[2]}
	     CNcounter=CNcounter+1
	 end
	 table.sort(CNList, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 frame.CustomNamesList:SetItems(CNList)
end

function lb.optionsGui.buffAssociations.onSlotLeftUp(slotindex)
--print("leftup")
	if lastIndex~=-1 then
		frame.buffSlots[lastIndex].Frame:SetBackgroundColor(0,1,0.2,1)
	end
	frame.buffSlots[slotindex].Frame:SetBackgroundColor(0,0,1,1)
	
	if lastIndex~=slotindex then
		 lastIndex=slotindex
		 lb.optionsGui.buffAssociations.ReadSlotData(slotindex)	
	end
end

function lb.optionsGui.buffAssociations.ReadSlotData(slotindex)
	lb.buffMonitor.updateSpellTextures()
	local buffs =lbSelectedBuffsList[lbValues.set][slotindex][1]
	local list={}
	local counter=1

	for key,buffTable in pairs(buffs) do
		local name=key
		local texture=lb.iconsCache.getTextureFromCache(name)
		list[counter]={name,texture[1],texture[2]}
		counter=counter+1
	end
	table.sort(list, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	frame.SlotDetailsList:SetItems(list)
	frame.SlotDetailsListView:SetVisible(true)
	frame.SlotDetailsOptions.CastByMeOnly:SetVisible(false)
	frame.SlotDetailsOptions.PriorityBuff:SetVisible(false)
end

function lb.optionsGui.buffAssociations.onAbilitiesItemDrag(item,x,y)
	for i = 1 , #(lbBuffSlotOptions[lbValues.set]) do
		if lb.optionsGui.isPointInFrame(frame.buffSlots[i].Frame,x,y) then
			--print ("into slot" ..tostring(i))
			local slotindex=i
			local buffs =lbSelectedBuffsList[lbValues.set][slotindex][1]
			if buffs[item[1]]==nil then
				buffs[item[1]]={castByMeOnly=true,showCount=true,showDuration=true}
			end
			
		    lb.optionsGui.buffAssociations.ReadSlotData(i)
			
			return
			
		end
	end
	if lastIndex~=nil then
		if lb.optionsGui.isPointInFrame(frame.SlotDetailsListView,x,y) then
			local buffs =lbSelectedBuffsList[lbValues.set][lastIndex][1]
			if buffs[item[1]]==nil then
				buffs[item[1]]={castByMeOnly=true,showCount=true,showDuration=true}
			end
			lb.optionsGui.buffAssociations.ReadSlotData(lastIndex)
		end
	end
	
end

function lb.optionsGui.buffAssociations.onSlotDetailItemDrag(item,x,y)
	--print("leftout")
	if lastIndex==-1 then return end
	for i = 1 , #(lbBuffSlotOptions[lbValues.set]) do
		if lb.optionsGui.isPointInFrame(frame.buffSlots[i].Frame,x,y) then
			local lastindex=lastIndex
			if lastIndex~=-1 then
				local lastbuffs =lbSelectedBuffsList[lbValues.set][lastIndex][1]
				lastbuffs[item[1]]=nil
			end
			local slotindex=i
			local buffs =lbSelectedBuffsList[lbValues.set][slotindex][1]
			if buffs[item[1]]==nil then
				buffs[item[1]]={castByMeOnly=true,showCount=true,showDuration=true}
			end
		    lb.optionsGui.buffAssociations.ReadSlotData(i)
			return
			
		end
	end
	if lb.optionsGui.isPointInFrame(frame.SideTable,x,y) then
		local lastindex=lastIndex
			if lastIndex~=-1 then
				local lastbuffs =lbSelectedBuffsList[lbValues.set][lastIndex][1]
				lastbuffs[item[1]]=nil
				lb.optionsGui.buffAssociations.ReadSlotData(lastIndex)
			end
	end
	
end

function lb.optionsGui.buffAssociations.updateData()
	for i =1 ,#(lbBuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotOptions[lbValues.set][i]
	 	if frame.buffSlots[i]==nil then frame.buffSlots[i]={} end
	 	if frame.buffSlots[i].Frame==nil then  frame.buffSlots[i].Frame= UI.CreateLbFrame("Texture", "UnitFrame",  frame.UnitFrame ) end
	 	if frame.buffSlots[i].Text ==nil then  frame.buffSlots[i].Text= UI.CreateLbFrame("Text", "UnitFrame", frame.buffSlots[i].Frame ) end
	 	frame.buffSlots[i].Frame:SetPoint(slotinfo[1],frame.UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.optionsGui.PreviewScale[1], slotinfo[4]*scaley*lb.optionsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	frame.buffSlots[i].Frame:SetWidth(iconl*lb.optionsGui.PreviewScale[1])
	 	frame.buffSlots[i].Frame:SetHeight(iconl*lb.optionsGui.PreviewScale[2])
	 	frame.buffSlots[i].Frame:SetBackgroundColor(0,1,0.2,1)
	 	frame.buffSlots[i].Frame:SetLayer(3)
		frame.buffSlots[i].Frame.Event.LeftUp=function () lb.optionsGui.buffAssociations.onSlotLeftUp(i) end
		frame.buffSlots[i].Frame:SetVisible(true)
	 	frame.buffSlots[i].Text= UI.CreateLbFrame("Text", "UnitFrame", frame.buffSlots[i].Frame )
	 	frame.buffSlots[i].Text:SetPoint("CENTER", frame.buffSlots[i].Frame ,"CENTER",0,0)
	 	frame.buffSlots[i].Text:SetText(tostring(i))
	 	frame.buffSlots[i].X=slotinfo[3]*scalex*lb.optionsGui.PreviewScale[1]
	 	frame.buffSlots[i].Y=slotinfo[4]*scaley*lb.optionsGui.PreviewScale[2]
	 end
	 if #(lbBuffSlotOptions[lbValues.set])<#(frame.buffSlots) then
	 	for i = #(lbBuffSlotOptions[lbValues.set])+1,#(frame.buffSlots) do
	 		if frame.buffSlots[i]~=nil then
	 			if frame.buffSlots[i].Frame~=nil then
		 			frame.buffSlots[i].Frame:SetVisible(false)
		 		end
	 		end
	 	end
	 end
	 lastIndex=-1
	 frame.SlotDetailsOptions.CastByMeOnly:SetVisible(false)
	 frame.SlotDetailsOptions.PriorityBuff:SetVisible(false)
	  frame.SlotDetailsListView:SetVisible(false)
	lb.optionsGui.buffAssociations.populateList()
end


function lb.optionsGui.buffAssociations.onSlotAssociationSelected(item,value,index)
	local buffname=value[1]
	local buffs =lbSelectedBuffsList[lbValues.set][lastIndex][1]
	
	for key,buffTable in pairs(buffs) do
		local name=key
		
		if key==buffname then
			checkedinit=true
		 	frame.SlotDetailsOptions.CastByMeOnly:SetChecked(buffTable.castByMeOnly)
		 	frame.SlotDetailsOptions.PriorityBuff:SetChecked(buffTable.priority==true)
			checkedinit=false
			frame.SlotDetailsOptions.CastByMeOnly:SetVisible(true)
			frame.SlotDetailsOptions.PriorityBuff:SetVisible(true)
		end
	end
end

function lb.optionsGui.buffAssociations.onCHKCastByMeChanged()
	if checkedinit then return end
	
	local buffname=frame.SlotDetailsList:GetSelectedItem()[1]
	
	local buffs =lbSelectedBuffsList[lbValues.set][lastIndex][1]
	
	for key,buffTable in pairs(buffs) do
		local name=key
		if key==buffname then
			buffTable.castByMeOnly=frame.SlotDetailsOptions.CastByMeOnly:GetChecked()
		end
	end
end

function lb.optionsGui.buffAssociations.onCHKPriorityChanged()
	if checkedinit then return end
	
	local buffname=frame.SlotDetailsList:GetSelectedItem()[1]
	
	local buffs =lbSelectedBuffsList[lbValues.set][lastIndex][1]
	
	for key,buffTable in pairs(buffs) do
		local name=key
		if key==buffname then
			buffTable.priority=frame.SlotDetailsOptions.PriorityBuff:GetChecked()
		end
	end
end

function lb.optionsGui.buffAssociations.addCustomName()
	local text= frame.SideTable.Tabs[2].txtNewCustomName:GetText()
	if text~=nil and text~="" then
		 lb.customNames.addCustomName(text)
		 ClearKeyFocus()
		 
		 lb.optionsGui.buffAssociations.populateList() -- populate lists
	end
end

function lb.optionsGui.buffAssociations.removeCustomName()
	local item= frame.CustomNamesList:GetSelectedItem()
	if item~=nil then
		 lb.customNames.removeCustomName(item[1])
		
		 lb.optionsGui.buffAssociations.populateList() -- populate lists
	end
end
