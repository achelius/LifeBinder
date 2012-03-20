-- Helper Functions

local INACTIVE_TAB_R = 0.12
local INACTIVE_TAB_G = 0.11
local INACTIVE_TAB_B = 0.12
local INACTIVE_BORDER_R = 0.23
local INACTIVE_BORDER_G = 0.22
local INACTIVE_BORDER_B = 0.23
local INACTIVE_FONT_R = 0.66
local INACTIVE_FONT_G = 0.65
local INACTIVE_FONT_B = 0.56
local HIGHLIGHT_FONT_R = 1
local HIGHLIGHT_FONT_G = 1
local HIGHLIGHT_FONT_B = 1
local ACTIVE_TAB_R = 0.17
local ACTIVE_TAB_G = 0.17
local ACTIVE_TAB_B = 0.17
local ACTIVE_FONT_R = 0.86
local ACTIVE_FONT_G = 0.81
local ACTIVE_FONT_B = 0.63
local ACTIVE_BORDER_R = 0.47
local ACTIVE_BORDER_G = 0.48
local ACTIVE_BORDER_B = 0.40
local TAB_BORDER_WIDTH = 1
local FONT_SIZE = 13
local HIGHLIGHT_FONT_SIZE = 14
local TAB_GAP = 4


-- Public Functions

local function AddTab(self, label, frame)
  local tab = {
    frame = frame,
    active = false,
  }
  table.insert(self.tabs, tab)
  local index = #self.tabs

  frame:SetParent(self.tabContent)
  frame:SetLayer(1)
  frame:SetAllPoints(self.tabContent)
  frame:SetVisible(false)

  -- Setup tab background and border
  tab.tabFrame = UI.CreateFrame("Frame", self:GetName().."Tab"..tostring(index), self)
  tab.tabFrame:SetBackgroundColor(INACTIVE_TAB_R, INACTIVE_TAB_G, INACTIVE_TAB_B, 1)
  tab.tabFrame:SetLayer(2)
  tab.tabFrame:SetHeight(25)
  Library.LibSimpleWidgets.SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, 0, 0, 0, 0, "t")
  Library.LibSimpleWidgets.SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, INACTIVE_BORDER_R, INACTIVE_BORDER_G, INACTIVE_BORDER_B, 1, "blr")

  -- Setup label and size tab to fit
  tab.labelFrame = UI.CreateFrame("Text", self:GetName().."Label"..tostring(index), tab.tabFrame)
  tab.labelFrame:SetFontSize(FONT_SIZE)
  tab.labelFrame:SetFontColor(INACTIVE_FONT_R, INACTIVE_FONT_G, INACTIVE_FONT_B)
  self:SetTabLabel(index, label)

  -- Setup mouse events for highlighting and activating tabs
  tab.tabFrame.Event.MouseIn = function()
    tab.labelFrame:SetFontSize(HIGHLIGHT_FONT_SIZE)
    tab.labelFrame:SetFontColor(HIGHLIGHT_FONT_R, HIGHLIGHT_FONT_G, HIGHLIGHT_FONT_B)
    local x = (tab.tabFrame:GetWidth() - tab.labelFrame:GetWidth()) / 2
    tab.labelFrame:SetPoint("LEFT", tab.tabFrame, "LEFT", x, nil)
  end
  tab.tabFrame.Event.MouseOut = function()
    tab.labelFrame:SetFontSize(FONT_SIZE)
    if tab.active then
      tab.labelFrame:SetFontColor(ACTIVE_FONT_R, ACTIVE_FONT_G, ACTIVE_FONT_B, 1)
    else
      tab.labelFrame:SetFontColor(INACTIVE_FONT_R, INACTIVE_FONT_G, INACTIVE_FONT_B, 1)
    end
    local x = (tab.tabFrame:GetWidth() - tab.labelFrame:GetWidth()) / 2
    tab.labelFrame:SetPoint("LEFT", tab.tabFrame, "LEFT", x, nil)
  end
  tab.tabFrame.Event.LeftDown = function()
    self:SetActiveTab(index)
  end

  -- Position tab
  local prevTab = self.tabs[index-1]
  if prevTab then
    tab.tabFrame:SetPoint("TOPLEFT", prevTab.tabFrame, "TOPRIGHT", TAB_GAP, 0)
  else
    tab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "BOTTOMLEFT", TAB_GAP*1.5, TAB_BORDER_WIDTH)
  end

  if #self.tabs == 1 then
    self:SetActiveTab(1)
  end
end

local function RemoveTab(self, index)
  local tab = self.tabs[index]
  if tab == nil then return end

  tab.tabFrame:SetVisible(false)
  tab.frame:SetVisible(false)

  local prevTab = self.tabs[index-1]
  local nextTab = self.tabs[index+1]

  table.remove(self.tabs, index)

  if nextTab ~= nil then
    if prevTab ~= nil then
      nextTab.tabFrame:SetPoint("TOPLEFT", prevTab.labelFrame, "TOPRIGHT", TAB_BORDER_WIDTH, 0)
    else
      nextTab.tabFrame:SetPoint("TOPLEFT", self.tabContent, "BOTTOMLEFT", TAB_BORDER_WIDTH, TAB_BORDER_WIDTH)
    end
  end

  if tab.active and #self.tabs > 0 then
    self:SetActiveTab(math.max(1, index-1))
  end
end

local function GetActiveTab(self)
  for i, tab in ipairs(self.tabs) do
    if tab.active then
      return i
    end
  end

  return nil
end

local function SetActiveTab(self, index)
  local origTab
  for i, tab in ipairs(self.tabs) do
    if tab.active then
      origTab = i
    end
    if i == index then
      tab.active = true
      tab.tabFrame:SetBackgroundColor(ACTIVE_TAB_R, ACTIVE_TAB_G, ACTIVE_TAB_B, 1)
      tab.tabFrame:SetHeight(27)
      tab.tabFrame:SetLayer(3)
      Library.LibSimpleWidgets.SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, ACTIVE_TAB_R, ACTIVE_TAB_R, ACTIVE_TAB_R, 1, "t")
      Library.LibSimpleWidgets.SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, ACTIVE_BORDER_R, ACTIVE_BORDER_G, ACTIVE_BORDER_B, 1, "blr")
      tab.labelFrame:SetFontSize(FONT_SIZE)
      tab.labelFrame:SetFontColor(ACTIVE_FONT_R, ACTIVE_FONT_G, ACTIVE_FONT_B)
      local x = (tab.tabFrame:GetWidth() - tab.labelFrame:GetWidth()) / 2
      tab.labelFrame:SetPoint("LEFT", tab.tabFrame, "LEFT", x, nil)
      tab.frame:SetVisible(true)
    else
      tab.active = false
      tab.tabFrame:SetBackgroundColor(INACTIVE_TAB_R, INACTIVE_TAB_G, INACTIVE_TAB_B, 1)
      tab.tabFrame:SetHeight(25)
      tab.tabFrame:SetLayer(2)
      Library.LibSimpleWidgets.SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, 0, 0, 0, 0, "t")
      Library.LibSimpleWidgets.SetBorder(tab.tabFrame, TAB_BORDER_WIDTH, INACTIVE_BORDER_R, INACTIVE_BORDER_R, INACTIVE_BORDER_R, 1, "blr")
      tab.labelFrame:SetFontSize(FONT_SIZE)
      tab.labelFrame:SetFontColor(INACTIVE_FONT_R, INACTIVE_FONT_G, INACTIVE_FONT_B)
      local x = (tab.tabFrame:GetWidth() - tab.labelFrame:GetWidth()) / 2
      tab.labelFrame:SetPoint("LEFT", tab.tabFrame, "LEFT", x, nil)
      tab.frame:SetVisible(false)
    end
  end

  if origTab ~= index and self.Event.TabSelect then
    self.Event.TabSelect(self, index)
  end
end

local function SetTabLabel(self, index, label)
  local tab = self.tabs[index]
  if tab == nil then return end

  tab.labelFrame:SetText(label)
  tab.tabFrame:SetWidth(tab.labelFrame:GetWidth() + 10)
  if tab.tabFrame:GetWidth() < 100 then
    tab.tabFrame:SetWidth(100)
  end
  local x = (tab.tabFrame:GetWidth() - tab.labelFrame:GetWidth()) / 2
  local y = (tab.tabFrame:GetHeight() - tab.labelFrame:GetHeight()) / 2
  tab.labelFrame:SetPoint("TOPLEFT", tab.tabFrame, "TOPLEFT", x, y)
end

local function SetTabContent(self, index, frame)
  local tab = self.tabs[index]
  if tab == nil then return end

  if tab.frame then
    tab.frame:SetVisible(false)
  end

  tab.frame = frame

  frame:SetParent(self.tabContent)
  frame:SetLayer(1)
  frame:SetAllPoints(self.tabContent)
  frame:SetVisible(tab.active)
end


-- Constructor Function

function Library.LibSimpleWidgets.TabView(name, parent)
  local widget = UI.CreateFrame("Frame", name, parent)
  widget.tabContent = UI.CreateFrame("Frame", name.."Content", widget)

  widget.tabs = {}

  widget.tabContent:SetBackgroundColor(ACTIVE_TAB_R, ACTIVE_TAB_G, ACTIVE_TAB_B, 1)
  widget.tabContent:SetPoint("TOPLEFT", widget, "TOPLEFT", 5, 5)
  widget.tabContent:SetPoint("BOTTOMRIGHT", widget, "BOTTOMRIGHT", -5, -32)
  widget.tabContent:SetLayer(1)
  Library.LibSimpleWidgets.SetBorder(widget.tabContent, 1, 0.27, 0.27, 0.27, 1)

  widget.AddTab = AddTab
  widget.RemoveTab = RemoveTab
  widget.GetActiveTab = GetActiveTab
  widget.SetActiveTab = SetActiveTab
  widget.SetTabLabel = SetTabLabel
  widget.SetTabContent = SetTabContent

  Library.LibSimpleWidgets.EventProxy(widget, { "TabSelect" })

  return widget
end
