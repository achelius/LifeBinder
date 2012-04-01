lb.slotsGui.slotsEditor={}
local frame=nil
local scalex=1-- lb.styles[lb.currentStyle].getFrameWidth()*0.009009009
local scaley=1--lb.styles[lb.currentStyle].getFrameHeight()*0.023255814
function lb.slotsGui.slotsEditor.createTable(parentFrame)

	 local optionsFrame
	 optionsFrame = UI.CreateFrame("Frame", "OptionsWindowA", parentFrame)
	
     
	 optionsFrame.UnitFrame = UI.CreateFrame("Texture", "UnitFrame",  optionsFrame  )
	 optionsFrame.UnitFrame:SetPoint("TOPLEFT",optionsFrame , "TOPLEFT", 20, 50)
	 
	 optionsFrame.UnitFrame:SetWidth(lb.styles[lb.currentStyle].getFrameWidth()*lb.slotsGui.PreviewScale[1])
	 optionsFrame.UnitFrame:SetHeight(lb.styles[lb.currentStyle].getFrameHeight()*lb.slotsGui.PreviewScale[2])
	 optionsFrame.UnitFrame:SetVisible(true)
	 optionsFrame.UnitFrame:SetTexture("LifeBinder", lb.styles[lb.currentStyle].getHealthFrameTexture())
	 optionsFrame.UnitFrame:SetLayer(1)
	 ------initialize Slots
	 optionsFrame.buffSlots={}
	 
	 for i =1 ,#(lbBuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotOptions[lbValues.set][i]
	 	optionsFrame.buffSlots[i]={}
	 	optionsFrame.buffSlots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  optionsFrame.UnitFrame )
	 	optionsFrame.buffSlots[i].Frame:SetPoint(slotinfo[1],optionsFrame.UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	optionsFrame.buffSlots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	optionsFrame.buffSlots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	optionsFrame.buffSlots[i].Frame:SetBackgroundColor(0,1,0.1,1)
	 	optionsFrame.buffSlots[i].Frame:SetLayer(3)
	 	optionsFrame.buffSlots[i].Frame.Event.LeftDown=function () lb.slotsGui.slotsEditor.onSlotLeftDown(0,i) end --0 means that's a buff
	 	optionsFrame.buffSlots[i].Frame.Event.LeftUp=function () lb.slotsGui.slotsEditor.onSlotLeftUp(0,i) end
	 	optionsFrame.buffSlots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.slotsEditor.onSlotUpoutside(0,i) end
	 	optionsFrame.buffSlots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(0,i,x,y) end
	 	optionsFrame.buffSlots[i].Text= UI.CreateFrame("Text", "UnitFrame", optionsFrame.buffSlots[i].Frame )
	 	optionsFrame.buffSlots[i].Text:SetPoint("CENTER", optionsFrame.buffSlots[i].Frame ,"CENTER",0,0)
	 	optionsFrame.buffSlots[i].Text:SetText(tostring(i))
	 	
	 	optionsFrame.buffSlots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	optionsFrame.buffSlots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
	 
	  optionsFrame.debuffSlots={}
	 
	 for i =1 ,#(lbDebuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbDebuffSlotOptions[lbValues.set][i]
	 	optionsFrame.debuffSlots[i]={}
	 	optionsFrame.debuffSlots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  optionsFrame.UnitFrame )
	 	optionsFrame.debuffSlots[i].Frame:SetPoint(slotinfo[1],optionsFrame.UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	optionsFrame.debuffSlots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	optionsFrame.debuffSlots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	optionsFrame.debuffSlots[i].Frame:SetBackgroundColor(1,0,0,1)
	 	optionsFrame.buffSlots[i].Frame:SetLayer(2)
	 	optionsFrame.debuffSlots[i].Frame.Event.LeftDown=function () lb.slotsGui.slotsEditor.onSlotLeftDown(1,i) end
	 	optionsFrame.debuffSlots[i].Frame.Event.LeftUp=function () lb.slotsGui.slotsEditor.onSlotLeftUp(1,i) end
	 	optionsFrame.debuffSlots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.slotsEditor.onSlotUpoutside(1,i) end
	 	optionsFrame.debuffSlots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(1,i,x,y) end
	 	optionsFrame.debuffSlots[i].Text= UI.CreateFrame("Text", "UnitFrame", optionsFrame.debuffSlots[i].Frame )
	 	optionsFrame.debuffSlots[i].Text:SetPoint("CENTER", optionsFrame.debuffSlots[i].Frame ,"CENTER",0,0)
	 	optionsFrame.debuffSlots[i].Text:SetText(tostring(i))
	 	optionsFrame.debuffSlots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	optionsFrame.debuffSlots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
	 --initialize Apply Button
	 optionsFrame.ApplyButton=UI.CreateFrame("RiftButton", "UnitFrame", optionsFrame )
	 optionsFrame.ApplyButton:SetPoint("BOTTOMRIGHT", optionsFrame,"BOTTOMRIGHT",-5,-5)
	 optionsFrame.ApplyButton:SetText("Apply")
	 optionsFrame.ApplyButton.Event.LeftClick=function() lb.buffMonitor.relocateBuffMonitorSlots() lb.debuffMonitor.relocateDebuffMonitorSlots() end
	 frame=optionsFrame
	 return optionsFrame
end




function lb.slotsGui.slotsEditor.onSlotLeftDown(type,index)
    if not lbValues.isincombat then
        slotdrag = true
        
        local mouseStatus = Inspect.Mouse()
        
        local slots=nil
        if type==0 then slots= lb.slotsGui.Tabs[2].buffSlots end
        if type==1 then slots= lb.slotsGui.Tabs[2].debuffSlots end
        slots[index].Frame:SetBackgroundColor(0,0,1,1) 
        if  (lb.slotsGui.selectedIndex~=-1 and lb.slotsGui.selectedIndex~=index) or (lb.slotsGui.selectedType~=-1 and lb.slotsGui.selectedType~=index) then
        	if lb.slotsGui.selectedType==0 then
         		lb.slotsGui.Tabs[2].buffSlots[lb.slotsGui.selectedIndex].Frame:SetBackgroundColor(0,1,0,1)
         	elseif lb.slotsGui.selectedType==1 then
         		lb.slotsGui.Tabs[2].debuffSlots[lb.slotsGui.selectedIndex].Frame:SetBackgroundColor(1,0,0,1)
         	end
        end 
        lb.slotsGui.selectedIndex=index
        lb.slotsGui.selectedType=type
        --print (slot:GetPosition()[1])
       	lb.slotsGui.clickOffset ["x"] = mouseStatus.x - slots[index].X
        lb.slotsGui.clickOffset ["y"] = mouseStatus.y - slots[index].Y
    end
end

function lb.slotsGui.slotsEditor.onSlotLeftUp(type,index)
if  lb.slotsGui.selectedIndex~=index then return end
if  lb.slotsGui.selectedType~=type then return end
    slotdrag = false
    --lb.slotsGui.Tabs[2].buffSlots[index].Frame:SetBackgroundColor(0,0,0,1)
end

function lb.slotsGui.slotsEditor.onSlotUpoutside(type,index)
if  lb.slotsGui.selectedIndex~=index then return end
if  lb.slotsGui.selectedType~=type then return end
    slotdrag = false
    --lb.slotsGui.Tabs[2].buffSlots[index].Frame:SetBackgroundColor(0,0,0,1) 
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
        if type==0 then slots=lb.slotsGui.Tabs[2].buffSlots options=lbBuffSlotOptions end
        if type==1 then slots=lb.slotsGui.Tabs[2].debuffSlots options=lbDebuffSlotOptions end 
        
   		slots[index].X=newx
	 	slots[index].Y=newy
	 
	 	
	 	---Experimental
	 	options[lbValues.set][index][3]=newx/scalex/lb.slotsGui.PreviewScale[1]
	 	options[lbValues.set][index][4]=newy/scaley/lb.slotsGui.PreviewScale[2]
	 	
	 	----
	 	if type==0 then lb.buffMonitor.relocateSingleBuffMonitorSlot(index) end
	 	if type==1 then lb.debuffMonitor.relocateSingleDebuffMonitorSlot(index) end
		slots[index].Frame:SetPoint("TOPLEFT", lb.slotsGui.Tabs[2].UnitFrame, "TOPLEFT", newx, newy)
		
    end
end

--called when changing spec
function lb.slotsGui.slotsEditor.updateData()
	
	
	for i =1 ,#(lbBuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbBuffSlotOptions[lbValues.set][i]
	 	--frame.buffSlots[i]={}
	 	--frame.buffSlots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  frame.UnitFrame )
	 	frame.buffSlots[i].Frame:SetPoint(slotinfo[1],frame.UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	frame.buffSlots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	frame.buffSlots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	frame.buffSlots[i].Frame:SetBackgroundColor(0,1,0.1,1)
	 	frame.buffSlots[i].Frame:SetLayer(3)
	 	frame.buffSlots[i].Frame.Event.LeftDown=function () lb.slotsGui.onSlotLeftDown(0,i) end --0 means that's a buff
	 	frame.buffSlots[i].Frame.Event.LeftUp=function () lb.slotsGui.onSlotLeftUp(0,i) end
	 	frame.buffSlots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.onSlotUpoutside(0,i) end
	 	frame.buffSlots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(0,i,x,y) end
	 	frame.buffSlots[i].Text= UI.CreateFrame("Text", "UnitFrame", frame.buffSlots[i].Frame )
	 	frame.buffSlots[i].Text:SetPoint("CENTER", frame.buffSlots[i].Frame ,"CENTER",0,0)
	 	frame.buffSlots[i].Text:SetText(tostring(i))
	 	
	 	frame.buffSlots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	frame.buffSlots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
	 
	
	 
	 for i =1 ,#(lbDebuffSlotOptions[lbValues.set]) do
	 	local slotinfo=lbDebuffSlotOptions[lbValues.set][i]
	 	--frame.debuffSlots[i]={}
	 	--frame.debuffSlots[i].Frame= UI.CreateFrame("Texture", "UnitFrame",  frame.UnitFrame )
	 	frame.debuffSlots[i].Frame:SetPoint(slotinfo[1],frame.UnitFrame, slotinfo[2], slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1], slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2])
	 	local iconwidth=slotinfo[5]*scalex
	        local iconheight=slotinfo[6]*scaley
	        local iconl=iconwidth
	        if iconheight<iconwidth then
	        	iconl=iconheight
	        end
	 	frame.debuffSlots[i].Frame:SetWidth(iconl*lb.slotsGui.PreviewScale[1])
	 	frame.debuffSlots[i].Frame:SetHeight(iconl*lb.slotsGui.PreviewScale[2])
	 	frame.debuffSlots[i].Frame:SetBackgroundColor(1,0,0,1)
	 	frame.buffSlots[i].Frame:SetLayer(2)
	 	frame.debuffSlots[i].Frame.Event.LeftDown=function () lb.slotsGui.onSlotLeftDown(1,i) end
	 	frame.debuffSlots[i].Frame.Event.LeftUp=function () lb.slotsGui.onSlotLeftUp(1,i) end
	 	frame.debuffSlots[i].Frame.Event.LeftUpoutside=function () lb.slotsGui.onSlotUpoutside(1,i) end
	 	frame.debuffSlots[i].Frame.Event.MouseMove=function (n,x,y) lb.slotsGui.OnSlotMouseMove(1,i,x,y) end
	 	frame.debuffSlots[i].Text= UI.CreateFrame("Text", "UnitFrame", frame.debuffSlots[i].Frame )
	 	frame.debuffSlots[i].Text:SetPoint("CENTER", frame.debuffSlots[i].Frame ,"CENTER",0,0)
	 	frame.debuffSlots[i].Text:SetText(tostring(i))
	 	frame.debuffSlots[i].X=slotinfo[3]*scalex*lb.slotsGui.PreviewScale[1]
	 	frame.debuffSlots[i].Y=slotinfo[4]*scaley*lb.slotsGui.PreviewScale[2]
	 end
end