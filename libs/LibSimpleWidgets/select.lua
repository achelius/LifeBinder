-- Helper Functions

local function contains(tbl, val)
  for k, v in pairs(tbl) do
    if v == val then
      return true
    end
  end
  return false
end

local function UpdateSelection(self, index)
  local item = self.items[index]

  if index == nil then
    self.current:SetText("Select...")
  else
    self.current:SetText(item)
  end
end


-- Current Frame Events

local function CurrentClick(self)
  local widget = self:GetParent()
  if not widget.enabled then return end
  local dropdown = widget.dropdown
  dropdown:SetVisible(not dropdown:GetVisible())
end


-- Dropdown Frame Events

local function DropdownItemClick(self)
  local widget = self:GetParent():GetParent()
  local item = self:GetText()
  widget.current:SetText(item)
  widget.dropdown:SetVisible(false)
  widget:SetSelectedIndex(self.index)
end

local function DropdownItemMouseIn(self)
  self:SetBackgroundColor(0.3, 0.3, 0.3, 1)
end

local function DropdownItemMouseOut(self)
  self:SetBackgroundColor(0, 0, 0, 0)
end


-- Public Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.current, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self.dropdown, width, r, g, b, a)
end

local function SetBackgroundColor(self, r, g, b, a)
  self.current:SetBackgroundColor(r, g, b, a)
  self.dropdown:SetBackgroundColor(r, g, b, a)
end

local function GetFontSize(self)
  return self.current:GetFontSize()
end

local function SetFontSize(self, size)
  self.current:SetFontSize(size)
  local height = 0
  for i, itemFrame in ipairs(self.itemFrames) do
    itemFrame:SetFontSize(size)
    height = height + itemFrame:GetHeight()
  end
  self.dropdown:SetHeight(height)
end

local function ResizeToFit(self)
  self.current:ClearAll()
  self:SetHeight(self.current:GetHeight())

  -- Find max item width, resets anchoring of each item frame
  local maxWidth = self.current:GetWidth()
  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame:GetVisible() then
      itemFrame:ClearAll()
      maxWidth = math.max(maxWidth, itemFrame:GetWidth())
    end
  end

  self:SetWidth(maxWidth)

  -- re-anchor item frames
  local prevItemFrame
  for i, itemFrame in ipairs(self.itemFrames) do
    if itemFrame then
      if prevItemFrame then
        itemFrame:SetPoint("TOPLEFT", prevItemFrame, "BOTTOMLEFT")
        itemFrame:SetPoint("TOPRIGHT", prevItemFrame, "BOTTOMRIGHT")
      else
        itemFrame:SetPoint("TOPLEFT", self.dropdown, "TOPLEFT")
        itemFrame:SetPoint("TOPRIGHT", self.dropdown, "TOPRIGHT")
      end
    end
    prevItemFrame = itemFrame
  end

  self.current:SetAllPoints(self)
end

local function GetEnabled(self)
  return self.enabled
end

local function SetEnabled(self, enabled)
  self.enabled = enabled
  if enabled then
    self.current:SetFontColor(1, 1, 1, 1)
  else
    self.current:SetFontColor(0.5, 0.5, 0.5, 1)
    self.dropdown:SetVisible(false)
  end
end

local function GetItems(self)
  return self.items
end

local function SetItems(self, items, values)
  self.items = items
  self.values = values or {}

  -- setup item frames
  local dropdownHeight = 0
  local prevItemFrame
  for i, v in ipairs(items) do
    local itemFrame
    if not self.itemFrames[i] then
      itemFrame = UI.CreateFrame("Text", self.dropdown:GetName().."Item"..i, self.dropdown)
      if prevItemFrame then
        itemFrame:SetPoint("TOPLEFT", prevItemFrame, "BOTTOMLEFT")
        itemFrame:SetPoint("TOPRIGHT", prevItemFrame, "BOTTOMRIGHT")
      else
        itemFrame:SetPoint("TOPLEFT", self.dropdown, "TOPLEFT")
        itemFrame:SetPoint("TOPRIGHT", self.dropdown, "TOPRIGHT")
      end
      itemFrame.Event.LeftClick = DropdownItemClick
      itemFrame.Event.MouseIn = DropdownItemMouseIn
      itemFrame.Event.MouseOut = DropdownItemMouseOut
      itemFrame.index = i
      self.itemFrames[i] = itemFrame
    else
      itemFrame = self.itemFrames[i]
    end
    itemFrame:SetText(v)
    itemFrame:SetVisible(true)
    dropdownHeight = dropdownHeight + itemFrame:GetHeight()
    prevItemFrame = itemFrame
  end

  -- set unused item frames invisible
  if #items < #self.itemFrames then
    for i = #items+1, #self.itemFrames do
      self.itemFrames[i]:SetVisible(false)
    end
  end

  self.dropdown:SetHeight(dropdownHeight)

  self.selectedIndex = nil
  UpdateSelection(self, nil)
end

local function GetValues(self)
  return self.values
end

local function GetSelectedItem(self)
  return self.items[self.selectedIndex]
end

local function SetSelectedItem(self, item, silent)
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
  return self.values[self.selectedIndex]
end

local function SetSelectedValue(self, value, silent)
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
  return self.selectedIndex
end

local function SetSelectedIndex(self, index, silent)
  if index and (index < 1 or index > #self.items) then
    index = nil
  end

  if index == self.selectedIndex then
    return
  end

  self.selectedIndex = index
  UpdateSelection(self, index)

  if not silent and self.Event.ItemSelect then
    local item = self.items[index]
    local value = self.values[index]
    self.Event.ItemSelect(self, item, value, index)
  end
end


-- Constructor Function

function Library.LibSimpleWidgets.Select(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.current = UI.CreateFrame("Text", widget:GetName().."Current", widget)
  widget.dropdown = UI.CreateFrame("Frame", widget:GetName().."Dropdown", widget)

  widget.enabled = true
  widget.items = {}
  widget.values = {}
  widget.itemFrames = {}
  widget.selectedIndex = nil

  widget:SetWidth(widget.current:GetWidth())
  widget:SetHeight(widget.current:GetHeight())

  widget.current:SetBackgroundColor(0, 0, 0, 1)
  widget.current:SetText("Select...")
  widget.current:SetAllPoints(widget)
  widget.current.Event.LeftClick = CurrentClick

  -- TODO: Down arrow button

  widget.dropdown:SetBackgroundColor(0, 0, 0, 1)
  widget.dropdown:SetPoint("TOPLEFT", widget.current, "BOTTOMLEFT", 0, 5)
  widget.dropdown:SetPoint("TOPRIGHT", widget.current, "BOTTOMRIGHT", 0, 5)
  widget.dropdown:SetVisible(false)

  widget.SetBorder = SetBorder
  widget.SetBackgroundColor = SetBackgroundColor
  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.ResizeToDefault = ResizeToFit -- TODO: Deprecated.
  widget.ResizeToFit = ResizeToFit
  widget.GetEnabled = GetEnabled
  widget.SetEnabled = SetEnabled
  widget.GetItems = GetItems
  widget.SetItems = SetItems
  widget.GetValues = GetValues
  widget.GetSelectedIndex = GetSelectedIndex
  widget.SetSelectedIndex = SetSelectedIndex
  widget.GetSelectedItem = GetSelectedItem
  widget.SetSelectedItem = SetSelectedItem
  widget.GetSelectedValue = GetSelectedValue
  widget.SetSelectedValue = SetSelectedValue

  Library.LibSimpleWidgets.EventProxy(widget, {"ItemSelect"})

  return widget
end
