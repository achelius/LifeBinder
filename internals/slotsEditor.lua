lb.slotsGui={}
lb.slotsGui.initialized=false
--called when initializing the slot options gui
local slotdrag=false
lb.slotsGui.clickOffset = {x = 0, y = 0}
lb.slotsGui.selectedIndex=-1
lb.slotsGui.selectedType=-1
lb.slotsGui.PreviewScale={4,4} --scale of the preview unit frame

function lb.slotsGui.initialize()
	 local scalex=1-- lb.styles[lb.currentStyle].getFrameWidth()*0.009009009
	 local scaley=1--lb.styles[lb.currentStyle].getFrameHeight()*0.023255814
	 lb.slotsGui.Window=UI.CreateFrame("SimpleWindow", "Options", lb.Context)
	 lb.slotsGui.Window:SetPoint("CENTER", UIParent, "CENTER")
	 lb.slotsGui.Window:SetWidth(850)
	 lb.slotsGui.Window:SetHeight(600)
	 lb.slotsGui.Window:SetLayer(10)
	 lb.slotsGui.Window:SetVisible(true)
	 lb.slotsGui.Window:SetCloseButtonVisible(true)
	 lb.slotsGui.Window.Event.Close=function()lb.buffMonitor.hideDummyBuffMonitorSlots() lb.debuffMonitor.hideDummyDebuffMonitorSlots() ClearKeyFocus() end
	 -----tab definitions
	 lb.slotsGui.TabControl=UI.CreateFrame("SimpleTabView", "OptionsWindowFrame", lb.slotsGui.Window)
	 lb.slotsGui.Tabs = {}
	 lb.slotsGui.TabControl:SetPoint("TOPLEFT", lb.slotsGui.Window, "TOPLEFT", 15, 50)
     lb.slotsGui.TabControl:SetPoint("BOTTOMRIGHT", lb.slotsGui.Window, "BOTTOMRIGHT", -15, -15)
	 lb.slotsGui.Tabs[1]={}
	 lb.slotsGui.Tabs[1].MainFrame = UI.CreateFrame("Frame", "OptionsWindowA", lb.slotsGui.TabControl)
	 lb.slotsGui.TabControl:AddTab("Slots Editor",lb.slotsGui.Tabs[1].MainFrame)
	 ------initialize tab 1
	 
	 lb.slotsGui.Tabs[1].UnitFrame = UI.CreateFrame("Texture", "UnitFrame", lb.slotsGui.Tabs[1].MainFrame )
	 lb.slotsGui.Tabs[1].UnitFrame:SetPoint("TOPLEFT",lb.slotsGui.Tabs[1].MainFrame , "TOPLEFT", 20, 50)
	 lb.slotsGui.Tabs[1].UnitFrame:SetWidth(lb.styles[lb.currentStyle].getFrameWidth()*lb.slotsGui.PreviewScale[1])
	 lb.slotsGui.Tabs[1].UnitFrame:SetHeight(lb.styles[lb.currentStyle].getFrameHeight()*lb.slotsGui.PreviewScale[2])
	 
	 lb.slotsGui.Tabs[1].UnitFrame:SetTexture("LifeBinder", lb.styles[lb.currentStyle].getHealthFrameTexture())
	 ------initialize Slots
	 lb.slotsGui.Tabs[1].buffSlots={}
	 
	 for i =1 ,#(lbBuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotOptions[lbValues.set][i]
	 	lb.slotsGui.Tabs[1].buffSlots[i]={}
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  lb.slotsGui.Tabs[1].UnitFrame )
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame:SetPoint(slotinfo[1],lb.slotsGui.Tabs[1].UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame:SetBackgroundColor(0,1,0.1,1)
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame:SetLayer(3)
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame.Event.LeftDown=function () lb.slotsGui.onSlotLeftDown(0,i) end --0 means that's a buff
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame.Event.LeftUp=function () lb.slotsGui.onSlotLeftUp(0,i) end
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.onSlotUpoutside(0,i) end
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(0,i,x,y) end
	 	lb.slotsGui.Tabs[1].buffSlots[i].Text= UI.CreateFrame("Text", "UnitFrame", lb.slotsGui.Tabs[1].buffSlots[i].Frame )
	 	lb.slotsGui.Tabs[1].buffSlots[i].Text:SetPoint("CENTER", lb.slotsGui.Tabs[1].buffSlots[i].Frame ,"CENTER",0,0)
	 	lb.slotsGui.Tabs[1].buffSlots[i].Text:SetText(tostring(i))
	 	
	 	lb.slotsGui.Tabs[1].buffSlots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	lb.slotsGui.Tabs[1].buffSlots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
	 
	  lb.slotsGui.Tabs[1].debuffSlots={}
	 
	 for i =1 ,#(lbDebuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbDebuffSlotOptions[lbValues.set][i]
	 	lb.slotsGui.Tabs[1].debuffSlots[i]={}
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  lb.slotsGui.Tabs[1].UnitFrame )
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame:SetPoint(slotinfo[1],lb.slotsGui.Tabs[1].UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame:SetBackgroundColor(1,0,0,1)
	 	lb.slotsGui.Tabs[1].buffSlots[i].Frame:SetLayer(2)
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame.Event.LeftDown=function () lb.slotsGui.onSlotLeftDown(1,i) end
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame.Event.LeftUp=function () lb.slotsGui.onSlotLeftUp(1,i) end
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.onSlotUpoutside(1,i) end
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(1,i,x,y) end
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Text= UI.CreateFrame("Text", "UnitFrame", lb.slotsGui.Tabs[1].debuffSlots[i].Frame )
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Text:SetPoint("CENTER", lb.slotsGui.Tabs[1].debuffSlots[i].Frame ,"CENTER",0,0)
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Text:SetText(tostring(i))
	 	lb.slotsGui.Tabs[1].debuffSlots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	lb.slotsGui.Tabs[1].debuffSlots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
	 lb.buffMonitor.showDummyBuffMonitorSlots()
	lb.debuffMonitor.showDummyDebuffMonitorSlots() 
	 
	 
	 
	 --initialize Apply Button
	 lb.slotsGui.Tabs[1].ApplyButton=UI.CreateFrame("RiftButton", "UnitFrame", lb.slotsGui.Tabs[1].MainFrame )
	 lb.slotsGui.Tabs[1].ApplyButton:SetPoint("BOTTOMRIGHT", lb.slotsGui.Tabs[1].MainFrame,"BOTTOMRIGHT",-5,-5)
	 lb.slotsGui.Tabs[1].ApplyButton:SetText("Apply")
	 lb.slotsGui.Tabs[1].ApplyButton.Event.LeftClick=function() lb.buffMonitor.relocateBuffMonitorSlots() lb.debuffMonitor.relocateDebuffMonitorSlots() end
	 --initialize abilities list
	 lb.slotsGui.Tabs[1].AbilitesList=UI.CreateFrame("AbilitiesList", "List", lb.slotsGui.Tabs[1].MainFrame)
	 
	 lb.slotsGui.Tabs[1].AbilitesListView=UI.CreateFrame("SimpleScrollView", "List", lb.slotsGui.Tabs[1].MainFrame)
	 lb.slotsGui.Tabs[1].AbilitesListView:SetPoint("TOPLEFT", lb.slotsGui.Tabs[1].MainFrame, "TOPLEFT",600, 100)
     lb.slotsGui.Tabs[1].AbilitesListView:SetWidth(140)
     lb.slotsGui.Tabs[1].AbilitesListView:SetHeight(240)
     lb.slotsGui.Tabs[1].AbilitesListView:SetLayer(1)
     lb.slotsGui.Tabs[1].AbilitesListView:SetBorder(1, 1, 1, 1, 1)
     lb.slotsGui.Tabs[1].AbilitesListView:SetContent( lb.slotsGui.Tabs[1].AbilitesList)
        
	 
	 local list={}
	 
	 local abs=Inspect.Ability.Detail(Inspect.Ability.List())
	 local counter=1
	 for k,ab in pairs(abs) do
		local name=ab.name
		local texture=lb.iconsCache.getTextureFromCache(name)
	     list[counter]={name,"Rift",ab.icon}
	     counter=counter+1
	 end
	 lb.slotsGui.Tabs[1].AbilitesList:SetItems(list)
	 
	 lb.slotsGui.initialized=true
end

function lb.slotsGui.show()
	if lb.slotsGui.initialized then
		lb.slotsGui.Window:SetVisible(true)
		lb.buffMonitor.showDummyBuffMonitorSlots()
		lb.debuffMonitor.showDummyDebuffMonitorSlots()
	else
		lb.slotsGui.initialize()
	end
end
function lb.slotsGui.hide()
	if lb.slotsGui.initialized then
		lb.slotsGui.Window:SetVisible(false)
		lb.buffMonitor.hideDummyBuffMonitorSlots()
		lb.debuffMonitor.hideDummyDebuffMonitorSlots()
	end
end
function lb.slotsGui.onSlotLeftDown(type,index)
    if not lbValues.isincombat then
        slotdrag = true
        
        local mouseStatus = Inspect.Mouse()
        
        local slots=nil
        if type==0 then slots= lb.slotsGui.Tabs[1].buffSlots end
        if type==1 then slots= lb.slotsGui.Tabs[1].debuffSlots end
        slots[index].Frame:SetBackgroundColor(0,0,1,1) 
        if  (lb.slotsGui.selectedIndex~=-1 and lb.slotsGui.selectedIndex~=index) or (lb.slotsGui.selectedType~=-1 and lb.slotsGui.selectedType~=index) then
        	if lb.slotsGui.selectedType==0 then
         		lb.slotsGui.Tabs[1].buffSlots[lb.slotsGui.selectedIndex].Frame:SetBackgroundColor(0,1,0,1)
         	elseif lb.slotsGui.selectedType==1 then
         		lb.slotsGui.Tabs[1].debuffSlots[lb.slotsGui.selectedIndex].Frame:SetBackgroundColor(1,0,0,1)
         	end
        end 
        lb.slotsGui.selectedIndex=index
        lb.slotsGui.selectedType=type
        --print (slot:GetPosition()[1])
       	lb.slotsGui.clickOffset ["x"] = mouseStatus.x - slots[index].X
        lb.slotsGui.clickOffset ["y"] = mouseStatus.y - slots[index].Y
    end
end

function lb.slotsGui.onSlotLeftUp(type,index)
if  lb.slotsGui.selectedIndex~=index then return end
if  lb.slotsGui.selectedType~=type then return end
    slotdrag = false
    --lb.slotsGui.Tabs[1].buffSlots[index].Frame:SetBackgroundColor(0,0,0,1)
end

function lb.slotsGui.onSlotUpoutside(type,index)
if  lb.slotsGui.selectedIndex~=index then return end
if  lb.slotsGui.selectedType~=type then return end
    slotdrag = false
    --lb.slotsGui.Tabs[1].buffSlots[index].Frame:SetBackgroundColor(0,0,0,1) 
end

function lb.slotsGui.OnSlotMouseMove(type,index,x,y)
if  lb.slotsGui.selectedIndex~=index then return end
if  lb.slotsGui.selectedType~=type then return end
    --print (tostring(x).."-"..tostring(y))
    if lbValues.isincombat then
        slotdrag = false
        return
    end
    if slotdrag == true then
    	local scalex=1--lbValues.mainwidth*0.009009009
	 	local scaley=1--lbValues.mainheight*0.023255814
    	local newx=x-(lb.slotsGui.clickOffset["x"])
    	local newy=y-(lb.slotsGui.clickOffset["y"])
    	local slots=nil
    	local options=nil 
        if type==0 then slots=lb.slotsGui.Tabs[1].buffSlots options=lbBuffSlotOptions end
        if type==1 then slots=lb.slotsGui.Tabs[1].debuffSlots options=lbDebuffSlotOptions end 
        
   		slots[index].X=newx
	 	slots[index].Y=newy
	 
	 	
	 	---Experimental
	 	options[lbValues.set][index][3]=newx/scalex/lb.slotsGui.PreviewScale[1]
	 	options[lbValues.set][index][4]=newy/scaley/lb.slotsGui.PreviewScale[2]
	 	
	 	----
	 	if type==0 then lb.buffMonitor.relocateSingleBuffMonitorSlot(index) end
	 	if type==1 then lb.debuffMonitor.relocateSingleDebuffMonitorSlot(index) end
		slots[index].Frame:SetPoint("TOPLEFT", lb.slotsGui.Tabs[1].UnitFrame, "TOPLEFT", newx, newy)
		
    end
end







--called when changing spec
function lb.slotsGui.updateOptions()

end



context = UI.CreateContext("Fluff Context")
focushack = UI.CreateFrame("RiftTextfield", "focus hack", context)
focushack:SetVisible(false)
function ClearKeyFocus()
    focushack:SetKeyFocus(true)
    focushack:SetKeyFocus(false)
end
