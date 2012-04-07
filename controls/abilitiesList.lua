-- Helper Functions

local function UpdateSelection(self)
  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame.selected then
      itemFrame.bgFrame:SetBackgroundColor(unpack(self.selectionBgColor))
    else
      local level = self.levels[i]
      local backgroundColor = {0, 0, 0, 0}
      if level then
        backgroundColor = self.levelBackgroundColors[level] or backgroundColor
      end
      itemFrame.bgFrame:SetBackgroundColor(unpack(backgroundColor))
    end
  end
end

local function CreateDragFrame(self,parent,mainframe)
	
	self.dragFrame = UI.CreateLbFrame("Texture", "DragTexture", mainframe)
	self.dragFrame:SetPoint("TOPLEFT",mainframe,"TOPLEFT",0,0)
	self.dragFrame:SetWidth(32)
	self.dragFrame:SetHeight(32)
	self.dragFrame.mainFrame=mainframe
	
	self.dragFrame:SetTexture("LibSimpleWidgets","textures/drag.png")
	self.dragFrame:SetVisible(false)
	self.dragFrame:SetLayer(60)
	self.dragEnabled=true
end
local function SetDragFrameToMousePosition(self,x,y)
   if self.dragFrame==nil then return end
   if not self.dragEnabled then return end
	self.dragFrame:SetPoint("TOPLEFT",self,"TOPLEFT",x-16-self:GetLeft(),y-16-self:GetTop())
	self.dragFrame.lastPositionX=x
	self.dragFrame.lastPositionY=y
end
local function SetDragFrameTexture(self,text1,text2)
   if self.dragFrame==nil then return end
   if not self.dragEnabled then return end
	self.dragFrame:SetTexture(text1,text2)
end

local function SetDragFrameVisibility(self,value)
	if self.dragFrame==nil then return end
	if not self.dragEnabled then return end
	self.dragFrame:SetVisible(value)
	self.dragFrame:SetLayer(60)
end
local function checkDragFramePosition(self)
	if self.dragFrame==nil then return false end
	if not self.dragEnabled then return end
	local x=self.dragFrame.lastPositionX
	local y=self.dragFrame.lastPositionY
	local left =self:GetLeft()
	local right =self:GetRight()
	local top =self:GetTop()
	local bottom =self:GetBottom()
	if x<right and x>left then
		if y<bottom and y>top then
			return false
		end
	end
	return true
end

-- Item Frame Events

local function ItemIsSelectable(self, index)
  local selectable = self.levelSelectable[self.levels[index]]
  return selectable == nil or selectable
end

local function ItemClick(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  if not ItemIsSelectable(widget, self.index) then return end
  if widget.selectionMode == "single" then
    widget:SetSelectedIndex(self.index)
  elseif widget.selectionMode == "multi" then
    if self.selected then
      widget:RemoveSelectedIndex(self.index)
    else
      widget:AddSelectedIndex(self.index)
    end
  end
end

local function ItemDown(self,index)
  local widget = self:GetParent()
  if not widget.enabled then return end
  if not ItemIsSelectable(widget, self.index) then return end
  if not widget.dragEnabled then return end
  widget.enableDrag=true
  local pos= Inspect.Mouse()
  SetDragFrameTexture(widget,widget.items[index][2],widget.items[index][3])
  SetDragFrameToMousePosition(widget,pos.x,pos.y)
  --SetDragFrameVisibility(widget,true)
  
end
local function ItemUp(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  widget.enableDrag=false
  SetDragFrameVisibility(widget,false)
  
end

local function ItemUpoutside(self,index)
  local widget = self:GetParent()
  if not widget.enabled then return end
  if not widget.dragEnabled then return end
  widget.enableDrag=false
  SetDragFrameVisibility(widget,false)
  --find out if the item was dragged outside of the frames
  local isOutside=checkDragFramePosition(widget)
  if widget.Event.DraggedOutItem  and isOutside then
  	local pos= Inspect.Mouse()
    widget.Event.DraggedOutItem(widget.items[index],pos.x,pos.y)
  end
end
local function ItemMouseMove(self,x,y)
  local widget = self:GetParent()
  if not widget.enabled then return end
  if not ItemIsSelectable(widget, self.index) then return end
  if not widget.dragEnabled then return end
  if widget.enableDrag then 
   	SetDragFrameToMousePosition(widget,x,y)
   	SetDragFrameVisibility(widget,true)
  end
end

local function ItemMouseIn(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  if not ItemIsSelectable(widget, self.index) then return end
  if not self.selected then
    self.bgFrame:SetBackgroundColor(0.3, 0.3, 0.3, 1)
  end
end

local function ItemMouseOut(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  if not ItemIsSelectable(widget, self.index) then return end
  if not self.selected then
    local level = widget.levels[self.index]
    local backgroundColor = {0, 0, 0, 0}
    if level then
      backgroundColor = widget.levelBackgroundColors[level] or backgroundColor
    end
    self.bgFrame:SetBackgroundColor(unpack(backgroundColor))
  end
end


local function LayoutItems(self)
  local height = 0
  local prevItemFrame
  for i, item in ipairs(self.items) do
    local itemFrame = self.itemFrames[i]
    local iconFrame = self.iconsFrames[i]
    local bgFrame = itemFrame and itemFrame.bgFrame
    if not itemFrame then
      itemFrame = UI.CreateLbFrame("Text", self:GetName().."Item"..i, self)
      itemFrame:SetBackgroundColor(0, 0, 0, 0)
      if prevItemFrame then
        itemFrame:SetPoint("TOP", prevItemFrame, "BOTTOM")
      else
        itemFrame:SetPoint("TOP", self, "TOP")
      end
      itemFrame:SetPoint("RIGHT", self, "RIGHT")
      bgFrame = UI.CreateLbFrame("Frame", self:GetName().."ItemBG"..i, self)
      bgFrame:SetLayer(itemFrame:GetLayer()-1)
      bgFrame:SetPoint("TOP", itemFrame, "TOP")
      bgFrame:SetPoint("BOTTOM", itemFrame, "BOTTOM")
      bgFrame:SetPoint("LEFT", self, "LEFT")
      bgFrame:SetPoint("RIGHT", self, "RIGHT")
      bgFrame.Event.LeftClick = function() ItemClick(itemFrame) end
      bgFrame.Event.LeftDown = function() ItemDown(itemFrame,i) end
      bgFrame.Event.LeftUpoutside = function() ItemUpoutside(itemFrame,i) end
      bgFrame.Event.LeftUp = function() ItemUp(itemFrame) end
      bgFrame.Event.MouseIn = function() ItemMouseIn(itemFrame) end
      bgFrame.Event.MouseOut = function() ItemMouseOut(itemFrame) end
      bgFrame.Event.MouseMove = function(buttons,x,y) ItemMouseMove(itemFrame,x,y) end
      itemFrame.index = i
      itemFrame.bgFrame = bgFrame
      self.itemFrames[i] = itemFrame
    end

    local level = self.levels[i]

    local indent = 0
    local fontSize = self.fontSize
    local fontColor = {1, 1, 1}
    local backgroundColor
    if itemFrame.selected then
      backgroundColor = self.selectionBgColor
    else
      backgroundColor = {0, 0, 0, 0}
    end
    if level then
      indent = self.indentSize * (level-1)
      fontSize = self.levelFontSizes[level] or fontSize
      fontColor = self.levelFontColors[level] or fontColor
      backgroundColor = self.levelBackgroundColors[level] or backgroundColor
    end
	local iconFrame = self.iconsFrames[i]
    itemFrame:SetPoint("LEFT", self, "LEFT", 35, nil)
    itemFrame:SetFontSize(fontSize)
    itemFrame:SetFontColor(unpack(fontColor))
	local desc=item[8]
	local text=item[1]
	if desc~=nil then
		text=text.."\n"..desc
	end
    if text~=1 then
      
      itemFrame:SetText(text)
      
    end
    itemFrame:SetVisible(true)
    itemFrame:SetHeight(40)
    itemFrame.bgFrame:SetBackgroundColor(unpack(backgroundColor))
    itemFrame.bgFrame:SetVisible(true)
	if not iconFrame then
	    self.iconsFrames[i]=UI.CreateLbFrame("Texture", self:GetName().."Itemt"..i, bgFrame)
	end
	self.iconsFrames[i]:SetTexture(item[2],item[3])
	self.iconsFrames[i]:SetPoint("TOPLEFT", bgFrame, "TOPLEFT", 0, 0)
	self.iconsFrames[i]:SetWidth(32)
	self.iconsFrames[i]:SetHeight(32)
	self.iconsFrames[i]:SetVisible(true)
	
	
    height = height + itemFrame:GetHeight()
    prevItemFrame = itemFrame
  
  end

  self:SetHeight(height)
end

-- Public Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self, width, r, g, b, a)
end

local function GetFontSize(self)
  return self.fontSize
end

local function SetFontSize(self, size)
  self.fontSize = size
  LayoutItems(self)
end

local function GetEnabled(self)
  return self.enabled
end

local function GetSelectionBackgroundColor(self)
  return unpack(self.selectionBgColor)
end

local function SetSelectionBackgroundColor(self, r, g, b, a)
  self.selectionBgColor = {r, g, b, a }
  UpdateSelection(self)
end

local function SetLevelIndentSize(self, size)
  self.indentSize = size
  LayoutItems(self)
end

local function SetLevelFontSize(self, level, size)
  self.levelFontSizes[level] = size
  LayoutItems(self)
end

local function SetLevelFontColor(self, level, r, g, b)
  self.levelFontColors[level] = {r, g, b}
  LayoutItems(self)
end

local function SetLevelBackgroundColor(self, level, r, g, b, a)
  self.levelBackgroundColors[level] = {r, g, b, a }
  LayoutItems(self)
end

local function SetLevelSelectable(self, level, selectable)
  self.levelSelectable[level] = selectable
end

local function SetEnabled(self, enabled)
  self.enabled = enabled
  if enabled then
    for i, itemFrame in ipairs(self.itemFrames) do
      itemFrame:SetFontColor(1, 1, 1, 1)
    end
  else
    for i, itemFrame in ipairs(self.itemFrames) do
      itemFrame:SetFontColor(0.5, 0.5, 0.5, 1)
    end
  end
end

local function GetItems(self)
  return self.items
end

local function SetItems(self, items, values, levels)
  self:ClearSelection(true)

  self.items = items
  self.values = values or {}
  self.levels = levels or {}

  LayoutItems(self)

  if #items < #self.itemFrames then
    for i = #items+1, #self.itemFrames do
      self.itemFrames[i]:SetVisible(false)
      self.itemFrames[i].bgFrame:SetVisible(false)
    end
  end
end

local function GetValues(self)
  return self.values
end

local function SetSelectionMode(self, mode)
  if mode ~= "single" and mode ~= "multi" then
    error("Invalid selection mode: "..mode)
  end

  self:ClearSelection()

  self.selectionMode = mode
end

local function GetSelectedItem(self)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  return self.items[self.selectedIndex]
end

local function SetSelectedItem(self, item, silent)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  if item then
    for i, v in ipairs(self.items) do
      if v == item then
        self:SetSelectedIndex(i, silent)
        return
      end
    end
  end

  self:SetSelectedIndex(nil, silent)
end

local function GetSelectedValue(self)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  return self.values[self.selectedIndex]
end

local function SetSelectedValue(self, value, silent)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  if value then
    for i, v in ipairs(self.values) do
      if v == value then
        self:SetSelectedIndex(i, silent)
        return
      end
    end
  end

  self:SetSelectedIndex(nil, silent)
end

local function GetSelectedIndex(self)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end
  return self.selectedIndex
end

local function SetSelectedIndex(self, index, silent)
  if self.selectionMode ~= "single" then
    error("List is not in single-select mode.")
  end

  if index == nil then
    self:ClearSelection(silent)
    return
  end

  if index and (index < 1 or index > #self.items) then
    index = nil
  end

  if index == self.selectedIndex then
    return
  end

  if self.selectedIndex then
    self.itemFrames[self.selectedIndex].selected = false
  end

  if index then
    self.itemFrames[index].selected = true
  end

  self.selectedIndex = index

  if not silent and self.Event.ItemSelect then
    local item = self.items[index]
    local value = self.values[index]
    self.Event.ItemSelect(self, item, value, index)
  end

  UpdateSelection(self)

  if not silent and self.Event.SelectionChange then
    self.Event.SelectionChange(self)
  end
end

local function AddSelectedIndex(self, index, silent)
  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if index and (index < 1 or index > #self.items) then
    return
  end

  if not self.itemFrames[index].selected then
    self.itemFrames[index].selected = true

    UpdateSelection(self)

    if not silent and self.Event.SelectionChange then
      self.Event.SelectionChange(self)
    end
  end
end

local function RemoveSelectedIndex(self, index, silent)
  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if index and (index < 1 or index > #self.items) then
    return
  end

  if self.itemFrames[index].selected then
    self.itemFrames[index].selected = false

    UpdateSelection(self)

    if not silent and self.Event.SelectionChange then
      self.Event.SelectionChange(self)
    end
  end
end

local function GetSelection(self)
  local selection = {}

  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame.selected then
      table.insert(selection, { index=i, item=self.items[i], value=self.values[i] })
    end
  end

  return selection
end

local function ClearSelection(self, silent)
  for i, itemFrame in ipairs(self.itemFrames) do
    itemFrame.selected = false
  end

  self.selectedIndex = nil

  UpdateSelection(self)

  if not silent and self.Event.SelectionChange then
    self.Event.SelectionChange(self)
  end
end

local function GetSelectedIndices(self)
  local indices = {}

  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame.selected then
      table.insert(indices, i)
    end
  end
  
  return indices
end

local function SetSelectedIndices(self, indices, silent)
  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if indices == nil then
    self:ClearSelection(silent)
    return
  end

  for i, itemFrame in ipairs(self.itemFrames) do
    itemFrame.selected = false
  end

  for _, i in ipairs(indices) do
    if i ~= nil and i >= 1 and i <= #self.items then
      self.itemFrames[i].selected = true
    end
  end

  UpdateSelection(self)

  if not silent and self.Event.SelectionChange then
    self.Event.SelectionChange(self)
  end
end

local function GetSelectedItems(self)
  local items = {}

  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame.selected then
      table.insert(items, self.items[i])
    end
  end

  return items
end

local function SetSelectedItems(self, items, silent)
  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if items == nil then
    self:ClearSelection(silent)
    return
  end

  local indices = {}

  for i, item in ipairs(self.items) do
    for _, selectItem in ipairs(items) do
      if item == selectItem then
        table.insert(indices, i)
      end
    end
  end

  self:SetSelectedIndices(indices, silent)
end

local function GetSelectedValues(self)
  local values = {}

  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame.selected then
      table.insert(values, self.values[i])
    end
  end

  return values
end

local function SetSelectedValues(self, values, silent)
  if self.selectionMode ~= "multi" then
    error("List is not in multi-select mode.")
  end

  if values == nil then
    self:ClearSelection(silent)
    return
  end

  local indices = {}

  for i, value in ipairs(self.values) do
    for _, selectValue in ipairs(values) do
      if value == selectValue then
        table.insert(indices, i)
      end
    end
  end

  self:SetSelectedIndices(indices, silent)
end


-- Constructor Function

function lb.controls.AbilitiesList(name, parent)
	--dump(mainframe)
  local widget = UI.CreateLbFrame("Frame", name, parent)
  widget:SetBackgroundColor(0, 0, 0, 1)

  widget.enabled = true
  widget.dragEnabled = false
  widget.fontSize = 12
  widget.selectionBgColor = {0, 0, 0.5, 1}
  widget.items = {}
  widget.values = {}
  widget.levels = {}
  widget.itemFrames = {}
  widget.iconsFrames = {}
  widget.indentSize = 10
  widget.levelFontSizes = {}
  widget.levelFontColors = {}
  widget.levelBackgroundColors = {}
  widget.levelSelectable = {}
  widget.selectedIndex = nil
  widget.selectionMode = "single"

  widget.SetBorder = SetBorder
  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.GetSelectionBackgroundColor = GetSelectionBackgroundColor
  widget.SetSelectionBackgroundColor = SetSelectionBackgroundColor
  widget.SetLevelIndentSize = SetLevelIndentSize
  widget.SetLevelFontSize = SetLevelFontSize
  widget.SetLevelFontColor = SetLevelFontColor
  widget.SetLevelBackgroundColor = SetLevelBackgroundColor
  widget.SetLevelSelectable = SetLevelSelectable
  widget.GetItems = GetItems
  widget.SetItems = SetItems
  widget.GetValues = GetValues
  widget.SetSelectionMode = SetSelectionMode
  widget.GetSelectedIndex = GetSelectedIndex
  widget.SetSelectedIndex = SetSelectedIndex
  widget.GetSelectedItem = GetSelectedItem
  widget.SetSelectedItem = SetSelectedItem
  widget.GetSelectedValue = GetSelectedValue
  widget.SetSelectedValue = SetSelectedValue
  widget.AddSelectedIndex = AddSelectedIndex
  widget.RemoveSelectedIndex = RemoveSelectedIndex
  widget.GetSelection = GetSelection
  widget.ClearSelection = ClearSelection
  widget.GetSelectedIndices = GetSelectedIndices
  widget.SetSelectedIndices = SetSelectedIndices
  widget.GetSelectedItems = GetSelectedItems
  widget.SetSelectedItems = SetSelectedItems
  widget.GetSelectedValues = GetSelectedValues
  widget.SetSelectedValues = SetSelectedValues
  widget.CreateDragFrame = CreateDragFrame
  Library.LibSimpleWidgets.EventProxy(widget, {"ItemSelect", "SelectionChange","DraggedOutItem"})
  
 
  
  return widget
end
