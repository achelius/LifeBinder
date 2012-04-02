lb.customNames={}

function lb.customNames.addCustomName(name)
    if lbCustomNamesList==nil then lbCustomNamesList={} end
    if name==nil then return end
   
    if lbCustomNamesList[name]==nil then
         lbCustomNamesList[name]={}
    end
end
function lb.customNames.removeCustomName(name)
	if lbCustomNamesList==nil then lbCustomNamesList={} end
    if name==nil then return end
    if lbCustomNamesList[name]~=nil then
         lbCustomNamesList[name]=nil
    end
end
function lb.customNames.getCustomName(name)
    if lbCustomNamesList==nil then lbCustomNamesList={}end
    if name==nil then return nil end
    return lbCustomNamesList[name]
end

function lb.customNames.getCustomNames()
    if lbCustomNamesList==nil then lbCustomNamesList={}end
    local names={}
    local counter=1
    for dname, ph in pairs(lbCustomNamesList) do
         names[counter]=dname
        counter=counter+1
    end
    return names
end

function lb.customNames.clear()
    --print ("clear")
    lbCustomNamesList={}
end

