function lb.onGroupJoin(unitID, specifier)
	--print("join->"..tostring(unitID)..tostring(specifier))
	local index=stripnum(specifier)
	lb.UnitsTableStatus[index][11]=true
end
function lb.onGroupLeave(unitID, specifier)
	--print("leave->"..tostring(unitID)..tostring(specifier))
	local index=stripnum(specifier)
	lb.UnitsTableStatus[index][5]=0
	lb.UnitsTableStatus[index][11]=true
end
function lb.onGroupChange(unitID, oldspecifier,newspecifier)
	--print("change->"..tostring(unitID)..tostring(oldspecifier)..tostring(newspecifier))
	local oldindex=stripnum(oldspecifier)
	local newindex=stripnum(newspecifier)
	
	lb.UnitsTableStatus[oldindex][11]=true
	lb.UnitsTableStatus[newindex][11]=true
	
	--dump(Inspect.Unit.Detail(oldspecifier))
	--dump(Inspect.Unit.Detail(newspecifier))
end

function lb.onPlayerJoin(units)
--	print ("pj")
--	print (units)
--    dump(units)
--    print("pj-")
    lb.UnitsTableStatus[1][11]=true
	lbUnitUpdate()
end

function lb.onPlayerLeave()
	--print ("pl")
	  lb.UnitsTableStatus[1][11]=true
	  lbUnitUpdate()
end