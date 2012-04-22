lb.commonUtils={}
function lb.commonUtils.createNUD(parentFrame,ctrlname,left,top,text,value)
	local nud={}
	nud.textFrame=UI.CreateLbFrame("Text",ctrlname.."Text",parentFrame)
	nud.textFrame:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left,top)
	nud.textFrame:SetText(text)
	nud.textFrame:SetWidth(100)
	nud.textArea=UI.CreateLbFrame("RiftTextfield",ctrlname.."TextBox",parentFrame)
	nud.textArea:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left+100,top)
	nud.textArea:SetBackgroundColor(0,0,1,1)
	
	nud.textArea:SetWidth(100)
	nud.textArea:SetText(tostring(value))
	
	nud.cmdMinus=UI.CreateLbFrame("RiftButton",ctrlname.."CmdMinus",parentFrame)
	nud.cmdMinus:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left+200,top-6)
	--nud.cmdMinus:SetFontSize(20)
	nud.cmdMinus:SetText("-")
	nud.cmdMinus:SetWidth(100)
	nud.cmdMinus.Event.LeftClick=function()if nud.textArea:GetText()~=nil and nud.textArea:GetText()~="" then nud.textArea:SetText(tostring(tonumber(nud.textArea:GetText())-1)) end end
	
	nud.cmdPlus=UI.CreateLbFrame("RiftButton",ctrlname.."CmdPlus",parentFrame)
	nud.cmdPlus:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left+300,top-6)
	--nud.cmdPlus:SetFontSize(20)
	nud.cmdPlus:SetText("+")
	nud.cmdPlus:SetWidth(100)
	nud.cmdPlus.Event.LeftClick=function() if (nud.textArea:GetText())~=nil and (nud.textArea:GetText())~="" then nud.textArea:SetText(tostring(tonumber(nud.textArea:GetText())+1)) end end

	return nud
end
function lb.commonUtils.createButton(parentFrame,name,left,top,width,height,text)
	local cmd =UI.CreateLbFrame("RiftButton",name,parentFrame)
	cmd:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left,top)
	cmd:SetText(text)
	cmd:SetWidth(width)
	cmd:SetHeight(height)
	
	return cmd
end
function lb.commonUtils.createComboBox(parentFrame,ctrlname,left,top,elements,defaultIndex,text,defaultValue)
	local nud={}
	nud.textFrame=UI.CreateLbFrame("Text",ctrlname.."Text",parentFrame)
	nud.textFrame:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left,top)
	nud.textFrame:SetText(text)
	nud.textFrame:SetWidth(100)
     nud.comboBox=UI.CreateLbFrame("SimpleSelect",ctrlname.."SelectCombobox",parentFrame)
	 nud.comboBox:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left+120,top)
	 nud.comboBox:SetWidth(200)
	 nud.comboBox:SetHeight(30)
	 nud.comboBox:SetLayer(40)
	 nud.comboBox:SetItems(elements)
	if defaultIndex~=nil then nud.comboBox:SetSelectedIndex(defaultIndex,true)end
	if defaultValue~=nil then nud.comboBox:SetSelectedItem(defaultValue,true)end
	return nud
end

function lb.commonUtils.createMover(parentFrame,name,left,top,leftValue,topValue,text)
	local mover={}
	mover.left=leftValue
	mover.top=topValue
	mover.textFrame=UI.CreateLbFrame("Text",name.."Text",parentFrame)
	mover.textFrame:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left,top+50)
	mover.textFrame:SetText(text)
	mover.textFrame:SetWidth(100)
	
	mover.txtLeft=UI.CreateLbFrame("RiftTextfield",name.."TextBox",parentFrame)
	mover.txtLeft:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left+120,top+40)
	mover.txtLeft:SetBackgroundColor(0,0,1,1)
	mover.txtLeft:SetWidth(60)
	mover.txtLeft:SetText(tostring(mover.left))
	mover.txtLeft.Event.TextfieldChange=function()print("change") if mover.txtLeft:GetText()~="" then mover.left=tonomber(mover.txtLeft:GetText()) end end
	
	mover.txtTop=UI.CreateLbFrame("RiftTextfield",name.."TextBox",parentFrame)
	mover.txtTop:SetPoint("TOPLEFT",parentFrame,"TOPLEFT",left+120,top+60)
	mover.txtTop:SetBackgroundColor(0,0,1,1)
	mover.txtTop:SetWidth(60)
	mover.txtTop:SetText(tostring(mover.top))
	mover.txtTop.Event.TextfieldChange=function() if mover.txtTop:GetText()~="" then mover.top=tonomber( mover.txtTop:GetText()) end end
	 --up
	 mover.MoveUp=UI.CreateLbFrame("RiftButton", name.."MoveUp", parentFrame )
	 mover.MoveUp:SetPoint("TOPLEFT", parentFrame,"TOPLEFT",left+130,top+5)
	 mover.MoveUp:SetWidth(30)
	 mover.MoveUp:SetHeight(40)
	 mover.MoveUp:SetText("^\n |")
	 mover.MoveUp.Event.LeftClick=function() mover.top=mover.top-1 mover.txtTop:SetText(tostring(mover.top))  end
	 --down
	 mover.MoveDown=UI.CreateLbFrame("RiftButton", name.."MoveUp", parentFrame )
	 mover.MoveDown:SetPoint("TOPLEFT", parentFrame,"TOPLEFT",left+130,top+75)
	 mover.MoveDown:SetWidth(30)
	 mover.MoveDown:SetHeight(40)
	 mover.MoveDown:SetText("^\n |")
	 mover.MoveDown.Event.LeftClick=function() mover.top=mover.top+1 mover.txtTop:SetText(tostring(mover.top)) end
	 
	 --left
	 mover.MoveLeft=UI.CreateLbFrame("RiftButton", name.."MoveLeft", parentFrame )
	 mover.MoveLeft:SetPoint("TOPLEFT", parentFrame,"TOPLEFT",left+90,top+40)
	 mover.MoveLeft:SetWidth(30)
	 mover.MoveLeft:SetHeight(30)
	 mover.MoveLeft:SetText("<--")
	 mover.MoveLeft.Event.LeftClick=function() mover.left=mover.left-1 mover.txtLeft:SetText(tostring(mover.left)) end
	 --right
	 mover.MoveRight=UI.CreateLbFrame("RiftButton", name.."MoveLeft", parentFrame )
	 mover.MoveRight:SetPoint("TOPLEFT", parentFrame,"TOPLEFT",left+180,top+40)
	 mover.MoveRight:SetWidth(40)
	 mover.MoveRight:SetHeight(30)
	 mover.MoveRight:SetText("-->")
	 mover.MoveRight.Event.LeftClick=function() mover.left=mover.left+1 mover.txtLeft:SetText(tostring(mover.left))  end
	
	return mover
end

function lb.commonUtils.createText(parentFrame,left,top,text)
	local tp=UI.CreateLbFrame("Text", "txt", parentFrame)
    tp:SetPoint("TOPLEFT", parentFrame, "TOPLEFT", left, top)
    tp:SetText(text)
    return tp
end

function lb.isFunction(aObject)
    if  'function' == type(aObject) then
        return true
    else
        return false
    end
end

function lb.copyTable(origin,destination)
	for key,value in pairs(origin) do
		--print (type(value))
		if 'table' == type(value) then
			destination[key]={}
			lb.copyTable(value,destination[key])
		else
			destination[key]=value
		end
	end
end