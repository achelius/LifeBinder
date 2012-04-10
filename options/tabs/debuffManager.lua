lb.optionsGui.debuffManager={}
local frame
function lb.optionsGui.debuffManager.createTable(parentFrame)
	 optionsFrame = UI.CreateLbFrame("Frame", "DebuffManagementTab", parentFrame)
	 frame=optionsFrame
	 
	 
	 --initializing debuffTable
	 writeText("Drag Debuffs from here:","text",optionsFrame,350,30)
	 optionsFrame.DebuffsTable=UI.CreateLbFrame("SimpleTabView", "OptionsWindowFrame", optionsFrame)
	 optionsFrame.DebuffsTable:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 350, 50)
     optionsFrame.DebuffsTable:SetPoint("BOTTOMRIGHT", optionsFrame, "BOTTOMRIGHT", -370, -15)
     optionsFrame.DebuffsTable:SetLayer(30)
     optionsFrame.DebuffsTable.Tabs={}
	 
	 
	 --initialize debuffs list
     optionsFrame.DebuffsTable.Tabs[1] = UI.CreateLbFrame("Frame", "BuffTab", optionsFrame.DebuffsTable)
	 optionsFrame.DebuffsTable:AddTab("Debuffs",optionsFrame.DebuffsTable.Tabs[1])
	 optionsFrame.DebuffsList=UI.CreateLbFrame("AbilitiesList", "DebuffsList",optionsFrame.DebuffsTable.Tabs[1])
	 optionsFrame.DebuffsList:CreateDragFrame(optionsFrame.DebuffsList,optionsFrame.DebuffsTable.Tabs[1],parentFrame)
	 optionsFrame.DebuffsList.Event.DraggedOutItem= lb.optionsGui.debuffManager.onDebuffItemDrag
	 optionsFrame.DebuffsListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.DebuffsTable.Tabs[1])
	 optionsFrame.DebuffsListView:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[1], "TOPLEFT",10, 30)
     optionsFrame.DebuffsListView:SetWidth(200)
     optionsFrame.DebuffsListView:SetHeight(340)
     optionsFrame.DebuffsListView:SetLayer(1)
     optionsFrame.DebuffsListView:SetBorder(2, 2, 2, 2, 2)
     optionsFrame.DebuffsListView:SetContent( optionsFrame.DebuffsList)
     optionsFrame.DebuffsRecordingCheckbox=UI.CreateLbFrame("SimpleCheckbox", "DebuffsRecordingCheckbox",optionsFrame.DebuffsTable.Tabs[1])
     optionsFrame.DebuffsRecordingCheckbox:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[1], "TOPLEFT",10, 5)
     optionsFrame.DebuffsRecordingCheckbox:SetText("Enable Debuff recording")
     optionsFrame.DebuffsRecordingCheckbox:SetChecked(lbValues.CacheDebuffs)
     optionsFrame.DebuffsRecordingCheckbox.Event.CheckboxChange = function () lbValues.CacheDebuffs=optionsFrame.DebuffsRecordingCheckbox:GetChecked() end 
        
	 
	  -- custom names
	 
	 optionsFrame.DebuffsTable.Tabs[2] = UI.CreateLbFrame("Frame", "CustomNamesTab", optionsFrame.DebuffsTable)
	 optionsFrame.DebuffsTable:AddTab("Custom Names",optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.CustomNamesList=UI.CreateLbFrame("AbilitiesList", "CustomNamesList",optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.CustomNamesList:CreateDragFrame(optionsFrame.CustomNamesList,optionsFrame.DebuffsTable.Tabs[2],parentFrame)
	 optionsFrame.CustomNamesList.Event.DraggedOutItem= lb.optionsGui.debuffManager.onDebuffItemDrag
	 optionsFrame.CustomNamesListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.CustomNamesListView:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2], "TOPLEFT",10, 20)
     optionsFrame.CustomNamesListView:SetWidth(200)
     optionsFrame.CustomNamesListView:SetHeight(300)
     optionsFrame.CustomNamesListView:SetLayer(1)
     optionsFrame.CustomNamesListView:SetBorder(2, 2, 2, 2, 2)
     optionsFrame.CustomNamesListView:SetContent( optionsFrame.CustomNamesList)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName=UI.CreateLbFrame("RiftTextfield", "txtNewCustomName", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2], "TOPLEFT",10, 360)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetWidth(100)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetHeight(30)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetBackgroundColor(0,0,0,1)
	   --initialize add Button
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton=UI.CreateLbFrame("RiftButton", "ApplyButton", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2],"TOPLEFT",120,360)
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton:SetText("Add")
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton:SetWidth(100)
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton.Event.LeftClick=lb.optionsGui.debuffManager.addCustomName
	    --initialize add Button
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton=UI.CreateLbFrame("RiftButton", "ApplyButton", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2],"TOPLEFT",10,320)
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton:SetText("Remove")
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton:SetWidth(200)
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton.Event.LeftClick=lb.optionsGui.debuffManager.removeCustomName
	 
	 --- initializing  whitelist
	 --adds the whitelist
	 writeText("Whitelisted Debuffs","text",optionsFrame,40,50)
	 optionsFrame.WhiteList=UI.CreateLbFrame("AbilitiesList", "WhiteList",optionsFrame)
	 optionsFrame.WhiteList:CreateDragFrame(optionsFrame.WhiteList,optionsFrame,parentFrame)
	 optionsFrame.WhiteList.Event.DraggedOutItem= lb.optionsGui.debuffManager.onWhiteListItemDrag
	 optionsFrame.WhiteListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame)
	 
	 optionsFrame.WhiteListView:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",40, 70)
     optionsFrame.WhiteListView:SetWidth(250)
     optionsFrame.WhiteListView:SetHeight(300)
     optionsFrame.WhiteListView:SetLayer(1)
     optionsFrame.WhiteListView:SetBorder(2, 2, 2, 2, 2)
     optionsFrame.WhiteListView:SetContent( optionsFrame.WhiteList)
     
     local rolesList={}
	 for i= 1,6 do
		 rolesList[i]=tostring(i)
	 end
	 optionsFrame.whiteListCopyFromRole=lb.commonUtils.createComboBox(optionsFrame,"WhiteListCopyFromRole",10,10,rolesList,nil,"Import from role:")
	 optionsFrame.whiteListCopyFromRole.comboBox:SetWidth(50)
	 optionsFrame.whiteListCopyFromRoleButton=lb.commonUtils.createButton(optionsFrame,"WhiteListCopyFromRoleButton",200,5,120,40,"Import") 
	 optionsFrame.whiteListCopyFromRoleButton.Event.LeftClick=lb.optionsGui.debuffManager.copyWhitelistFromAnotherRole
	 
	  --adds the BlackList
	 writeText("Blacklisted Debuffs","text",optionsFrame,620,50)
	 optionsFrame.BlackList=UI.CreateLbFrame("AbilitiesList", "BlackList",optionsFrame)
	 optionsFrame.BlackList:CreateDragFrame(optionsFrame.BlackList,optionsFrame,parentFrame)
	 optionsFrame.BlackList.Event.DraggedOutItem= lb.optionsGui.debuffManager.onBlackListItemDrag
	 optionsFrame.BlackListView=UI.CreateLbFrame("SimpleScrollView", "List", optionsFrame)
	 optionsFrame.BlackListView:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",620, 70)
     optionsFrame.BlackListView:SetWidth(250)
     optionsFrame.BlackListView:SetHeight(300)
     optionsFrame.BlackListView:SetLayer(1)
     optionsFrame.BlackListView:SetBorder(2, 2, 2, 2, 2)
     optionsFrame.BlackListView:SetContent( optionsFrame.BlackList)
 
	 optionsFrame.blackListCopyFromRole=lb.commonUtils.createComboBox(optionsFrame,"BlackListCopyFromRole",620,10,rolesList,nil,"Import from role:")
	 optionsFrame.blackListCopyFromRole.comboBox:SetWidth(50)
	 optionsFrame.blackListCopyFromRoleButton=lb.commonUtils.createButton(optionsFrame,"BlackListCopyFromRoleButton",820,5,120,40,"Import") 
	 optionsFrame.blackListCopyFromRoleButton.Event.LeftClick=lb.optionsGui.debuffManager.copyBlacklistFromAnotherRole
	
     
     
     writeText("If it's not whitelisted and it's not blacklisted:","text",optionsFrame,620,380)
     optionsFrame.ShowCurableOnlyCheckBox=UI.CreateLbFrame("SimpleCheckbox", "ShowCurableOnlyCheckBox",optionsFrame)
     optionsFrame.ShowCurableOnlyCheckBox:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",620, 400)
     optionsFrame.ShowCurableOnlyCheckBox:SetText("Show only curable debuffs")
     optionsFrame.ShowCurableOnlyCheckBox:SetChecked(lbDebuffOptions[lbValues.set].showCurableOnly)
     optionsFrame.ShowCurableOnlyCheckBox.Event.CheckboxChange = lb.optionsGui.debuffManager.updateDebuffFilterOptions 
     
     optionsFrame.ShowPoisonCheckBox=UI.CreateLbFrame("SimpleCheckbox", "ShowPoisonCheckBox",optionsFrame)
     optionsFrame.ShowPoisonCheckBox:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",630, 420)
     optionsFrame.ShowPoisonCheckBox:SetText("Show poisons")
     optionsFrame.ShowPoisonCheckBox:SetChecked(lbDebuffOptions[lbValues.set].poison)
     optionsFrame.ShowPoisonCheckBox.Event.CheckboxChange = lb.optionsGui.debuffManager.updateDebuffFilterOptions
     
     optionsFrame.ShowCurseCheckBox=UI.CreateLbFrame("SimpleCheckbox", "ShowCurseCheckBox",optionsFrame)
     optionsFrame.ShowCurseCheckBox:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",630, 440)
     optionsFrame.ShowCurseCheckBox:SetText("Show curses")
     optionsFrame.ShowCurseCheckBox:SetChecked(lbDebuffOptions[lbValues.set].curse)
     optionsFrame.ShowCurseCheckBox.Event.CheckboxChange = lb.optionsGui.debuffManager.updateDebuffFilterOptions
     
     optionsFrame.ShowDiseaseCheckBox=UI.CreateLbFrame("SimpleCheckbox", "ShowDiseaseCheckBox",optionsFrame)
     optionsFrame.ShowDiseaseCheckBox:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",630, 460)
     optionsFrame.ShowDiseaseCheckBox:SetText("Show diseases")
     optionsFrame.ShowDiseaseCheckBox:SetChecked(lbDebuffOptions[lbValues.set].disease)
     optionsFrame.ShowDiseaseCheckBox.Event.CheckboxChange = lb.optionsGui.debuffManager.updateDebuffFilterOptions
     --optionsFrame.ShowCurableOnlyCheckBox:SetChecked(lbValues.CacheDebuffs)
     --optionsFrame.ShowCurableOnlyCheckBox.Event.CheckboxChange = function () lbValues.CacheDebuffs=optionsFrame.DebuffsRecordingCheckbox:GetChecked() end 
     
     
     lb.optionsGui.debuffManager.populateList()
     
	 return optionsFrame
end

function lb.optionsGui.debuffManager.updateDebuffFilterOptions()
	lbDebuffOptions[lbValues.set].showCurableOnly=optionsFrame.ShowCurableOnlyCheckBox:GetChecked()
	lbDebuffOptions[lbValues.set].poison=optionsFrame.ShowPoisonCheckBox:GetChecked()
	lbDebuffOptions[lbValues.set].curse=optionsFrame.ShowCurseCheckBox:GetChecked()
	lbDebuffOptions[lbValues.set].disease=optionsFrame.ShowDiseaseCheckBox:GetChecked()
	frame.ShowPoisonCheckBox:SetVisible(lbDebuffOptions[lbValues.set].showCurableOnly)
	frame.ShowCurseCheckBox:SetVisible(lbDebuffOptions[lbValues.set].showCurableOnly)
	frame.ShowDiseaseCheckBox:SetVisible(lbDebuffOptions[lbValues.set].showCurableOnly)
end

function lb.optionsGui.debuffManager.populateList()
	
	frame.ShowCurableOnlyCheckBox:SetChecked(lbDebuffOptions[lbValues.set].showCurableOnly)
	frame.ShowPoisonCheckBox:SetChecked(lbDebuffOptions[lbValues.set].poison)
	frame.ShowCurseCheckBox:SetChecked(lbDebuffOptions[lbValues.set].curse)
	frame.ShowDiseaseCheckBox:SetChecked(lbDebuffOptions[lbValues.set].disease)
	frame.ShowPoisonCheckBox:SetVisible(lbDebuffOptions[lbValues.set].showCurableOnly)
	frame.ShowCurseCheckBox:SetVisible(lbDebuffOptions[lbValues.set].showCurableOnly)
	frame.ShowDiseaseCheckBox:SetVisible(lbDebuffOptions[lbValues.set].showCurableOnly)
	
	
	
	---tab 4 debuffs list
	local dbList={}
	 
	 local dbcounter=1
	 for k,ab in pairs(lbDebuffCacheList) do
		local name=k
		 dbList[dbcounter]={name,"Rift",ab[3]}
		 dbList[dbcounter][8]=ab[2]
	     dbcounter=dbcounter+1
	 end
	 table.sort(dbList, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 frame.DebuffsList:SetItems(dbList)
	 
	 ---tab 4 whitelist
	 local WList={}
	 
	 local Wcounter=1
	 for k,ab in pairs(lbDebuffWhitelist[lbValues.set]) do
		local name=k
		local texture=lb.iconsCache.getTextureFromCache(name)
		if texture[1]=="LifeBinder" then
			local dbval= getDebuffFromCache(name)
			if dbval ~=nil then
				texture[1]="Rift"
				texture[2]=dbval[3]
			end
		end
	     WList[Wcounter]={name,texture[1],texture[2]}
	     Wcounter=Wcounter+1
	 end
	 table.sort(WList, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 frame.WhiteList:SetItems(WList)
	  ---tab 4 blacklist
	 local BList={}
	 
	 local Bcounter=1
	 for k,ab in pairs(lbDebuffBlackList[lbValues.set]) do
		local name=k
		local texture=lb.iconsCache.getTextureFromCache(name)
		if texture[1]=="LifeBinder" then
			local dbval= getDebuffFromCache(name)
			if dbval ~=nil then
				texture[1]="Rift"
				texture[2]=dbval[3]
			end
		end
	     BList[Bcounter]={name,texture[1],texture[2]}
	     Bcounter=Bcounter+1
	 end
	 table.sort(BList, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 frame.BlackList:SetItems(BList)
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
				texture[1]=dbval[3]
				texture[2]=dbval[3]
			end
		end
	     CNList[CNcounter]={name,texture[1],texture[2]}
	     CNcounter=CNcounter+1
	 end
	 table.sort(CNList, function(a,b) return a[1] < b[1] end) --sorts alphabetically
	 frame.CustomNamesList:SetItems(CNList)
end


function lb.optionsGui.debuffManager.onDebuffItemDrag(item,x,y)
	if lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].WhiteListView,x,y) then
		if lbDebuffWhitelist[lbValues.set][item[1]]==nil then
			lbDebuffWhitelist[lbValues.set][item[1]]={castByMe=false}
		end
	end
	if lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].BlackListView,x,y) then
		if lbDebuffBlackList[lbValues.set][item[1]]==nil then
			lbDebuffBlackList[lbValues.set][item[1]]={castByMe=false}
		end
	end
	lb.optionsGui.debuffManager.populateList()-- populate lists
end

function lb.optionsGui.debuffManager.onWhiteListItemDrag(item,x,y)

	if lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].DebuffsListView,x,y) or lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].BlackListView,x,y) then
		lbDebuffWhitelist[lbValues.set][item[1]]=nil
		if lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].BlackListView,x,y) then
			if lbDebuffBlackList[lbValues.set][item[1]]==nil then
				lbDebuffBlackList[lbValues.set][item[1]]={castByMe=false}
			end
		end
	end
	lb.optionsGui.debuffManager.populateList() -- populate lists
end

function lb.optionsGui.debuffManager.onBlackListItemDrag(item,x,y)
	if lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].DebuffsListView,x,y) or lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].WhiteListView,x,y) then
		lbDebuffBlackList[lbValues.set][item[1]]=nil
		if lb.optionsGui.isPointInFrame(lb.optionsGui.Tabs[4].WhiteListView,x,y) then
			if lbDebuffWhitelist[lbValues.set][item[1]]==nil then
				lbDebuffWhitelist[lbValues.set][item[1]]={castByMe=false}
			end
		end
	end
	lb.optionsGui.debuffManager.populateList() -- populate lists
end

function lb.optionsGui.debuffManager.copyWhitelistFromAnotherRole()
	--reads current selected item
	local index=optionsFrame.whiteListCopyFromRole.comboBox:GetSelectedIndex()
	
	if index==nil then return end
	if index~=lbValues.set then
		local counter=0
		for debName,debOpts in pairs(lbDebuffWhitelist[index]) do
			if lbDebuffWhitelist[lbValues.set][debName]==nil then
				counter=counter+1
				lbDebuffWhitelist[lbValues.set][debName]={}
				for propName,propValue in pairs(debOpts) do
					lbDebuffWhitelist[lbValues.set][debName][propName]=	propValue 
				end
			end
		end
		print ("Imported debuff priority list from role "..tostring(index).. " count:"..tostring(counter))
	end
	lb.optionsGui.debuffManager.populateList() -- populate lists
end

function lb.optionsGui.debuffManager.copyBlacklistFromAnotherRole()
	--reads current selected item
	local index=optionsFrame.blackListCopyFromRole.comboBox:GetSelectedIndex()
	
	if index==nil then return end
	if index~=lbValues.set then
		local counter=0
		for debName,debOpts in pairs(lbDebuffBlackList[index]) do
			if lbDebuffBlackList[lbValues.set][debName]==nil then
				counter=counter+1
				lbDebuffBlackList[lbValues.set][debName]={}
				for propName,propValue in pairs(debOpts) do
					lbDebuffBlackList[lbValues.set][debName][propName]=	propValue 
				end
			end
		end
		print ("Imported debuff priority list from role "..tostring(index).. " count:"..tostring(counter))
	end
	lb.optionsGui.debuffManager.populateList() -- populate lists
end

function lb.optionsGui.debuffManager.updateData()
	frame.DebuffsRecordingCheckbox:SetChecked(lbValues.CacheDebuffs)
	lb.optionsGui.debuffManager.populateList()
end

function lb.optionsGui.debuffManager.addCustomName()
	local text= frame.DebuffsTable.Tabs[2].txtNewCustomName:GetText()
	if text~=nil and text~="" then
		 lb.customNames.addCustomName(text)
		 ClearKeyFocus()
		 
		 lb.optionsGui.debuffManager.populateList() -- populate lists
	end
end

function lb.optionsGui.debuffManager.removeCustomName()
	local item= frame.CustomNamesList:GetSelectedItem()
	if item~=nil then
	print(item[1])
		 lb.customNames.removeCustomName(item[1])
		
		 lb.optionsGui.debuffManager.populateList() -- populate lists
	end
end

