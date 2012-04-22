
--how to update values:
--stTable.fastInitialize() -- to update the backframe and mask positions and dimensions
--stTable.initialize() -- to update all other things
--do not use stTable.CreateFrame() because you want to change what's already created 

lb.styles["standard"]={}
local stTable=lb.styles["standard"]
local optionsTable=nil
local frame=nil
stTable.force=false
stTable.changingonevent=false
--
--  if not stTable.force then
--		stTable.profileChanger.onPlayerReady()
--		stTable.layoutChanger.onGroupChange()
--	end
function stTable.firstInitialization()
	stTable.InitializeOptionsTable()
	stTable.fastInitialize()
end

function stTable.InitializeOptionsTable()
	--set values like this (optionsTable.xxxxxx) , they will be saved into the savedvariables of the character
	
	
	if optionsTable==nil then optionsTable=lb.styles.getConfiguration("standard") end
	
	optionsTable.Value="standard"
	stTable.options=optionsTable
	stTable.importer.initializeImporter()--convert the current settings to the new standard
	stTable.profileChanger.initializeProfileChangerTable() --initialize profile auto changer
	if optionsTable.selectedProfile==nil then optionsTable.selectedProfile="default" end
	if #(stTable.getProfilesList())==0 and optionsTable["default"]==nil then
		stTable.createProfile("default",nil)
	end
	
	if optionsTable[optionsTable.selectedProfile].visible==nil then optionsTable[optionsTable.selectedProfile].visible=true end
    stTable.setAddonVisibility(optionsTable[optionsTable.selectedProfile].visible==true)
	stTable.buffManager.initializeBuffMonitorOptionsTable()
	stTable.debuffManager.initializeDebuffMonitorOptionsTable()
	stTable.mouseBinds.initializemouseBindsOptionsTable()
	stTable.layoutChanger.initializeLayoutChangerTable() --initialize layout auto changer
	
end

function stTable.createProfile(name,copyfrom,changeprof)
	if name==nil then return end
	if copyfrom ==nil then
		if optionsTable[name]==nil then optionsTable[name]={} end		
		if optionsTable[name].common==nil then optionsTable[name].common={} end
		if optionsTable[name].selectedLayout==nil then optionsTable[name].selectedLayout="default" end
		if optionsTable[name].visible==nil then optionsTable[name].visible=true end
		if optionsTable.selectedProfile==nil then
			optionsTable.selectedProfile=name
		end
		stTable.createLayout(name,"default",nil,nil)
	else
		optionsTable[name]={}
		lb.copyTable(optionsTable[copyfrom],optionsTable[name])		
	end
	if changeprof then
		stTable.changeProfile(name)
	end
end

function stTable.createLayout(profile,name,originprofile,originlayout)
	if name==nil then return end
	if profile==nil then return end
	if name=="common" then print("The layout name \"common\" is reserved!") return end
	if originprofile ==nil then
		
		if optionsTable[profile][name]==nil then optionsTable[profile][name]={} end
		if optionsTable[profile][name].windowLocation==nil then optionsTable[profile][name].windowLocation={left=0,top=0} end
		if optionsTable[profile][name].enabled==nil then optionsTable[profile][name].enabled=true end
		if optionsTable[profile][name].HpValueVisualizationFormat==nil then optionsTable[profile][name].HpValueVisualizationFormat=0 end  -- 0 -> percent  1--> hp deficit 2 --> current hp/ maxhp
		if optionsTable[profile][name].frameWidth==nil then optionsTable[profile][name].frameWidth=110 end
		if optionsTable[profile][name].frameHeight==nil then optionsTable[profile][name].frameHeight=43 end
		if optionsTable[profile][name].framehSpace==nil then optionsTable[profile][name].framehSpace=0 end
		if optionsTable[profile][name].framevSpace==nil then optionsTable[profile][name].framevSpace=0 end
		if optionsTable[profile][name].roleIconPackage==nil then optionsTable[profile][name].roleIconPackage=0 end
		if optionsTable[profile][name].applyScale==nil then optionsTable[profile][name].applyScale=true end --not used
		if optionsTable[profile][name].roleIcon==nil then optionsTable[profile][name].roleIcon={left=4,top=6,width=20,height=20} end
		if optionsTable[profile][name].nameText==nil then optionsTable[profile][name].nameText={left=30,top=7,fontSize=12,numLetters=5} end
		if optionsTable[profile][name].hpText==nil then optionsTable[profile][name].hpText={left=-10,top=-10,fontSize=12,style=0} end
		if optionsTable[profile][name].manaBar==nil then optionsTable[profile][name].manaBar={height=5} end
		if optionsTable[profile][name].manaBar.direction==nil then optionsTable[profile][name].manaBar.direction=0 end --not used
		if optionsTable[profile][name].flowDirection==nil then optionsTable[profile][name].flowDirection={firstUnit="BOTTOMLEFT",unitGrowth="RIGHT",groupGrowth="UP"} end
		if optionsTable[profile][name].currentFlowDirection==nil then optionsTable[profile][name].currentFlowDirection=1 end
		if optionsTable[profile][name].menuBar==nil then optionsTable[profile][name].menuBar={create=true,show=true,showInCombat=false} end
		if optionsTable[profile][name].hpBar==nil then optionsTable[profile][name].hpBar={left=0,top=0,width=1,height=1,direction=0,texture="Textures/bars/health.png"} end
		
	else
		if originlayout==nil then return end
		optionsTable[profile][name]={}
		lb.copyTable(optionsTable[originprofile][originlayout],optionsTable[profile][name])		
	end
end

function stTable.fastInitialize()
	if optionsTable==nil then  optionsTable=lb.styles.getConfiguration("standard") end --gets configuration from savedvars and stores it into the local stTable.getLayoutTable()
	stTable.InitializeOptionsTable() --initializes stTable.getLayoutTable()
	
	lb.WindowFrameTop:SetTexture("Rift","nil")
	
	local fupos=stTable.getLayoutTable().flowDirection.firstUnit
	local unitgrowth=stTable.getLayoutTable().flowDirection.unitGrowth
	local groupGrowth=stTable.getLayoutTable().flowDirection.groupGrowth
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
						local totalwidth= stTable.getLayoutTable().frameWidth*5
						local totalheight= stTable.getLayoutTable().frameHeight*4
						left=stTable.getLayoutTable().frameWidth * (i -1) 
						top=totalheight- stTable.getLayoutTable().frameHeight * (a)
					end
				elseif unitgrowth=="UP" then
					if groupGrowth=="RIGHT" then
						local totalwidth= stTable.getLayoutTable().frameWidth*4
						local totalheight= stTable.getLayoutTable().frameHeight*5
						left=stTable.getLayoutTable().frameWidth * (a -1) 
						top=totalheight- stTable.getLayoutTable().frameHeight * (i)
					end
				end
			elseif fupos =="BOTTOMRIGHT" then
				if unitgrowth=="LEFT" then
					if groupGrowth=="UP" then
						local totalwidth= stTable.getLayoutTable().frameWidth*5
						local totalheight= stTable.getLayoutTable().frameHeight*4
						left=totalwidth-stTable.getLayoutTable().frameWidth * (i) 
						top=totalheight-stTable.getLayoutTable().frameHeight * (a)
					end
				elseif unitgrowth=="UP" then
					if groupGrowth=="LEFT" then
						local totalwidth= stTable.getLayoutTable().frameWidth*4
						local totalheight= stTable.getLayoutTable().frameHeight*5
						left=totalwidth-stTable.getLayoutTable().frameWidth * (a) 
						top=totalheight- stTable.getLayoutTable().frameHeight * (i)
					end
				end
			elseif fupos =="TOPLEFT" then
				if unitgrowth=="RIGHT" then
					if groupGrowth=="DOWN" then
						local totalwidth= stTable.getLayoutTable().frameWidth*5
						local totalheight= stTable.getLayoutTable().frameHeight*4	
						left=stTable.getLayoutTable().frameWidth * (i -1) 
						top=stTable.getLayoutTable().frameHeight * (a-1)
					end
				elseif unitgrowth=="DOWN" then
					if groupGrowth=="RIGHT" then
						local totalwidth= stTable.getLayoutTable().frameWidth*4
						local totalheight= stTable.getLayoutTable().frameHeight*5
						left=stTable.getLayoutTable().frameWidth * (a -1)
						top=stTable.getLayoutTable().frameHeight * (i - 1)

					end
				end
			elseif fupos =="TOPRIGHT" then
			--a=group
			--i=unit
				if unitgrowth=="LEFT" then
					if groupGrowth=="DOWN" then
						local totalwidth= stTable.getLayoutTable().frameWidth*5
						local totalheight= stTable.getLayoutTable().frameHeight*4	
						left=totalwidth-stTable.getLayoutTable().frameWidth * (i) 
						top=stTable.getLayoutTable().frameHeight * (a-1)
					end
				elseif unitgrowth=="DOWN" then
					if groupGrowth=="LEFT" then
						local totalwidth= stTable.getLayoutTable().frameWidth*4
						local totalheight= stTable.getLayoutTable().frameHeight*5
						left=totalwidth-stTable.getLayoutTable().frameWidth * (a)
						top=stTable.getLayoutTable().frameHeight * (i - 1)
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
			lb.frames[var].groupBF:SetHeight(stTable.getLayoutTable().frameHeight)
			lb.frames[var].groupBF:SetWidth(stTable.getLayoutTable().frameWidth)
			if lb.frames[var].groupBF==nil then lb.frames[var].groupBF:SetVisible(false)end
			
			if lb.frames[var].groupMask ==nil then lb.frames[var].groupMask = UI.CreateLbFrame("Frame", "groupMask"..i, lb.CenterFrame) end
			lb.frames[var].groupMask:SetLayer(97)
			lb.frames[var].groupMask:SetBackgroundColor(0,0,0,0)
			lb.frames[var].groupMask:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", left , top)
			lb.frames[var].groupMask:SetHeight(stTable.getLayoutTable().frameHeight)
			lb.frames[var].groupMask:SetWidth(stTable.getLayoutTable().frameWidth)
			lb.frames[var].groupMask:SetSecureMode("restricted")
			if not lb.UnitsTableStatus[var][12] then lb.frames[var].groupMask:SetVisible(false) end
			if stTable.getLayoutTable().menuBar.create and Command.Unit~=nil then
				if lb.frames[var].groupMenu ==nil then lb.frames[var].groupMenu = UI.CreateLbFrame("Frame", "groupMenu"..i, lb.CenterFrame) end
				lb.frames[var].groupMenu:SetLayer(99)
				lb.frames[var].groupMenu:SetBackgroundColor(0,0,0,0)
				lb.frames[var].groupMenu:SetPoint("TOPLEFT", lb.CenterFrame, "TOPLEFT", left , top)
				lb.frames[var].groupMenu:SetHeight(stTable.getLayoutTable().frameHeight)
				lb.frames[var].groupMenu:SetWidth(10)
				lb.frames[var].groupMenu:SetSecureMode("restricted")
				lb.frames[var].groupMenu.Event.RightClick=function () stTable.CreateMenu(var) end
				if not lb.UnitsTableStatus[var][12] and stTable.getLayoutTable().menuBar.show then lb.frames[var].groupMenu:SetVisible(false) end
			end
		end
	end
	
	stTable.setMainWindowLocation(stTable.getLayoutTable().windowLocation.left,stTable.getLayoutTable().windowLocation.top)
	
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
	 	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local stTable.getLayoutTable()
		stTable.InitializeOptionsTable() --initializes stTable.getLayoutTable()
	end
	
	lb.WindowFrameTop:SetTexture("Rift","nil")
	local totalwidth= stTable.getLayoutTable().frameWidth*4
	local totalheight= stTable.getLayoutTable().frameHeight*5
	
	local var = index
	--lb.frames[var].groupBF:SetTexture("LifeBinder", "Textures/backframe.png")
	
	
	lb.frames[var].groupAggro:SetTexture("LifeBinder", "Textures/backframe.png")
    lb.frames[var].groupAggro:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 0,  0 )
    lb.frames[var].groupAggro:SetHeight(stTable.getLayoutTable().frameHeight)
    lb.frames[var].groupAggro:SetWidth(stTable.getLayoutTable().frameWidth)
    lb.frames[var].groupAggro:SetLayer(1)
    lb.frames[var].groupAggro:SetVisible(true)
    
	--Set Resource Frame
	lb.frames[var].groupRF:SetPoint("BOTTOMLEFT", lb.frames[var].groupBF, "BOTTOMLEFT", 3, -2)
	lb.frames[var].groupRF:SetHeight(stTable.getLayoutTable().manaBar.height)
	lb.frames[var].groupRF:SetWidth(stTable.getLayoutTable().frameWidth - 5)
	lb.frames[var].groupRF:SetLayer(2)
	lb.frames[var].groupRF:SetVisible(true)

    lb.frames[var].groupTarget:SetTexture("LifeBinder", "Textures/targetframe.png")
    lb.frames[var].groupTarget:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 2,  2 )
    lb.frames[var].groupTarget:SetHeight(stTable.getLayoutTable().frameHeight - 5)
    lb.frames[var].groupTarget:SetWidth(stTable.getLayoutTable().frameWidth - 5)
    lb.frames[var].groupTarget:SetLayer(3)
    lb.frames[var].groupTarget:SetVisible(false)

    lb.frames[var].groupCastBar:SetTexture("LifeBinder", "Textures/bars/cast.png")
    lb.frames[var].groupCastBar:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 0, 0 )
    lb.frames[var].groupCastBar:SetHeight(7)
    lb.frames[var].groupCastBar:SetWidth(stTable.getLayoutTable().frameWidth-3)
    lb.frames[var].groupCastBar:SetLayer(6)
    lb.frames[var].groupCastBar:SetVisible(false)

	lb.frames[var].groupHF:SetTexture("LifeBinder",stTable.getHealthFrameTexture())
	lb.frames[var].groupHF:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", 2,  2 )
	lb.frames[var].groupHF:SetHeight(stTable.getLayoutTable().frameHeight - 4-stTable.getLayoutTable().manaBar.height)
	lb.frames[var].groupHF:SetWidth(stTable.getLayoutTable().frameWidth - 5)
	lb.frames[var].groupHF:SetLayer(0)


	lb.frames[var].groupName:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", stTable.getLayoutTable().nameText.left*stTable.getLayoutTable().frameWidth*0.009009009, stTable.getLayoutTable().nameText.top*stTable.getLayoutTable().frameHeight*0.023255814)
	lb.frames[var].groupName:SetLayer(2)
    local percfsize=round((stTable.getLayoutTable().nameText.fontSize)*stTable.getLayoutTable().frameHeight*0.023255814*0.8)

    if percfsize>20 then
        percfsize=19
    elseif percfsize<10 then
        percfsize=10
    end
    lb.frames[var].groupName:SetFontSize(percfsize)
    
	lb.frames[var].groupStatus:SetText("100%")
	lb.frames[var].groupStatus:SetFontColor(lbCallingColors[5].r, lbCallingColors[5].g, lbCallingColors[5].b, 1)
	lb.frames[var].groupStatus:SetLayer(2)
	lb.frames[var].groupStatus:SetPoint("BOTTOMRIGHT", lb.frames[var].groupBF, "BOTTOMRIGHT", -10*stTable.getLayoutTable().frameWidth*0.009009009, -10*stTable.getLayoutTable().frameHeight*0.023255814)
    percfsize=round((lbValues.font)*stTable.getLayoutTable().frameHeight*0.023255814*0.7)
    if percfsize>12 then
        percfsize=12
    elseif percfsize<8 then
        percfsize=8
    end

    lb.frames[var].groupStatus:SetFontSize(percfsize)
	lb.frames[var].groupRole:SetPoint("TOPLEFT", lb.frames[var].groupBF, "TOPLEFT", stTable.getLayoutTable().roleIcon.left*stTable.getLayoutTable().frameWidth*0.009009009,  stTable.getLayoutTable().roleIcon.top*stTable.getLayoutTable().frameHeight*0.023255814 )
	lb.frames[var].groupRole:SetHeight(stTable.getLayoutTable().roleIcon.height)
	lb.frames[var].groupRole:SetWidth(stTable.getLayoutTable().roleIcon.width)
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
end
function stTable.onPlayerReady()

	stTable.profileChanger.onPlayerReady()
--	print("styleplayerready2")
--	stTable.layoutChanger.forceOnGroupChange()

end


function stTable.getLayoutTable(profilename,name)
	local profname=profilename
	local nam =name
	if profname==nil then profname=optionsTable.selectedProfile end
	if nam==nil then nam=optionsTable[profname].selectedLayout end
	if optionsTable==nil then
	 	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local stTable.getLayoutTable()
		stTable.InitializeOptionsTable() --initializes stTable.getLayoutTable()
	end
	return optionsTable[profname][nam]
end

function stTable.getProfileTable(profilename)
	if optionsTable==nil then
	 	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local stTable.getLayoutTable()
		stTable.InitializeOptionsTable() --initializes stTable.getLayoutTable()
	end
	if profilename==nil then
		return optionsTable[optionsTable.selectedProfile]
	else
		return optionsTable[profilename]
	end
end

function stTable.getSpecificProfileTable(profilename)
	if optionsTable==nil then
	 	optionsTable=lb.styles.getConfiguration("standard") --gets configuration from savedvars and stores it into the local stTable.getLayoutTable()
		stTable.InitializeOptionsTable() --initializes stTable.getLayoutTable()
	end
	return optionsTable[profilename]
end
function stTable.hasLayout(profile,name)
	for key,value in pairs(optionsTable[profile]) do
		if "table"==type(value) then
			if key==name then
				return true
			end
		end
	end
	return false
end

function stTable.getLayoutsList(profile)
	local plist={}
	for key,value in pairs(optionsTable[profile]) do
		if "table"==type(value) and key~="common" then
			table.insert(plist,key)
		end
	end
	return plist
end
function stTable.getProfilesList()
	local plist={}
	for key,value in pairs(optionsTable) do
		if "table"==type(value) and key ~="profileChanger" then
			table.insert(plist,key)
		end
	end
	return plist
end


function stTable.changeProfile(name)
	if name==nil then return end
	if optionsTable.selectedProfile==name then return end
	local pt= stTable.getSpecificProfileTable(name)
	if #(stTable.getLayoutsList(name))==0 then
		stTable.createLayout(name,"default")
	else
		if pt.selectedLayout~=nil then
			if not stTable.hasLayout(name,pt.selectedLayout) then
				stTable.createLayout(name,pt.selectedLayout)
				
			end
		else
			if not stTable.hasLayout(name,"default") then
				stTable.createLayout(name,"default")
			end
			optionsTable[optionsTable.selectedProfile].selectedLayout="default"
		end
	end
	
	stTable.force=true
	print("Profile changed to:"..name)
	stTable.changeLayout(name,pt.selectedLayout)
	
	stTable.force=false
end

function stTable.changeLayout(profilename,name)
	if name==nil then return end
	if lb.isincombat then
		print("Layout change in combat detected, waiting until combat ends")
		layoutToChange={profilename,name}
		return nil
	else
		layoutToChange=nil
	end
	local pt= stTable.getSpecificProfileTable(profilename)
	if stTable.getProfileTable().selectedLayout==name then
		--checks if it's the same name
		if optionsTable.selectedProfile==profilename then
			--it's the same profile and layout so it doesn't update
			return nil
		end
	end
	--if pt.selectedLayout==name and not force then return end
	if #(stTable.getLayoutsList(profilename))==0 then
		stTable.createLayout(profilename,name)
	else
		if not stTable.hasLayout(profilename,name) then
			stTable.createLayout(profilename,name)
		end
	end
	
	optionsTable.selectedProfile=profilename
	pt.selectedLayout=name
	stTable.force=true
	stTable.fastInitialize()
	stTable.initialize()
	stTable.buffManager.initializeBuffMonitor()
	stTable.buffManager.updateSpellTextures()
	stTable.debuffManager.initializeDebuffMonitor()
	stTable.mouseBinds.initializemouseBindsOptionsTable()
	lb.mouseBinds.setMouseActions()
	stTable.UpdateProfileSelector()
	--stTable.layoutChanger.initializeLayoutChangerTable()
	stTable.force=false
	print("Layout changed to:"..profilename.."."..name)
end

function stTable.removeProfile(profilename)
	if optionsTable[profilename]==nil then return end
	local profileslist=stTable.getProfilesList()
	if #(profileslist) ==1 then print("Can't delete the last profile") return end
	local nextindex=-1
	for i = 1,#(profileslist) do
		if profileslist[i]==profilename then
		else
			nextindex=i
		end
	end
	if nextindex==-1 then print("Can't delete the last profile") return end
	
	if optionsTable.selectedProfile==profilename then
		print("Changing to another profile before starting")
		stTable.changeProfile(profileslist[nextindex])
	end
	print("Removing chosen profile rules")
	stTable.profileChanger.removeEveryRoleOfProfile(profilename)
	print("Removing chosen profile")
	optionsTable[profilename]=nil
	print("Chosen profile removed")
	stTable.UpdateProfileSelector()
end

function stTable.removeLayout(profilename,name)
	if profilename==nil then return end
	if name==nil then return end
	if optionsTable[profilename]==nil then return end
	local layoutslist=stTable.getLayoutsList(profilename)
	if #(layoutslist) ==1 then print("Can't delete the last layout") return end
	local nextindex=-1
	for i = 1,#(layoutslist) do
		if layoutslist[i]==name then
		else
			nextindex=i
		end
	end
	if nextindex==-1 then print("Can't delete the last layout") return end
	if optionsTable.selectedProfile==profilename then
		if stTable.getProfileTable(profilename).selectedLayout==name then
			print("Changing to another layout before starting")
			stTable.changeLayout(profilename,layoutslist[nextindex])
		end
	end
	print("Removing chosen layout rules")
	stTable.layoutChanger.removeEveryRoleOfLayout(profilename,name)
	print("Removing chosen layout")
	optionsTable[profilename][name]=nil
	print("Chosen layout removed")
	stTable.UpdateProfileSelector()
end

function stTable.getMainWindowLocation()
	return stTable.getLayoutTable().windowLocation
end

function stTable.setMainWindowLocation(x,y,profilename,layoutname)
	if profilename==nil or profilename==nil then
		stTable.getLayoutTable().windowLocation.left=x
		stTable.getLayoutTable().windowLocation.top=y
		lb.Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT",x,y)
	else
		stTable.getLayoutTable(profilename,layoutname).windowLocation.left=x
		stTable.getLayoutTable(profilename,layoutname).windowLocation.top=y
		lb.Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", x,y)
	end
end
function stTable.setAddonVisibility(visible)
	stTable.getProfileTable().visible=visible
	lb.Window:SetVisible(visible)
end
function stTable.hideFrame(index)
	if lb.UnitsTableStatus[index][12] then 
		lb.frames[index].groupBF:SetVisible(false)
	end
end
function stTable.forceHideFrame(index)
	lb.frames[index].groupBF:SetVisible(false)
end
function stTable.showFrame(index)
	if lb.UnitsTableStatus[index][12] then 
		lb.frames[index].groupBF:SetVisible(true)
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
	if lb.frames[index].groupMenu~=nil and stTable.getLayoutTable().menuBar.show then lb.frames[index].groupMenu:SetVisible(true) end
end

function stTable.hideMasks(index)
	if lb.frames[index].groupMask~=nil then lb.frames[index].groupMask:SetVisible(false) end
	if lb.frames[index].groupMenu~=nil and stTable.getLayoutTable().menuBar.show  then lb.frames[index].groupMenu:SetVisible(false) end
end

function stTable.getHealthFrameTexture()
	return stTable.getLayoutTable().hpBar.texture
end
function stTable.getFrameWidth()
	return stTable.getLayoutTable().frameWidth
end
function stTable.getFrameHeight()
	return stTable.getLayoutTable().frameHeight
end

function stTable.onCombatEnter()
	--print("combatEnter")
 	if not stTable.getLayoutTable().menuBar.showInCombat then
 		for var= 1,20 do
 			if lb.frames[var].groupMenu ~=nil then
				lb.frames[var].groupMenu:SetVisible(false)
			end
		end
	end
end	

function stTable.onCombatExit()
	--print("combatExit")
	for var= 1,20 do
		if lb.frames[var].groupMenu ~=nil then
			if lb.UnitsTableStatus[var][12] then lb.frames[var].groupMenu:SetVisible(true) end
		end
	end
	if layoutToChange~= nil then
		stTable.changeLayout(layoutToChange[1],layoutToChange[2])
		layoutToChange=nil
	end
end


function stTable.setNameValue(index,name)
	if string.len(name) > stTable.getLayoutTable().nameText.numLetters then name = string.sub(name, 1, stTable.getLayoutTable().nameText.numLetters) end --restrict names
    lb.frames[index].groupName:SetText(name)
end

function stTable.setCastBarValue(index,value,max)
    if value==nil then value=0 end
    local cwidth=(value/max)*(stTable.getLayoutTable().frameWidth-3)
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
	lb.frames[index].groupRF:SetWidth((stTable.getLayoutTable().frameWidth-5)*(resourcesRatio))
end

function stTable.setHealthBarValue(index,value,maxvalue)
	if index==nil then return end
	if maxvalue==nil then return end
	if value==nil then return end
	local resourcesRatio = value/maxvalue
	lb.frames[index].groupHF:SetWidth((stTable.getLayoutTable().frameWidth-5)*(resourcesRatio))
end

function stTable.setHealthBarText(index,value,maxvalue)
	if index==nil then return end
	local resourcesRatio = value/maxvalue
	local healthpercent = string.format("%s%%", (math.ceil(value/maxvalue * 100)))
	lb.frames[index].groupStatus:SetText(healthpercent)
end

function stTable.setRoleIcon(index,calling,role)
	if index==nil then return end
	
	if stTable.getLayoutTable().roleIconPackage ==1 then
		lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/role_icons2/"..tostring(role)..".png")
	else
		lb.frames[index].groupRole:SetTexture("LifeBinder","Textures/role_icons/"..tostring(calling).."-"..tostring(role)..".png")
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
          	lb.frames[index].groupHF:SetTexture("LifeBinder",stTable.getHealthFrameTexture())
  
    else
    	--print("4")
          lb.frames[index].groupHF:SetTexture("LifeBinder", stTable.getHealthFrameTexture())
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


function stTable.onOptionsWindowInitialization()
	lb.optionsGui.TabControl:SetPoint("TOPLEFT", lb.optionsGui.Window, "TOPLEFT", 15, 90)
	lb.optionsGui.profileSelect={}
	lb.optionsGui.profileSelect.cmbProfile=lb.commonUtils.createComboBox(lb.optionsGui.Window,"cmbProfile",40,60,stTable.getProfilesList(),nil,"Current profile",optionsTable.selectedProfile)
	lb.optionsGui.profileSelect.cmbProfile.comboBox.Event.ItemSelect=stTable.onCmbProfileChangeItem
	lb.optionsGui.profileSelect.cmbLayout=lb.commonUtils.createComboBox(lb.optionsGui.Window,"cmbLayouts",440,60,stTable.getLayoutsList(optionsTable.selectedProfile),nil,"Current layout",stTable.getProfileTable().selectedLayout)
	lb.optionsGui.profileSelect.cmbLayout.comboBox.Event.ItemSelect=stTable.onCmbLayoutChangeItem
	
	------------------------------------------------------------------------initializing table 7 (profiles)
	lb.optionsGui.Tabs[7]=UI.CreateLbFrame("Frame", "placeholder", lb.optionsGui.Window)
	lb.optionsGui.TabControl:AddTab("Profiles",lb.optionsGui.Tabs[7])
end
function stTable.onOptionsTabChanged(tab,index)
	if index==7 then
		if lb.optionsGui.Tabs[7]:GetName()=="placeholder" then
			lb.optionsGui.Tabs[7]=lb.optionsGui.profilesEditor.createTable(lb.optionsGui.TabControl)
			
			lb.optionsGui.TabControl:SetTabContent(7,lb.optionsGui.Tabs[7])
		else
			lb.optionsGui.profilesEditor.updateData()
		end
	end
end
function stTable.UpdateProfileSelector()
	if lb.optionsGui.profileSelect~=nil then
		stTable.changingonevent=true--locks every itemchanged event from the comboboxes
		lb.optionsGui.profileSelect.cmbProfile.comboBox:SetItems(stTable.getProfilesList())
		lb.optionsGui.profileSelect.cmbProfile.comboBox:SetSelectedItem(optionsTable.selectedProfile)
		lb.optionsGui.profileSelect.cmbLayout.comboBox:SetItems(stTable.getLayoutsList(optionsTable.selectedProfile))
		lb.optionsGui.profileSelect.cmbLayout.comboBox:SetSelectedItem(stTable.getProfileTable().selectedLayout)
		stTable.changingonevent=false
	end
end
function stTable.onCmbProfileChangeItem(item, value, index)
	if stTable.changingonevent then return end
	--print (value)
	stTable.changeProfile(value)
	--lb.optionsGui.TabControl:SetActiveTab(1)
	stTable.force=true
	lb.optionsGui.profileSelect.cmbLayout.comboBox:SetItems(stTable.getLayoutsList(optionsTable.selectedProfile))
	lb.optionsGui.profileSelect.cmbLayout.comboBox:SetSelectedItem(stTable.getProfileTable().selectedLayout)
	lb.optionsGui.TabControl:SetActiveTab(1)
	stTable.force=false
end

function stTable.onCmbLayoutChangeItem(item, value, index)
	if stTable.force then return end
	if stTable.changingonevent then return end
	stTable.force=true
	stTable.changeLayout(optionsTable.selectedProfile,value)
	lb.optionsGui.TabControl:SetActiveTab(1)
	stTable.force=false
end


function stTable.getOptionsWindow(optionsFrame)
	frame=optionsFrame
	lb.commonUtils.createText(optionsFrame,0,0,"Standard style options")
	optionsFrame.frameWidth=lb.commonUtils.createNUD(optionsFrame,"frameWidth",0,20,"Frame Width",stTable.getLayoutTable().frameWidth)
	optionsFrame.frameHeight=lb.commonUtils.createNUD(optionsFrame,"frameWidth",0,50,"Frame Height",stTable.getLayoutTable().frameHeight)
	--optionsFrame.framehSpacing=lb.commonUtils.createNUD(optionsFrame,"horizspacing",0,80,"Horiz.Space",stTable.getLayoutTable().framehSpace)
	--optionsFrame.framevSpacing=lb.commonUtils.createNUD(optionsFrame,"vertspacing",0,110,"Vert.Space",stTable.getLayoutTable().framevSpace)
	optionsFrame.playerNameMover= lb.commonUtils.createMover(optionsFrame,"playerNameMover",0,80,stTable.getLayoutTable().nameText.left,stTable.getLayoutTable().nameText.top,"Name position")
	optionsFrame.roleIconMover= lb.commonUtils.createMover(optionsFrame,"playerNameMover",230,80,stTable.getLayoutTable().roleIcon.left,stTable.getLayoutTable().roleIcon.top,"Role icon\n position")
	optionsFrame.nameFontSize=lb.commonUtils.createNUD(optionsFrame,"nameFontSize",0,200,"Name font size",stTable.getLayoutTable().nameText.fontSize)
	optionsFrame.nameNumLetters=lb.commonUtils.createNUD(optionsFrame,"nameNumLetters",0,230,"Name chars count",stTable.getLayoutTable().nameText.numLetters)
	optionsFrame.manaBarHeight=lb.commonUtils.createNUD(optionsFrame,"manaBarHeight",0,260,"ManaBar height",stTable.getLayoutTable().manaBar.height)
	local list={}
	for i= 1,8 do
		list[i]=tostring(i)
	end
	optionsFrame.FlowDirection=lb.commonUtils.createComboBox(optionsFrame,"FlowDirection",450,20,list,stTable.getLayoutTable().currentFlowDirection,"Unit positioning")
	optionsFrame.FlowDirectionImage= UI.CreateLbFrame("Texture", "FlowDirectionImage", optionsFrame)
	optionsFrame.FlowDirectionImage:SetPoint("TOPLEFT",optionsFrame,"TOPLEFT",450,60)
	optionsFrame.FlowDirectionImage:SetWidth(397)
	optionsFrame.FlowDirectionImage:SetHeight(227)
	optionsFrame.FlowDirectionImage:SetTexture("LifeBinder","textures/unitpositioning.png")
	
	optionsFrame.applyButton=lb.commonUtils.createButton(optionsFrame,"applybutton",250,320,150,30,"Apply settings")
	optionsFrame.applyButton.Event.LeftClick=stTable.setOptionsValues
end

function stTable.setOptionsValues()
	--dump(stTable.getLayoutTable())
	stTable.getLayoutTable().frameWidth=tonumber(frame.frameWidth.textArea:GetText())
	stTable.getLayoutTable().frameHeight=tonumber(frame.frameHeight.textArea:GetText())
	stTable.getLayoutTable().roleIcon.left=frame.roleIconMover.left
	stTable.getLayoutTable().roleIcon.top=frame.roleIconMover.top
	stTable.getLayoutTable().nameText.fontSize=tonumber(frame.nameFontSize.textArea:GetText())
	stTable.getLayoutTable().nameText.left=frame.playerNameMover.left
	stTable.getLayoutTable().nameText.top=frame.playerNameMover.top
	stTable.getLayoutTable().manaBar.height=tonumber(frame.manaBarHeight.textArea:GetText())
	stTable.getLayoutTable().nameText.numLetters=tonumber(frame.nameNumLetters.textArea:GetText())
	--print(frame.FlowDirection.comboBox:GetSelectedIndex())
	stTable.setFlowDirection(frame.FlowDirection.comboBox:GetSelectedIndex())
	stTable.force=true
	stTable.fastInitialize()
	stTable.initialize()
	stTable.force=false
end
function stTable.setFlowDirection(flowIndex)
	local found=true
	local sflowIndex=tostring(flowIndex)
	if sflowIndex=="1" then
		stTable.getLayoutTable().flowDirection={firstUnit="BOTTOMLEFT",unitGrowth="RIGHT",groupGrowth="UP"}
	elseif sflowIndex =="2" then
		stTable.getLayoutTable().flowDirection={firstUnit="BOTTOMLEFT",unitGrowth="UP",groupGrowth="RIGHT"}
	elseif sflowIndex =="3" then
		stTable.getLayoutTable().flowDirection={firstUnit="TOPLEFT",unitGrowth="RIGHT",groupGrowth="DOWN"}
	elseif sflowIndex =="4" then
		stTable.getLayoutTable().flowDirection={firstUnit="TOPLEFT",unitGrowth="DOWN",groupGrowth="RIGHT"}
	elseif sflowIndex =="5" then
		stTable.getLayoutTable().flowDirection={firstUnit="TOPRIGHT",unitGrowth="LEFT",groupGrowth="DOWN"}
	elseif sflowIndex =="6" then
		stTable.getLayoutTable().flowDirection={firstUnit="TOPRIGHT",unitGrowth="DOWN",groupGrowth="LEFT"}
	elseif sflowIndex =="7" then
		stTable.getLayoutTable().flowDirection={firstUnit="BOTTOMRIGHT",unitGrowth="LEFT",groupGrowth="UP"}
	elseif sflowIndex =="8" then
		stTable.getLayoutTable().flowDirection={firstUnit="BOTTOMRIGHT",unitGrowth="UP",groupGrowth="LEFT"}
	else
		found=false
	end
	if found then
		stTable.getLayoutTable().currentFlowDirection=flowIndex
		stTable.fastInitialize()
	end
end

function stTable.setRoleIconPackage(packageIndex)
	local pkg= tonumber(packageIndex)
	stTable.getLayoutTable().roleIconPackage=pkg
	for i = 1,20 do
		if lb.UnitsTableStatus[i][12] then
			stTable.setRoleIcon(i,lb.UnitsTableStatus[i][9],lb.UnitsTableStatus[i][4])
		end	
	end
end



function stTable.slashCommHandler(cmd,params)
	local cmdv= lb.slashCommands.parseCommandValues(params[1])
	
	if cmdv[1]=="setfd" then
		stTable.setFlowDirection(cmdv[2])
		return true
	elseif cmdv[1]=="rolep" then
		stTable.setRoleIconPackage(cmdv[2])
		return true
	elseif cmdv[1]=="getcprofile" then
		print ("Current profile:"..tostring(optionsTable.selectedProfile))
		return true
	elseif cmdv[1]=="getprofileslist" then
		print("----Profiles list")
		for key,value in pairs(stTable.getProfilesList()) do
			print(key)
		end
		print("-----")
		return true
	elseif cmdv[1]=="setprofile" then
		stTable.changeProfile(cmdv[2])
		print ("Activated profile:"..tostring(cmdv[2]))
		print ("Activated layout:"..tostring(optionsTable[optionsTable.selectedProfile].selectedLayout))
		return true
	elseif cmdv[1]=="createprofile" then
		if cmdv[2]==nil or cmdv[2]=="" then return true end
		print ("Creating profile:"..tostring(cmdv[2]))
		stTable.createProfile(cmdv[2])
		print ("Created profile:"..tostring(cmdv[2]))
		stTable.changeProfile(cmdv[2])
		print ("Activated profile:"..tostring(cmdv[2]))
		print ("Activated layout:"..tostring(optionsTable[optionsTable.selectedProfile].selectedLayout))
		return true
	elseif cmdv[1]=="removeprofile" then
		if cmdv[2]==nil or cmdv[2]=="" then return true end
		stTable.removeProfile(cmdv[2])
		return true
	elseif cmdv[1]=="getlayoutslist" then
		print("----Layouts list for profile:" ..tostring(optionsTable.selectedProfile))
		for key,value in pairs(stTable.getLayoutsList(optionsTable.selectedProfile)) do
			print(value)
		end
		print("-----")
		return true
	elseif cmdv[1]=="getclayout" then
		print ("Current profile:"..tostring(optionsTable.selectedProfile))
		print ("Current layout:"..tostring(optionsTable[optionsTable.selectedProfile].selectedLayout))
		return true
	elseif cmdv[1]=="setlayout" then
		stTable.changeLayout(optionsTable.selectedProfile,cmdv[2])
		print ("Activated profile:"..tostring(optionsTable.selectedProfile))
		print ("Activated layout:"..tostring(optionsTable[optionsTable.selectedProfile].selectedLayout))
		return true
	elseif cmdv[1]=="removelayout" then
		if cmdv[2]==nil or cmdv[2]=="" then return true end
		stTable.removeLayout(optionsTable.selectedProfile,cmdv[2])
		return true
	elseif cmdv[1]=="simgchange" then
		print ("Simulating group size of "..tostring(cmdv[2]))
		stTable.layoutChanger.onGroupCountChange(tonumber(cmdv[2]))
		return true
	end
	return false
end

--add the /lb standard command handler
lb.addCustomSlashCommand("standard",stTable.slashCommHandler)