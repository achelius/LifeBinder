[LifeBinder](http://riftui.com/downloads/info213-LifeBinder.html/) - Healing one click at a time!
=================================================================================================

What is LifeBinder?
-------------------
LifeBinder is a raid frame substitute focusing on healing needs. It offers a wide variety of customization in terms of how you want your frames to look. You choose what you see and how you respond to the condition. This add-on prides on giving you the best setup for your individual needs. Please however understand that the current Rift API is limited and thus preventing us succeeding our true goals.

Nonetheless, the add-on makes it easier to monitor incoming damage, damage over time, healing, healing over time, buffs and debuffs. So that you can accurately and efficiently heal no matter how much is going on in raid. No longer do you have to look at Rift's messy default raid frames and wonder if your stacks are falling off or if the tank just used a cooldown.

Changelog
---------
- Edited function for onBuffRemove() - buffmonitor.lua, now updates only the changed slots on buff remove event, reducing CPU usage from 45% to 8% max with 20 debuffs changing almost at the same time (found out tonight while playing a purifier cleric). `Achelius 20/03/12`
- Added slash commands. `Protonova 03/20/12`
- Changed add-on's name from RiftHBot to LifeBinder. `Achelius & Protonova 03/20/12`
- Implemented new file structure. `Protonova 03/20/12`
- Working version of Buff/Debuff white/black listing, but GUI needs to be fixed. `Achelius 03/21/12`

Key Features
------------
- Ability to track raid debuff, dispellable debuffs, HoTs and much more.
- Ability to use Click-to-cast spells.
- Aggro indication for all members of group.
- Castbar on target frames.
- Code efficiency, most of the elements are only active when needed otherwise they are removed from CPU cycles.
- Customizable appearance to suit your needs. Almost every visual aspect can be changed.
- Indication of distance or line of sight.
- Mousebind, Buff and Debuff profiles for all individual specs.
- Mouseover targeting. LB knows when you hover over a target.
- Role changing buttons that disappear in combat.
- Target indication, know what you target.

LifeBinder for Dummies
----------------------
- Download the Latest ***stable*** version from [RiftUI](http://riftui.com/downloads/info213-LifeBinder.html): http://riftui.com/downloads/info213-LifeBinder.html
- Download the latest ***preview*** version from [GitHub](https://github.com/achelius/LifeBinder): https://github.com/achelius/LifeBinder

### Installing and Updating ###
1. Completely log off Rift
2. Copy the addon folders into your Rift addon folder.
3. Logon to Rift and when you have reached your character selection screen click on the Addons button. Check that LifeBinder is visible and checked.
4. As a priority you should open options menu and configure spells, cures and buffs.

### Updating Troubles ###

*** **If you get nil errors after updating** ***

1. Completely log off Rift
2. Run the Reset_LifeBinder.bat file in the LifeBinder addon folder, this clears old saved LifeBinder settings from your account's SavedVariables folder.
3. Logon to Rift on your main healer.
4. As a priority you should open options menu and redo configure spells, cures and buffs.

### Using LifeBinder ###
*Pending, work in progress*

### LifeBinder Options ###
*Pending, work in progress*

Known Issues
------------
- Only in group mode and during combat if a player disconnects, the game sort the players in the group moving the disconnected player last, but I cannot reassign the frames mouseover unit id during combat so it bugs out, I'm trying to fix it but i don't want to complicate things too much or they will easily break.
- LoS indicator doesn't work like it's intended but is fixed in the upcoming version 0.25.
- In a 20 man raid. When you apply a great number of buffs at the same time it slow down the game considerably (like when you are spamming healing flood in combat on a 20 man raid), Rift has an incredible amount of buffs on every character at the sametime.

Future Implementations
----------------------
- Read todo.md for now *work in progress*.

Questions?
----------
If you have any questions, please feel free to ask them on the [Developing LifeBinder Core](http://lifebinder.ceroaim.us) forum or email us at *prjaddon (at) gmail (dot) com* or comment on our addon's RiftUI page.