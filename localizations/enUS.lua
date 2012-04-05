--[[--------------------------------------------------------------------
	enUS.lua						English localization module.
	Maintained by: Protonova
----------------------------------------------------------------------]]
LB_Version = "0.27"

local lang = Inspect.System.Language()
if (lang == "gibberish") then

else
	-- Class
	LIFEBINDER_CLERIC						= "Cleric";
	LIFEBINDER_MAGE							= "Mage";
	LIFEBINDER_ROGUE						= "Rogue";
	LIFEBINDER_WARRIOR						= "Warrior";

	-- slashCmds.lua
	LB_OPTIONS_SC_ALL						= "all";
	LB_OPTIONS_SC_APPEARANCE_RESET			= "LifeBinder's Appearance has now been reset. Please /reloadui.";
	LB_OPTIONS_SC_ASC						= "asc";
	LB_OPTIONS_SC_CHOOSE_EN_OR_DIS			= "Please choose to enable or disable.";
	LB_OPTIONS_SC_CHOOSE_PROPER_CMD			= "Please choose a proper command.";
	LB_OPTIONS_SC_CMD_NOT_RECOGNIZED		= "Command not recognized, please try again.";
	LB_OPTIONS_SC_CONFIG					= "config";
	LB_OPTIONS_SC_DISABLE					= "disable" or "dis";
	LB_OPTIONS_SC_ENABLE					= "enable" or "en";
	LB_OPTIONS_SC_HELP						= "help";
	LB_OPTIONS_SC_HIDE						= "hide";
	LB_OPTIONS_SC_LBDISABLED				= "LifeBinder is now Disabled.";
	LB_OPTIONS_SC_LBENABLED					= "LifeBinder is now Enabled.";
	LB_OPTIONS_SC_LBLOCKED					= "LifeBinder is now Locked. Please /reloadui.";
	LB_OPTIONS_SC_LBUNLOCKED				= "LifeBinder is now Unlocked. Please /reloadui.";
	LB_OPTIONS_SC_LOCK						= "lock";
	LB_OPTIONS_SC_MANABAR					= "manabar";
	LB_OPTIONS_SC_MANABAR_DISABLED			= "Manabars disabled. Please /reloadui.";
	LB_OPTIONS_SC_MANABAR_ENABLED			= "Manabars enabled. Please /reloadui.";
	LB_OPTIONS_SC_MODULE					= "module";
	LB_OPTIONS_SC_POSITION					= "position" or "pos";
	LB_OPTIONS_SC_POSRESET					= "LifeBinder's Position has now been reset. Please /reloadui.";
	LB_OPTIONS_SC_RESET						= "reset";
	LB_OPTIONS_SC_SHOW						= "show";
	LB_OPTIONS_SC_SIZE						= "size";
	LB_OPTIONS_SC_SIZE_RESET				= "LifeBinder's Size has now been reset. Please /reloadui.";
	LB_OPTIONS_SC_UI						= "ui";
	LB_OPTIONS_SC_UNLOCK					= "unlock";
	LB_SC_HELP 								= {
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
	LB_WELCOME_MSG							= "Welcome to LifeBinder v0.27! Type /lb for commands.";
---------------------------------------------------------------------------------------
-- mouseBinds.lua
modifier="[alt]"
modifier="[ctrl]"
modifier="[shift]"
---------------------------------------------------------------------------------------
-- specButtons.lua
lb.SpecButton1.Event.LeftClick="/role 1"
lb.SpecButton2.Event.LeftClick="/role 2"
lb.SpecButton3.Event.LeftClick="/role 3"
lb.SpecButton4.Event.LeftClick="/role 4"
lb.SpecButton5.Event.LeftClick="/role 5"
lb.SpecButton6.Event.LeftClick="/role 6"
---------------------------------------------------------------------------------------
-- main.lua
print ("loading")
lbMacroText[1]={{"target ##", "", "", "", ""} }
lbMacroText[2]={{"target ##", "", "", "", ""} }
lbMacroText[3]={{"target ##", "", "", "", ""} }
lbMacroText[4]={{"target ##", "", "", "", ""} }
lbMacroText[5]={{"target ##", "", "", "", ""} }
lbMacroText[6]={{"target ##", "", "", "", ""} }
lbMacroButton[1]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
lbMacroButton[2]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
lbMacroButton[3]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
lbMacroButton[4]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
lbMacroButton[5]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }
lbMacroButton[6]={{"target ##", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", ""}, {"", "", "", "" } }

---------------------------------------------------------------------------------------
DBM_CORE_NEED_SUPPORT				= "Are you good with programming or languages? If yes, the DBM team needs your help to keep DBM the best boss mod for WoW. Join the team by visiting www.deadlybossmods.com or sending a message to tandanu@deadlybossmods.com or nitram@deadlybossmods.com."
DBM_HOW_TO_USE_MOD					= "Welcome to DBM. Type /dbm help for a list of supported commands. To access options type /dbm in your chat to begin configuration. Load specific zones manually to configure any boss specific settings to your liking as well. DBM tries to do this for you by scanning your spec on first run, but some might want additional options turned on anyways."