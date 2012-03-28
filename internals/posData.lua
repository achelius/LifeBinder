local _G = getfenv(0)
local unitdetail = _G.Inspect.Unit.Detail
local timeFrame=_G.Inspect.Time.Frame
local playerThrottleLastTime=0
local targetThrottleLastTime=0



local function getThrottle(index)
    local now =  timeFrame()
    local elapsed = now - lb.posData.units[index].lasttime
    if (elapsed >= (.5)) then --half a second
        lb.posData.units[index].lasttime = now
        return true
    end
end

local function getPlayerThrottle()
    local now =  timeFrame()
    local elapsed = now - playerThrottleLastTime
    if (elapsed >= (.5)) then --half a second
        playerThrottleLastTime = now
        return true
    end
end
local function getTargetThrottle()
    local now =  timeFrame()
    local elapsed = now - targetThrottleLastTime
    if (elapsed >= (.5)) then --half a second
        targetThrottleLastTime = now
        return true
    end
end


lb.posData={}
lb.playerPosition={}
lb.posData.OutOfRange={}
lb.posData.player={}
lb.posData.targetOORStatus=nil
lb.posData.CurrentTarget=nil
lb.posData.player.OutOfRange, Event.Unit.Detail.OutOfRange = Utility.Event.Create("Rift", "Unit.Detail.OutOfRange")
--lb.LastTarget
function onOutOfRange(unit,status)
	if unit==nil then return end
	local index= GetIndexFromID(unit)
	print (tostring(unit) ..tostring(status))
	if index~=nil then
		print(index)
		lb.styles[lb.currentStyle].setBlockedValue(index,lb.UnitsTableStatus[index][3],status)
	end
end

function lb.posData.initialize()
	local playdet =unitdetail("player")
	local tardet =unitdetail("player.target")
	
	--player positions
	lb.playerPosition.X=0
	lb.playerPosition.Y=0
	lb.playerPosition.Z=0
	
	if playdet~=nil then
		if playdet.coordX~=nil then
			lb.playerPosition.X=playdet.coordX
			lb.playerPosition.Y=playdet.coordY
			lb.playerPosition.Z=playdet.coordZ
		end
	end
	dump(lb.playerPosition)
	--initialize for group positions
	lb.posData.units={}
	for i = 1,20 do
		lb.posData.units[i]={}
		lb.posData.units[i].X=0
		lb.posData.units[i].Y=0
		lb.posData.units[i].Z=0
		lb.posData.units[i].lasttime=timeFrame()
		lb.posData.units[i].distance=0
		lb.posData.units[i].distancelong=0
	end
	lb.posData.Target={}
	lb.posData.Target.X=0
	lb.posData.Target.Y=0
	lb.posData.Target.Z=0
	lb.posData.Target.lasttime=timeFrame()
	lb.posData.Target.distance=0
	lb.posData.Target.distancelong=0
	if tardet~=nil then
		if tardet.coordX~=nil then
			lb.posData.CurrentTarget=tardet.id
			lb.posData.Target.X=tardet.coordX
			lb.posData.Target.Y=tardet.coordY
			lb.posData.Target.Z=tardet.coordZ
			lb.posData.updateTargetPosition(lb.posData.Target.X,lb.posData.Target.Y,lb.posData.Target.Z)
		end
	end
	
end

function lb.posData.onPlayerTargetChanged(unit)
	if unit==false then
		lb.posData.targetOORStatus=nil
		lb.posData.CurrentTarget=nil
    else
     	local tardet =unitdetail(unit)
		if tardet~=nil then
			if tardet.coordX~=nil then
				lb.posData.CurrentTarget=unit
				lb.posData.targetOORStatus=false
				lb.posData.Target.X=tardet.coordX
				lb.posData.Target.Y=tardet.coordY
				lb.posData.Target.Z=tardet.coordZ
				lb.posData.updateTargetPosition(lb.posData.Target.X,lb.posData.Target.Y,lb.posData.Target.Z,true)
				
			end
		end
    end
   
end

function lb.posData.onPlayerMovement(x,y,z)
	for id,val in pairs(x) do
		if id==lb.PlayerID then
			lb.posData.updatePlayerPosition(x[id],y[id],z[id])
			
			if lb.posData.CurrentTarget ~=nil then 
				lb.posData.updateTargetPosition(lb.posData.Target.X,lb.posData.Target.Y,lb.posData.Target.Z)
			end
		end
		lb.posData.updateUnitPos(GetIndexFromID(id),x[id],y[id],z[id])
		
		if id==lb.posData.CurrentTarget then
			lb.posData.Target.X=x[id]
			lb.posData.Target.Y=y[id]
			lb.posData.Target.Z=z[id]
			lb.posData.updateTargetPosition(x[id],y[id],z[id])
			 
		end
	end
end

function lb.posData.updateTargetPosition(x,y,z,noThrottle)
	local timer = getTargetThrottle()--throttle to limit cpu usage (period set to 0.5 sec)
	if not timer and noThrottle==nil then return end
	lb.posData.Target.X=x
	lb.posData.Target.Y=y
	lb.posData.Target.Z=z
	local dx=lb.posData.Target.X-lb.playerPosition.X
	local dy=lb.posData.Target.Y-lb.playerPosition.Y
	local dz=lb.posData.Target.Z-lb.playerPosition.Z
	
	lb.posData.Target.distancelong=dx*dx+dz*dz+dy*dy
	
	lb.posData.Target.distance=lb.posData.getFastDistance(dx,dy,dz)
	
    print (lb.posData.Target.distance)
    print (lb.posData.getFastDistance(dx,dy,dz))
    if lb.posData.Target.distancelong>=lbValues.MaxRange then
		if not lb.posData.targetOORStatus or lb.posData.targetOORStatus==nil then
			lb.posData.targetOORStatus=true
			lb.posData.player.OutOfRange(lb.posData.CurrentTarget,true)
		end
	else
		if lb.posData.targetOORStatus or lb.posData.targetOORStatus==nil then
			lb.posData.targetOORStatus=false
			lb.posData.player.OutOfRange(lb.posData.CurrentTarget,false)
		end
	end
    
end

function lb.posData.updatePlayerPosition(x,y,z)
	local timer = getPlayerThrottle()--throttle to limit cpu usage (period set to 0.5 sec)
	lb.playerPosition.X=x
	lb.playerPosition.Y=y
	lb.playerPosition.Z=z
	recalculateDistances()
end

function recalculateDistances()
	for i= 1,20 do
		
		if lb.posData.units[i].X~=0 then
			
			
			local dx=lb.posData.units[i].X-lb.playerPosition.X
			local dy=lb.posData.units[i].Y-lb.playerPosition.Y
			local dz=lb.posData.units[i].Z-lb.playerPosition.Z
			
			lb.posData.units[i].distancelong=dx*dx+dz*dz+dy*dy
						   
		    lb.posData.units[i].distance=lb.posData.getFastDistance(dx,dy,dz)	
		    
--		    print (i)
-- 				print (ident)
-- 				print(lb.posData.units[i].distance)
-- 				print (lb.posData.units[i].distancelong>=lbValues.MaxRange)
-- 				print (lb.UnitsTableStatus[ident][10])
		    	if ident~="player" then
			    	if lb.UnitsTableStatus[i]~=nil then
						if lb.posData.units[i].distancelong>=lbValues.MaxRange then
							if not lb.UnitsTableStatus[i][10] or lb.UnitsTableStatus[i][10]==nil then
								lb.UnitsTableStatus[i][10]=true
								lb.posData.player.OutOfRange(lb.UnitsTableStatus[i][5],true)
								print (i .. "-->in")
							end
						else
							if lb.UnitsTableStatus[i][10] or lb.UnitsTableStatus[i][10]==nil then
								lb.UnitsTableStatus[i][10]=false
								print (i .. "-->out")
								lb.posData.player.OutOfRange(lb.UnitsTableStatus[i][5],false)
							end
						end
					end
				end
			
		end
	end
end

function lb.posData.resetUnitPositionofIndex(index,x,y,z)
	if x==nil then return end
	lb.posData.units[index].X=x
	lb.posData.units[index].Y=y
	lb.posData.units[index].Z=z
	
	local dx=x-lb.playerPosition.X
	local dy=y-lb.playerPosition.Y
	local dz=z-lb.playerPosition.Z
	
	lb.posData.units[index].distancelong=dx*dx+dz*dz+dy*dy
    lb.posData.units[index].distance=lb.posData.getFastDistance(dx,dy,dz)
    
    if ident~=nil then
    	if lb.UnitsTableStatus[index]~=nil then
			if lb.posData.units[index].distancelong>=lbValues.MaxRange then
				if not lb.UnitsTableStatus[index][10] or lb.UnitsTableStatus[index][10]==nil  then
					lb.UnitsTableStatus[index][10]=true
					lb.posData.player.OutOfRange(lb.UnitsTableStatus[index][5],true)
				end
			else
				if lb.UnitsTableStatus[index][10] or lb.UnitsTableStatus[index][10]==nil  then
					lb.UnitsTableStatus[index][10]=false
					lb.posData.player.OutOfRange(lb.UnitsTableStatus[index][5],false)
				end
			end
		end
	end

	
	
	
end

function lb.posData.updateUnitPos(index,x,y,z)
	if index==nil then return end
	
	local timer = getThrottle(index)--throttle to limit cpu usage (period set to 0.5 sec)
	
    if not timer then return end
	lb.posData.units[index].X=x
	lb.posData.units[index].Y=y
	lb.posData.units[index].Z=z
	
	local dx=x-lb.playerPosition.X
	local dy=y-lb.playerPosition.Y
	local dz=z-lb.playerPosition.Z
	lb.posData.units[index].distancelong=dx*dx+dz*dz+dy*dy
	
	
    lb.posData.units[index].distance=lb.posData.getFastDistance(dx,dy,dz)
 	local ident = getIdentifierFromIndex(index)
 	
    if ident~=nil then
    	if lb.UnitsTableStatus[index]~=nil then
			if lb.posData.units[index].distancelong>=lbValues.MaxRange then
				if not lb.UnitsTableStatus[index][10] or lb.UnitsTableStatus[index][10]==nil  then
					lb.UnitsTableStatus[index][10]=true
					lb.posData.player.OutOfRange(lb.UnitsTableStatus[index][5],true)
				end
			else
				if lb.UnitsTableStatus[index][10] or lb.UnitsTableStatus[index][10]==nil  then
					lb.UnitsTableStatus[index][10]=false
					lb.posData.player.OutOfRange(lb.UnitsTableStatus[index][5],false)
				end
			end
		end
	end
end

function lb.posData.getFastDistance(dx,dy,dz)
	local approx=0
	if  dx < 0 then dx = -dx end 
   	if  dz < 0 then dz = -dz end
   	if  dx < dz then
   
      min = dx
      max = dz
    else 
      min = dz
      max = dx
   	end
   	approx = ( max * 1007 ) + ( min * 441 );
    if  max < ( bit.lshift(min,4) ) then
      approx = approx-( max * 40 )
	end
    dtemp=(bit.rshift(( approx + 512 ), 10) )
    if  dy < 0 then dy = -dy end 
   	if  dtemp < 0 then dtemp = -dtemp end
   	if  dy < dtemp then
   
      min = dy
      max = dtemp
    else 
      min = dtemp
      max = dy
   	end
   	approx = ( max * 1007 ) + ( min * 441 );
    if  max < ( bit.lshift(min,4) ) then
      approx = approx-( max * 40 )
	end
    return (bit.rshift(( approx + 512 ), 10) )
end