function slashCommands(cmdLine)
	local cmdLine = string.lower(cmdLine)
	if (cmdLine.find(cmdLine,"help") or cmdLine.find(cmdLine,"?")) then
		print ("------------------------") --Longer on purpose because of Rift's odd char spacing
		print ("LifeBinder Help Menu")
		print ("------------------------")
		print ("/lb config  -- Configure LifeBinder.")
		print ("/lb show    -- Show LifeBinder.")
		print ("/lb hide    -- Hide LifeBinder.")
		print ("/lb lock    -- Lock the raidui, hiding the dragger.")
		print ("/lb unlock  -- Unlock the raid ui, making the dragger appear.")
		print ("/lb reset   -- Reset to raidui to default location.")
		print ("/lb ui      -- Reload UI.")
		print ("/lb asc     -- Display additional slash commands.")
	end
	if(cmdLine.find(cmdLine, "config")) then
		print ("debug: config")
		if not lbValues.isincombat then lb.WindowOptions:SetVisible(true) end
		--register event
	end
	if(cmdLine == "show")) then
		print ("debug: show")
		lbValues.addonState = true
		--register event
		print ("LifeBinder is now Enabled.")
	end
	if(cmdLine == "hide")) then
		print ("debug: hide")
		lbValues.addonState = false
		print ("LifeBinder is now Disabled.")
		--register event
	end
	if(cmdLine == "lock") then
		print ("debug: lock")
		lbValues.lockedState = true
		--register event
		print ("LifeBinder is now Locked. Please /reloadui.")
	end
	if(cmdLine == "unlock") then
		print ("debug: unlock")
		lbValues.lockedState = false
		--register event
		print ("LifeBinder is now Unlocked. Please /reloadui.")
	end
	
	--Reset commands
	if (cmdLine == "reset") then
		print("debug: reset list requested")
		if(cmdLine.find(cmdLine, "position") or cmdLine.find(cmdLine, "pos")) then
			print("debug: reset location")
			lbValues.windowstate = true
			lbValues.locmainx = 0
			lbValues.locmainy = 0
			print ("LifeBinder's Position has now been reset. Please /reloadui.")
		elseif(cmdLine.find(cmdLine, "size")) then
			print("debug: reset size")
			lbValues.windowstate = true
			lbValues.mainheight = 300
			lbValues.mainwidth = 500
			print ("LifeBinder's Size has now been reset. Please /reloadui.")
		elseif(cmdLine.find(cmdLine, "all")) then
			print("debug: reset all")
			lbValues = {addonState = true, windowstate = true, lockedState = false, locmainx = 0, locmainy = 0, mainheight = 300, mainwidth = 500, font = 16, pet = false, texture = "health_g.png", set = 1, hotwatch = true, debuffwatch = true, rolewatch = true, showtooltips = true }
			print ("LifeBinder's Appearance has now been reset. Please /reloadui.")
		else
			print ("Please choose a proper command.")
		end
	end

	--Module commands
	if(cmdLine == "module") then
		print("debug: module list requested")
		if(cmdLine.find(cmdLine, "manabar")) then
			if(cmdLine.find(cmdLine, "enable") or cmdLine.find(cmdLine, "en")) then
				--register event
				print ("Manabars enabled. Please /reloadui.")
			elseif(cmdLine.find(cmdLine, "disable") or cmdLine.find(cmdLine, "dis")) then
				--register event
				print ("Manabars disabled. Please /reloadui.")
			else
				print ("Please choose to enable or disable.")
			end
		end
	end
	
	if(cmdLine == "asc") then
		print ("debug: asc")
		--register event
	end
	if(cmdLine == "ui") then
		print ("debug: reloadui")
		--register event
	end
	
	--Derp finder
	if (not (cmdLine.find(cmdLine, "config") or cmdLine.find(cmdLine, "show") or cmdLine.find(cmdLine, "hide") or cmdLine.find(cmdLine, "lock") or cmdLine.find(cmdLine, "module") or cmdLine.find(cmdLine, "reset") or cmdLine.find(cmdLine, "ui") or cmdLine.find(cmdLine, "asc"))) then
		print ("Command not recognized, please try again.")
	end
end

-- register slash commands
table.insert(Command.Slash.Register("lb"), {slashCommands, "LifeBinder", "lbSlashCmds"})
table.insert(Command.Slash.Register("lifebinder"), {slashCommands, "LifeBinder", "lbSlashCmds"})