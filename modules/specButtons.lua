-- Contains specific functions relative ti the spec buttons


-- elements declarations
lb.SpecButton1 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.SpecButton1:SetSecureMode("restricted")
lb.SpecButton2 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.SpecButton2:SetSecureMode("restricted")
lb.SpecButton3 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.SpecButton3:SetSecureMode("restricted")
lb.SpecButton4 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.SpecButton4:SetSecureMode("restricted")
lb.SpecButton5 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.SpecButton5:SetSecureMode("restricted")
lb.SpecButton6 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.SpecButton6:SetSecureMode("restricted")
lb.SpecButtons={lb.SpecButton1,lb.SpecButton2,lb.SpecButton3,lb.SpecButton4,lb.SpecButton5,lb.SpecButton6 }

-- specbuttons initialization, called by event ability added and role change event
function initializeSpecButtons()
    
    -- spec 1
    lb.SpecButton1:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 25, 4)
    lb.SpecButton1:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.SpecButton1:SetWidth(24)
    lb.SpecButton1:SetHeight(24)
    lb.SpecButton1:SetLayer(2)
    -- spec2
    lb.SpecButton2:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 50, 4)
    lb.SpecButton2:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.SpecButton2:SetWidth(24)
    lb.SpecButton2:SetHeight(24)
    lb.SpecButton2:SetLayer(2)
    --spec 3
    lb.SpecButton3:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 75, 4)
    lb.SpecButton3:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.SpecButton3:SetWidth(24)
    lb.SpecButton3:SetHeight(24)
    lb.SpecButton3:SetLayer(2)
    -- spec 4
    lb.SpecButton4:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 100, 4)
    lb.SpecButton4:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.SpecButton4:SetWidth(24)
    lb.SpecButton4:SetHeight(24)
    lb.SpecButton4:SetLayer(2)
    -- spec 5
    lb.SpecButton5:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 125, 4)
    lb.SpecButton5:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.SpecButton5:SetWidth(24)
    lb.SpecButton5:SetHeight(24)
    lb.SpecButton5:SetLayer(2)
    -- spec 6
    lb.SpecButton6:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 150, 4)
    lb.SpecButton6:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.SpecButton6:SetWidth(24)
    lb.SpecButton6:SetHeight(24)
    lb.SpecButton6:SetLayer(2)

    lb.SpecButton1.Event.LeftClick="/role 1"
    lb.SpecButton2.Event.LeftClick="/role 2"
    lb.SpecButton3.Event.LeftClick="/role 3"
    lb.SpecButton4.Event.LeftClick="/role 4"
    lb.SpecButton5.Event.LeftClick="/role 5"
    lb.SpecButton6.Event.LeftClick="/role 6"

    setCurrentSpec()


end

function setCurrentSpec()
    spec =lbValues.set
    if spec~=nil then
        lb.SpecButtons[spec]:SetTexture("LifeBinder", "Textures/peton.png")
    end
end

-- spec buttons mouse events
----------------------------------1---------------------------                ~
function lb.SpecButton1.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.SpecButton1:SetTexture("LifeBinder", "Textures/petonin.png")
   -- end
end
function lb.SpecButton1.Event:MouseOut()
    if (lbValues.set~=1) then
        lb.SpecButton1:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.SpecButton1:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------2---------------------------
function lb.SpecButton2.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.SpecButton2:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.SpecButton2.Event:MouseOut()
    if (lbValues.set~=2) then
        lb.SpecButton2:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.SpecButton2:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------3---------------------------
function lb.SpecButton3.Event:MouseIn()
   -- if not lbValues.isincombat then
        lb.SpecButton3:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.SpecButton3.Event:MouseOut()
    if (lbValues.set~=3)then
        lb.SpecButton3:SetTexture("LifeBinder", "Textures/petoff.png")

    else
        lb.SpecButton3:SetTexture("LifeBinder", "Textures/peton.png")
    end
end


----------------------------------4---------------------------
function lb.SpecButton4.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.SpecButton4:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.SpecButton4.Event:MouseOut()
    if  (lbValues.set~=4)then
        lb.SpecButton4:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.SpecButton4:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------5---------------------------
function lb.SpecButton5.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.SpecButton5:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.SpecButton5.Event:MouseOut()
    if  (lbValues.set~=5)then
        lb.SpecButton5:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.SpecButton5:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------3---------------------------
function lb.SpecButton6.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.SpecButton6:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.SpecButton6.Event:MouseOut()
    if(lbValues.set~=6)then
        lb.SpecButton6:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.SpecButton6:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
function showSpecButtons()
    for i = 1 ,6 do
        lb.SpecButtons[i]:SetVisible(true)
    end
end
function hideSpecButtons()
    for i = 1 ,6 do
        lb.SpecButtons[i]:SetVisible(false)
    end
end