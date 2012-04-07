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
	 lb.slotsGui.Window=UI.CreateLbFrame("SimpleWindow", "SlotsGui", lb.Context)
	 lb.slotsGui.Window:SetSecureMode("restricted")
	 lb.slotsGui.Window:SetPoint("CENTER", UIParent, "CENTER")
	 lb.slotsGui.Window:SetWidth(1000)
	 lb.slotsGui.Window:SetHeight(600)
	 lb.slotsGui.Window:SetLayer(10)
	 lb.slotsGui.Window:SetVisible(true)
	 lb.slotsGui.Window:SetCloseButtonVisible(true)
	 lb.slotsGui.Window.Event.Close=function()lb.buffMonitor.hideDummyBuffMonitorSlots() lb.debuffMonitor.hideDummyDebuffMonitorSlots() ClearKeyFocus() end
	 -----tab definitions
	 lb.slotsGui.TabControl=UI.CreateLbFrame("SimpleTabView", "OptionsWindowFrame", lb.slotsGui.Window)
	 lb.slotsGui.TabControl:SetSecureMode("restricted")
	 lb.slotsGui.Tabs = {}
	 lb.slotsGui.TabControl:SetPoint("TOPLEFT", lb.slotsGui.Window, "TOPLEFT", 15, 50)
     lb.slotsGui.TabControl:SetPoint("BOTTOMRIGHT", lb.slotsGui.Window, "BOTTOMRIGHT", -15, -15)
     
     lb.slotsGui.TabControl.Event.TabSelect =lb.slotsGui.OnTabChanged
-------------------------------------------------------------------------------initialize tab 1
	 lb.slotsGui.Tabs[1]=UI.CreateLbFrame("Frame", "placeholder", lb.slotsGui.Window)
	 --dump(lb.slotsGui.Tabs[1])
	 --lb.slotsGui.Tabs[1]=lb.slotsGui.addonInfo.createTable( lb.slotsGui.TabControl)
	 --dump(lb.slotsGui.Tabs[1])
	 lb.slotsGui.TabControl:AddTab("Welcome",lb.slotsGui.Tabs[1])
	 
-------------------------------------------------------------------------------initialize tab 2
	 lb.slotsGui.Tabs[2]=UI.CreateLbFrame("Frame", "placeholder", lb.slotsGui.Window)
	 --lb.slotsGui.Tabs[2]=lb.slotsGui.slotsEditor.createTable(lb.slotsGui.TabControl)
	 lb.slotsGui.TabControl:AddTab("Condition Placement",lb.slotsGui.Tabs[2])

-------------------------------------------------------------------------initializing table 3
	 lb.slotsGui.Tabs[3]=UI.CreateLbFrame("Frame", "placeholder", lb.slotsGui.Window)
	 lb.slotsGui.TabControl:AddTab("Buffs",lb.slotsGui.Tabs[3])
		 
-------------------------------------------------------------------------initializing table 4
	 lb.slotsGui.Tabs[4]=UI.CreateLbFrame("Frame", "placeholder", lb.slotsGui.Window)
	 lb.slotsGui.TabControl:AddTab("Debuffs",lb.slotsGui.Tabs[4])
-------------------------------------------------------------------------initializing table 5
	 lb.slotsGui.Tabs[5]=UI.CreateLbFrame("Frame", "placeholder", lb.slotsGui.Window)
	 lb.slotsGui.TabControl:AddTab("Binds",lb.slotsGui.Tabs[5])
	 
------------------------------------------------------------------------initializing table 6
	 lb.slotsGui.Tabs[6]=UI.CreateLbFrame("Frame", "placeholder", lb.slotsGui.Window)
	 lb.slotsGui.TabControl:AddTab("Skins",lb.slotsGui.Tabs[6])
	 
	 lb.slotsGui.initialized=true
end

function lb.slotsGui.OnTabChanged(tab,index)
	local showdummies=false
	if index==1 then
		if lb.slotsGui.Tabs[1]:GetName()=="placeholder" then
			lb.slotsGui.Tabs[1]=lb.slotsGui.addonInfo.createTable( lb.slotsGui.TabControl)
			lb.slotsGui.TabControl:SetTabContent(1,lb.slotsGui.Tabs[1])
		end
	elseif index==2 then
		if lb.slotsGui.Tabs[2]:GetName()=="placeholder" then
			lb.slotsGui.Tabs[2]=lb.slotsGui.slotsEditor.createTable(lb.slotsGui.TabControl)
			lb.slotsGui.TabControl:SetTabContent(2,lb.slotsGui.Tabs[2])
		else
			lb.slotsGui.slotsEditor.updateData()
		end
		showdummies=true
	elseif index==3 then
		if lb.slotsGui.Tabs[3]:GetName()=="placeholder" then
			lb.slotsGui.Tabs[3]=lb.slotsGui.buffAssociations.createTable(lb.slotsGui.TabControl)
			lb.slotsGui.TabControl:SetTabContent(3,lb.slotsGui.Tabs[3])
		else
			lb.slotsGui.buffAssociations.updateData()
		end
	elseif index==4 then
		if lb.slotsGui.Tabs[4]:GetName()=="placeholder" then
			lb.slotsGui.Tabs[4]=lb.slotsGui.debuffManager.createTable(lb.slotsGui.TabControl)
			lb.slotsGui.TabControl:SetTabContent(4,lb.slotsGui.Tabs[4])
		else
			lb.slotsGui.debuffManager.updateData()
		end
	elseif index==5 then
		if lb.slotsGui.Tabs[5]:GetName()=="placeholder" then
			lb.slotsGui.Tabs[5]=lb.slotsGui.mouseBinds.createTable(lb.slotsGui.TabControl)
			lb.slotsGui.TabControl:SetTabContent(5,lb.slotsGui.Tabs[5])
		else
			 lb.slotsGui.mouseBinds.updateData()
		end
	elseif index==6 then
		if lb.slotsGui.Tabs[6]:GetName()=="placeholder" then
			lb.slotsGui.Tabs[6]=lb.slotsGui.styleOptions.createTable(lb.slotsGui.TabControl)
			
			lb.slotsGui.TabControl:SetTabContent(6,lb.slotsGui.Tabs[6])
		else
			 lb.slotsGui.styleOptions.updateData()
		end
	end
	if showdummies then
		lb.buffMonitor.showDummyBuffMonitorSlots()
	 		lb.debuffMonitor.showDummyDebuffMonitorSlots() 
	else
		lb.buffMonitor.hideDummyBuffMonitorSlots()
    	lb.debuffMonitor.hideDummyDebuffMonitorSlots()
	end
end





function lb.slotsGui.isPointInFrame(frame,x,y)
	local left =frame:GetLeft()
	local right =frame:GetRight()
	local top =frame:GetTop()
	local bottom =frame:GetBottom()
	if x<right and x>left then
		if y<bottom and y>top then
			return true
		end
	end
	return false
end
function lb.slotsGui.show()
	if lb.slotsGui.initialized then
		lb.slotsGui.updateOptions()
		lb.slotsGui.Window:SetVisible(true)
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

function lb.slotsGui.updateOptions()
	if lb.slotsGui.Tabs[2]:GetName()~="placeholder" then lb.slotsGui.slotsEditor.updateData() end
	if lb.slotsGui.Tabs[4]:GetName()~="placeholder" then lb.slotsGui.debuffManager.updateData() end	
	if lb.slotsGui.Tabs[3]:GetName()~="placeholder" then lb.slotsGui.buffAssociations.updateData() end
	if lb.slotsGui.Tabs[5]:GetName()~="placeholder" then lb.slotsGui.mouseBinds.updateData() end	
end



context = UI.CreateContext("Fluff Context")
focushack = UI.CreateLbFrame("RiftTextfield", "focus hack", context)
focushack:SetVisible(false)
function ClearKeyFocus()
    focushack:SetKeyFocus(true)
    focushack:SetKeyFocus(false)
end

function writeText(text,name,parent,left,top)
    local tp=UI.CreateLbFrame("Text", name, parent)
    tp:SetPoint("TOPLEFT", parent, "TOPLEFT", left, top)
    tp:SetText(text)
end