-- Internal Functions

local function UpdateScrollbarVisiblity(self)
  self.scrollbar:SetVisible(self:GetVisible() and self.showScrollbar and self.scrollbarNeeded)
end

local function ContentResized(self)
  local maxOffset = self:GetMaxOffset()
  if maxOffset == 0 then
    self.offset = 0
    self.scrollbarNeeded = false
  else
    if self.offset > maxOffset then
      self.offset = maxOffset
    end
    self.scrollbarNeeded = true
    self.scrollbar:SetRange(0, maxOffset)
    self.scrollbar:SetThickness(self:GetHeight() / self.content:GetHeight() * maxOffset)
  end
  self:UpdateScrollbarVisiblity()
  self:PositionContent()
  self:PositionScrollbar()
end

local function GetScrollOffset(self)
  return self.offset
end

local function ScrollTo(self, offset)
  self.offset = offset
  self:PositionContent()
  self:PositionScrollbar()
end

local function GetMaxOffset(self)
  return math.max(0, self.content:GetHeight() - self:GetHeight())
end

local function PositionContent(self)
  self.content:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -self.offset)
  if self.scrollbar:GetVisible() then
    self.content:SetPoint("TOPRIGHT", self, "TOPRIGHT", -self.scrollbar:GetWidth(), -self.offset)
  else
    self.content:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, -self.offset)
  end
end

local function PositionScrollbar(self)
  if self.scrollbar:GetVisible() then
    self.scrollbar:SetPosition(self.offset)
  end
end


-- Event Functions

local function WheelForward(self)
  if not self.content then
    return
  end

  if self.content:GetHeight() < self:GetHeight() then
    return
  end

  self.offset = math.max(0, self.offset - self.scrollInterval)

  self:PositionContent()
  self:PositionScrollbar()
end

local function WheelBack(self)
  if not self.content then
    return
  end

  if self.content:GetHeight() < self:GetHeight() then
    return
  end

  local _, maxOffset = self.scrollbar:GetRange()
  self.offset = math.min(maxOffset, self.offset + self.scrollInterval)

  self:PositionContent()
  self:PositionScrollbar()
end

local function ContentSizeChanged(self)
  self:GetParent():ContentResized()
  if self:GetParent().oldContentSizeFunc then
    self:GetParent():oldContentSizeFunc()
  end
end


-- Public Functions

local function SetBorder(self, width, r, g, b, a)
  Library.LibSimpleWidgets.SetBorder(self, width, r, g, b, a)
end

local function SetBackgroundColor(self, r, g, b, a)
  self.bg:SetBackgroundColor(r, g, b, a)
end

local function SetVisible(self, visible)
  self:SavedSetVisible(visible)
  self:UpdateScrollbarVisiblity()
end

local function SetContent(self, content)
  if self.content then
    self.content:SetVisible(false)
    self.content.Event.Size = self.oldContentSizeFunc
    self.oldContentSizeFunc = nil
    self.content = nil
  end

  self.content = content
  self.offset = 0

  content:SetParent(self)
  content:SetLayer(5)

  local height = content:GetHeight()
  content:ClearAll()
  content:SetHeight(height)

  self.oldContentSizeFunc = content.Event.Size
  content.Event.Size = ContentSizeChanged

  self:ContentResized()
end

local function GetScrollInterval(self)
  return self.scrollInterval
end

local function SetScrollInterval(self, interval)
  self.scrollInterval = interval
end

local function GetShowScrollbar(self)
  return self.showScrollbar
end

local function SetShowScrollbar(self, show)
  self.showScrollbar = show
  self:UpdateScrollbarVisiblity()
end

local function GetScrollbarWidth(self)
  return self.scrollbar:GetWidth()
end

local function SetScrollbarWidth(self, width)
  self.scrollbar:SetWidth(width)
end


-- Constructor Functions

function Library.LibSimpleWidgets.ScrollView(name, parent)
  local widget = UI.CreateFrame("Mask", name, parent)
  widget.bg = UI.CreateFrame("Frame", name.."BG", widget)
  widget.scrollbar = UI.CreateFrame("RiftScrollbar", name.."Scrollbar", parent)

  widget.scrollInterval = 35
  widget.showScrollbar = true
  widget.scrollbarNeeded = false

  widget.bg:SetAllPoints(widget)
  widget.bg:SetLayer(-1)
  widget.bg:SetBackgroundColor(0, 0, 0, 0)

  widget.scrollbar.scrollview = widget
  widget.scrollbar:SetOrientation("vertical")
  widget.scrollbar:SetLayer(10)
  widget.scrollbar:SetPoint("TOPRIGHT", widget, "TOPRIGHT", 0, 0)
  widget.scrollbar:SetPoint("BOTTOMRIGHT", widget, "BOTTOMRIGHT", 0, 0)
  widget.scrollbar.Event.ScrollbarChange = function()
    widget.offset = widget.scrollbar:GetPosition()
    widget:PositionContent()
  end

  -- Public API
  widget.SetBorder = SetBorder
  widget.SetBackgroundColor = SetBackgroundColor
  widget.SavedSetVisible = widget.SetVisible
  widget.SetVisible = SetVisible
  widget.SetContent = SetContent
  widget.GetScrollInterval = GetScrollInterval
  widget.SetScrollInterval = SetScrollInterval
  widget.GetShowScrollbar = GetShowScrollbar
  widget.SetShowScrollbar = SetShowScrollbar
  widget.GetScrollbarWidth = GetScrollbarWidth
  widget.SetScrollbarWidth = SetScrollbarWidth

  -- Helper Functions
  widget.ContentResized = ContentResized
  widget.GetScrollOffset = GetScrollOffset
  widget.ScrollTo = ScrollTo
  widget.GetMaxOffset = GetMaxOffset
  widget.PositionContent = PositionContent
  widget.PositionScrollbar = PositionScrollbar
  widget.UpdateScrollbarVisiblity = UpdateScrollbarVisiblity

  widget:UpdateScrollbarVisiblity()

  -- Events
  widget.Event.WheelBack = WheelBack
  widget.Event.WheelForward = WheelForward

  return widget
end
