local function createBorderFrame(frame, name)
  local border = frame[name]
  if border then
    return border
  end

  border = UI.CreateFrame("Frame", frame:GetName()..name, frame:GetParent())
  frame[name] = border

  return border
end

function Library.LibSimpleWidgets.SetBorder(frame, width, r, g, b, a, borders)
  -- defaults
  width = width or 1
  r = r or 0
  g = g or 0
  b = b or 0
  a = a or 0
  borders = borders or "tblr"

  local bt, bb, bl, br

  -- Re-use the existing borders or create new ones
  bt = createBorderFrame(frame, "LSWTopBorder")
  bb = createBorderFrame(frame, "LSWBottomBorder")
  bl = createBorderFrame(frame, "LSWLeftBorder")
  br = createBorderFrame(frame, "LSWRightBorder")

  -- Hook SetVisible so we can do the same on the borders
  if not frame.OldSetVisible then
    frame.OldSetVisible = frame.SetVisible
    function frame:SetVisible(visible)
      self.LSWTopBorder:SetVisible(visible)
      self.LSWBottomBorder:SetVisible(visible)
      self.LSWLeftBorder:SetVisible(visible)
      self.LSWRightBorder:SetVisible(visible)
      self:OldSetVisible(visible)
    end
  end

  local btv = string.find(borders, "t") ~= nil
  local bbv = string.find(borders, "b") ~= nil
  local blv = string.find(borders, "l") ~= nil
  local brv = string.find(borders, "r") ~= nil

  -- top border
  bt:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", -width, 0)
  bt:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", width, 0)
  bt:SetHeight(width)
  bt:SetLayer(frame:GetLayer())

  -- bottom border
  bb:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -width, 0)
  bb:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", width, 0)
  bb:SetHeight(width)
  bb:SetLayer(frame:GetLayer())

  -- left border
  bl:SetPoint("TOPRIGHT", frame, "TOPLEFT", 0, -width)
  bl:SetPoint("BOTTOMRIGHT", frame, "BOTTOMLEFT", 0, width)
  bl:SetWidth(width)
  bl:SetLayer(frame:GetLayer())

  -- right border
  br:SetPoint("TOPLEFT", frame, "TOPRIGHT", 0, -width)
  br:SetPoint("BOTTOMLEFT", frame, "BOTTOMRIGHT", 0, width)
  br:SetWidth(width)
  br:SetLayer(frame:GetLayer())

  -- Make the borders match the frames current visibility
  if btv then
    bt:SetBackgroundColor(r, g, b, a)
    bt:SetVisible(frame:GetVisible())
  end
  if bbv then
    bb:SetBackgroundColor(r, g, b, a)
    bb:SetVisible(frame:GetVisible())
  end
  if blv then
    bl:SetBackgroundColor(r, g, b, a)
    bl:SetVisible(frame:GetVisible())
  end
  if brv then
    br:SetBackgroundColor(r, g, b, a)
    br:SetVisible(frame:GetVisible())
  end
end
