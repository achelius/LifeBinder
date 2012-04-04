
-- planned functions: see: stylescore.lua

lb.styles["standard"]={}
local stTable=lb.styles["standard"]
local optionsTable=nil

function stTable.InitializeOptionsTable()
	--set values like this (optionsTable.xxxxxx) , they will be saved into the savedvariables of the character
	optionsTable.Value="cippolippo"
	if optionsTable.HpValueVisualizationFormat==nil then optionsTable.HpValueVisualizationFormat=0 end  -- 0 -> percent  1--> hp deficit 2 --> current hp/ maxhp
	if optionsTable.frameWidth==nil then optionsTable.frameWidth=110 end
	if optionsTable.frameHeight==nil then optionsTable.frameHeight=43 end
	
end

function stTable.CreateFrame(index)
	if index==nil then return end
	local i =index
	
	
	if lb.frames[i]==nil then lb.frames[i]={} end
	
 	
	--lb.frames[i].groupBF = UI.CreateFrame("Texture", "Border", lb.CenterFrame)
	lb.frames[i].groupHF = UI.CreateFrame("Texture", "Health", lb.frames[i].groupBF)
	lb.frames[i].groupRF = UI.CreateFrame("Texture", "Resource", lb.frames[i].groupBF)
    lb.frames[i].groupTarget = UI.CreateFrame("Texture", "Target", lb.frames[i].groupBF)
    lb.frames[i].groupAggro = UI.CreateFrame("Texture", "ReceivingSpell", lb.frames[i].groupBF)
    lb.frames[i].groupCastBar = UI.CreateFrame("Texture", "ReceivingSpell", lb.frames[i].groupBF)
	lb.frames[i].groupName = UI.CreateFrame("Text", "Name", lb.frames[i].groupBF)
	lb.frames[i].groupStatus = UI.CreateFrame("Text", "Status", lb.frames[i].groupBF)
	lb.frames[i].groupRole = UI.CreateFrame("Texture", "Role", lb.frames[i].groupBF)
	--lb.frames[i].groupMask = UI.CreateFrame("Frame", "group"..i, lb.frames[i].Window)
	--lb.frames[i].groupMask:SetSecureMode("restricted")
	
	stTable.initializeIndex(i)
	lb.UnitsTableStatus[i][12]=true --Frame Created
	
end
function stTable.fastInitialize()
	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local optionsTable
	
	stTable.InitializeOptionsTable() --initializes optionsTable
	lb.WindowFrameTop:SetTexture("Rift","nil")
	local totalwidth= optionsTable.frameWidth*4
	local totalheight= optionsTable.frameHeight*5
    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			--lb.groupBF[var]:SetTexture("LifeBinder", "Textures/backframe.png")
			if lb.frames[var]==nil then lb.frames[var]={} end
			lb.frames[var].groupBF = UI.CreateFrame("Texture", "Border", lb.CenterFrame)
			lb.frames[var].groupBF:SetLayer(1)
			lb.frames[var].groupBF:SetBackgroundColor(0, 0, 0, 1)
			lb.frames[var].groupBF:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", optionsTable.frameWidth * (i -1) , totalheight- optionsTable.frameHeight * (a - 1))
			lb.frames[var].groupBF:SetHeight(optionsTable.frameHeight)
			lb.frames[var].groupBF:SetWidth(optionsTable.frameWidth)
			lb.frames[var].groupBF:SetVisible(false)
			
			lb.frames[var].groupMask = UI.CreateFrame("Frame", "group"..i, lb.Window)
			lb.frames[var].groupMask:SetLayer(99)
			lb.frames[var].groupMask:SetBackgroundColor(0,0,0,0)
			lb.frames[var].groupMask:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", optionsTable.frameWidth * (i -1) , totalheight- optionsTable.frameHeight * (a - 1))
			lb.frames[var].groupMask:SetHeight(optionsTable.frameHeight)
			lb.frames[var].groupMask:SetWidth(optionsTable.frameWidth)
			lb.frames[var].groupMask:SetSecureMode("restricted")
			lb.frames[var].groupMask:SetVisible(false)
			
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

function stTable.initializeIndex(index)
	if optionsTable==nil then
	 	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local optionsTable
		stTable.InitializeOptionsTable() --initializes optionsTable
	end
	lb.WindowFrameTop:SetTexture("Rift","nil")
	local totalwidth= optionsTable.frameWidth*4
	local totalheight= optionsTable.frameHeight*5
	
	local var = index
	--lb.frames[var].groupBF:SetTexture("LifeBinder", "Textures/backframe.png")
	
	
	lb.frames[var].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
    lb.frames[var].groupAggro:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 0,  0 )
    lb.frames[var].groupAggro:SetHeight(optionsTable.frameHeight)
    lb.frames[var].groupAggro:SetWidth(optionsTable.frameWidth)
    lb.frames[var].groupAggro:SetLayer(1)
    lb.frames[var].groupAggro:SetVisible(true)
    
	--Set Resource Frame
	lb.frames[var].groupRF:SetPoint("BOTTOMLEFT", lb.frames[var].groupBF, "BOTTOMLEFT", 1, -3)
	lb.frames[var].groupRF:SetHeight(5)
	lb.frames[var].groupRF:SetWidth(optionsTable.frameWidth - 4)
	lb.frames[var].groupRF:SetLayer(2)
	lb.frames[var].groupRF:SetVisible(true)

    lb.frames[var].groupTarget:SetTexture("LifeBinder", "Textures/targetframe.png")
    lb.frames[var].groupTarget:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 2,  2 )
    lb.frames[var].groupTarget:SetHeight(optionsTable.frameHeight - 5)
    lb.frames[var].groupTarget:SetWidth(optionsTable.frameWidth - 5)
    lb.frames[var].groupTarget:SetLayer(3)
    lb.frames[var].groupTarget:SetVisible(false)

  
    

    lb.frames[var].groupCastBar:SetTexture("LifeBinder", "Textures/bars/cast.png")
    lb.frames[var].groupCastBar:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 0, 0 )
    lb.frames[var].groupCastBar:SetHeight(7)
    lb.frames[var].groupCastBar:SetWidth(optionsTable.frameWidth-3)
    lb.frames[var].groupCastBar:SetLayer(6)
    lb.frames[var].groupCastBar:SetVisible(false)

	lb.frames[var].groupHF:SetTexture("LifeBinder",stTable.getHealthFrameTexture())
	lb.frames[var].groupHF:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 2,  2 )
	lb.frames[var].groupHF:SetHeight(optionsTable.frameHeight - 9)
	lb.frames[var].groupHF:SetWidth(optionsTable.frameWidth - 5)
	lb.frames[var].groupHF:SetLayer(0)


	lb.frames[var].groupName:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 30*optionsTable.frameWidth*0.009009009, 7*optionsTable.frameHeight*0.023255814)
	lb.frames[var].groupName:SetLayer(2)
    local percfsize=round((lbValues.font)*optionsTable.frameHeight*0.023255814*0.8)

    if percfsize>12 then
        percfsize=12
    elseif percfsize<10 then
        percfsize=10
    end
    lb.frames[var].groupName:SetFontSize(percfsize)
	--lb.frames[var].groupName:SetText(lb.frames[var].UnitsTable[var])

	lb.frames[var].groupStatus:SetText("100%")
	lb.frames[var].groupStatus:SetFontColor(lbCallingColors[5].r, lbCallingColors[5].g, lbCallingColors[5].b, 1)
	lb.frames[var].groupStatus:SetLayer(2)
	lb.frames[var].groupStatus:SetPoint("BOTTOMRIGHT", lb.frames[var].groupBF, "BOTTOMRIGHT", -10*optionsTable.frameWidth*0.009009009, -10*optionsTable.frameHeight*0.023255814)
    percfsize=round((lbValues.font)*optionsTable.frameHeight*0.023255814*0.7)
    if percfsize>12 then
        percfsize=12
    elseif percfsize<8 then
        percfsize=8
    end

    lb.frames[var].groupStatus:SetFontSize(percfsize)

	--lb.frames[var].groupRole:SetTexture("LifeBinder", "Textures/blank.png")
	lb.frames[var].groupRole:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 4*optionsTable.frameWidth*0.009009009,  6*optionsTable.frameHeight*0.023255814 )
	lb.frames[var].groupRole:SetHeight(20)
	lb.frames[var].groupRole:SetWidth(20)
	lb.frames[var].groupRole:SetLayer(3)

    

	

    

end



function stTable.initialize()

    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			  stTable.initializeIndex(var)         

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
function stTable.hideFrame(index)
	if lb.UnitsTableStatus[index][12] then 
		lb.frames[index].groupBF:SetVisible(false)
	end
end
function stTable.hideAllEmptyFrames()
	for var= 1,20 do
		if not lb.UnitsTableStatus[var][12] then 
			lb.frames[var].groupBF:SetVisible(false)
		end
	end
end
function stTable.showAllFrames()
	for var= 1,20 do
		lb.frames[var].groupBF:SetVisible(true)
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
    lb.frames[index].groupCastBar:SetWidth(cwidth)
end

function stTable.isCastbarIndexVisible(index)
    local vis =lb.frames[index].groupCastBar:GetVisible()
    if vis==true then
        return true
    else
        return false
    end
end

function stTable.setCastbarVisible(index,value)
    lb.frames[index].groupCastBar:SetVisible(value)
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
				lb.frames[index].groupRF:SetTexture("LifeBinder", "textures/bars/mana.png")
			elseif(unitTable.calling == "warrior") then
				lb.frames[index].groupRF:SetTexture("LifeBinder", "textures/bars/energy.png")
			elseif(unitTable.calling == "rogue") then
				lb.frames[index].groupRF:SetTexture("LifeBinder", "textures/bars/energy.png")
			else
				lb.frames[index].groupRF:SetTexture("LifeBinder", "textures/bars/resource_plain.png")
			end
			
			
			if unitTable.calling == lb.Calling[i] then
				lb.frames[index].groupName:SetFontColor(lbCallingColors[i].r, lbCallingColors[i].g, lbCallingColors[i].b, 1)
			end
		end
	else
		lb.frames[index].groupName:SetFontColor(1, 1, 1, 1)
	end
end

function stTable.setManaBarValue(index,value,maxvalue)
	if index==nil then return end
	if maxvalue==nil then return end
	if value==nil then return end
	local resourcesRatio = value/maxvalue
	lb.frames[index].groupRF:SetWidth((optionsTable.frameWidth-4)*(resourcesRatio))
end

function stTable.setHealthBarValue(index,value,maxvalue)
	if index==nil then return end
	if maxvalue==nil then return end
	if value==nil then return end
	local resourcesRatio = value/maxvalue
	lb.frames[index].groupHF:SetWidth((optionsTable.frameWidth-5)*(resourcesRatio))
end

function stTable.setHealthBarText(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	

		local healthpercent = string.format("%s%%", (math.ceil(value/maxvalue * 100)))
		lb.frames[index].groupStatus:SetText(healthpercent)

end

function stTable.setRoleIcon(index,calling,role)
	if index==nil then return end
	
	lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/role_icons/"..tostring(calling).."-"..tostring(role)..".png")
	lb.frames[index].groupRole:SetVisible(true)
end

function stTable.setBlockedValue(index,losvalue,oorvalue)
	if index==nil then return end
	if losvalue or oorvalue then
			--print("1")
          lb.frames[index].groupHF:SetTexture("LifeBinder", "Textures/healthlos.png")
    elseif losvalue==nil and oorvalue then
    --print("2")
    	  lb.frames[index].groupHF:SetTexture("LifeBinder", "Textures/healthlos.png")
    elseif losvalue==nil and (oorvalue==nil or oorvalue==false)  then
--print("3")
          	lb.frames[index].groupHF:SetTexture("LifeBinder","Textures/bars/health.png")
  
    else
    	--print("4")
          lb.frames[index].groupHF:SetTexture("LifeBinder", "Textures/bars/health.png")
    end
end
