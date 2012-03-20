function setMouseActions()
    if rhbValues.set==nil then return end
    if rhbValues.isincombat then return end
    local associations =rhbMacroButton[rhbValues.set]
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
                --if i==1 then print   ("left"..generateMacro(value,fname))end
                rhb.groupMask[i].Event.LeftDown=generateMacro(value,fname)
            elseif key==2 then
                -- righeclick
                --if i==1 then print   ("right"..generateMacro(value,fname))end
                rhb.groupMask[i].Event.RightDown=generateMacro(value,fname)
            elseif key==3 then
                -- middleclick
                --print(generateMacro(value,fname))
                rhb.groupMask[i].Event.MiddleDown=generateMacro(value,fname)
            elseif key==4 then
                -- mouse4
                --print(generateMacro(value,fname))
                rhb.groupMask[i].Event.Mouse4Down=generateMacro(value,fname)
            elseif key==5 then
                -- mouse5
                --print(generateMacro(value,fname))
                rhb.groupMask[i].Event.Mouse5Down=generateMacro(value,fname)
            end

        end
    end

end

function generateMacro(associations,name)
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

