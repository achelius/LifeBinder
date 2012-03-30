lb.slotsGui={}
lb.slotsGui.initialized=false
--called when initializing the slot options gui
local slotdrag=false
lb.slotsGui.clickOffset = {x = 0, y = 0}
lb.slotsGui.selectedIndex=-1
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
	 lb.slotsGui.Window.Event.Close=function()lb.buffMonitor.hideDummyBuffMonitorSlots() ClearKeyFocus() end
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
	 lb.slotsGui.Tabs[1].UnitFrame:SetPoint("TOPLEFT",lb.slotsGui.Tabs[1].MainFrame , "TOPLEFT", 20, 100)
	 lb.slotsGui.Tabs[1].UnitFrame:SetWidth(lb.styles[lb.currentStyle].getFrameWidth()*lb.slotsGui.PreviewScale[1])
	 lb.slotsGui.Tabs[1].UnitFrame:SetHeight(lb.styles[lb.currentStyle].getFrameHeight()*lb.slotsGui.PreviewScale[2])
	 
	 lb.slotsGui.Tabs[1].UnitFrame:SetTexture("LifeBinder", lb.styles[lb.currentStyle].getHealthFrameTexture())
	 ------initialize Slots
	 lb.slotsGui.Tabs[1].Slots={}
	 
	 for i =1 ,#(lbBuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotOptions[lbValues.set][i]
	 	lb.slotsGui.Tabs[1].Slots[i]={}
	 	lb.slotsGui.Tabs[1].Slots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  lb.slotsGui.Tabs[1].UnitFrame )
	 	lb.slotsGui.Tabs[1].Slots[i].Frame:SetPoint(slotinfo[1],lb.slotsGui.Tabs[1].UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	lb.slotsGui.Tabs[1].Slots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	lb.slotsGui.Tabs[1].Slots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	lb.slotsGui.Tabs[1].Slots[i].Frame:SetBackgroundColor(0,0,0,1)
	 	lb.slotsGui.Tabs[1].Slots[i].Frame.Event.LeftDown=function () lb.slotsGui.onSlotLeftDown(i) end
	 	lb.slotsGui.Tabs[1].Slots[i].Frame.Event.LeftUp=function () lb.slotsGui.onSlotLeftUp(i) end
	 	lb.slotsGui.Tabs[1].Slots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.onSlotUpoutside(i) end
	 	lb.slotsGui.Tabs[1].Slots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(i,x,y) end
	 	lb.slotsGui.Tabs[1].Slots[i].Text= UI.CreateFrame("Text", "UnitFrame", lb.slotsGui.Tabs[1].Slots[i].Frame )
	 	lb.slotsGui.Tabs[1].Slots[i].Text:SetPoint("CENTER", lb.slotsGui.Tabs[1].Slots[i].Frame ,"CENTER",0,0)
	 	lb.slotsGui.Tabs[1].Slots[i].Text:SetText(tostring(i))
	 	lb.slotsGui.Tabs[1].Slots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	lb.slotsGui.Tabs[1].Slots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
	 
	 --initialize Apply Button
	 lb.slotsGui.Tabs[1].ApplyButton=UI.CreateFrame("RiftButton", "UnitFrame", lb.slotsGui.Tabs[1].MainFrame )
	 lb.slotsGui.Tabs[1].ApplyButton:SetPoint("BOTTOMRIGHT", lb.slotsGui.Tabs[1].MainFrame,"BOTTOMRIGHT",-5,-5)
	 lb.slotsGui.Tabs[1].ApplyButton:SetText("Apply")
	 lb.slotsGui.Tabs[1].ApplyButton.Event.LeftClick=function() lb.buffMonitor.relocateBuffMonitorSlots() end
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
	 lb.buffMonitor.showDummyBuffMonitorSlots()
	 lb.slotsGui.initialized=true
end

function lb.slotsGui.show()
	if lb.slotsGui.initialized then
		lb.slotsGui.Window:SetVisible(true)
		lb.buffMonitor.showDummyBuffMonitorSlots()
	else
		lb.slotsGui.initialize()
	end
end
function lb.slotsGui.hide()
	if lb.slotsGui.initialized then
		lb.slotsGui.Window:SetVisible(false)
		lb.buffMonitor.hideDummyBuffMonitorSlots()
	end
end
function lb.slotsGui.onSlotLeftDown(index)
    if not lbValues.isincombat then
        slotdrag = true
        
        local mouseStatus = Inspect.Mouse()
        lb.slotsGui.Tabs[1].Slots[index].Frame:SetBackgroundColor(1,0,0,1)
        local slot=lb.slotsGui.Tabs[1].Slots[index]
        if  lb.slotsGui.selectedIndex~=-1 and lb.slotsGui.selectedIndex~=index then lb.slotsGui.Tabs[1].Slots[lb.slotsGui.selectedIndex].Frame:SetBackgroundColor(0,0,0,1) end 
        lb.slotsGui.selectedIndex=index
        --print (slot:GetPosition()[1])
       	lb.slotsGui.clickOffset ["x"] = mouseStatus.x - slot.X
        lb.slotsGui.clickOffset ["y"] = mouseStatus.y - slot.Y
    end
end

function lb.slotsGui.onSlotLeftUp(index)
if  lb.slotsGui.selectedIndex~=index then return end
    slotdrag = false
    --lb.slotsGui.Tabs[1].Slots[index].Frame:SetBackgroundColor(0,0,0,1)
end

function lb.slotsGui.onSlotUpoutside(index)
if  lb.slotsGui.selectedIndex~=index then return end
    slotdrag = false
    --lb.slotsGui.Tabs[1].Slots[index].Frame:SetBackgroundColor(0,0,0,1) 
end

function lb.slotsGui.OnSlotMouseMove(index,x,y)
if  lb.slotsGui.selectedIndex~=index then return end
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
   		lb.slotsGui.Tabs[1].Slots[index].X=newx
	 	lb.slotsGui.Tabs[1].Slots[index].Y=newy
	 
	 	---Experimental
	 	lbBuffSlotOptions[lbValues.set][index][3]=newx/scalex/lb.slotsGui.PreviewScale[1]
	 	lbBuffSlotOptions[lbValues.set][index][4]=newy/scaley/lb.slotsGui.PreviewScale[2]
	 	
	 	----
	 	lb.buffMonitor.relocateSingleBuffMonitorSlot(index)
		lb.slotsGui.Tabs[1].Slots[index].Frame:SetPoint("TOPLEFT", lb.slotsGui.Tabs[1].UnitFrame, "TOPLEFT", newx, newy)
		
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
