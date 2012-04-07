lb.slotsGui.addonInfo={}
local frame=nil
local text = "VERSION 1.0.1.1 (PUBLIC BETA)\n\n\nLifeBinder - Healing one click at a time!\n\nWhat is LifeBinder?\n\nLifeBinder is raid frames addon focused on personalization, buffs and debuffs\n We wanted to create an addon that has a lot of features that simplifies the healer work, features that the default raid frames don't have\n Please undestrand that the Rift API is limited and of couse bugs can come out\n One of them is disconnections while in combat in a 5 players group, the game automatically reorders the players to have the disconnected one last,\n in combat that causes problems with how we set up the addon for performance\n We are working on solving that\n\n We are also planning to add more features,\n other features are there but disabled until patch 1.8 hits, like out of range detection\n\n Styles are a first implementation of what we want to do with them, they are as easy as we want to edit, so for now there are only two:\n Horizontal groups growing from bottom (standard) and the classic (oldstyle) \n We are planning to make a fully personalizable style but we didn't have the time to implement that\n\n We have so many things in mind that we want to implement but as always when writing addons we tend to need a lot of time for development and testing."

function lb.slotsGui.addonInfo.createTable(parentFrame)
 	 local optionsFrame
	 optionsFrame = UI.CreateLbFrame("Frame", "OptionsWindowA", parentFrame)
	 writeText(text,"text",optionsFrame,10,10)
	 
	 frame=optionsFrame
	 return optionsFrame
end


