function slashCommands(cmdLine)
	local cmdLine = string.lower(cmdLine)
	if (cmdLine.find(cmdLine,"help")) then
		print ("------------------------") --Longer on purpose because of rift's odd char spacing
		print ("RiftHbot Help Menu")
		print ("------------------------")
		print ("/rhb config  -- Configure RiftHbot.")
		print ("/rhb show    -- Show RiftHbot.")
		print ("/rhb hide    -- Hide RiftHbot.")
		print ("/rhb reset   -- Reset to raidui to default location.")
		print ("/rhb lock    -- Lock the raidui, hiding the dragger.")
		print ("/rhb unlock  -- Unlock the raid ui, making the dragger appear.")
	end
	if(cmdLine.find(cmdLine, "config")) then
		print ("debug: config")
		if not rhbValues.isincombat then rhb.WindowOptions:SetVisible(true) end
		--register event
	end
	if(cmdLine.find(cmdLine, "show")) then
		print ("debug: show")
		rhbValues.addonState = true
		--register event
	end
	if(cmdLine.find(cmdLine, "hide")) then
		print ("debug: hide")
		rhbValues.addonState = false
		--register event
	end
	if(cmdLine == "lock") then
		print ("debug: lock")
		rhbValues.lockedState = true
		--register event
	end
	if(cmdLine == "unlock") then
		print ("debug: unlock")
		rhbValues.lockedState = false
		--register event
	end
	
	--Reset commands
	if (cmdLine == "reset") then
		print("debug: reset list requested")
	elseif(cmdLine.find(cmdLine, "reset")) then
		if(cmdLine.find(cmdLine, "location") or cmdLine.find(cmdLine, "loc")) then
			print("debug: reset location")
			rhbValues.windowstate = true
			rhbValues.locmainx = 0
			rhbValues.locmainy = 0
		elseif(cmdLine.find(cmdLine, "size")) then
			print("debug: reset size")
			rhbValues.windowstate = true
			rhbValues.mainheight = 300
			rhbValues.mainwidth = 500
		elseif(cmdLine.find(cmdLine, "all")) then
			print("debug: reset all")
			rhbValues = {addonState = true, windowstate = true, lockedState = false, locmainx = 0, locmainy = 0, mainheight = 300, mainwidth = 500, font = 16, pet = false, texture = "health_g.png", set = 1, hotwatch = true, debuffwatch = true, rolewatch = true, showtooltips = true }
		else
			print ("Please choose a proper command.")
		end
	end

	--Module commands
	if (cmdLine == "module") then
		print("debug: module list requested")
	end
	if(cmdLine.find(cmdLine, "module")) then
		if(cmdLine.find(cmdLine, "manabar")) then
			if(cmdLine.find(cmdLine, "enable") or cmdLine.find(cmdLine, "en")) then
				print ("Manabars enabled.")
				--register event
			elseif(cmdLine.find(cmdLine, "disable") or cmdLine.find(cmdLine, "dis")) then
			print ("Manabars disabled.")
				--register event
			else
				print ("Please choose to enable or disable.")
			end
		end
	end
	
	--Derp finder
	if (not (cmdLine.find(cmdLine, "config") or cmdLine.find(cmdLine, "show") or cmdLine.find(cmdLine, "hide") or cmdLine.find(cmdLine, "lock") or cmdLine.find(cmdLine, "module") or cmdLine.find(cmdLine, "reset"))) then
		print ("L2Spell bro.")
	end
end

-- register slash commands
table.insert(Command.Slash.Register("rhb"), {slashCommands, "RiftHbot", "rhbSlashCmds"})
table.insert(Command.Slash.Register("rifthbot"), {slashCommands, "RiftHbot", "rhbSlashCmds"})