
local stTable=lb.styles["standard"]
local optionsTable=nil
local frame=nil
stTable.mouseBinds={}
function stTable.mouseBinds.initializemouseBindsOptionsTable()
	if optionsTable==nil then optionsTable=stTable.options end
		--print(stTable.getLayoutTable().buffs)
	
	if stTable.getProfileTable().common.mouseBinds ==nil then
		stTable.getProfileTable().common.mouseBinds={}
		local lbMouseBinds=stTable.getProfileTable().common.mouseBinds
      
    	for g= 1,5 do
    		lbMouseBinds[g]={}
    		for h= 1,7 do
    			lbMouseBinds[g][h]={}	
    		end
    	end
       
	end
	lb.mouseBinds.getMouseBindsTable=stTable.mouseBinds.getMouseBindsTable --overrides this default function
end

function stTable.mouseBinds.getMouseBindsTable()
	return stTable.getProfileTable().common.mouseBinds
end
