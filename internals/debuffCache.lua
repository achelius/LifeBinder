-- Saves Debuffs into a list
local DebuffCaching=false


function addDebuffToCache(debuff)
    if DebuffCacheList==nil then DebuffCacheList={} end
    while DebuffCaching do

    end
    DebuffCaching=true
    if rhbValues.CacheDebuffs then

       if debuff==nil then return end
       if DebuffCacheList==nil then DebuffCacheList={} end
       local name = debuff.name
       if DebuffCacheList[name]==nil then
           DebuffCacheList[name]={}
           DebuffCacheList[name][1]=debuff.id
           DebuffCacheList[name][2]=debuff.description
           DebuffCacheList[name][3]=debuff.icon
       end
    end
    DebuffCaching=false
end
function getDebuffFromCache(name)
    if DebuffCacheList==nil then DebuffCacheList={}end
    if name==nil then return nil end
    return DebuffCacheList[name]
end
function getDebuffCacheNames()
    if DebuffCacheList==nil then DebuffCacheList={}end
    local names={}
    local counter=1
    for dname, debuffinfo in pairs(DebuffCacheList) do
         names[counter]=dname
        counter=counter+1
    end
    return names
end
function DebuffCacheClear()
    --print ("clear")
    DebuffCacheList=nil
end

