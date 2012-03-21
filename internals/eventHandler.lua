print ("ciao")
table.insert(Event.Unit.Detail.Health, {rhbHpUpdate, "RiftHbot", "Update_Health"})
table.insert(Event.Unit.Detail.HealthMax, {rhbHpUpdate, "RiftHbot", "Update_Max_Health"})
table.insert(Event.Unit.Detail.Aggro, {rhbAggroUpdate, "RiftHbot", "Update_Aggro_Flags"})
table.insert(Event.Unit.Detail.Blocked, {rhbBlockedUpdate, "RiftHbot", "Update_Blocked_Flags"})
table.insert(Event.Ability.Add, {onAbilityAdded, "RiftHbot", "onAbilityAdded"})
table.insert(Event.System.Secure.Enter, {onSecureEnter, "RiftHbot", "onSecureEnter"})
table.insert(Event.System.Secure.Leave, {onSecureExit, "RiftHbot", "onSecureExit"})
table.insert(Event.Addon.Startup.End, {rhbloadSettings, "RiftHbot", "rhbloadSettings"})
table.insert(Event.TEMPORARY.Role, {onRoleChanged, "RiftHbot", "onRoleChanged"})
table.insert(Event.System.Update.Begin, {rhbUnitUpdate, "RiftHbot", "UpdateGroupDetails"})
table.insert(Event.System.Update.Begin, {castbarUpdate, "RiftHbot", "CastbarUpdate"})
table.insert(Event.Unit.Castbar, {onCastbarChanged, "RiftHbot", "OnCastBarChanged"})
table.insert(Event.Buff.Add, {onBuffAdd, "RiftHbot", "onBuffChange"})
table.insert(Event.Buff.Remove, {onBuffRemove, "RiftHbot", "onBuffRemove"})
-- create a change target event
table.insert(Library.LibUnitChange.Register("player.target"), {onPlayerTargetChanged, "RiftHbot", "OnUnitChange"})
table.insert(Library.LibUnitChange.Register("mouseover"), {onMouseOverTargetChanged, "RiftHbot", "OnUnitMouseoverChange"})




