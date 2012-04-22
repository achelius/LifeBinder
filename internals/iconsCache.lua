
lb.iconsCache={} --icon cache table
lb.iconsCacheCount=0 --icon cache count
lb.iconsCache.Icons={}
lb.NoIconsBuffList={} --list of buffs that doesn't have an icon because are not abilities, created by the functionCompileBuffsList() in buffmonitor.lua
function lb.iconsCache.getTextureFromCache(abilityName)
    local texture= lb.iconsCache.Icons[abilityName]
    if texture==nil then
        texture={"LifeBinder","Textures/buffhot.png"}
    end
    return texture
end

function lb.iconsCache.hasTextureInCache(abilityName)
    if lb.iconsCache.Icons[abilityName]==nil then
        return false
    else
        return true
    end

end

function lb.iconsCache.addTextureToCache(abilityName,textureLocation,texturePath)
    if not lb.iconsCache.hasTextureInCache(abilityName) then
        lb.iconsCache.Icons[abilityName]={textureLocation,texturePath }
        lb.iconsCacheCount=lb.iconsCacheCount+1
        lb.iconsCache.removeFromNoIconList(abilityName)
    end
end

function lb.iconsCache.removeFromNoIconList(abilityname)
    if lb.NoIconsBuffList[a]~=nil then
        lb.NoIconsBuffList[a]=nil
        --print (a)
    end
end
