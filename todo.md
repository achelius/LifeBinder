Future Implementations
======================

This is a list of currently plan future additions for LifeBinder. Last updated 

Achepjr
-------
- Manabar support (with events only in combat and with events + periodic update out of combat), see manabar.lua for details.
- Separate main frame elements in separate files (like manabar.lua,healthbar.lua, etc). `DONE`
- Move buffs/debuffs related functions into the buffmonitor.lua and move the file into frmelements folder
- Move castbar.lua into frmelements folder `DONE`
- Whitelist/blacklist for debuffs

Protonova
---------
* Add opactiy to LoS/OoR conditions to frame.
* Fix Slash Commands `DONE`
    > Switch for manabars. `DONE`
    > Switch for dragger. `DONE`
    > Switch for profiling. Possibly save layout per spec instead of overall profile.
    > Switch for /help. `DONE`
    > Switch for configuration menu. `DONE`
* Add 2 modes. Normal and None intrusive mode where mouse clicks just dont register other than left click. (For mouseover only users).
* Add a timer bar for HoTs (Max 4 trackable HoTs). Ideally for SS, HS, HC, HF. Originally thought 3, 4 might be too intrusive.
* Add Ability to switch between percent and exact HP deficit to Units.
* Add localizations.
* Add optional healer stats LDB
* Add segmented HoT indicator for SS.
* Change how death is displayed... 0% isn't cutting it. No way of Telling who is SWing either.
* Discuss changing name of Addon. `DONE`
* Figure out how to replace Role icons with something none intrusive.
* Fix OoR detection. Via Default max range of spell (like ressurection).
* Intoduce new textures via style.lua once completed.
* Modify how frames are displayed in terms of layers as well as how D/C, Porting, Has aggro, and selected (bar too thick) are displayed.
* Redesign the specs buttons, add tooltip ability to grab spec name from talent panel. (Maybe, I still don't like that bar)
* Redo file and folder naming/structure. `DONE`