-- Contains specific functions relative ti the spec buttons


-- elements declarations
rhb.SpecButton1 = UI.CreateFrame("Texture", "CloseButton", rhb.Window)
rhb.SpecButton1:SetSecureMode("restricted")
rhb.SpecButton2 = UI.CreateFrame("Texture", "CloseButton", rhb.Window)
rhb.SpecButton2:SetSecureMode("restricted")
rhb.SpecButton3 = UI.CreateFrame("Texture", "CloseButton", rhb.Window)
rhb.SpecButton3:SetSecureMode("restricted")
rhb.SpecButton4 = UI.CreateFrame("Texture", "CloseButton", rhb.Window)
rhb.SpecButton4:SetSecureMode("restricted")
rhb.SpecButton5 = UI.CreateFrame("Texture", "CloseButton", rhb.Window)
rhb.SpecButton5:SetSecureMode("restricted")
rhb.SpecButton6 = UI.CreateFrame("Texture", "CloseButton", rhb.Window)
rhb.SpecButton6:SetSecureMode("restricted")
rhb.SpecButtons={rhb.SpecButton1,rhb.SpecButton2,rhb.SpecButton3,rhb.SpecButton4,rhb.SpecButton5,rhb.SpecButton6 }

-- specbuttons initialization, called by event ability added and role change event
function initializeSpecButtons()
    
    -- spec 1
    rhb.SpecButton1:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 25, 4)
    rhb.SpecButton1:SetTexture("RiftHbot", "Textures/petoff.png")
    rhb.SpecButton1:SetWidth(24)
    rhb.SpecButton1:SetHeight(24)
    rhb.SpecButton1:SetLayer(2)
    -- spec2
    rhb.SpecButton2:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 50, 4)
    rhb.SpecButton2:SetTexture("RiftHbot", "Textures/petoff.png")
    rhb.SpecButton2:SetWidth(24)
    rhb.SpecButton2:SetHeight(24)
    rhb.SpecButton2:SetLayer(2)
    --spec 3
    rhb.SpecButton3:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 75, 4)
    rhb.SpecButton3:SetTexture("RiftHbot", "Textures/petoff.png")
    rhb.SpecButton3:SetWidth(24)
    rhb.SpecButton3:SetHeight(24)
    rhb.SpecButton3:SetLayer(2)
    -- spec 4
    rhb.SpecButton4:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 100, 4)
    rhb.SpecButton4:SetTexture("RiftHbot", "Textures/petoff.png")
    rhb.SpecButton4:SetWidth(24)
    rhb.SpecButton4:SetHeight(24)
    rhb.SpecButton4:SetLayer(2)
    -- spec 5
    rhb.SpecButton5:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 125, 4)
    rhb.SpecButton5:SetTexture("RiftHbot", "Textures/petoff.png")
    rhb.SpecButton5:SetWidth(24)
    rhb.SpecButton5:SetHeight(24)
    rhb.SpecButton5:SetLayer(2)
    -- spec 6
    rhb.SpecButton6:SetPoint("TOPLEFT", rhb.WindowFrameTop, "TOPLEFT", 150, 4)
    rhb.SpecButton6:SetTexture("RiftHbot", "Textures/petoff.png")
    rhb.SpecButton6:SetWidth(24)
    rhb.SpecButton6:SetHeight(24)
    rhb.SpecButton6:SetLayer(2)

    rhb.SpecButton1.Event.LeftClick="/role 1"
    rhb.SpecButton2.Event.LeftClick="/role 2"
    rhb.SpecButton3.Event.LeftClick="/role 3"
    rhb.SpecButton4.Event.LeftClick="/role 4"
    rhb.SpecButton5.Event.LeftClick="/role 5"
    rhb.SpecButton6.Event.LeftClick="/role 6"

    setCurrentSpec()


end

function setCurrentSpec()
    spec =rhbValues.set
    if spec~=nil then
        rhb.SpecButtons[spec]:SetTexture("RiftHbot", "Textures/peton.png")
    end
end

-- spec buttons mouse events
----------------------------------1---------------------------                ~
function rhb.SpecButton1.Event:MouseIn()
    --if not rhbValues.isincombat then
        rhb.SpecButton1:SetTexture("RiftHbot", "Textures/petonin.png")
   -- end
end
function rhb.SpecButton1.Event:MouseOut()
    if (rhbValues.set~=1) then
        rhb.SpecButton1:SetTexture("RiftHbot", "Textures/petoff.png")
    else
        rhb.SpecButton1:SetTexture("RiftHbot", "Textures/peton.png")
    end
end
----------------------------------2---------------------------
function rhb.SpecButton2.Event:MouseIn()
    --if not rhbValues.isincombat then
        rhb.SpecButton2:SetTexture("RiftHbot", "Textures/petonin.png")
    --end
end
function rhb.SpecButton2.Event:MouseOut()
    if (rhbValues.set~=2) then
        rhb.SpecButton2:SetTexture("RiftHbot", "Textures/petoff.png")
    else
        rhb.SpecButton2:SetTexture("RiftHbot", "Textures/peton.png")
    end
end
----------------------------------3---------------------------
function rhb.SpecButton3.Event:MouseIn()
   -- if not rhbValues.isincombat then
        rhb.SpecButton3:SetTexture("RiftHbot", "Textures/petonin.png")
    --end
end
function rhb.SpecButton3.Event:MouseOut()
    if (rhbValues.set~=3)then
        rhb.SpecButton3:SetTexture("RiftHbot", "Textures/petoff.png")

    else
        rhb.SpecButton3:SetTexture("RiftHbot", "Textures/peton.png")
    end
end


----------------------------------4---------------------------
function rhb.SpecButton4.Event:MouseIn()
    --if not rhbValues.isincombat then
        rhb.SpecButton4:SetTexture("RiftHbot", "Textures/petonin.png")
    --end
end
function rhb.SpecButton4.Event:MouseOut()
    if  (rhbValues.set~=4)then
        rhb.SpecButton4:SetTexture("RiftHbot", "Textures/petoff.png")
    else
        rhb.SpecButton4:SetTexture("RiftHbot", "Textures/peton.png")
    end
end
----------------------------------5---------------------------
function rhb.SpecButton5.Event:MouseIn()
    --if not rhbValues.isincombat then
        rhb.SpecButton5:SetTexture("RiftHbot", "Textures/petonin.png")
    --end
end
function rhb.SpecButton5.Event:MouseOut()
    if  (rhbValues.set~=5)then
        rhb.SpecButton5:SetTexture("RiftHbot", "Textures/petoff.png")
    else
        rhb.SpecButton5:SetTexture("RiftHbot", "Textures/peton.png")
    end
end
----------------------------------3---------------------------
function rhb.SpecButton6.Event:MouseIn()
    --if not rhbValues.isincombat then
        rhb.SpecButton6:SetTexture("RiftHbot", "Textures/petonin.png")
    --end
end
function rhb.SpecButton6.Event:MouseOut()
    if(rhbValues.set~=6)then
        rhb.SpecButton6:SetTexture("RiftHbot", "Textures/petoff.png")
    else
        rhb.SpecButton6:SetTexture("RiftHbot", "Textures/peton.png")
    end
end
function showSpecButtons()
    for i = 1 ,6 do
        rhb.SpecButtons[i]:SetVisible(true)
    end
end
function hideSpecButtons()
    for i = 1 ,6 do
        rhb.SpecButtons[i]:SetVisible(false)
    end
end