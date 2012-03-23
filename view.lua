local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitydetail = _G.Inspect.Ability.Detail
local abilitylist = _G.Inspect.Ability.List
function lbCreateWindow()
	lb.Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", lbValues.locmainx, lbValues.locmainy)
	lb.Window:SetHeight(lbValues.mainheight)
	lb.Window:SetWidth(lbValues.mainwidth)
	lb.WindowFrameTop:SetTexture("LifeBinder", "Textures/header.png")
	lb.WindowFrameTop:SetPoint("TOPLEFT", lb.Window, "TOPLEFT", 0, 0)
	lb.WindowFrameTop:SetPoint("TOPRIGHT", lb.Window, "TOPRIGHT", 0, 0)
	lb.WindowFrameTop:SetHeight(30)
    lb.WindowFrameTop:SetWidth(200)
    lb.WindowFrameTop:SetMouseMasking("limited")
    lb.CombatStatus:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 7, 7)
    lb.CombatStatus:SetLayer(4)
    lb.CombatStatus:SetTexture("LifeBinder", "Textures/buffhot.png")
    lb.WindowDrag:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT")
    --lb.WindowDrag:SetPoint("TOPRIGHT", lb.WindowFrameTop, "TOPRIGHT")
    lb.WindowDrag:SetHeight(30)
    lb.WindowDrag:SetWidth(200)
    lb.WindowDrag:SetMouseMasking("limited")
    --lb.WindowDrag:SetBackgroundColor(0, 0, 0, 1)


    lb.CenterFrame:SetPoint("TOPLEFT", lb.WindowFrameTop, "BOTTOMLEFT", 0, 10)
    lb.CenterFrame:SetPoint("BOTTOMRIGHT", lb.Window, "BOTTOMRIGHT", 0, 0)
    lb.CenterFrame:SetLayer(1)
    lb.CombatStatus.Event.LeftClick=function() if not lbValues.isincombat then lb.WindowOptions:SetVisible(true)end end
    initializeSpecButtons()
	lbCreateGroups()
	--toggleLockedWindow(lbValues.islocked)
	
	if (lbValues.lockedState == false) then
	    lb.ResizeButton:SetTexture("LifeBinder", "Textures/resizer.png")
		lb.ResizeButton:SetWidth(32)
		lb.ResizeButton:SetHeight(32)
		lb.ResizeButton:SetLayer(3)
		lb.ResizeButton:SetVisible(true)
		lb.ResizeButton:SetPoint("BOTTOMRIGHT", lb.CenterFrame, "BOTTOMRIGHT", 0, 0)
	end
end

function lbCreateGroups()
	tempx = (math.ceil((lb.Window:GetWidth() - 24) /4))
	tempy = (math.ceil((lb.Window:GetHeight() - 60) / 5))

    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			lb.groupBF[var]:SetTexture("LifeBinder", "Textures/backframe.png")
			lb.groupBF[var]:SetLayer(1)
			lb.groupBF[var]:SetBackgroundColor(0, 0, 0, 1)
			lb.groupBF[var]:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", tempx * (a -1) ,  tempy * (i - 1))
			lb.groupBF[var]:SetHeight(tempy)
			lb.groupBF[var]:SetWidth(tempx)
			lb.groupBF[var]:SetVisible(true)
			
			--Set Resource Frame
			lb.groupRF[var]:SetPoint("BOTTOMLEFT", lb.groupMask[var], "BOTTOMLEFT", -2, 0)
			lb.groupRF[var]:SetHeight(5)
			lb.groupRF[var]:SetWidth(tempx - 6)
			lb.groupRF[var]:SetLayer(2)
			lb.groupRF[var]:SetVisible(true)

            lb.groupTarget[var]:SetTexture("LifeBinder", "Textures/targetframe.png")
            lb.groupTarget[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
            lb.groupTarget[var]:SetHeight(tempy - 5)
            lb.groupTarget[var]:SetWidth(tempx - 5)
            lb.groupTarget[var]:SetLayer(3)
            lb.groupTarget[var]:SetVisible(false)

            lb.groupReceivingSpell[var]:SetTexture("LifeBinder", "Textures/recframe.png")
            lb.groupReceivingSpell[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
            lb.groupReceivingSpell[var]:SetHeight(tempy - 5)
            lb.groupReceivingSpell[var]:SetWidth(tempx - 5)
            lb.groupReceivingSpell[var]:SetLayer(4)
            lb.groupReceivingSpell[var]:SetVisible(false)

            lb.groupCastBar[var]:SetTexture("LifeBinder", "Textures/health_r.png")
            lb.groupCastBar[var]:SetPoint("BOTTOMLEFT", lb.groupBF[var], "BOTTOMLEFT", 0,  -3*tempy*0.023255814 )
            lb.groupCastBar[var]:SetHeight(6*tempy*0.023255814)
            lb.groupCastBar[var]:SetWidth(tempx-5)
            lb.groupCastBar[var]:SetLayer(6)
            lb.groupCastBar[var]:SetVisible(false)

			lb.groupHF[var]:SetTexture("LifeBinder", "Textures/health_g.png")
			lb.groupHF[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
			lb.groupHF[var]:SetHeight(tempy - 5)
			lb.groupHF[var]:SetWidth(tempx - 5)
			lb.groupHF[var]:SetLayer(0)

		
			lb.groupName[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 24*tempx*0.009009009, 3*tempy*0.023255814)
			lb.groupName[var]:SetLayer(2)
            local percfsize=round((lbValues.font)*tempy*0.023255814*0.8)

            if percfsize>12 then
                percfsize=12
            elseif percfsize<10 then
                percfsize=10
            end
            lb.groupName[var]:SetFontSize(percfsize)
			--lb.groupName[var]:SetText(lb.UnitsTable[var])

			lb.groupStatus[var]:SetText("100%")
			lb.groupStatus[var]:SetFontColor(lbCallingColors[5].r, lbCallingColors[5].g, lbCallingColors[5].b, 1)
			lb.groupStatus[var]:SetLayer(2)
			lb.groupStatus[var]:SetPoint("TOPRIGHT", lb.groupBF[var], "TOPRIGHT", -10*tempx*0.009009009, (tempy /2 )*tempy*0.023255814)
            percfsize=round((lbValues.font)*tempy*0.023255814*0.7)
            if percfsize>12 then
                percfsize=12
            elseif percfsize<8 then
                percfsize=8
            end

            lb.groupStatus[var]:SetFontSize(percfsize)

			lb.groupRole[var]:SetTexture("LifeBinder", "Textures/blank.png")
			lb.groupRole[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 6*tempx*0.009009009,  6*tempy*0.023255814 )
			lb.groupRole[var]:SetHeight(16*tempx*0.009009009)
			lb.groupRole[var]:SetWidth(16*tempy*0.023255814)
			lb.groupRole[var]:SetLayer(2)

            

			lb.groupMask[var]:SetLayer(3)
			lb.groupMask[var]:SetBackgroundColor(0,0,0,0)
			lb.groupMask[var]:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", tempx * (a - 1) + (a * 4),  tempy * (i - 1))
			lb.groupMask[var]:SetHeight(tempy)
			lb.groupMask[var]:SetWidth(tempx)
			
			lb.groupMask[var]:SetVisible(false)

            

		end
	end
	--processMacroText(lb.UnitsTable)
--	for var = 1,20 do
--        name=string.format("group%.2d", var)
--        lb.groupMask[var].Event.LeftClick="/target @".. name
--
--	end
	if tempx <  95 then
		size = tempx / 4
		lbValues.font = math.ceil(tempx / 6)
	else
		size = 24
		lbValues.font = 16
	end

end

function lb.ResizeButton.Event:LeftDown()
    if not lbValues.islocked then
        windowResizeActive = true
        local mouseStatus = Inspect.Mouse()
        lb.clickOffset["x"] = mouseStatus.x
        lb.clickOffset["y"] = mouseStatus.y
        lb.resizeOffset["x"] = lbValues.mainwidth
        lb.resizeOffset["y"] = lbValues.mainheight
    end
end
function lb.ResizeButton.Event:LeftUp()
    windowResizeActive = false
    lbValues.mainwidth = lb.Window:GetWidth()
    lbValues.mainheight = lb.Window:GetHeight()
end
function lb.ResizeButton.Event:MouseIn()

        lb.ResizeButton:SetTexture("LifeBinder", "Textures/resizerin.png")

end
function lb.ResizeButton.Event:MouseOut()
    lb.ResizeButton:SetTexture("LifeBinder", "Textures/resizer.png")
end
function lb.ResizeButton.Event:LeftUpoutside()
    windowResizeActive = false
end
function lb.ResizeButton.Event:MouseMove(x,y)
    if windowResizeActive == true then

        lb.Window:SetWidth(math.ceil(lb.resizeOffset["x"] + (x - lb.clickOffset["x"])))
        lb.Window:SetHeight(math.ceil(lb.resizeOffset["y"] + (y - lb.clickOffset["y"])))
        lbCreateGroups()
    end
end

function lb.WindowDrag.Event:LeftDown()
    if not lbValues.isincombat then
        windowdragActive = true
        local mouseStatus = Inspect.Mouse()
        lb.clickOffset["x"] = mouseStatus.x - lbValues.locmainx
        lb.clickOffset["y"] = mouseStatus.y - lbValues.locmainy
    end
end

function lb.WindowDrag.Event:LeftUp()
    windowdragActive = false
end
function lb.WindowDrag.Event:LeftUpoutside()
    windowdragActive = false
end
function lb.WindowDrag.Event:MouseMove(x,y)
    --print (tostring(x).."-"..tostring(y))
    if lbValues.isincombat then
        windowdragActive = false
        return
    end
    if windowdragActive == true then

        lbValues.locmainx = x - lb.clickOffset["x"]
        lbValues.locmainy = y - lb.clickOffset["y"]
        lb.Window:SetPoint("TOPLEFT", lb.Context, "TOPLEFT", lbValues.locmainx, lbValues.locmainy)
    end
end

function round (x)
    if x >= 0 then
        return math.floor (x + 0.5)
    end  -- if positive

    return math.ceil (x - 0.5)
end -- function round