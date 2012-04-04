LB_SC_HELP = { -- Temp array while locales being made
	"---------------------------------------------------------------",
	"LifeBinder	Help Menu",
	"---------------------------------------------------------------",
	"/lb config		-- Configure LifeBinder.",
	"/lb show		-- Show LifeBinder.",
	"/lb hide		-- Hide LifeBinder.",
	"/lb reset		-- Reset to raidui to default location.",
	"/lb lock		-- Lock the raidui, hiding the dragger.",
	"/lb unlock		-- Unlock the raid ui, shows dragger.",
	"/lb ui			-- Reload UI.",
	"/lb asc		-- Display additional slash commands."
}

function slashCommands(cmdLine)
	local cmdLine = string.lower(cmdLine)
	local commandDone=false
	if (cmdLine == "help" or cmdLine.find(cmdLine, '?')) then
		for i = 1, #LB_SC_HELP do print(LB_SC_HELP[i]) end
	end
	if(cmdLine.find(cmdLine, "config")) then
		print ("debug: config")
		if not lbValues.isincombat then lb.slotsGui.show() end
		--register event
		commandDone=true
	end
	if(cmdLine == "show") then
		print ("debug: show")
		lbValues.addonState = true
		--register event
		print ("LifeBinder is now Enabled.")
		commandDone=true
	end
	if(cmdLine == "hide") then
		print ("debug: hide")
		lbValues.addonState = false
		print ("LifeBinder is now Disabled.")
		commandDone=true
		--register event
	end
	if(cmdLine == "lock") then
		print ("debug: lock")
		lbValues.lockedState = true
		--register event
		print ("LifeBinder is now Locked. Please /reloadui.")
		commandDone=true
	end
	if(cmdLine == "unlock") then
		print ("debug: unlock")
		lbValues.lockedState = false
		--register event
		print ("LifeBinder is now Unlocked. Please /reloadui.")
		commandDone=true
	end
	
	--Reset commands
	if (cmdLine.find(cmdLine, "reset")) then
		print("debug: reset list requested")
		if(cmdLine.find(cmdLine, "position") or cmdLine.find(cmdLine, "pos")) then
			print("debug: reset location")
			lbValues.windowstate = true
			lbValues.locmainx = 0
			lbValues.locmainy = 0
			print ("LifeBinder's Position has now been reset. Please /reloadui.")
			commandDone=true
		elseif(cmdLine.find(cmdLine, "size")) then
			print("debug: reset size")
			lbValues.windowstate = true
			lbValues.mainheight = 300
			lbValues.mainwidth = 500
			print ("LifeBinder's Size has now been reset. Please /reloadui.")
			commandDone=true
		elseif(cmdLine.find(cmdLine, "all")) then
			print("debug: reset all")
			lbValues = {addonState = true, windowstate = true, lockedState = false, locmainx = 0, locmainy = 0, mainheight = 300, mainwidth = 500, font = 16, pet = false, texture = "health_g.png", set = 1, hotwatch = true, debuffwatch = true, rolewatch = true, showtooltips = true }
			print ("LifeBinder's Appearance has now been reset. Please /reloadui.")
			commandDone=true
		else
			print ("Please choose a proper command.")
			commandDone=true
		end
	end

	--Module commands
	if(cmdLine.find(cmdLine, "module")) then
		print("debug: module list requested")
		if(cmdLine.find(cmdLine, "manabar")) then
			if(cmdLine.find(cmdLine, "enable") or cmdLine.find(cmdLine, "en")) then
				--register event
				print ("Manabars enabled. Please /reloadui.")
				commandDone=true
			elseif(cmdLine.find(cmdLine, "disable") or cmdLine.find(cmdLine, "dis")) then
				--register event
				print ("Manabars disabled. Please /reloadui.")
				commandDone=true
			else
				print ("Please choose to enable or disable.")
				commandDone=true
			end
		end
	end
	
	if(cmdLine == "asc") then
		print ("debug: asc")
		commandDone=true
		--register event
	end
	if(cmdLine == "ui") then
		print ("debug: reloadui")
		commandDone=true
		--register event
	end
	if(cmdLine == "disable") then
		
		--register event
		lbValues.AddonDisabled = true
		
		print ("Addon disabled, write /reloadui to reload the interface")
		commandDone=true
	end
	if(cmdLine == "enable") then
		
		--register event
		lbValues.AddonDisabled = false
		print ("Addon enabled, write /reloadui to reload the interface")
		commandDone=true
	end
	
	if(cmdLine == "stylereinit") then
		lb.styles[lb.currentStyle].initialize()
		lbUnitUpdate()
		commandDone=true
	end
	if(cmdLine == "styleviewall") then
		lb.styles[lb.currentStyle].showAllFrames()
		commandDone=true
		
	end
	
	if(cmdLine == "stylehideall") then
		lb.styles[lb.currentStyle].hideAllEmptyFrames()
		commandDone=true
		
	end
	if(cmdLine == "dbrecstart") then
		lbValues.CacheDebuffs=true
		commandDone=true
		
	end
	if(cmdLine == "dbrecend") then
		lbValues.CacheDebuffs=false
		commandDone=true
		
	end
	if(cmdLine == "dbrecclear") then
		DebuffCacheClear()
		commandDone=true
		
	end
	
	--Derp finder
	if not commandDone then
		print ("Command not recognized, please try again.")
	end
end

-- register slash commands
table.insert(Command.Slash.Register("lb"), {slashCommands, "LifeBinder", "lbSlashCmds"})
table.insert(Command.Slash.Register("lifebinder"), {slashCommands, "LifeBinder", "lbSlashCmds"})