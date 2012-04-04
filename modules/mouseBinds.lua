lb.mouseBinds={}
function lb.mouseBinds.setMouseActions()
    if lbValues.set==nil then return end
    if lb.isincombat then return end
    local associations =lbMouseBinds[lbValues.set]
    for i = 1,20 do
        local fname=""
        --print (lastMode)
        
	        if lastMode == 0 then
	            if i==1 then
	                fname="self"
	            else
	                fname=string.format("group%.2d", i)
	            end
	        else
	            fname=string.format("group%.2d", i)
	        end
	        for key,value in pairs(associations) do
	            --print(tostring(i).."->"..key)
	            if key==1 then
	                --leftclick
	                --if i==1 then print   ("left"..lb.mouseBinds.generateMacro(value,fname))end
	                lb.frames[i].groupMask.Event.LeftDown=lb.mouseBinds.generateMacro(value,fname)
	            elseif key==2 then
	                -- righeclick
	                --if i==1 then print   ("right"..lb.mouseBinds.generateMacro(value,fname))end
	                lb.frames[i].groupMask.Event.RightDown=lb.mouseBinds.generateMacro(value,fname)
	            elseif key==3 then
	                -- middleclick
	                --print(lb.mouseBinds.generateMacro(value,fname))
	                lb.frames[i].groupMask.Event.MiddleDown=lb.mouseBinds.generateMacro(value,fname)
	            elseif key==4 then
	                -- mouse4
	                --print(lb.mouseBinds.generateMacro(value,fname))
	                lb.frames[i].groupMask.Event.Mouse4Down=lb.mouseBinds.generateMacro(value,fname)
	            elseif key==5 then
	                -- mouse5
	                --print(lb.mouseBinds.generateMacro(value,fname))
	                lb.frames[i].groupMask.Event.Mouse5Down=lb.mouseBinds.generateMacro(value,fname)
	            end
	
	        end
        
    end

end

function lb.mouseBinds.setMouseActionsForIndex(index)
    if lbValues.set==nil then return end
    if lb.isincombat then return end
    local i=index
    local associations =lbMouseBinds[lbValues.set]
    
        local fname=""
        --print (lastMode)
        if lastMode == 0 then
            if i==1 then
                fname="self"
            else
                fname=string.format("group%.2d", i)
            end
        else
            fname=string.format("group%.2d", i)
        end
        for key,value in pairs(associations) do
            --print(tostring(i).."->"..key)
            if key==1 then
                --leftclick
                --if i==1 then print   ("left"..lb.mouseBinds.generateMacro(value,fname))end
                lb.frames[i].groupMask.Event.LeftDown=lb.mouseBinds.generateMacro(value,fname)
            elseif key==2 then
                -- righeclick
                --if i==1 then print   ("right"..lb.mouseBinds.generateMacro(value,fname))end
                lb.frames[i].groupMask.Event.RightDown=lb.mouseBinds.generateMacro(value,fname)
            elseif key==3 then
                -- middleclick
                --print(lb.mouseBinds.generateMacro(value,fname))
                lb.frames[i].groupMask.Event.MiddleDown=lb.mouseBinds.generateMacro(value,fname)
            elseif key==4 then
                -- mouse4
                --print(lb.mouseBinds.generateMacro(value,fname))
                lb.frames[i].groupMask.Event.Mouse4Down=lb.mouseBinds.generateMacro(value,fname)
            elseif key==5 then
                -- mouse5
                --print(lb.mouseBinds.generateMacro(value,fname))
                lb.frames[i].groupMask.Event.Mouse5Down=lb.mouseBinds.generateMacro(value,fname)
            end

        end
    

end

function lb.mouseBinds.generateMacro(associations,name)
	
    local none=associations[1]
    local alt=associations[2]
    local ctrl=associations[3]
    local shift=associations[4]
    local altctrl=associations[5]
    local shiftalt=associations[6]
    local shiftctrl=associations[7]
    local macro=""
-- {"ability name","Rift",ab.icon,"type","command","mousebutton","modifier"}
    local modifier=""
    if altctrl~=nil then
        modifier="[alt] [ctrl]"
        local temp=""
        for k,val in pairs(altctrl) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
        macro= macro..temp
    end
    
    if shiftalt~=nil then
        modifier="[alt] [shift]"
        local temp=""
        for k,val in pairs(shiftalt) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
        macro= macro..temp
    end
    
    if shiftctrl~=nil then
        modifier="[ctrl] [shift]"
        local temp=""
        for k,val in pairs(shiftctrl) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
        macro= macro..temp
    end
    
    if alt~=nil then
        modifier="[alt]"
        local temp=""
        for k,val in pairs(alt) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
        macro= macro..temp
    end
    if ctrl~=nil then
        modifier="[ctrl]"
       local temp=""
        for k,val in pairs(ctrl) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
		macro= macro..temp
    end
    if shift~=nil then
        modifier="[shift]"
        local temp=""
        for k,val in pairs(shift) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
        macro= macro..temp
    end
    if none~=nil then
    	modifier=""
        local temp=""
        for k,val in pairs(none) do
        	if val[4]=="cast" then
        		temp=temp.."/cast "..modifier.." @"..name.." "..val[5].."\13"
        	elseif val[4]=="target" then
        		temp=temp.."/target "..modifier.." @"..name.."\13"
        	elseif val[4]=="assist" then
        		temp=temp.."/target "..modifier.." @"..name..".target\13"
        	elseif val[4]=="focus" then
        		temp=temp.."/focus "..modifier.." @"..name.."\13"
        	elseif val[4]=="macro" then
        		temp=temp..val[5]
        	end
        	
        end
        macro= macro..temp
    end
    macro=string.gsub(macro,"\13","\n")
--    print("-----------------")
--    dump (associations)
--    print("-----------------")
--    print (macro)
--    print("-----------------")
    return macro
end

