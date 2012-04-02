lb.slotsGui.debuffManager={}
local frame
function lb.slotsGui.debuffManager.createTable(parentFrame)
	 optionsFrame = UI.CreateFrame("Frame", "DebuffManagementTab", parentFrame)
	 frame=optionsFrame
	 
	 
	 --initializing debuffTable
	 optionsFrame.DebuffsTable=UI.CreateFrame("SimpleTabView", "OptionsWindowFrame", optionsFrame)
	 optionsFrame.DebuffsTable:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT", 350, 50)
     optionsFrame.DebuffsTable:SetPoint("BOTTOMRIGHT", optionsFrame, "BOTTOMRIGHT", -370, -15)
     optionsFrame.DebuffsTable:SetLayer(30)
     optionsFrame.DebuffsTable.Tabs={}
	 
	 
	 --initialize debuffs list
     optionsFrame.DebuffsTable.Tabs[1] = UI.CreateFrame("Frame", "BuffTab", optionsFrame.DebuffsTable)
	 optionsFrame.DebuffsTable:AddTab("Debuffs",optionsFrame.DebuffsTable.Tabs[1])
	 optionsFrame.DebuffsList=UI.CreateFrame("AbilitiesList", "DebuffsList",optionsFrame.DebuffsTable.Tabs[1])
	 optionsFrame.DebuffsList:CreateDragFrame(optionsFrame.DebuffsList,optionsFrame.DebuffsTable.Tabs[1],parentFrame)
	 optionsFrame.DebuffsList.Event.DraggedOutItem= lb.slotsGui.debuffManager.onDebuffItemDrag
	 optionsFrame.DebuffsListView=UI.CreateFrame("SimpleScrollView", "List", optionsFrame.DebuffsTable.Tabs[1])
	 optionsFrame.DebuffsListView:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[1], "TOPLEFT",10, 20)
     optionsFrame.DebuffsListView:SetWidth(200)
     optionsFrame.DebuffsListView:SetHeight(350)
     optionsFrame.DebuffsListView:SetLayer(1)
     optionsFrame.DebuffsListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.DebuffsListView:SetContent( optionsFrame.DebuffsList)
        
	 
	  -- custom names
	 optionsFrame.DebuffsTable.Tabs[2] = UI.CreateFrame("Frame", "CustomNamesTab", optionsFrame.DebuffsTable)
	 optionsFrame.DebuffsTable:AddTab("Custom Names",optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.CustomNamesList=UI.CreateFrame("AbilitiesList", "CustomNamesList",optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.CustomNamesList:CreateDragFrame(optionsFrame.CustomNamesList,optionsFrame.DebuffsTable.Tabs[2],parentFrame)
	 optionsFrame.CustomNamesList.Event.DraggedOutItem= lb.slotsGui.debuffManager.onDebuffItemDrag
	 optionsFrame.CustomNamesListView=UI.CreateFrame("SimpleScrollView", "List", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.CustomNamesListView:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2], "TOPLEFT",10, 20)
     optionsFrame.CustomNamesListView:SetWidth(200)
     optionsFrame.CustomNamesListView:SetHeight(300)
     optionsFrame.CustomNamesListView:SetLayer(1)
     optionsFrame.CustomNamesListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.CustomNamesListView:SetContent( optionsFrame.CustomNamesList)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName=UI.CreateFrame("RiftTextfield", "txtNewCustomName", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2], "TOPLEFT",10, 360)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetWidth(100)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetHeight(30)
	 optionsFrame.DebuffsTable.Tabs[2].txtNewCustomName:SetBackgroundColor(0,0,0,1)
	   --initialize add Button
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton=UI.CreateFrame("RiftButton", "ApplyButton", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2],"TOPLEFT",120,360)
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton:SetText("Add")
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton:SetWidth(100)
	 optionsFrame.DebuffsTable.Tabs[2].addCustomNameButton.Event.LeftClick=lb.slotsGui.debuffManager.addCustomName
	    --initialize add Button
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton=UI.CreateFrame("RiftButton", "ApplyButton", optionsFrame.DebuffsTable.Tabs[2])
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton:SetPoint("TOPLEFT", optionsFrame.DebuffsTable.Tabs[2],"TOPLEFT",10,320)
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton:SetText("Remove")
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton:SetWidth(200)
	 optionsFrame.DebuffsTable.Tabs[2].removeCustomNameButton.Event.LeftClick=lb.slotsGui.debuffManager.removeCustomName
	 
	 --- initializing  whitelist
	 --adds the whitelist
	 optionsFrame.WhiteList=UI.CreateFrame("AbilitiesList", "WhiteList",optionsFrame)
	 optionsFrame.WhiteList:CreateDragFrame(optionsFrame.WhiteList,optionsFrame,parentFrame)
	 optionsFrame.WhiteList.Event.DraggedOutItem= lb.slotsGui.debuffManager.onWhiteListItemDrag
	 optionsFrame.WhiteListView=UI.CreateFrame("SimpleScrollView", "List", optionsFrame)
	 
	 optionsFrame.WhiteListView:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",40, 70)
     optionsFrame.WhiteListView:SetWidth(250)
     optionsFrame.WhiteListView:SetHeight(300)
     optionsFrame.WhiteListView:SetLayer(1)
     optionsFrame.WhiteListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.WhiteListView:SetContent( optionsFrame.WhiteList)
	 
	  --adds the BlackList
	 optionsFrame.BlackList=UI.CreateFrame("AbilitiesList", "BlackList",optionsFrame)
	 optionsFrame.BlackList:CreateDragFrame(optionsFrame.BlackList,optionsFrame,parentFrame)
	 optionsFrame.BlackList.Event.DraggedOutItem= lb.slotsGui.debuffManager.onBlackListItemDrag
	 optionsFrame.BlackListView=UI.CreateFrame("SimpleScrollView", "List", optionsFrame)
	 optionsFrame.BlackListView:SetPoint("TOPLEFT", optionsFrame, "TOPLEFT",620, 70)
     optionsFrame.BlackListView:SetWidth(250)
     optionsFrame.BlackListView:SetHeight(300)
     optionsFrame.BlackListView:SetLayer(1)
     optionsFrame.BlackListView:SetBorder(1, 1, 1, 1, 1)
     optionsFrame.BlackListView:SetContent( optionsFrame.BlackList)
     lb.slotsGui.debuffManager.populateList()
	 return optionsFrame
end

function lb.slotsGui.debuffManager.populateList()
	---tab 4 debuffs list
	local dbList={}
	 
	 local dbcounter=1
	 for k,ab in pairs(lbDebuffCacheList) do
		local name=k
		 dbList[dbcounter]={name,"Rift",ab[3]}
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
				texture[1]=dbval[2]
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
				texture[1]=dbval[2]
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


function lb.slotsGui.debuffManager.onDebuffItemDrag(item,x,y)
	if lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].WhiteListView,x,y) then
		if lbDebuffWhitelist[lbValues.set][item[1]]==nil then
			lbDebuffWhitelist[lbValues.set][item[1]]={castByMe=false}
		end
	end
	if lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].BlackListView,x,y) then
		if lbDebuffBlackList[lbValues.set][item[1]]==nil then
			lbDebuffBlackList[lbValues.set][item[1]]={castByMe=false}
		end
	end
	lb.slotsGui.debuffManager.populateList()-- populate lists
end

function lb.slotsGui.debuffManager.onWhiteListItemDrag(item,x,y)
	if lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].DebuffsList,x,y) or lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].BlackListView,x,y) then
		lbDebuffWhitelist[lbValues.set][item[1]]=nil
		if lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].BlackListView,x,y) then
			if lbDebuffBlackList[lbValues.set][item[1]]==nil then
				lbDebuffBlackList[lbValues.set][item[1]]={castByMe=false}
			end
		end
	end
	lb.slotsGui.debuffManager.populateList() -- populate lists
end

function lb.slotsGui.debuffManager.onBlackListItemDrag(item,x,y)
	if lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].DebuffsList,x,y) or lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].WhiteListView,x,y) then
		lbDebuffBlackList[lbValues.set][item[1]]=nil
		if lb.slotsGui.isPointInFrame(lb.slotsGui.Tabs[4].WhiteListView,x,y) then
			if lbDebuffWhitelist[lbValues.set][item[1]]==nil then
				lbDebuffWhitelist[lbValues.set][item[1]]={castByMe=false}
			end
		end
	end
	lb.slotsGui.debuffManager.populateList() -- populate lists
end

function lb.slotsGui.debuffManager.updateData()
	lb.slotsGui.debuffManager.populateList()
end

function lb.slotsGui.debuffManager.addCustomName()
	local text= frame.DebuffsTable.Tabs[2].txtNewCustomName:GetText()
	if text~=nil and text~="" then
		 lb.customNames.addCustomName(text)
		 ClearKeyFocus()
		 
		 lb.slotsGui.debuffManager.populateList() -- populate lists
	end
end

function lb.slotsGui.debuffManager.removeCustomName()
	local item= frame.CustomNamesList:GetSelectedItem()
	if item~=nil then
		 lb.customNames.removeCustomName(item[1])
		
		 lb.slotsGui.debuffManager.populateList() -- populate lists
	end
end

