[RiftHbot](http://riftui.com/downloads/info213-RiftHbot.html/) - Healing one click at a time!
=============================================================================================

<<<<<<< HEAD
Features
--------


Changelog
--------------


What you need to use this script
--------------------------------

=======
What is RiftHbot?
-----------------
RiftHbot is a raid frame substitute focusing on healing needs. It offers a wide variety of customization in terms of how you want your frames to look. You choose what you see and how you respond to the condition. This add-on prides on giving you the best setup for your individual needs. Please however understand that the current Rift API is limited and thus preventing us succeeding our true goals.

Nonetheless, the add-on makes it easier to monitor incoming damage, damage over time, healing, healing over time, buffs and debuffs. So that you can accurately and efficiently heal no matter how much is going on in raid. No longer do you have to look at Rift's messy default raid frames and wonder if your stacks are falling off or if the tank just used a cooldown.

Changelog
---------
- Edited function for onBuffRemove() - buffmonitor.lua, now updates only the changed slots on buff remove event, reducing CPU usage from 45% to 8% max with 20 debuffs changing almost at the same time (found out tonight while playing a purifier cleric). `Achelius 20/03/2012`

Key Features
------------
- Ability to trash raid debuff, dispellable debuffs, HoTs and much more.
- Ability to use Click-to-cast spells.
- Aggro indication for all members of group.
- Castbar on target frames.
- Code efficiency, most of the elements are only active when needed otherwise they are removed from CPU cycles.
- Customizable appearance to suit your needs. Almost every visual aspect can be changed.
- Indication of distance or line of sight.
- Mousebind, Buff and Debuff profiles for all individual specs.
- Mouseover targeting. RHB knows when you hover over a target.
- Role changing buttons that disappear in combat.
- Target indication, know what you target.

RiftHbot for Dummies
--------------------
Work in progress.
>>>>>>> 2a67f2ba878ea12a80e9300a4a905c633a862c07

Known Issues
------------
<<<<<<< HEAD

Future Implementations
----------------------
1.	
2.	
3.	
=======
- Only in group mode and during combat if a player disconnects, the game sort the players in the group moving the disconnected player last, but i cannot reassign the frames mouseover unit id during combat so it bugs out, I’m trying to fix it but i don't want to complicate things too much or they will easily break.
- Los indicator doesn't work like it's intended but is fixed in the upcoming version 0.25.
- In a 20 man raid. When you apply a great number of buffs at the same time it slow down the game considerably (like when you are spamming Healing Flood in combat on a 20 man raid), rift has an incredible amount of buffs on every character at the same time.

Future Implementations
----------------------
1. Work in progress.
2. Work in progress.
3. Work in progress.
>>>>>>> 2a67f2ba878ea12a80e9300a4a905c633a862c07
