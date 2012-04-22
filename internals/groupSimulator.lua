lb.groupSimulator={}
function lb.groupSimulator.showDummies(count)
	if count==nil then return end
	for i = 1 , count do
		--print (lb.UnitsTableStatus[i][11])
		if not lb.UnitsTableStatus[i][12] then
		
			lb.createNewFrame(i,true)
		end
		lb.UnitsTableStatus[i][14]=true
		lb.styles[lb.currentStyle].initializeIndex(i)
		lb.styles[lb.currentStyle].showFrame(i)
	end
	--print("count-"..tostring(count))
	for i =(count+1),20 do
		--print("cc-"..tostring(i))
		if lb.UnitsTableStatus[i][12] then
			lb.UnitsTableStatus[i][14]=false 
			lb.UnitsTableStatus[i][11]=true --flags the frame for an update
		end
	end
end

function lb.groupSimulator.removeDummies()
	for i = 1 , 20 do
		if lb.UnitsTableStatus[i][12] then
			lb.UnitsTableStatus[i][14]=false 
			lb.UnitsTableStatus[i][11]=true --flags the frame for an update
		end
		
	end
end
function lb.groupSimulator.groupSimulator(cmd,params)
	local cmdv= lb.slashCommands.parseCommandValues(params[1])
	
	if cmdv[1]=="showdummies" then
		lb.groupSimulator.showDummies(tonumber(cmdv[2]))
		return true
	elseif cmdv[1]=="removedummies"then
		lb.groupSimulator.removeDummies()
		return true
	end
	return false
end

lb.addCustomSlashCommand("test",lb.groupSimulator.groupSimulator)