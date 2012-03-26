table.insert(Event.Unit.Detail.Health, {lbHpUpdate, "LifeBinder", "Update_Health"})
table.insert(Event.Unit.Detail.HealthMax, {lbHpUpdate, "LifeBinder", "Update_Max_Health"})
table.insert(Event.Unit.Detail.Mana, {updateResourceBar, "LifeBinder", "Update_Mana"})
table.insert(Event.Unit.Detail.ManaMax, {updateResourceBar, "LifeBinder", "Update_Max_Mana"})
table.insert(Event.Unit.Detail.Power, {updateResourceBar, "LifeBinder", "Update_Power"})
table.insert(Event.Unit.Detail.Energy, {updateResourceBar, "LifeBinder", "Update_Energy"})
table.insert(Event.Unit.Detail.EnergyMax, {updateResourceBar, "LifeBinder", "Update_Max_Energy"})
table.insert(Event.Unit.Detail.Aggro, {lbAggroUpdate, "LifeBinder", "Update_Aggro_Flags"})
table.insert(Event.Unit.Detail.Blocked, {lbBlockedUpdate, "LifeBinder", "Update_Blocked_Flags"})
table.insert(Event.Ability.Add, {onAbilityAdded, "LifeBinder", "onAbilityAdded"})
table.insert(Event.System.Secure.Enter, {onSecureEnter, "LifeBinder", "onSecureEnter"})
table.insert(Event.System.Secure.Leave, {onSecureExit, "LifeBinder", "onSecureExit"})
table.insert(Event.Addon.SavedVariables.Load.End, {lbLoadVariables, "LifeBinder", "lbLoadVariables"})
table.insert(Event.TEMPORARY.Role, {onRoleChanged, "LifeBinder", "onRoleChanged"})
table.insert(Event.Unit.Detail.Role, {onUnitRoleChanged, "LifeBinder", "onUnitRoleChanged"})

table.insert(Event.Addon.Load.End, {lbUnitUpdate, "LifeBinder", "UpdateGroupDetails"})

table.insert(Event.System.Update.Begin, {castbarUpdate, "LifeBinder", "CastbarUpdate"})
table.insert(Event.Unit.Castbar, {onCastbarChanged, "LifeBinder", "OnCastBarChanged"})
table.insert(Event.Buff.Add, {onBuffAdd, "LifeBinder", "onBuffChange"})
table.insert(Event.Buff.Remove, {onBuffRemove, "LifeBinder", "onBuffRemove"})
-- create a change target event
table.insert(Library.LibUnitChange.Register("player.target"), {onPlayerTargetChanged, "LifeBinder", "OnUnitChange"})
table.insert(Library.LibUnitChange.Register("mouseover"), {onMouseOverTargetChanged, "LifeBinder", "OnUnitMouseoverChange"})


-- safesraidmanager events
table.insert(Event.SafesRaidManager.Group.Join, {lbUnitUpdate , "LifeBinder", "GroupJoin"})
table.insert(Event.SafesRaidManager.Group.Leave, {lbUnitUpdate , "LifeBinder", "GroupLeave"})

table.insert(Event.SafesRaidManager.Player.Join, {lbUnitUpdate , "LifeBinder", "PlayerJoin"})
table.insert(Event.SafesRaidManager.Player.Leave,{lbUnitUpdate , "LifeBinder", "PlayerLeave"})

--player available wait
WaitPlayerEventID={waitPlayerAvailable, "LifeBinder", "WaitPlayerAvailable"}
table.insert(Event.System.Update.Begin,WaitPlayerEventID)
function remev()
	for id, eventData in ipairs(Event.System.Update.Begin) do
		if eventData == WaitPlayerEventID then
			
			table.remove(Event.System.Update.Begin, id)
			break
		end
	end
end
function RemoveEventHandler(table,event_id)
	--removing
	for id, eventData in ipairs(table) do
		if eventData == event_id then
			
			table.remove(table, id)
			break
		end
	end
end