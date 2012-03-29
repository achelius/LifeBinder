
-- planned functions: see: stylescore.lua

lb.styles["standard"]={}
local stTable=lb.styles["standard"]
local optionsTable=nil

function stTable.InitializeOptionsTable()
	--set values like this (optionsTable.xxxxxx) , they will be saved into the savedvariables of the character
	optionsTable.Value="cippolippo"
	if optionsTable.frameWidth==nil then optionsTable.frameWidth=110 end
	if optionsTable.frameHeight==nil then optionsTable.frameHeight=43 end
	
end
function stTable.initialize()
	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local optionsTable
	
	stTable.InitializeOptionsTable() --initializes optionsTable
	lb.WindowFrameTop:SetTexture("Rift","nil")
	local totalwidth= optionsTable.frameWidth*4
	local totalheight= optionsTable.frameHeight*5
    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			--lb.groupBF[var]:SetTexture("LifeBinder", "Textures/backframe.png")
			lb.groupBF[var]:SetLayer(1)
			lb.groupBF[var]:SetBackgroundColor(0, 0, 0, 1)
			lb.groupBF[var]:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", optionsTable.frameWidth * (i -1) , totalheight- optionsTable.frameHeight * (a - 1))
			lb.groupBF[var]:SetHeight(optionsTable.frameHeight)
			lb.groupBF[var]:SetWidth(optionsTable.frameWidth)
			lb.groupBF[var]:SetVisible(false)
			
			lb.groupAggro[var]:SetTexture("LifeBinder", "Textures/backframe.png")
            lb.groupAggro[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 0,  0 )
            lb.groupAggro[var]:SetHeight(optionsTable.frameHeight)
            lb.groupAggro[var]:SetWidth(optionsTable.frameWidth)
            lb.groupAggro[var]:SetLayer(1)
            lb.groupAggro[var]:SetVisible(true)
            
			--Set Resource Frame
			lb.groupRF[var]:SetPoint("BOTTOMLEFT", lb.groupBF[var], "BOTTOMLEFT", 1, -3)
			lb.groupRF[var]:SetHeight(5)
			lb.groupRF[var]:SetWidth(optionsTable.frameWidth - 4)
			lb.groupRF[var]:SetLayer(2)
			lb.groupRF[var]:SetVisible(true)

            lb.groupTarget[var]:SetTexture("LifeBinder", "Textures/targetframe.png")
            lb.groupTarget[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
            lb.groupTarget[var]:SetHeight(optionsTable.frameHeight - 5)
            lb.groupTarget[var]:SetWidth(optionsTable.frameWidth - 5)
            lb.groupTarget[var]:SetLayer(3)
            lb.groupTarget[var]:SetVisible(false)

          
            

            lb.groupCastBar[var]:SetTexture("LifeBinder", "Textures/bars/cast.png")
            lb.groupCastBar[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 0, 0 )
            lb.groupCastBar[var]:SetHeight(7)
            lb.groupCastBar[var]:SetWidth(optionsTable.frameWidth-3)
            lb.groupCastBar[var]:SetLayer(6)
            lb.groupCastBar[var]:SetVisible(false)

			lb.groupHF[var]:SetTexture("LifeBinder",stTable.getHealthFrameTexture())
			lb.groupHF[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 2,  2 )
			lb.groupHF[var]:SetHeight(optionsTable.frameHeight - 9)
			lb.groupHF[var]:SetWidth(optionsTable.frameWidth - 5)
			lb.groupHF[var]:SetLayer(0)

		
			lb.groupName[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 30*optionsTable.frameWidth*0.009009009, 7*optionsTable.frameHeight*0.023255814)
			lb.groupName[var]:SetLayer(2)
            local percfsize=round((lbValues.font)*optionsTable.frameHeight*0.023255814*0.8)

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
			lb.groupStatus[var]:SetPoint("BOTTOMRIGHT", lb.groupBF[var], "BOTTOMRIGHT", -10*optionsTable.frameWidth*0.009009009, -10*optionsTable.frameHeight*0.023255814)
            percfsize=round((lbValues.font)*optionsTable.frameHeight*0.023255814*0.7)
            if percfsize>12 then
                percfsize=12
            elseif percfsize<8 then
                percfsize=8
            end

            lb.groupStatus[var]:SetFontSize(percfsize)

			lb.groupRole[var]:SetTexture("LifeBinder", "Textures/blank.png")
			lb.groupRole[var]:SetPoint("TOPLEFT", lb.groupBF[var], "TOPLEFT", 4*optionsTable.frameWidth*0.009009009,  6*optionsTable.frameHeight*0.023255814 )
			lb.groupRole[var]:SetHeight(20)
			lb.groupRole[var]:SetWidth(20)
			lb.groupRole[var]:SetLayer(2)

            

			lb.groupMask[var]:SetLayer(99)
			lb.groupMask[var]:SetBackgroundColor(0,0,0,0)
			lb.groupMask[var]:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", optionsTable.frameWidth * (i -1) , totalheight- optionsTable.frameHeight * (a - 1))
			lb.groupMask[var]:SetHeight(optionsTable.frameHeight)
			lb.groupMask[var]:SetWidth(optionsTable.frameWidth)
			
			lb.groupMask[var]:SetVisible(false)

            

		end
	end
	--processMacroText(lb.UnitsTable)
--	for var = 1,20 do
--        name=string.format("group%.2d", var)
--        lb.groupMask[var].Event.LeftClick="/target @".. name
--
--	end
	if optionsTable.frameWidth <  95 then
		size = optionsTable.frameWidth / 4
		lbValues.font = math.ceil(optionsTable.frameWidth / 6)
	else
		size = 24
		lbValues.font = 16
	end
end

function stTable.showAllFrames()
	for var= 1,20 do
		lb.groupBF[var]:SetVisible(true)
	end
end
function stTable.getHealthFrameTexture()
	return "Textures/bars/health.png"
end
function stTable.getFrameWidth()
	return optionsTable.frameWidth
end
function stTable.getFrameHeight()
	return optionsTable.frameHeight
end

function stTable.setCastBarValue(index,value,max)
    if value==nil then value=0 end
    local cwidth=(value/max)*(optionsTable.frameWidth-3)
    lb.groupCastBar[index]:SetWidth(cwidth)
end

function stTable.isCastbarIndexVisible(index)
    local vis =lb.groupCastBar[index]:GetVisible()
    if vis==true then
        return true
    else
        return false
    end
end

function stTable.setCastbarVisible(index,value)
    lb.groupCastBar[index]:SetVisible(value)
end

function stTable.resetCastbarIndex(index)
    stTable.setCastbarVisible(index,false)
    stTable.setCastBarValue(index,(0)*10,1*10)
end

function stTable.setManaBar(index,unitTable)
	if unitTable.calling then
		for i = 1, 4 do
			--initializeResourceBar(unitTable.calling) -- Set Resource Bar Color
			if (unitTable.calling == "mage" or unitTable.calling == "cleric") then
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/bars/mana.png")
			elseif(unitTable.calling == "warrior") then
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/bars/energy.png")
			elseif(unitTable.calling == "rogue") then
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/bars/energy.png")
			else
				lb.groupRF[index]:SetTexture("LifeBinder", "textures/bars/resource_plain.png")
			end
			
			
			if unitTable.calling == lb.Calling[i] then
				lb.groupName[index]:SetFontColor(lbCallingColors[i].r, lbCallingColors[i].g, lbCallingColors[i].b, 1)
			end
		end
	else
		lb.groupName[index]:SetFontColor(1, 1, 1, 1)
	end
end

function stTable.setManaBarValue(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	lb.groupRF[index]:SetWidth((optionsTable.frameWidth-4)*(resourcesRatio))
end

function stTable.setHealthBarValue(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	lb.groupHF[index]:SetWidth((optionsTable.frameWidth-5)*(resourcesRatio))
end

function stTable.setHealthBarText(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	local healthpercent = string.format("%s%%", (math.ceil(value/maxvalue * 100)))
	lb.groupStatus[index]:SetText(healthpercent)
end

function stTable.setBlockedValue(index,losvalue,oorvalue)
	if index==nil then return end
	if losvalue or oorvalue then
			--print("1")
          lb.groupHF[index]:SetTexture("LifeBinder", "Textures/healthlos.png")
    elseif losvalue==nil and oorvalue then
    --print("2")
    	  lb.groupHF[index]:SetTexture("LifeBinder", "Textures/healthlos.png")
    elseif losvalue==nil and (oorvalue==nil or oorvalue==false)  then
--print("3")
          	lb.groupHF[index]:SetTexture("LifeBinder","Textures/bars/health.png")
  
    else
    	--print("4")
          lb.groupHF[index]:SetTexture("LifeBinder", "Textures/bars/health.png")
    end
end
