local PADDING = 3
local MAX_WIDTH = 250
local MAX_HEIGHT = 500
local MOUSE_X_OFFSET = 18
local MOUSE_Y_OFFSET = 25

-- Helper Functions

local function ResizeToFit(self)
  self.text:ClearAll()
  local w = math.min(MAX_WIDTH, self.text:GetWidth())
  self.text:SetWidth(w)
  local h = math.min(MAX_HEIGHT, self.text:GetHeight())
  self.text:ClearWidth()
  self.text:SetPoint("TOPLEFT", self, "TOPLEFT", PADDING, PADDING)
  self.text:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -PADDING, -PADDING)
  self:SetWidth(w + PADDING * 2)
  self:SetHeight(h + PADDING * 2)
end

-- Public Functions

local function GetFontSize(self)
  return self.text:GetFontSize()
end

local function SetFontSize(self, size)
  self.text:SetFontSize(size)
  ResizeToFit(self)
end

local function GetFontColor(self)
  return self.text:GetFontColor()
end

local function SetFontColor(self, r, g, b, a)
  self.text:SetFontColor(r, g, b, a)
end

local function Show(self, owner, text)
  self.owner = owner
  self.text:SetText(text)
  ResizeToFit(self)

  local m = Inspect.Mouse()
  local left, top = owner:GetBounds()
  self:SetPoint("TOPLEFT", owner, "TOPLEFT", m.x - left + MOUSE_X_OFFSET, m.y - top + MOUSE_Y_OFFSET)
  self:SetVisible(true)
end

local function Hide(self, owner)
  if self.owner ~= owner then return end
  self:SetVisible(false)
  self.owner = nil
end

local function InjectEvents(self, frame, tooltipTextFunc)
  local tooltip = self
  frame.Event.MouseIn = function() tooltip:Show(frame, tooltipTextFunc(tooltip)) end
  frame.Event.MouseMove = function() tooltip:Show(frame, tooltipTextFunc(tooltip)) end
  frame.Event.MouseOut = function() tooltip:Hide(frame) end
end

local function RemoveEvents(self, frame)
  frame.Event.MouseIn = nil
  frame.Event.MouseMove = nil
  frame.Event.MouseOut = nil
end


-- Constructor Function

function Library.LibSimpleWidgets.Tooltip(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.text = UI.CreateFrame("Text", name .. "Text", widget)

  widget:SetBackgroundColor(0, 0, 0, 1)
  widget:SetLayer(999)
  Library.LibSimpleWidgets.SetBorder(widget, 1, 0.5, 0.5, 0.5, 1)
  widget:SetVisible(false)

  widget.text:SetWordwrap(true)
  ResizeToFit(widget)

  widget.GetFontSize = GetFontSize
  widget.SetFontSize = SetFontSize
  widget.GetFontColor = GetFontColor
  widget.SetFontColor = SetFontColor
  widget.Show = Show
  widget.Hide = Hide
  widget.InjectEvents = InjectEvents
  widget.RemoveEvents = RemoveEvents

  return widget
end
