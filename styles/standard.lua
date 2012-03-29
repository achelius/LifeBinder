
-- planned functions: see: stylescore.lua

lb.styles["standard"]={}
local stTable=lb.styles["standard"]
local optionsTable=nil
function stTable.setFrames()
	--now i want to load the settings for the standard style
	optionsTable=lb.styles.getConfiguration("standard")
	print ("standard")
end

function stTable.initialize()
	
	
    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			lb.groupBF[var]:SetTexture("LifeBinder", "Textures/backframe.png")
			lb.groupBF[var]:SetLayer(1)
			lb.groupBF[var]:SetBackgroundColor(0, 0, 0, 1)
			lb.groupBF[var]:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", lbValues.mainwidth * (a -1) ,  lbValues.mainheight * (i - 1))
			lb.groupBF[var]:SetHeight(lbValues.mainheight)
			lb.groupBF[var]:SetWidth(lbValues.mainwidth)
			lb.groupBF[var]:SetVisible(false)
			
			--Set Resource Frame
			lb.groupRF[var]:SetPoint("BOTTOMLEFT", lb.groupBF[var], "BOTTOMLEFT", 5, 0)
			lb.groupRF[var]:SetHeight(5)
			lb.groupRF[var]:SetWidth(lbValues.mainwidth - 6)
			lb.groupRF[var]:SetLayer(2)
			lb.groupRF[var]:SetVisible(true)

            lb.groupTarget[var]:SetTexture("LifeBinder", "Textures/targetframe.png")
            lb.groupTarget[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
            lb.groupTarget[var]:SetHeight(lbValues.mainheight - 5)
            lb.groupTarget[var]:SetWidth(lbValues.mainwidth - 5)
            lb.groupTarget[var]:SetLayer(3)
            lb.groupTarget[var]:SetVisible(false)

            lb.groupAggro[var]:SetTexture("LifeBinder", "Textures/recframe.png")
            lb.groupAggro[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
            lb.groupAggro[var]:SetHeight(lbValues.mainheight - 5)
            lb.groupAggro[var]:SetWidth(lbValues.mainwidth - 5)
            lb.groupAggro[var]:SetLayer(4)
            lb.groupAggro[var]:SetVisible(false)

            lb.groupCastBar[var]:SetTexture("LifeBinder", "Textures/health_r.png")
            lb.groupCastBar[var]:SetPoint("BOTTOMLEFT", lb.groupBF[var], "BOTTOMLEFT", 0,  -3*lbValues.mainheight*0.023255814 )
            lb.groupCastBar[var]:SetHeight(6*lbValues.mainheight*0.023255814)
            lb.groupCastBar[var]:SetWidth(lbValues.mainwidth-5)
            lb.groupCastBar[var]:SetLayer(6)
            lb.groupCastBar[var]:SetVisible(false)

			lb.groupHF[var]:SetTexture("LifeBinder","Textures/"..lbValues.texture)
			lb.groupHF[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
			lb.groupHF[var]:SetHeight(lbValues.mainheight - 5)
			lb.groupHF[var]:SetWidth(lbValues.mainwidth - 5)
			lb.groupHF[var]:SetLayer(0)

		
			lb.groupName[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 24*lbValues.mainwidth*0.009009009, 3*lbValues.mainheight*0.023255814)
			lb.groupName[var]:SetLayer(2)
            local percfsize=round((lbValues.font)*lbValues.mainheight*0.023255814*0.8)

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
			lb.groupStatus[var]:SetPoint("TOPRIGHT", lb.groupBF[var], "TOPRIGHT", -10*lbValues.mainwidth*0.009009009, (lbValues.mainheight /2 )*lbValues.mainheight*0.023255814)
            percfsize=round((lbValues.font)*lbValues.mainheight*0.023255814*0.7)
            if percfsize>12 then
                percfsize=12
            elseif percfsize<8 then
                percfsize=8
            end

            lb.groupStatus[var]:SetFontSize(percfsize)

			lb.groupRole[var]:SetTexture("LifeBinder", "Textures/blank.png")
			lb.groupRole[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 6*lbValues.mainwidth*0.009009009,  6*lbValues.mainheight*0.023255814 )
			lb.groupRole[var]:SetHeight(16*lbValues.mainwidth*0.009009009)
			lb.groupRole[var]:SetWidth(16*lbValues.mainheight*0.023255814)
			lb.groupRole[var]:SetLayer(2)

            

			lb.groupMask[var]:SetLayer(3)
			lb.groupMask[var]:SetBackgroundColor(0,0,0,0)
			lb.groupMask[var]:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", lbValues.mainwidth * (a - 1) + (a * 4),  lbValues.mainheight * (i - 1))
			lb.groupMask[var]:SetHeight(lbValues.mainheight)
			lb.groupMask[var]:SetWidth(lbValues.mainwidth)
			
			lb.groupMask[var]:SetVisible(false)

            

		end
	end
	--processMacroText(lb.UnitsTable)
--	for var = 1,20 do
--        name=string.format("group%.2d", var)
--        lb.groupMask[var].Event.LeftClick="/target @".. name
--
--	end
	if lbValues.mainwidth <  95 then
		size = lbValues.mainwidth / 4
		lbValues.font = math.ceil(lbValues.mainwidth / 6)
	else
		size = 24
		lbValues.font = 16
	end
end

function stTable.setManaBarValue(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	lb.groupRF[index]:SetWidth((lbValues.mainwidth-6)*(resourcesRatio))
end
function stTable.setHealthBarValue(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	lb.groupHF[index]:SetWidth((lbValues.mainwidth-5)*(resourcesRatio))
end
function stTable.setHealthBarText(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	local healthpercent = string.format("%s%%", (math.ceil(value/maxvalue * 100)))
	lb.groupStatus[index]:SetText(healthpercent)
end

function stTable.setBlockedValue(index,value)
	if index==nil then return end
	if value then
          lb.groupHF[index]:SetTexture("LifeBinder", "Textures/healthlos.png")
    elseif value==nil  then
          lb.groupHF[index]:SetTexture("LifeBinder", "Textures/bars/health.png")
    else
          lb.groupHF[index]:SetTexture("LifeBinder", "Textures/bars/health.png")
    end
end

