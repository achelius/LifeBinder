
--how to update values:
--stTable.fastInitialize() -- to update the backframe and mask positions and dimensions
--stTable.initialize() -- to update all other things
--do not use stTable.CreateFrame() because you want to change what's already created 

lb.styles["standard"]={}
local stTable=lb.styles["standard"]
local optionsTable=nil
local frame=nil


function stTable.InitializeOptionsTable()
	--set values like this (optionsTable.xxxxxx) , they will be saved into the savedvariables of the character
	optionsTable.Value="standard"
	if optionsTable.HpValueVisualizationFormat==nil then optionsTable.HpValueVisualizationFormat=0 end  -- 0 -> percent  1--> hp deficit 2 --> current hp/ maxhp
	if optionsTable.frameWidth==nil then optionsTable.frameWidth=110 end
	if optionsTable.frameHeight==nil then optionsTable.frameHeight=43 end
	if optionsTable.framehSpace==nil then optionsTable.framehSpace=0 end
	if optionsTable.framevSpace==nil then optionsTable.framevSpace=0 end
	if optionsTable.roleIconPackage==nil then optionsTable.roleIconPackage=0 end
	if optionsTable.applyScale==nil then optionsTable.applyScale=true end
	if optionsTable.roleIcon==nil then optionsTable.roleIcon={left=4,top=6,width=20,height=20} end
	if optionsTable.nameText==nil then optionsTable.nameText={left=30,top=7,fontSize=12,numLetters=5} end
	if optionsTable.hpText==nil then optionsTable.hpText={left=-10,top=-10,fontSize=12,style=0} end
	if optionsTable.manaBar==nil then optionsTable.manaBar={height=5} end
	if optionsTable.flowDirection==nil then optionsTable.flowDirection={firstUnit="BOTTOMLEFT",unitGrowth="RIGHT",groupGrowth="UP"} end
	if optionsTable.currentFlowDirection==nil then optionsTable.currentFlowDirection=1 end
	if optionsTable.menuBar==nil then optionsTable.menuBar={create=true,show=true,showInCombat=false} end
end

function stTable.fastInitialize()
	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local optionsTable
	stTable.InitializeOptionsTable() --initializes optionsTable
	
	lb.WindowFrameTop:SetTexture("Rift","nil")
	
	local fupos=optionsTable.flowDirection.firstUnit
	local unitgrowth=optionsTable.flowDirection.unitGrowth
	local groupGrowth=optionsTable.flowDirection.groupGrowth
    for a = 1, 4 do
		for i = 1, 5 do
			local var = i + ((a-1) * 5)
			local left=0
			local top=0
			--a=group
			--i=unit
			if fupos =="BOTTOMLEFT" then
				if unitgrowth=="RIGHT" then
					if groupGrowth=="UP" then
						local totalwidth= optionsTable.frameWidth*5
						local totalheight= optionsTable.frameHeight*4
						left=optionsTable.frameWidth * (i -1) 
						top=totalheight- optionsTable.frameHeight * (a)
					end
				elseif unitgrowth=="UP" then
					if groupGrowth=="RIGHT" then
						local totalwidth= optionsTable.frameWidth*4
						local totalheight= optionsTable.frameHeight*5
						left=optionsTable.frameWidth * (a -1) 
						top=totalheight- optionsTable.frameHeight * (i)
					end
				end
			elseif fupos =="BOTTOMRIGHT" then
				if unitgrowth=="LEFT" then
					if groupGrowth=="UP" then
						local totalwidth= optionsTable.frameWidth*5
						local totalheight= optionsTable.frameHeight*4
						left=totalwidth-optionsTable.frameWidth * (i) 
						top=totalheight-optionsTable.frameHeight * (a)
					end
				elseif unitgrowth=="UP" then
					if groupGrowth=="LEFT" then
						local totalwidth= optionsTable.frameWidth*4
						local totalheight= optionsTable.frameHeight*5
						left=totalwidth-optionsTable.frameWidth * (a) 
						top=totalheight- optionsTable.frameHeight * (i)
					end
				end
			elseif fupos =="TOPLEFT" then
				if unitgrowth=="RIGHT" then
					if groupGrowth=="DOWN" then
						local totalwidth= optionsTable.frameWidth*5
						local totalheight= optionsTable.frameHeight*4	
						left=optionsTable.frameWidth * (i -1) 
						top=optionsTable.frameHeight * (a-1)
					end
				elseif unitgrowth=="DOWN" then
					if groupGrowth=="RIGHT" then
						local totalwidth= optionsTable.frameWidth*4
						local totalheight= optionsTable.frameHeight*5
						left=optionsTable.frameWidth * (a -1)
						top=optionsTable.frameHeight * (i - 1)

					end
				end
			elseif fupos =="TOPRIGHT" then
			--a=group
			--i=unit
				if unitgrowth=="LEFT" then
					if groupGrowth=="DOWN" then
						local totalwidth= optionsTable.frameWidth*5
						local totalheight= optionsTable.frameHeight*4	
						left=totalwidth-optionsTable.frameWidth * (i) 
						top=optionsTable.frameHeight * (a-1)
					end
				elseif unitgrowth=="DOWN" then
					if groupGrowth=="LEFT" then
						local totalwidth= optionsTable.frameWidth*4
						local totalheight= optionsTable.frameHeight*5
						left=totalwidth-optionsTable.frameWidth * (a)
						top=optionsTable.frameHeight * (i - 1)
--					
					end
				end	
			end
			
			--lb.groupBF[var]:SetTexture("LifeBinder", "Textures/backframe.png")
			if lb.frames[var]==nil then lb.frames[var]={} end
			if lb.frames[var].groupBF==nil then lb.frames[var].groupBF = UI.CreateLbFrame("Texture", "Border", lb.CenterFrame) end
			lb.frames[var].groupBF:SetLayer(1)
			lb.frames[var].groupBF:SetBackgroundColor(0, 0, 0, 1)
			lb.frames[var].groupBF:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", left , top)
			lb.frames[var].groupBF:SetHeight(optionsTable.frameHeight)
			lb.frames[var].groupBF:SetWidth(optionsTable.frameWidth)
			if lb.frames[var].groupBF==nil then lb.frames[var].groupBF:SetVisible(false)end
			
			if lb.frames[var].groupMask ==nil then lb.frames[var].groupMask = UI.CreateLbFrame("Frame", "groupMask"..i, lb.CenterFrame) end
			lb.frames[var].groupMask:SetLayer(97)
			lb.frames[var].groupMask:SetBackgroundColor(0,0,0,0)
			lb.frames[var].groupMask:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", left , top)
			lb.frames[var].groupMask:SetHeight(optionsTable.frameHeight)
			lb.frames[var].groupMask:SetWidth(optionsTable.frameWidth)
			lb.frames[var].groupMask:SetSecureMode("restricted")
			if not lb.UnitsTableStatus[var][12] then lb.frames[var].groupMask:SetVisible(false) end
			if optionsTable.menuBar.create and Command.Unit~=nil then
				if lb.frames[var].groupMenu ==nil then lb.frames[var].groupMenu = UI.CreateLbFrame("Frame", "groupMenu"..i, lb.CenterFrame) end
				lb.frames[var].groupMenu:SetLayer(99)
				lb.frames[var].groupMenu:SetBackgroundColor(0,0,0,0)
				lb.frames[var].groupMenu:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", left , top)
				lb.frames[var].groupMenu:SetHeight(optionsTable.frameHeight)
				lb.frames[var].groupMenu:SetWidth(10)
				lb.frames[var].groupMenu:SetSecureMode("restricted")
				lb.frames[var].groupMenu.Event.RightClick=function () stTable.CreateMenu(var) end
				if not lb.UnitsTableStatus[var][12] and optionsTable.menuBar.show then lb.frames[var].groupMenu:SetVisible(false) end
			end
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



function stTable.CreateFrame(index)
	if index==nil then return end
	local i =index
	
	
	if lb.frames[i]==nil then lb.frames[i]={} end
	
 	
	--lb.frames[i].groupBF = UI.CreateLbFrame("Texture", "Border", lb.CenterFrame)
	lb.frames[i].groupHF = UI.CreateLbFrame("Texture", "Health", lb.frames[i].groupBF)
	lb.frames[i].groupRF = UI.CreateLbFrame("Texture", "Resource", lb.frames[i].groupBF)
    lb.frames[i].groupTarget = UI.CreateLbFrame("Texture", "Target", lb.frames[i].groupBF)
    lb.frames[i].groupAggro = UI.CreateLbFrame("Texture", "ReceivingSpell", lb.frames[i].groupBF)
    lb.frames[i].groupCastBar = UI.CreateLbFrame("Texture", "ReceivingSpell", lb.frames[i].groupBF)
	lb.frames[i].groupName = UI.CreateLbFrame("Text", "Name", lb.frames[i].groupBF)
	lb.frames[i].groupStatus = UI.CreateLbFrame("Text", "Status", lb.frames[i].groupBF)
	lb.frames[i].groupRole = UI.CreateLbFrame("Texture", "Role", lb.frames[i].groupBF)
	--lb.frames[i].groupMask = UI.CreateLbFrame("Frame", "group"..i, lb.frames[i].Window)
	--lb.frames[i].groupMask:SetSecureMode("restricted")
	
	stTable.initializeIndex(i)
	lb.UnitsTableStatus[i][12]=true --Frame Created
	
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
	lb.frames[var].groupRF:SetPoint("BOTTOMLEFT", lb.frames[var].groupBF, "BOTTOMLEFT", 3, -2)
	lb.frames[var].groupRF:SetHeight(optionsTable.manaBar.height)
	lb.frames[var].groupRF:SetWidth(optionsTable.frameWidth - 5)
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
	lb.frames[var].groupHF:SetHeight(optionsTable.frameHeight - 4-optionsTable.manaBar.height)
	lb.frames[var].groupHF:SetWidth(optionsTable.frameWidth - 5)
	lb.frames[var].groupHF:SetLayer(0)


	lb.frames[var].groupName:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", optionsTable.nameText.left*optionsTable.frameWidth*0.009009009, optionsTable.nameText.top*optionsTable.frameHeight*0.023255814)
	lb.frames[var].groupName:SetLayer(2)
    local percfsize=round((optionsTable.nameText.fontSize)*optionsTable.frameHeight*0.023255814*0.8)

    if percfsize>20 then
        percfsize=19
    elseif percfsize<10 then
        percfsize=10
    end
    lb.frames[var].groupName:SetFontSize(percfsize)
    
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
	lb.frames[var].groupRole:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", optionsTable.roleIcon.left*optionsTable.frameWidth*0.009009009,  optionsTable.roleIcon.top*optionsTable.frameHeight*0.023255814 )
	lb.frames[var].groupRole:SetHeight(optionsTable.roleIcon.height)
	lb.frames[var].groupRole:SetWidth(optionsTable.roleIcon.width)
	lb.frames[var].groupRole:SetLayer(3)
end



function stTable.initialize()

    for a = 1, 4 do
		for i = 1, 5 do
			var = i + ((a-1) * 5)
			if lb.UnitsTableStatus[var][12] then
			  stTable.initializeIndex(var)    
			end     

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

function stTable.showMasks(index)
	if lb.frames[index].groupMask~=nil then lb.frames[index].groupMask:SetVisible(true) end
	if lb.frames[index].groupMenu~=nil and optionsTable.menuBar.show then lb.frames[index].groupMenu:SetVisible(true) end
end

function stTable.hideMasks(index)
	if lb.frames[index].groupMask~=nil then lb.frames[index].groupMask:SetVisible(false) end
	if lb.frames[index].groupMenu~=nil and optionsTable.menuBar.show  then lb.frames[index].groupMenu:SetVisible(false) end
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

function stTable.onCombatEnter()
	--print("combatEnter")
 	if not optionsTable.menuBar.showInCombat then
 		for var= 1,20 do
			lb.frames[var].groupMenu:SetVisible(false)
		end
	end
end	

function stTable.onCombatExit()
	--print("combatExit")
	for var= 1,20 do
		if lb.UnitsTableStatus[var][12] then lb.frames[var].groupMenu:SetVisible(true) end
	end
end


function stTable.setNameValue(index,name)
	if string.len(name) > optionsTable.nameText.numLetters then name = string.sub(name, 1, optionsTable.nameText.numLetters) end --restrict names
    lb.frames[index].groupName:SetText(name)
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
	lb.frames[index].groupRF:SetWidth((optionsTable.frameWidth-5)*(resourcesRatio))
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
	if optionsTable.roleIconPackage ==0 then
		lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/role_icons/"..tostring(calling).."-"..tostring(role)..".png")
	elseif optionsTable.roleIconPackage ==1 then
		lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/role_icons2/"..tostring(role)..".png")
	end
	lb.frames[index].groupRole:SetVisible(true)
end
function stTable.setReadyCheck(index,value)
	if index==nil then return end
	if value then
		lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/ready/ready.png")
	elseif not value then
		lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/ready/notready.png")
	end
	
	lb.frames[index].groupRole:SetVisible(true)
end

function stTable.setBlockedValue(index,losvalue,oorvalue)
	if index==nil then return end
	if losvalue or oorvalue then
			--print("1")
          lb.frames[index].groupHF:SetTexture("LifeBinder", "Textures/bars/healthlos.png")
    elseif losvalue==nil and oorvalue then
    --print("2")
    	  lb.frames[index].groupHF:SetTexture("LifeBinder", "Textures/bars/healthlos.png")
    elseif losvalue==nil and (oorvalue==nil or oorvalue==false)  then
--print("3")
          	lb.frames[index].groupHF:SetTexture("LifeBinder","Textures/bars/health.png")
  
    else
    	--print("4")
          lb.frames[index].groupHF:SetTexture("LifeBinder", "Textures/bars/health.png")
    end
end

function stTable.setAggroStatus(index,status)
	if index==nil then return end
	if status then
        lb.frames[index].groupAggro:SetTexture("LifeBinder", "Textures/aggroframe.png")
    else
        lb.frames[index].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
    end
end
function stTable.setOfflineStatus(index,value)
	if index==nil then return end
	 if value then
        lb.frames[index].groupStatus:SetText("(D/C)")
        lb.frames[index].groupHF:SetWidth(1)
		lb.frames[index].groupRF:SetWidth(1)
    end
end

function stTable.CreateMenu(index)
	if lb.UnitsTableStatus[index][5]~=nil and lb.UnitsTableStatus[index][5]~=0 then
		if Command.Unit~=nil then
			if lb.isFunction (Command.Unit.Menu) then 
				if not lb.isincombat then Command.Unit.Menu(lb.UnitsTableStatus[index][5]) end 
			else
				print("Function not enabled until 1.8")
			end
		else
			print("Function not enabled until 1.8")
		end
	end
end

--------------------------------------------options----------------------------------------------------------------------- 
function stTable.getOptionsWindow(optionsFrame)
	frame=optionsFrame
	lb.commonUtils.createText(optionsFrame,0,0,"Standard style options")
	optionsFrame.frameWidth=lb.commonUtils.createNUD(optionsFrame,"frameWidth",0,20,"Frame Width",optionsTable.frameWidth)
	optionsFrame.frameHeight=lb.commonUtils.createNUD(optionsFrame,"frameWidth",0,50,"Frame Height",optionsTable.frameHeight)
	--optionsFrame.framehSpacing=lb.commonUtils.createNUD(optionsFrame,"horizspacing",0,80,"Horiz.Space",optionsTable.framehSpace)
	--optionsFrame.framevSpacing=lb.commonUtils.createNUD(optionsFrame,"vertspacing",0,110,"Vert.Space",optionsTable.framevSpace)
	optionsFrame.playerNameMover= lb.commonUtils.createMover(optionsFrame,"playerNameMover",0,80,optionsTable.nameText.left,optionsTable.nameText.top,"Name position")
	optionsFrame.roleIconMover= lb.commonUtils.createMover(optionsFrame,"playerNameMover",230,80,optionsTable.roleIcon.left,optionsTable.roleIcon.top,"Role icon\n position")
	optionsFrame.nameFontSize=lb.commonUtils.createNUD(optionsFrame,"nameFontSize",0,200,"Name font size",optionsTable.nameText.fontSize)
	optionsFrame.nameNumLetters=lb.commonUtils.createNUD(optionsFrame,"nameNumLetters",0,230,"Name chars count",optionsTable.nameText.numLetters)
	optionsFrame.manaBarHeight=lb.commonUtils.createNUD(optionsFrame,"manaBarHeight",0,260,"ManaBar height",optionsTable.manaBar.height)
	local list={}
	for i= 1,8 do
		list[i]=tostring(i)
	end
	optionsFrame.FlowDirection=lb.commonUtils.createComboBox(optionsFrame,"FlowDirection",450,20,list,optionsTable.currentFlowDirection,"Unit positioning")
	optionsFrame.FlowDirectionImage= UI.CreateLbFrame("Texture", "FlowDirectionImage", optionsFrame)
	optionsFrame.FlowDirectionImage:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",450,60)
	optionsFrame.FlowDirectionImage:SetWidth(397)
	optionsFrame.FlowDirectionImage:SetHeight(227)
	optionsFrame.FlowDirectionImage:SetTexture("LifeBinder","textures/unitpositioning.png")
	
	optionsFrame.applyButton=lb.commonUtils.createButton(optionsFrame,"applybutton",250,320,150,30,"Apply settings")
	optionsFrame.applyButton.Event.LeftClick=stTable.setOptionsValues
end

function stTable.setOptionsValues()
	optionsTable.frameWidth=tonumber(frame.frameWidth.textArea:GetText())
	optionsTable.frameHeight=tonumber(frame.frameHeight.textArea:GetText())
	optionsTable.roleIcon.left=frame.roleIconMover.left
	optionsTable.roleIcon.top=frame.roleIconMover.top
	optionsTable.nameText.fontSize=tonumber(frame.nameFontSize.textArea:GetText())
	optionsTable.nameText.left=frame.playerNameMover.left
	optionsTable.nameText.top=frame.playerNameMover.top
	optionsTable.manaBar.height=tonumber(frame.manaBarHeight.textArea:GetText())
	optionsTable.nameText.numLetters=tonumber(frame.nameNumLetters.textArea:GetText())
	print(frame.FlowDirection.comboBox:GetSelectedIndex())
	stTable.setFlowDirection(frame.FlowDirection.comboBox:GetSelectedIndex())
	stTable.fastInitialize()
	stTable.initialize()
end
function stTable.setFlowDirection(flowIndex)
	local found=true
	local sflowIndex=tostring(flowIndex)
	if sflowIndex=="1" then
		optionsTable.flowDirection={firstUnit="BOTTOMLEFT",unitGrowth="RIGHT",groupGrowth="UP"}
	elseif sflowIndex =="2" then
		optionsTable.flowDirection={firstUnit="BOTTOMLEFT",unitGrowth="UP",groupGrowth="RIGHT"}
	elseif sflowIndex =="3" then
		optionsTable.flowDirection={firstUnit="TOPLEFT",unitGrowth="RIGHT",groupGrowth="DOWN"}
	elseif sflowIndex =="4" then
		optionsTable.flowDirection={firstUnit="TOPLEFT",unitGrowth="DOWN",groupGrowth="RIGHT"}
	elseif sflowIndex =="5" then
		optionsTable.flowDirection={firstUnit="TOPRIGHT",unitGrowth="LEFT",groupGrowth="DOWN"}
	elseif sflowIndex =="6" then
		optionsTable.flowDirection={firstUnit="TOPRIGHT",unitGrowth="DOWN",groupGrowth="LEFT"}
	elseif sflowIndex =="7" then
		optionsTable.flowDirection={firstUnit="BOTTOMRIGHT",unitGrowth="LEFT",groupGrowth="UP"}
	elseif sflowIndex =="8" then
		optionsTable.flowDirection={firstUnit="BOTTOMRIGHT",unitGrowth="UP",groupGrowth="LEFT"}
	else
		found=false
	end
	if found then
		optionsTable.currentFlowDirection=flowIndex
		stTable.fastInitialize()
	end
end




function stTable.slashCommHandler(cmd,params)
	local cmdv= lb.slashCommands.parseCommandValues(params[1])
	
	if cmdv[1]=="setfd" then
		stTable.setFlowDirection(cmdv[2])
		return true
	end
	return false
end

--add the /lb standard command handler
lb.addCustomSlashCommand("standard",stTable.slashCommHandler)