local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local abilitydetail = _G.Inspect.Ability.Detail
local abilitylist = _G.Inspect.Ability.List
function rhbCreateWindow()
	rhb.Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", rhbValues.locmainx, rhbValues.locmainy)
	rhb.Window:SetHeight(rhbValues.mainheight)
	rhb.Window:SetWidth(rhbValues.mainwidth)
	rhb.WindowFrameTop:SetTexture("RiftHbot", "Textures/header.png")
	rhb.WindowFrameTop:SetPoint("TOPLEFT", rhb.Window, "TOPLEFT", 0, 0)
	rhb.WindowFrameTop:SetPoint("TOPRIGHT", rhb.Window, "TOPRIGHT", 0, 0)
	rhb.WindowFrameTop:SetHeight(30)
    rhb.WindowFrameTop:SetWidth(200)
    rhb.WindowFrameTop:SetMouseMasking("limited")
    rhb.CombatStatus:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 7, 7)
    rhb.CombatStatus:SetLayer(4)
    rhb.CombatStatus:SetTexture("RiftHbot", "Textures/buffhot.png")
    rhb.WindowDrag:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT")
    --rhb.WindowDrag:SetPoint("TOPRIGHT", rhb.WindowFrameTop, "TOPRIGHT")
    rhb.WindowDrag:SetHeight(30)
    rhb.WindowDrag:SetWidth(200)
    rhb.WindowDrag:SetMouseMasking("limited")
    --rhb.WindowDrag:SetBackgroundColor(0, 0, 0, 1)


    rhb.CenterFrame:SetPoint("TOPLEFT", rhb.WindowFrameTop, "BOTTOMLEFT", 0, 10)
    rhb.CenterFrame:SetPoint("BOTTOMRIGHT", rhb.Window, "BOTTOMRIGHT", 0, 0)
    rhb.CenterFrame:SetLayer(1)
    rhb.CombatStatus.Event.LeftClick=function() if not rhbValues.isincombat then rhb.WindowOptions:SetVisible(true)end end
    initializeSpecButtons()
	rhbCreateGroups()
	--toggleLockedWindow(rhbValues.islocked)
	
	if (rhbValues.lockedState == false) then
	    rhb.ResizeButton:SetTexture("RiftHbot", "Textures/resizer.png")
		rhb.ResizeButton:SetWidth(32)
		rhb.ResizeButton:SetHeight(32)
		rhb.ResizeButton:SetLayer(3)
		rhb.ResizeButton:SetVisible(true)
		rhb.ResizeButton:SetPoint("BOTTOMRIGHT", rhb.CenterFrame, "BOTTOMRIGHT", 0, 0)
	end
end

function rhbCreateGroups()
	tempx = (math.ceil((rhb.Window:GetWidth() - 24) /4))
	tempy = (math.ceil((rhb.Window:GetHeight() - 60) / 5))

    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			rhb.groupBF[var]:SetTexture("RiftHbot", "Textures/backframe.png")
			rhb.groupBF[var]:SetLayer(1)
			rhb.groupBF[var]:SetBackgroundColor(0, 0, 0, 1)
			rhb.groupBF[var]:SetPoint("TOPLEFT", rhb.CenterFrame, "TOPLEFT", tempx * (a -1) ,  tempy * (i - 1))
			rhb.groupBF[var]:SetHeight(tempy)
			rhb.groupBF[var]:SetWidth(tempx)

			rhb.groupBF[var]:SetVisible(true)

            rhb.groupTarget[var]:SetTexture("RiftHbot", "Textures/targetframe.png")
            rhb.groupTarget[var]:SetPoint("TOPLEFT", rhb.groupBF[var], "TOPLEFT", 2,  2 )
            rhb.groupTarget[var]:SetHeight(tempy - 5)
            rhb.groupTarget[var]:SetWidth(tempx - 5)
            rhb.groupTarget[var]:SetLayer(2)
            rhb.groupTarget[var]:SetVisible(false)

            rhb.groupReceivingSpell[var]:SetTexture("RiftHbot", "Textures/recframe.png")
            rhb.groupReceivingSpell[var]:SetPoint("TOPLEFT", rhb.groupBF[var], "TOPLEFT", 2,  2 )
            rhb.groupReceivingSpell[var]:SetHeight(tempy - 5)
            rhb.groupReceivingSpell[var]:SetWidth(tempx - 5)
            rhb.groupReceivingSpell[var]:SetLayer(2)
            rhb.groupReceivingSpell[var]:SetVisible(false)

            rhb.groupCastBar[var]:SetTexture("RiftHbot", "Textures/health_r.png")
            rhb.groupCastBar[var]:SetPoint("BOTTOMLEFT", rhb.groupBF[var], "BOTTOMLEFT", 0,  -3*tempy*0.023255814 )
            rhb.groupCastBar[var]:SetHeight(6*tempy*0.023255814)
            rhb.groupCastBar[var]:SetWidth(tempx-5)
            rhb.groupCastBar[var]:SetLayer(6)
            rhb.groupCastBar[var]:SetVisible(false)

			rhb.groupHF[var]:SetTexture("RiftHbot", "Textures/health_g.png")
			rhb.groupHF[var]:SetPoint("TOPLEFT", rhb.groupBF[var], "TOPLEFT", 2,  2 )
			rhb.groupHF[var]:SetHeight(tempy - 5)
			rhb.groupHF[var]:SetWidth(tempx - 5)


			rhb.groupHF[var]:SetLayer(0)

		
			rhb.groupName[var]:SetPoint("TOPLEFT", rhb.groupBF[var], "TOPLEFT", 24*tempx*0.009009009, 3*tempy*0.023255814)
			rhb.groupName[var]:SetLayer(2)
            local percfsize=round((rhbValues.font)*tempy*0.023255814*0.8)

            if percfsize>12 then
                percfsize=12
            elseif percfsize<10 then
                percfsize=10
            end
            rhb.groupName[var]:SetFontSize(percfsize)
			--rhb.groupName[var]:SetText(rhb.UnitsTable[var])

			rhb.groupStatus[var]:SetText("100%")
			rhb.groupStatus[var]:SetFontColor(rhbCallingColors[5].r, rhbCallingColors[5].g, rhbCallingColors[5].b, 1)
			rhb.groupStatus[var]:SetLayer(2)
			rhb.groupStatus[var]:SetPoint("TOPRIGHT", rhb.groupBF[var], "TOPRIGHT", -10*tempx*0.009009009, (tempy /2 )*tempy*0.023255814)
            percfsize=round((rhbValues.font)*tempy*0.023255814*0.7)
            if percfsize>12 then
                percfsize=12
            elseif percfsize<8 then
                percfsize=8
            end

            rhb.groupStatus[var]:SetFontSize(percfsize)

			rhb.groupRole[var]:SetTexture("RiftHbot", "Textures/blank.png")
			rhb.groupRole[var]:SetPoint("TOPLEFT", rhb.groupBF[var], "TOPLEFT", 6*tempx*0.009009009,  6*tempy*0.023255814 )
			rhb.groupRole[var]:SetHeight(16*tempx*0.009009009)
			rhb.groupRole[var]:SetWidth(16*tempy*0.023255814)
			rhb.groupRole[var]:SetLayer(2)

            initializeBuffMonitor()

			rhb.groupMask[var]:SetLayer(3)
			rhb.groupMask[var]:SetBackgroundColor(0,0,0,0)
			rhb.groupMask[var]:SetPoint("TOPLEFT", rhb.CenterFrame, "TOPLEFT", tempx * (a - 1) + (a * 4),  tempy * (i - 1))
			rhb.groupMask[var]:SetHeight(tempy)
			rhb.groupMask[var]:SetWidth(tempx)
			
			rhb.groupMask[var]:SetVisible(false)

            

		end
	end
	--processMacroText(rhb.UnitsTable)
--	for var = 1,20 do
--        name=string.format("group%.2d", var)
--        rhb.groupMask[var].Event.LeftClick="/target @".. name
--
--	end
	if tempx <  95 then
		size = tempx / 4
		rhbValues.font = math.ceil(tempx / 6)
	else
		size = 24
		rhbValues.font = 16
	end

end

function rhb.ResizeButton.Event:LeftDown()
    if not rhbValues.islocked then
        windowResizeActive = true
        local mouseStatus = Inspect.Mouse()
        rhb.clickOffset["x"] = mouseStatus.x
        rhb.clickOffset["y"] = mouseStatus.y
        rhb.resizeOffset["x"] = rhbValues.mainwidth
        rhb.resizeOffset["y"] = rhbValues.mainheight
    end
end
function rhb.ResizeButton.Event:LeftUp()
    windowResizeActive = false
    rhbValues.mainwidth = rhb.Window:GetWidth()
    rhbValues.mainheight = rhb.Window:GetHeight()
end
function rhb.ResizeButton.Event:MouseIn()

        rhb.ResizeButton:SetTexture("RiftHbot", "Textures/resizerin.png")

end
function rhb.ResizeButton.Event:MouseOut()
    rhb.ResizeButton:SetTexture("RiftHbot", "Textures/resizer.png")
end
function rhb.ResizeButton.Event:LeftUpoutside()
    windowResizeActive = false
end
function rhb.ResizeButton.Event:MouseMove(x,y)
    if windowResizeActive == true then

        rhb.Window:SetWidth(math.ceil(rhb.resizeOffset["x"] + (x - rhb.clickOffset["x"])))
        rhb.Window:SetHeight(math.ceil(rhb.resizeOffset["y"] + (y - rhb.clickOffset["y"])))
        rhbCreateGroups()
    end
end

function rhb.WindowDrag.Event:LeftDown()
    if not rhbValues.isincombat then
        windowdragActive = true
        local mouseStatus = Inspect.Mouse()
        rhb.clickOffset["x"] = mouseStatus.x - rhbValues.locmainx
        rhb.clickOffset["y"] = mouseStatus.y - rhbValues.locmainy
    end
end

function rhb.WindowDrag.Event:LeftUp()
    windowdragActive = false
end
function rhb.WindowDrag.Event:LeftUpoutside()
    windowdragActive = false
end
function rhb.WindowDrag.Event:MouseMove(x,y)
    --print (tostring(x).."-"..tostring(y))
    if rhbValues.isincombat then
        windowdragActive = false
        return
    end
    if windowdragActive == true then

        rhbValues.locmainx = x - rhb.clickOffset["x"]
        rhbValues.locmainy = y - rhb.clickOffset["y"]
        rhb.Window:SetPoint("TOPLEFT", rhb.Context, "TOPLEFT", rhbValues.locmainx, rhbValues.locmainy)
    end
end

function round (x)
    if x >= 0 then
        return math.floor (x + 0.5)
    end  -- if positive

    return math.ceil (x - 0.5)
end -- function round