lb.optionsGui={}
lb.optionsGui.initialized=false
--called when initializing the slot options gui
local slotdrag=false
lb.optionsGui.clickOffset = {x = 0, y = 0}
lb.optionsGui.selectedIndex=-1
lb.optionsGui.selectedType=-1
lb.optionsGui.PreviewScale={4,4} --scale of the preview unit frame

function lb.optionsGui.initialize()
	 local scalex=1-- lb.styles[lb.currentStyle].getFrameWidth()*0.009009009
	 local scaley=1--lb.styles[lb.currentStyle].getFrameHeight()*0.023255814
	 lb.optionsGui.Window=UI.CreateLbFrame("SimpleWindow", "SlotsGui", lb.Context)
	 
	 lb.optionsGui.Window:SetPoint("CENTER", UIParent, "CENTER")
	 lb.optionsGui.Window:SetWidth(1000)
	 lb.optionsGui.Window:SetHeight(600)
	 lb.optionsGui.Window:SetLayer(10)
	 lb.optionsGui.Window:SetVisible(true)
	 lb.optionsGui.Window:SetCloseButtonVisible(true)
	 lb.optionsGui.Window.Event.Close=function()lb.buffMonitor.hideDummyBuffMonitorSlots() lb.debuffMonitor.hideDummyDebuffMonitorSlots() ClearKeyFocus() end
	 -----tab definitions
	 lb.optionsGui.TabControl=UI.CreateLbFrame("SimpleTabView", "OptionsWindowFrame", lb.optionsGui.Window)
	 
	 lb.optionsGui.Tabs = {}
	 lb.optionsGui.TabControl:SetPoint("TOPLEFT", lb.optionsGui.Window, "TOPLEFT", 15, 50)
     lb.optionsGui.TabControl:SetPoint("BOTTOMRIGHT", lb.optionsGui.Window, "BOTTOMRIGHT", -15, -15)
     
     lb.optionsGui.TabControl.Event.TabSelect =lb.optionsGui.OnTabChanged
-------------------------------------------------------------------------------initialize tab 1
	 lb.optionsGui.Tabs[1]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	 --dump(lb.optionsGui.Tabs[1])
	 --lb.optionsGui.Tabs[1]=lb.optionsGui.addonInfo.createTable( lb.optionsGui.TabControl)
	 --dump(lb.optionsGui.Tabs[1])
	 lb.optionsGui.TabControl:AddTab("Welcome",lb.optionsGui.Tabs[1])
	 
-------------------------------------------------------------------------------initialize tab 2
	 lb.optionsGui.Tabs[2]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	 --lb.optionsGui.Tabs[2]=lb.optionsGui.slotsEditor.createTable(lb.optionsGui.TabControl)
	 lb.optionsGui.TabControl:AddTab("Condition Placement",lb.optionsGui.Tabs[2])

-------------------------------------------------------------------------initializing table 3
	 lb.optionsGui.Tabs[3]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	 lb.optionsGui.TabControl:AddTab("Buffs",lb.optionsGui.Tabs[3])
		 
-------------------------------------------------------------------------initializing table 4
	 lb.optionsGui.Tabs[4]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	 lb.optionsGui.TabControl:AddTab("Debuffs",lb.optionsGui.Tabs[4])
-------------------------------------------------------------------------initializing table 5
	 lb.optionsGui.Tabs[5]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	 lb.optionsGui.TabControl:AddTab("Binds",lb.optionsGui.Tabs[5])
	 
------------------------------------------------------------------------initializing table 6
	 lb.optionsGui.Tabs[6]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	 lb.optionsGui.TabControl:AddTab("Skins",lb.optionsGui.Tabs[6])
	 
	 lb.optionsGui.initialized=true
end

function lb.optionsGui.OnTabChanged(tab,index)
	local showdummies=false
	if index==1 then
		if lb.optionsGui.Tabs[1]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[1]=lb.optionsGui.addonInfo.createTable( lb.optionsGui.TabControl)
			lb.optionsGui.TabControl:SetTabContent(1,lb.optionsGui.Tabs[1])
		end
	elseif index==2 then
		if lb.optionsGui.Tabs[2]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[2]=lb.optionsGui.slotsEditor.createTable(lb.optionsGui.TabControl)
			lb.optionsGui.TabControl:SetTabContent(2,lb.optionsGui.Tabs[2])
		else
			lb.optionsGui.slotsEditor.updateData()
		end
		showdummies=true
	elseif index==3 then
		if lb.optionsGui.Tabs[3]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[3]=lb.optionsGui.buffAssociations.createTable(lb.optionsGui.TabControl)
			lb.optionsGui.TabControl:SetTabContent(3,lb.optionsGui.Tabs[3])
		else
			lb.optionsGui.buffAssociations.updateData()
		end
	elseif index==4 then
		if lb.optionsGui.Tabs[4]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[4]=lb.optionsGui.debuffManager.createTable(lb.optionsGui.TabControl)
			lb.optionsGui.TabControl:SetTabContent(4,lb.optionsGui.Tabs[4])
		else
			lb.optionsGui.debuffManager.updateData()
		end
	elseif index==5 then
		if lb.optionsGui.Tabs[5]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[5]=lb.optionsGui.mouseBinds.createTable(lb.optionsGui.TabControl)
			lb.optionsGui.TabControl:SetTabContent(5,lb.optionsGui.Tabs[5])
		else
			 lb.optionsGui.mouseBinds.updateData()
		end
	elseif index==6 then
		if lb.optionsGui.Tabs[6]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[6]=lb.optionsGui.styleOptions.createTable(lb.optionsGui.TabControl)
			
			lb.optionsGui.TabControl:SetTabContent(6,lb.optionsGui.Tabs[6])
		else
			 lb.optionsGui.styleOptions.updateData()
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





function lb.optionsGui.isPointInFrame(frame,x,y)
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
function lb.optionsGui.show()
	if lb.optionsGui.initialized then
		lb.optionsGui.updateOptions()
		lb.optionsGui.Window:SetVisible(true)
	else
		lb.optionsGui.initialize()
	end
end
function lb.optionsGui.hide()
	if lb.optionsGui.initialized then
		lb.optionsGui.Window:SetVisible(false)
		lb.buffMonitor.hideDummyBuffMonitorSlots()
		lb.debuffMonitor.hideDummyDebuffMonitorSlots()
		 
	end
end

function lb.optionsGui.updateOptions()
	if lb.optionsGui.Tabs[2]:GetName()~="placeholder" then lb.optionsGui.slotsEditor.updateData() end
	if lb.optionsGui.Tabs[4]:GetName()~="placeholder" then lb.optionsGui.debuffManager.updateData() end	
	if lb.optionsGui.Tabs[3]:GetName()~="placeholder" then lb.optionsGui.buffAssociations.updateData() end
	if lb.optionsGui.Tabs[5]:GetName()~="placeholder" then lb.optionsGui.mouseBinds.updateData() end	
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