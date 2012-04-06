lb.LB_SC_HELP = { -- Temp array while locales being made
	"---------------------------------------------------------------",
	"LifeBinder	Help Menu,",
	"---------------------------------------------------------------",
	"FOR THE MOMMENT ONLY USE CONFIG",
	"OTHER COMMANDS DO NOT WORK",
	"/lb config		-- Configure LifeBinder.",
	"/lb lock		-- Lock the raidui",
	"/lb unlock		-- Unlock the raid ui",
	"/lb enable		-- Enables the addon, requires a /reloadUI to take effect",
	"/lb disable	-- Disables the addon, requires a /reloadUI to take effect"
}
lb.slashCommands={}
lb.customSlashCommands={}

function lb.addCustomSlashCommand(commandName,functionToCall)
	if commandName==nil then return end
	lb.customSlashCommands[commandName]=functionToCall
end

function lb.slashCommands.parse(cmdLine)
	local cmdLine = string.lower(cmdLine)
	local parameters={}
	local counter=1
	
	for par in string.gmatch(cmdLine,"[^%s]+") do
		parameters[counter]=par
		counter=counter+1
		local commandDone=false
		if par==nil or par~=""  then
			
			local subcommands={}
			local scounter=1
			for subc in string.gmatch(par,"[^.]+") do
				if scounter >1 then 
					subcommands[scounter-1]=subc
				else
					par=subc
				end
				scounter=scounter+1
			end
			
			--inserts commands from here
			if (par == "help" or par == "?") then
				for i = 1, #(lb.LB_SC_HELP) do print(lb.LB_SC_HELP[i]) end
				
			elseif (par=="config") then
				--print ("debug: config")
				if not lb.isincombat then lb.slotsGui.show() end
				commandDone=true
			elseif(par == "lock") then
				lbValues.lockedState = true
				lb.CombatStatus:SetVisible(not lbValues.lockedState)
				print ("LifeBinder is now Locked.")
				commandDone=true
			elseif(par == "unlock") then
				lbValues.lockedState = false
				lb.CombatStatus:SetVisible(not lbValues.lockedState)
				print ("LifeBinder is now Unlocked.")
				commandDone=true
			elseif(par == "disable") then
				lbValues.AddonDisabled = true
				print ("Addon disabled, write /reloadui to reload the interface")
				commandDone=true
			elseif(par == "enable") then
				lbValues.AddonDisabled = false
				print ("Addon enabled, write /reloadui to reload the interface")
				commandDone=true
			elseif (par == "style") then
				if subcommands[1]~=nil then
					--has a subcommand of this format style.xxxx
					local subc =subcommands[1]
					if subc=="reinit" then
						print ("Current Style reinitialization..")
						lb.styles[lb.currentStyle].fastInitialize()
						lb.styles[lb.currentStyle].initialize()
						lbUnitUpdate()
						print ("Current Style reinitialization completed")
						commandDone=true
					elseif subc=="viewall" then
						print ("Showing all frames")
						lb.styles[lb.currentStyle].showAllFrames()
						commandDone=true
					elseif subc=="hideall" then
						print ("Hiding all frames")
						lb.styles[lb.currentStyle].hideAllEmptyFrames()
						commandDone=true
					end
				end
			elseif (par == "dbrec") then
				if subcommands[1]~=nil then
					--has a subcommand of this format dbrec.xxxx
					local subc =subcommands[1]
					if subc=="start" then
						print ("Debuff Recorder enabled")
						lbValues.CacheDebuffs=true
						commandDone=true
					elseif subc=="end" then
						print ("Debuff Recorder disabled")
						lbValues.CacheDebuffs=false
						commandDone=true
					elseif subc=="clear" then
						print ("Debuff Recorder cache cleared")
						DebuffCacheClear()
						commandDone=true
					end
				end
			else
				--- searching for custom command
				if lb.customSlashCommands[par]~=nil then
					lb.customSlashCommands[par](par,subcommands)
					commandDone=true
				end
			end
			if not commandDone then
				print ("Command "..par.." not recognized, please try again.")
			end
		end
		
		
	end
--
--	
--	if(cmdLine == "show") then
--		print ("debug: show")
--		lbValues.addonState = true
--		--register event
--		print ("LifeBinder is now Enabled.")
--		commandDone=true
--	end
--	if(cmdLine == "hide") then
--		print ("debug: hide")
--		lbValues.addonState = false
--		print ("LifeBinder is now Disabled.")
--		commandDone=true
--		--register event
--	end
--	if(cmdLine == "lock") then
--		print ("debug: lock")
--		lbValues.lockedState = true
--		--register event
--		print ("LifeBinder is now Locked. Please /reloadui.")
--		commandDone=true
--	end
--	if(cmdLine == "unlock") then
--		print ("debug: unlock")
--		lbValues.lockedState = false
--		--register event
--		print ("LifeBinder is now Unlocked. Please /reloadui.")
--		commandDone=true
--	end
	--Reset commands
--	if (cmdLine.find(cmdLine, "reset")) then
--		print("debug: reset list requested")
--		if(cmdLine.find(cmdLine, "position") or cmdLine.find(cmdLine, "pos")) then
--			print("debug: reset location")
--			lbValues.windowstate = true
--			lbValues.locmainx = 0
--			lbValues.locmainy = 0
--			print ("LifeBinder's Position has now been reset. Please /reloadui.")
--			commandDone=true
--		elseif(cmdLine.find(cmdLine, "size")) then
--			print("debug: reset size")
--			lbValues.windowstate = true
--			lbValues.mainheight = 300
--			lbValues.mainwidth = 500
--			print ("LifeBinder's Size has now been reset. Please /reloadui.")
--			commandDone=true
--		elseif(cmdLine.find(cmdLine, "all")) then
--			print("debug: reset all")
--			lbValues = {addonState = true, windowstate = true, lockedState = false, locmainx = 0, locmainy = 0, mainheight = 300, mainwidth = 500, font = 16, pet = false, texture = "health_g.png", set = 1, hotwatch = true, debuffwatch = true, rolewatch = true, showtooltips = true }
--			print ("LifeBinder's Appearance has now been reset. Please /reloadui.")
--			commandDone=true
--		else
--			print ("Please choose a proper command.")
--			commandDone=true
--		end
--	end
	--Module commands
--	if(cmdLine.find(cmdLine, "module")) then
--		print("debug: module list requested")
--		if(cmdLine.find(cmdLine, "manabar")) then
--			if(cmdLine.find(cmdLine, "enable") or cmdLine.find(cmdLine, "en")) then
--				--register event
--				print ("Manabars enabled. Please /reloadui.")
--				commandDone=true
--			elseif(cmdLine.find(cmdLine, "disable") or cmdLine.find(cmdLine, "dis")) then
--				--register event
--				print ("Manabars disabled. Please /reloadui.")
--				commandDone=true
--			else
--				print ("Please choose to enable or disable.")
--				commandDone=true
--			end
--		end
--	end
--	if(cmdLine == "asc") then
--		print ("debug: asc")
--		commandDone=true
--		--register event
--	end
--	if(cmdLine == "ui") then
--		print ("debug: reloadui")
--		commandDone=true
--		--register event
--	end

end

function lb.slashCommands.parseCommandValues(string)
	local returnTable={}
	for par in string.gmatch(string,"[^=]+") do
		table.insert(returnTable,par)
	end
	return returnTable
end

-- register slash commands
table.insert(Command.Slash.Register("lb"), {lb.slashCommands.parse, "LifeBinder", "lbSlashCmds"})
table.insert(Command.Slash.Register("lifebinder"), {lb.slashCommands.parse, "LifeBinder", "lbSlashCmds"})