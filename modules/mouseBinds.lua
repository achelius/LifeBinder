lb.mouseBinds={}
function lb.mouseBinds.setMouseActions()
    if lbValues.set==nil then return end
    if lbValues.isincombat then return end
    local associations =lbMacroButton[lbValues.set]
    for i = 1,20 do
        local fname=""
        --print (lastMode)
        if lb.UnitsTableStatus[i][12] then
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

end

function lb.mouseBinds.setMouseActionsForIndex(index)
    if lbValues.set==nil then return end
    if lbValues.isincombat then return end
    local i=index
    local associations =lbMacroButton[lbValues.set]
    
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

    local macro=""

    local modifier=""
    --print ("none->"..none)
    if alt~=nil and alt ~="" then
        modifier="[alt]"
        alt=string.gsub(alt,"##"," "..tostring(modifier).." ##")
        macro= macro..alt.."\13"

    end
    if ctrl~=nil and ctrl ~="" then
        modifier="[ctrl]"
        ctrl=string.gsub(ctrl,"##"," "..tostring(modifier).." ##")
        macro=macro..ctrl.."\13"

    end
    if shift~=nil and shift ~="" then
        modifier="[shift]"
        shift=string.gsub(shift,"##"," "..tostring(modifier).." ##")
        macro=macro..shift.."\13"

    end
    if none~=nil and none ~="" then
        macro=macro..none.."\13"
    end
    macro=string.gsub(string.gsub(macro,"##","@"..tostring(name)),"\13","\n")
    --print(macro)
    return macro
end

