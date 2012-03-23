lb.SlotsGui={}
--called when initializing the slot options gui
local slotdrag=false
lb.SlotsGui.clickOffset = {x = 0, y = 0}
lb.SlotsGui.selectedIndex=-1
lb.SlotsGui.PreviewScale={3,3} --scale of the preview unit frame

function lb.SlotsGui.initialize()
	 local scalex=tempx*0.009009009
	 local scaley=tempy*0.023255814
	 lb.SlotsGui.Window=UI.CreateFrame("SimpleWindow", "Options", lb.Context)
	 lb.SlotsGui.Window:SetPoint("CENTER", UIParent, "CENTER")
	 lb.SlotsGui.Window:SetWidth(850)
	 lb.SlotsGui.Window:SetHeight(600)
	 lb.SlotsGui.Window:SetLayer(10)
	 lb.SlotsGui.Window:SetVisible(true)
	 lb.SlotsGui.Window:SetCloseButtonVisible(true)
	 lb.SlotsGui.Window.Event.Close=function() ClearKeyFocus() end
	 -----tab definitions
	 lb.SlotsGui.TabControl=UI.CreateFrame("SimpleTabView", "OptionsWindowFrame", lb.SlotsGui.Window)
	 lb.SlotsGui.Tabs = {}
	 lb.SlotsGui.TabControl:SetPoint("TOPLEFT", lb.SlotsGui.Window, "TOPLEFT", 15, 50)
     lb.SlotsGui.TabControl:SetPoint("BOTTOMRIGHT", lb.SlotsGui.Window, "BOTTOMRIGHT", -15, -15)
	 lb.SlotsGui.Tabs[1]={}
	 lb.SlotsGui.Tabs[1].MainFrame = UI.CreateFrame("Frame", "OptionsWindowA", lb.SlotsGui.TabControl)
	 lb.SlotsGui.TabControl:AddTab("Slots Editor",lb.SlotsGui.Tabs[1].MainFrame)
	 ------initialize tab 1
	 
	 lb.SlotsGui.Tabs[1].UnitFrame = UI.CreateFrame("Texture", "UnitFrame", lb.SlotsGui.Tabs[1].MainFrame )
	 lb.SlotsGui.Tabs[1].UnitFrame:SetPoint("TOPLEFT",lb.SlotsGui.Tabs[1].MainFrame , "TOPLEFT", 150, 150)
	 lb.SlotsGui.Tabs[1].UnitFrame:SetWidth(tempx*lb.SlotsGui.PreviewScale[1])
	 lb.SlotsGui.Tabs[1].UnitFrame:SetHeight(tempy*lb.SlotsGui.PreviewScale[2])
	 
	 lb.SlotsGui.Tabs[1].UnitFrame:SetTexture("LifeBinder", "Textures/health_g.png")
	 ------initialize Slots
	 lb.SlotsGui.Tabs[1].Slots={}
	 
	 for i =1 ,#(lbBuffSlotPositions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotPositions[lbValues.set][i]
	 	lb.SlotsGui.Tabs[1].Slots[i]={}
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  lb.SlotsGui.Tabs[1].UnitFrame )
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame:SetPoint(slotinfo[1],lb.SlotsGui.Tabs[1].UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.SlotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.SlotsGui.PreviewScale[2])
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame:SetWidth(slotinfo[5]*scalex*lb.SlotsGui.PreviewScale[1])
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame:SetHeight(slotinfo[6]*scaley*lb.SlotsGui.PreviewScale[2])
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame:SetBackgroundColor(0,0,0,1)
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame.Event.LeftDown=function () onSlotLeftDown(i) end
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame.Event.LeftUp=function () onSlotLeftUp(i) end
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame.Event.LeftUpoutside=function () onSlotUpoutside(i) end
	 	lb.SlotsGui.Tabs[1].Slots[i].Frame.Event.MouseMove=function (n,x,y) OnSlotMouseMove(i,x,y) end
	 	lb.SlotsGui.Tabs[1].Slots[i].Text= UI.CreateFrame("Text", "UnitFrame", lb.SlotsGui.Tabs[1].Slots[i].Frame )
	 	lb.SlotsGui.Tabs[1].Slots[i].Text:SetPoint("CENTER", lb.SlotsGui.Tabs[1].Slots[i].Frame ,"CENTER",0,0)
	 	lb.SlotsGui.Tabs[1].Slots[i].Text:SetText(tostring(i))
	 	lb.SlotsGui.Tabs[1].Slots[i].X=slotinfo[3]*scalex*lb.SlotsGui.PreviewScale[1]
	 	lb.SlotsGui.Tabs[1].Slots[i].Y=slotinfo[4]*scaley*lb.SlotsGui.PreviewScale[2]
	 end
	 
	 --initialize Apply Button
	 lb.SlotsGui.Tabs[1].ApplyButton=UI.CreateFrame("RiftButton", "UnitFrame", lb.SlotsGui.Tabs[1].MainFrame )
	 lb.SlotsGui.Tabs[1].ApplyButton:SetPoint("BOTTOMRIGHT", lb.SlotsGui.Tabs[1].MainFrame,"BOTTOMRIGHT",-5,-5)
	 lb.SlotsGui.Tabs[1].ApplyButton:SetText("Apply")
	 lb.SlotsGui.Tabs[1].ApplyButton.Event.LeftClick=function() relocateBuffMonitorSlots() end
	 
end

function onSlotLeftDown(index)
    if not lbValues.isincombat then
        slotdrag = true
        
        local mouseStatus = Inspect.Mouse()
        
        local slot=lb.SlotsGui.Tabs[1].Slots[index]
        lb.SlotsGui.selectedIndex=index
        --print (slot:GetPosition()[1])
       	lb.SlotsGui.clickOffset ["x"] = mouseStatus.x - slot.X
        lb.SlotsGui.clickOffset ["y"] = mouseStatus.y - slot.Y
    end
end

function onSlotLeftUp(index)
if  lb.SlotsGui.selectedIndex~=index then return end
    slotdrag = false
end
function onSlotUpoutside(index)
if  lb.SlotsGui.selectedIndex~=index then return end
    slotdrag = false
    
end
function OnSlotMouseMove(index,x,y)
if  lb.SlotsGui.selectedIndex~=index then return end
    --print (tostring(x).."-"..tostring(y))
    if lbValues.isincombat then
        slotdrag = false
        return
    end
    if slotdrag == true then
    	local scalex=tempx*0.009009009
	 local scaley=tempy*0.023255814
    	local newx=x-(lb.SlotsGui.clickOffset["x"])
    	local newy=y-(lb.SlotsGui.clickOffset["y"])
   		lb.SlotsGui.Tabs[1].Slots[index].X=newx
	 	lb.SlotsGui.Tabs[1].Slots[index].Y=newy
	 	---Experimental
	 	lbBuffSlotPositions[lbValues.set][index][3]=newx/scalex/lb.SlotsGui.PreviewScale[1]
	 	lbBuffSlotPositions[lbValues.set][index][4]=newy/scaley/lb.SlotsGui.PreviewScale[2]
	 	----
	 	relocateSingleBuffMonitorSlot(index)
		lb.SlotsGui.Tabs[1].Slots[index].Frame:SetPoint("TOPLEFT", lb.SlotsGui.Tabs[1].UnitFrame, "TOPLEFT", newx, newy)
		
    end
end







--called when changing spec
function lb.SlotsGui.updateOptions()

end
