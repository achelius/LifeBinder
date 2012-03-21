
table.insert(Event.Unit.Detail.Health, {lbHpUpdate, "LifeBinder", "Update_Health"})
table.insert(Event.Unit.Detail.HealthMax, {lbHpUpdate, "LifeBinder", "Update_Max_Health"})
table.insert(Event.Unit.Detail.Aggro, {lbAggroUpdate, "LifeBinder", "Update_Aggro_Flags"})
table.insert(Event.Unit.Detail.Blocked, {lbBlockedUpdate, "LifeBinder", "Update_Blocked_Flags"})
table.insert(Event.Ability.Add, {onAbilityAdded, "LifeBinder", "onAbilityAdded"})
table.insert(Event.System.Secure.Enter, {onSecureEnter, "LifeBinder", "onSecureEnter"})
table.insert(Event.System.Secure.Leave, {onSecureExit, "LifeBinder", "onSecureExit"})
--table.insert(Event.Addon.Startup.End, {lbloadSettings, "LifeBinder", "lbloadSettings"})
table.insert(Event.Addon.SavedVariables.Load.End, {loadsettings, "LifeBinder", "loadSettings"})
table.insert(Event.TEMPORARY.Role, {onRoleChanged, "LifeBinder", "onRoleChanged"})
table.insert(Event.System.Update.Begin, {lbUnitUpdate, "LifeBinder", "UpdateGroupDetails"})
table.insert(Event.System.Update.Begin, {castbarUpdate, "LifeBinder", "CastbarUpdate"})
table.insert(Event.Unit.Castbar, {onCastbarChanged, "LifeBinder", "OnCastBarChanged"})
table.insert(Event.Buff.Add, {onBuffAdd, "LifeBinder", "onBuffChange"})
table.insert(Event.Buff.Remove, {onBuffRemove, "LifeBinder", "onBuffRemove"})
-- create a change target event
table.insert(Library.LibUnitChange.Register("player.target"), {onPlayerTargetChanged, "LifeBinder", "OnUnitChange"})
table.insert(Library.LibUnitChange.Register("mouseover"), {onMouseOverTargetChanged, "LifeBinder", "OnUnitMouseoverChange"})




