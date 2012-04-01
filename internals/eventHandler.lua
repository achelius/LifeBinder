table.insert(Event.Addon.SavedVariables.Load.End, {loadVariables, "LifeBinder", "lbLoadVariables"})
lb.waitPlayerEventID={waitPlayerAvailable, "LifeBinder", "WaitPlayerAvailable"}
function lb.EnableStarterCycle()
	if not lbValues.AddonDisabled then
		table.insert(Event.System.Update.Begin, lb.waitPlayerEventID)
	end
end
function lb.EnableHandlers()
	if not lbValues.AddonDisabled then
			table.insert(Event.Unit.Detail.Health, {lb.onHpUpdate, "LifeBinder", "Update_Health"})
			table.insert(Event.Unit.Detail.HealthMax, {lb.onHpUpdate, "LifeBinder", "Update_Max_Health"})
			table.insert(Event.Unit.Detail.Mana, {lb.manaBars.updateResourceBar, "LifeBinder", "Update_Mana"})
			table.insert(Event.Unit.Detail.ManaMax, {lb.manaBars.updateResourceBar, "LifeBinder", "Update_Max_Mana"})
			table.insert(Event.Unit.Detail.Power, {lb.manaBars.updateResourceBar, "LifeBinder", "Update_Power"})
			table.insert(Event.Unit.Detail.Energy, {lb.manaBars.updateResourceBar, "LifeBinder", "Update_Energy"})
			table.insert(Event.Unit.Detail.EnergyMax, {lb.manaBars.updateResourceBar, "LifeBinder", "Update_Max_Energy"})
			table.insert(Event.Unit.Detail.Aggro, {lb.onAggroUpdate, "LifeBinder", "Update_Aggro_Flags"})
			table.insert(Event.Unit.Detail.Blocked, {lb.onBlockedUpdate, "LifeBinder", "Update_Blocked_Flags"})
			table.insert(Event.Unit.Detail.Offline, {lb.onOfflineUpdate, "LifeBinder", "Update_Offline_Flags"})
			table.insert(Event.Ability.Add, {lb.onAbilityAdded, "LifeBinder", "lb.onAbilityAdded"})
			table.insert(Event.System.Secure.Enter, {lb.onSecureEnter, "LifeBinder", "lb.onSecureEnter"})
			table.insert(Event.System.Secure.Leave, {lb.onSecureExit, "LifeBinder", "lb.onSecureExit"})
			
			table.insert(Event.TEMPORARY.Role, {lb.onRoleChanged, "LifeBinder", "lb.onRoleChanged"})
			table.insert(Event.Unit.Detail.Role, {lb.onUnitRoleChanged, "LifeBinder", "onUnitRoleChanged"})
			
			table.insert(Event.Addon.Load.End, {lbUnitUpdate, "LifeBinder", "UpdateGroupDetails"})
			
			table.insert(Event.System.Update.Begin, {castbarUpdate, "LifeBinder", "CastbarUpdate"})
			table.insert(Event.System.Update.Begin, {lb.UpdatePlayerFrame, "LifeBinder", "UpdatePlayerFrame"})
			--table.insert(Event.System.Update.Begin, {lb.buffMonitor.updateDurations, "LifeBinder", "updatedurationscycle"})
			table.insert(Event.Unit.Castbar, {onCastbarChanged, "LifeBinder", "OnCastBarChanged"})
			table.insert(Event.Buff.Add, {lb.onBuffAdd, "LifeBinder", "lb.buffMonitor.onBuffAdd"})
			table.insert(Event.Buff.Remove, {lb.onBuffRemove, "LifeBinder", "lb.buffMonitor.onBuffRemove"})
			-- create a change target event
			table.insert(Library.LibUnitChange.Register("player.target"), {lb.onPlayerTargetChanged, "LifeBinder", "OnUnitChange"})
			table.insert(Library.LibUnitChange.Register("mouseover"), {lb.onMouseOverTargetChanged, "LifeBinder", "OnUnitMouseoverChange"})
			
			---coordinates changer
			if (Event.Unit.Detail.Coord~=nil) then
				table.insert(Event.Unit.Detail.Coord, {lb.posData.onPlayerMovement, "LifeBinder", "OnUnitCoodsChange"})
				table.insert(Library.LibUnitChange.Register("player.target"), {lb.posData.onPlayerTargetChanged, "LifeBinder", "OnUnitChange"})
				table.insert(Event.Unit.Detail.OutOfRange, {lb.onOutOfRange , "LifeBinder", "outofrange"})
			end
			--table.insert(Event.Unit.Detail.OutOfRange, {test , "LifeBinder", "outofrange"})
				
			
			-- safesraidmanager events
			table.insert(Event.SafesRaidManager.Group.Join, {lb.onGroupJoin , "LifeBinder", "GroupJoin"})
			table.insert(Event.SafesRaidManager.Group.Leave, {lb.onGroupLeave , "LifeBinder", "GroupLeave"})
			table.insert(Event.SafesRaidManager.Group.Change, {lb.onGroupChange , "LifeBinder", "GroupLeave"})
			table.insert(Event.SafesRaidManager.Player.Join, {lb.onPlayerJoin , "LifeBinder", "PlayerJoin"})
			table.insert(Event.SafesRaidManager.Player.Leave,{lb.onPlayerLeave, "LifeBinder", "PlayerLeave"})
			
	end
end

function lb.remWaitPlayerHook()
	for id, eventData in ipairs(Event.System.Update.Begin) do
		if eventData == lb.waitPlayerEventID then
			table.remove(Event.System.Update.Begin, id)
			break
		end
	end
end
function lb.RemoveEventHandler(table,event_id)
	--removing
	for id, eventData in ipairs(table) do
		if eventData == event_id then
			
			table.remove(table, id)
			break
		end
	end
end