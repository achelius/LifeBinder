lb.readyCheck={}

function lb.readyCheck.onReadyEvent(units)
	for unitID,value in pairs(units) do
		local ind =lb.GetIndexFromID(unitID)
		if ind~=nil then
			if value=="nil" then
				lb.styles[lb.currentStyle].setRoleIcon(ind,lb.UnitsTableStatus[ind][9],lb.UnitsTableStatus[ind][4])	
			else	
				lb.styles[lb.currentStyle].setReadyCheck(ind,value)
			end
		end
	end
	
end