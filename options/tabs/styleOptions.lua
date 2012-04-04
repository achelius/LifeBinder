lb.slotsGui.styleOptions={}
local frame=nil
function lb.slotsGui.styleOptions.createTable(parentFrame)
 	 local optionsFrame
	 optionsFrame = UI.CreateFrame("Frame", "OptionsWindowA", parentFrame)
	 writeText("Current Selected Style","text",optionsFrame,10,30)
	 optionsFrame.styleSelectCombobox=UI.CreateFrame("SimpleSelect", "styleSelectCombobox",optionsFrame)
	 optionsFrame.styleSelectCombobox:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",10,50)
	 optionsFrame.styleSelectCombobox:SetWidth(200)
	 optionsFrame.styleSelectCombobox:SetHeight(30)
	 local list={}
	 local counter=1
	 local currentsel=-1
	 for key,stl in pairs(lb.styles) do
	 	if not isFunction(stl) then
		 	if stl.fastInitialize~=nil then
		 		  list[counter]=key 
		 		  if key==lb.styles.getCurrentStyleName() then currentsel=counter end
		 		  counter=counter+1
		 	end
	 	end
	 end
	 optionsFrame.styleSelectCombobox:SetItems(list)
	 if currentsel~=-1 then optionsFrame.styleSelectCombobox:SetSelectedIndex(currentsel,true) end
	 
	 optionsFrame.styleApplyButton=UI.CreateFrame("RiftButton", "styleApplyButton",optionsFrame)
	 optionsFrame.styleApplyButton:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",250,50)
	 optionsFrame.styleApplyButton:SetWidth(100)
	 optionsFrame.styleApplyButton:SetHeight(30)
	 
	 optionsFrame.styleApplyButton:SetText("Apply")
	 optionsFrame.styleApplyButton.Event.LeftClick=lb.slotsGui.styleOptions.SetCurrentStyle
	 
	 optionsFrame.styleStatusText=UI.CreateFrame("Text", "styleStatusText",optionsFrame)
	 optionsFrame.styleStatusText:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",10,90)
	 optionsFrame.styleStatusText:SetWidth(400)
	 optionsFrame.styleStatusText:SetHeight(30)
	 optionsFrame.styleStatusText:SetFontColor(1,0,0,1)
	 optionsFrame.styleStatusText:SetText("")
--	 optionsFrame.styleReloaduiButton=UI.CreateFrame("RiftButton", "styleReloaduiButton",optionsFrame)
--	 optionsFrame.styleReloaduiButton:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",350,50)
--	 optionsFrame.styleReloaduiButton:SetWidth(120)
--	 optionsFrame.styleReloaduiButton:SetHeight(30)
--	 optionsFrame.styleReloaduiButton:SetText("Reload UI")
--	 
--	 optionsFrame.styleReloaduiButton.Event.LeftClick="/reloadui"
	 writeText("Styles only changes unit frames positions for now, it will be expanded later","text",optionsFrame,10,10)
	 frame=optionsFrame
	 return optionsFrame
end
function lb.slotsGui.styleOptions.SetCurrentStyle()
	dump(frame.styleSelectCombobox:GetSelectedItem())
	lb.styles.setCurrentStyleName(frame.styleSelectCombobox:GetSelectedItem())
	lb.slotsGui.styleOptions.populateList()
	frame.styleStatusText:SetText("Please write /reloadui to apply")
--	frame.styleApplyButton:SetWidth(300)
--	frame.styleApplyButton:SetText("Please write /reloadui to apply")
end

function lb.slotsGui.styleOptions.populateList()
	 local list={}
	 local counter=1
	 local currentsel=-1
	 for key,stl in pairs(lb.styles) do
	 	if not isFunction(stl) then
		 	if stl.fastInitialize~=nil then
		 		  list[counter]=key 
		 		  if key==lb.styles.getCurrentStyleName() then currentsel=counter end
		 		  counter=counter+1
		 	end
	 	end
	 end
	 frame.styleSelectCombobox:SetItems(list)
	 if currentsel~=-1 then frame.styleSelectCombobox:SetSelectedIndex(currentsel,true) end
end

function lb.slotsGui.styleOptions.updateData()
	 lb.slotsGui.styleOptions.populateList()
end

function isFunction(aObject)
    if  'function' == type(aObject) then
        return true
    else
        return false
    end
end