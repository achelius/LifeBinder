-- Saves Debuffs into a list
local DebuffCaching=false


function addDebuffToCache(debuff)
    if lbDebuffCacheList==nil then lbDebuffCacheList={} end
    while DebuffCaching do

    end
    DebuffCaching=true
    
    if lbValues.CacheDebuffs then
	  
       if debuff==nil then return end
       if lbDebuffCacheList==nil then lbDebuffCacheList={} end
       local name = debuff.name
       lbDebuffCacheList[name]={debuff.id,debuff.description,debuff.icon}
    end
    DebuffCaching=false
end
function getDebuffFromCache(name)
    if lbDebuffCacheList==nil then lbDebuffCacheList={}end
    if name==nil then return nil end
    return lbDebuffCacheList[name]
end
function getDebuffCacheNames()
    if lbDebuffCacheList==nil then lbDebuffCacheList={}end
    local names={}
    local counter=1
    for dname, debuffinfo in pairs(lbDebuffCacheList) do
         names[counter]=dname
        counter=counter+1
    end
    return names
end
function DebuffCacheClear()
    --print ("clear")
    lbDebuffCacheList={}
end

