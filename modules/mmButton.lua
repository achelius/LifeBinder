--LBMMB

nkManager = {	addonButton = {},
				langText = {},
				button = nil,
				context = nil,
				secure = false
			}
				
nkManager.context = UI.CreateContext("nkButton")
nkManager.context:SetSecureMode('restricted')

function nkManager.settingsHandler()
	
	local settings = {
		mmButtonX = - 230,
		mmButtonY = 215,
		locked = true
	}
	
	if nkManagerSettings == nil then
		nkManagerSettings = settings
	else
		for k, v in pairs (settings) do if nkManagerSettings[k] == nil then nkManagerSettings[k] = v end end
	end
		
end

function nkManager.init(addonName, subMenuItems, mainFunc)

	if nkManager.button == nil then nkManager.button = nkManager.addonButton:new() end	
	if addonName ~= nil then nkManager.button:addAddon (addonName, subMenuItems, mainFunc) end

end

function nkManager.SetError (flag)

	if nkManager.button == nil then return end
	
	nkManager.button:SetError(flag)

end

function nkManager.addonButton:new()

	local this = {}
		
	local button = UI.CreateFrame ('nkExtTexture', 'nkButton', nkManager.context, {type = 'nkManager', path = 'nkButton.png', width = 35, height = 34, anchors = {{ from = "TOPRIGHT", object = UIParent, to = "TOPRIGHT", x = nkManagerSettings.mmButtonX, y = nkManagerSettings.mmButtonY }} })
	button:SetSecureMode('restricted')
	
	local items = {}
	button.menu = UI.CreateFrame ('nkExtMenu', 'nkManagerMenu', button:getElement(), { fontsize = 13, width = 120, color = { border = '000000', body = '333333', bodyactive= 'FFFFFF', labelinactive = 'FFFFFF', labelactive = '000000'}, anchors = {{ from = 'TOPRIGHT', object = button:getElement(), to = "CENTER", x = -10, y = 0 }}, items = items })

	button:SetEvent('LeftClick', function (element) 		
		if nkManager.secure == false then
			if button.menu:GetVisible() == true then 
				button.menu:SetVisible(false) 
			elseif button.menu:getEntryCount() > 0 then
				button.menu:SetVisible(true) 
			end
		end
	end)
	
	button:SetEvent('RightDown', function(element)
		if nkManager.secure == false then
			element.MouseDown = true
			mouseData = Inspect.Mouse()			
			element.startX = mouseData.x
			element.startY = mouseData.y
		end
	end)
			
	button:SetEvent('MouseMove', function(element)
		if element.MouseDown then
			mouseData = Inspect.Mouse()
			curdivX = mouseData.x - element.startX
			curdivY = mouseData.y - element.startY
			button:update({ anchors = {{ from = "TOPRIGHT", object = UIParent, to = "TOPRIGHT", x = nkManagerSettings.mmButtonX + curdivX, y = nkManagerSettings.mmButtonY + curdivY }} })
		end
	end)
	
	button:SetEvent('RightUp', function(element) 
		if element.MouseDown then 
			element.MouseDown = false 
			curdivX = mouseData.x - element.startX
			curdivY = mouseData.y - element.startY
			nkManagerSettings.mmButtonX = nkManagerSettings.mmButtonX + curdivX
			nkManagerSettings.mmButtonY = nkManagerSettings.mmButtonY + curdivY
		end 
	end)
	
	this.element = button
	
	setmetatable(this, self)
	self.__index = self
	return this
	
end

function nkManager.addonButton:toggleMenu()

	local button = self.element

	if button.menu:GetVisible() == true then 
		button.menu:SetVisible(false) 
	elseif button.menu:getEntryCount() > 0 then
		button.menu:SetVisible(true) 
	end 

end


function nkManager.addonButton:addAddon (addonName, subMenuItems, mainFunc)

	local button = self.element

	local items = button.menu.items
	
	if subMenuItems == nil then
		table.insert (items, { closeOnClick = true, label = addonName, func = mainFunc })
	else
		if button.subMenu == nil then button.subMenu = {} end
		
		local mainMenuItems = button.menu:getItems()
		
		local anchor = {{ from = "TOPRIGHT", object = button.menu:getElement(), to = "TOPLEFT" }}
		if #mainMenuItems > 0 then anchor = {{ from = "TOPRIGHT", object = mainMenuItems[#mainMenuItems]:getElement(), to = "TOPLEFT", x = 0, y = 18 }} end		
		
		local subitems = {}
		
		for k, v in pairs(subMenuItems) do
			if v.seperator == true then
				table.insert(subitems, { seperator = true })
			elseif v.func ~= nil then
				table.insert(subitems, { closeOnClick = true, label = v.label, macro = v.macro, func = function() self:closeAllMenus(); v.func() end })
			else
				table.insert(subitems, { closeOnClick = true, label = v.label, macro = v.macro, func = function() self:closeAllMenus() end })
			end
		end
		
		local subMenu = UI.CreateFrame ('nkExtMenu', 'nkManagerSubMenu' .. addonName, button.menu:getElement(), { fontsize = 13, width = 120, color = { border = '000000', body = '333333', bodyactive= 'FFFFFF', labelinactive = 'FFFFFF', labelactive = '000000'}, anchors = anchor, items = subitems })
		table.insert (button.subMenu, subMenu)
		
		local showSubMenu = function ()
			if subMenu:GetVisible() == true then 
				subMenu:SetVisible(false) 
			elseif subMenu:getEntryCount() > 0 then
				subMenu:SetVisible(true) 
			end 
		end
		
		table.insert (items, { subMenu = true, label = addonName, func = function () showSubMenu() end })
	end	
	
	button.menu:update ({ items = items })

end

function nkManager.addonButton:closeAllMenus ()

	for k, v in pairs (self.element.subMenu) do
		v:SetVisible(false)
	end
	
	self.element.menu:SetVisible(false)

end

function nkManager.addonButton:SetVisible(flag) self.element:getElement():SetVisible(flag) end

function nkManager.addonButton:SetError(flag)

	local texture = 'nkButton.png'
	if flag == true then texture = 'nkButtonError.png' end
	
	self.element:SetTexture({ type = "nkManager", path = texture })

end

table.insert(Event.Addon.SavedVariables.Load.End, {nkManager.settingsHandler, "nkManager", "variablesLoaded"})
table.insert(Event.System.Secure.Enter, {function() nkManager.secure = true end, "nkManager", "secureEnter"})
table.insert(Event.System.Secure.Leave, {function() nkManager.secure = false end, "nkManager", "secureLeave"})