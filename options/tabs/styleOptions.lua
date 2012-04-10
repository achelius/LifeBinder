lb.optionsGui.styleOptions={}
local frame=nil
function lb.optionsGui.styleOptions.createTable(parentFrame)
 	 local optionsFrame
	 optionsFrame = UI.CreateLbFrame("Frame", "OptionsWindowA", parentFrame)
	 writeText("Current Selected Style","text",optionsFrame,10,50)
	 optionsFrame.comboBox=UI.CreateLbFrame("SimpleSelect", "styleSelectCombobox",optionsFrame)
	 optionsFrame.comboBox:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",10,70)
	 optionsFrame.comboBox:SetWidth(200)
	 optionsFrame.comboBox:SetHeight(30)
	 local list={}
	 local counter=1
	 local currentsel=-1
	 for key,stl in pairs(lb.styles) do
	 	if not lb.isFunction(stl) then
		 	if stl.fastInitialize~=nil then
		 		  list[counter]=key 
		 		  if key==lb.styles.getCurrentStyleName() then currentsel=counter end
		 		  counter=counter+1
		 	end
	 	end
	 end
	 optionsFrame.comboBox:SetItems(list)
	 optionsFrame.comboBox:SetLayer(7)
	 if currentsel~=-1 then optionsFrame.comboBox:SetSelectedIndex(currentsel,true) end
	 
	 optionsFrame.styleApplyButton=UI.CreateLbFrame("RiftButton", "styleApplyButton",optionsFrame)
	 optionsFrame.styleApplyButton:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",250,70)
	 optionsFrame.styleApplyButton:SetWidth(100)
	 optionsFrame.styleApplyButton:SetHeight(30)
	 
	 optionsFrame.styleApplyButton:SetText("Apply")
	 optionsFrame.styleApplyButton.Event.LeftClick=lb.optionsGui.styleOptions.SetCurrentStyle
	 
	 optionsFrame.styleStatusText=UI.CreateLbFrame("Text", "styleStatusText",optionsFrame)
	 optionsFrame.styleStatusText:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",10,100)
	 optionsFrame.styleStatusText:SetWidth(400)
	 optionsFrame.styleStatusText:SetHeight(30)
	 optionsFrame.styleStatusText:SetFontColor(1,0,0,1)
	 optionsFrame.styleStatusText:SetText("")
	 --initializing style options frame
	 writeText("Style detailed options","text",optionsFrame,10,120)
	 optionsFrame.styleDetalsOptions = UI.CreateLbFrame("Frame", "OptionsWindowA", optionsFrame)
	 optionsFrame.styleDetalsOptions:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",10,150)
	-- optionsFrame.styleDetalsOptions:SetBackgroundColor(0,0,0,1)
	 optionsFrame.styleDetalsOptions:SetWidth(700)
	 optionsFrame.styleDetalsOptions:SetHeight(300)
	 
	 lb.styles[lb.currentStyle].getOptionsWindow(optionsFrame.styleDetalsOptions)
	 
--	 optionsFrame.styleReloaduiButton=UI.CreateLbFrame("RiftButton", "styleReloaduiButton",optionsFrame)
--	 optionsFrame.styleReloaduiButton:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",350,50)
--	 optionsFrame.styleReloaduiButton:SetWidth(120)
--	 optionsFrame.styleReloaduiButton:SetHeight(30)
--	 optionsFrame.styleReloaduiButton:SetText("Reload UI")
--	 
--	 optionsFrame.styleReloaduiButton.Event.LeftClick="/reloadui"
	 writeText("Note: Styles only changes unit frames positions for now, it will be expanded later.","text",optionsFrame,10,10)
	 frame=optionsFrame
	 return optionsFrame
end
function lb.optionsGui.styleOptions.SetCurrentStyle()
	dump(frame.comboBox:GetSelectedItem())
	lb.styles.setCurrentStyleName(frame.comboBox:GetSelectedItem())
	lb.optionsGui.styleOptions.populateList()
	frame.styleStatusText:SetText("Please write /reloadui to apply")
--	frame.styleApplyButton:SetWidth(300)
--	frame.styleApplyButton:SetText("Please write /reloadui to apply")
end

function lb.optionsGui.styleOptions.populateList()
	 local list={}
	 local counter=1
	 local currentsel=-1
	 for key,stl in pairs(lb.styles) do
	 	if not lb.isFunction(stl) then
		 	if stl.fastInitialize~=nil then
		 		  list[counter]=key 
		 		  if key==lb.styles.getCurrentStyleName() then currentsel=counter end
		 		  counter=counter+1
		 	end
	 	end
	 end
	 frame.comboBox:SetItems(list)
	 if currentsel~=-1 then frame.comboBox:SetSelectedIndex(currentsel,true) end
end

function lb.optionsGui.styleOptions.updateData()
	 lb.optionsGui.styleOptions.populateList()
end

