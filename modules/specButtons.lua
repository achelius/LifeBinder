-- Contains specific functions relative ti the spec buttons

lb.specButtons={}

-- elements declarations
lb.specButtons.SpecButton1 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.specButtons.SpecButton1:SetSecureMode("restricted")
lb.specButtons.SpecButton2 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.specButtons.SpecButton2:SetSecureMode("restricted")
lb.specButtons.SpecButton3 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.specButtons.SpecButton3:SetSecureMode("restricted")
lb.specButtons.SpecButton4 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.specButtons.SpecButton4:SetSecureMode("restricted")
lb.specButtons.SpecButton5 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.specButtons.SpecButton5:SetSecureMode("restricted")
lb.specButtons.SpecButton6 = UI.CreateFrame("Texture", "CloseButton", lb.Window)
lb.specButtons.SpecButton6:SetSecureMode("restricted")
lb.specButtons.SpecButtons={lb.specButtons.SpecButton1,lb.specButtons.SpecButton2,lb.specButtons.SpecButton3,lb.specButtons.SpecButton4,lb.specButtons.SpecButton5,lb.specButtons.SpecButton6 }

-- specbuttons initialization, called by event ability added and role change event
function initializeSpecButtons()
    
    -- spec 1
    lb.specButtons.SpecButton1:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 25, 4)
    lb.specButtons.SpecButton1:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.specButtons.SpecButton1:SetWidth(24)
    lb.specButtons.SpecButton1:SetHeight(24)
    lb.specButtons.SpecButton1:SetLayer(2)
    -- spec2
    lb.specButtons.SpecButton2:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 50, 4)
    lb.specButtons.SpecButton2:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.specButtons.SpecButton2:SetWidth(24)
    lb.specButtons.SpecButton2:SetHeight(24)
    lb.specButtons.SpecButton2:SetLayer(2)
    --spec 3
    lb.specButtons.SpecButton3:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 75, 4)
    lb.specButtons.SpecButton3:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.specButtons.SpecButton3:SetWidth(24)
    lb.specButtons.SpecButton3:SetHeight(24)
    lb.specButtons.SpecButton3:SetLayer(2)
    -- spec 4
    lb.specButtons.SpecButton4:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 100, 4)
    lb.specButtons.SpecButton4:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.specButtons.SpecButton4:SetWidth(24)
    lb.specButtons.SpecButton4:SetHeight(24)
    lb.specButtons.SpecButton4:SetLayer(2)
    -- spec 5
    lb.specButtons.SpecButton5:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 125, 4)
    lb.specButtons.SpecButton5:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.specButtons.SpecButton5:SetWidth(24)
    lb.specButtons.SpecButton5:SetHeight(24)
    lb.specButtons.SpecButton5:SetLayer(2)
    -- spec 6
    lb.specButtons.SpecButton6:SetPoint("TOPLEFT", lb.WindowFrameTop, "TOPLEFT", 150, 4)
    lb.specButtons.SpecButton6:SetTexture("LifeBinder", "Textures/petoff.png")
    lb.specButtons.SpecButton6:SetWidth(24)
    lb.specButtons.SpecButton6:SetHeight(24)
    lb.specButtons.SpecButton6:SetLayer(2)

    lb.specButtons.SpecButton1.Event.LeftClick="/role 1"
    lb.specButtons.SpecButton2.Event.LeftClick="/role 2"
    lb.specButtons.SpecButton3.Event.LeftClick="/role 3"
    lb.specButtons.SpecButton4.Event.LeftClick="/role 4"
    lb.specButtons.SpecButton5.Event.LeftClick="/role 5"
    lb.specButtons.SpecButton6.Event.LeftClick="/role 6"
    


    setCurrentSpec()


end

function setCurrentSpec()
    spec =lbValues.set
    if spec~=nil then
        lb.specButtons.SpecButtons[spec]:SetTexture("LifeBinder", "Textures/peton.png")
    end
end

function lb.specButtons.onMouseIn(index)
	lb.specButtons.SpecButtons[index]:SetTexture("LifeBinder", "Textures/petonin.png")
end

-- spec buttons mouse events
----------------------------------1---------------------------                ~
function lb.specButtons.SpecButton1.Event:MouseIn()
    --if not lbValues.isincombat then
        
   -- end
end
function lb.specButtons.SpecButton1.Event:MouseOut()
    if (lbValues.set~=1) then
        lb.specButtons.SpecButton1:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.specButtons.SpecButton1:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------2---------------------------
function lb.specButtons.SpecButton2.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.specButtons.SpecButton2:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.specButtons.SpecButton2.Event:MouseOut()
    if (lbValues.set~=2) then
        lb.specButtons.SpecButton2:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.specButtons.SpecButton2:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------3---------------------------
function lb.specButtons.SpecButton3.Event:MouseIn()
   -- if not lbValues.isincombat then
        lb.specButtons.SpecButton3:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.specButtons.SpecButton3.Event:MouseOut()
    if (lbValues.set~=3)then
        lb.specButtons.SpecButton3:SetTexture("LifeBinder", "Textures/petoff.png")

    else
        lb.specButtons.SpecButton3:SetTexture("LifeBinder", "Textures/peton.png")
    end
end


----------------------------------4---------------------------
function lb.specButtons.SpecButton4.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.specButtons.SpecButton4:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.specButtons.SpecButton4.Event:MouseOut()
    if  (lbValues.set~=4)then
        lb.specButtons.SpecButton4:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.specButtons.SpecButton4:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------5---------------------------
function lb.specButtons.SpecButton5.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.specButtons.SpecButton5:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.specButtons.SpecButton5.Event:MouseOut()
    if  (lbValues.set~=5)then
        lb.specButtons.SpecButton5:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.specButtons.SpecButton5:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
----------------------------------3---------------------------
function lb.specButtons.SpecButton6.Event:MouseIn()
    --if not lbValues.isincombat then
        lb.specButtons.SpecButton6:SetTexture("LifeBinder", "Textures/petonin.png")
    --end
end
function lb.specButtons.SpecButton6.Event:MouseOut()
    if(lbValues.set~=6)then
        lb.specButtons.SpecButton6:SetTexture("LifeBinder", "Textures/petoff.png")
    else
        lb.specButtons.SpecButton6:SetTexture("LifeBinder", "Textures/peton.png")
    end
end
function lb.specButtons.showAll()
    for i = 1 ,6 do
        lb.specButtons.SpecButtons[i]:SetVisible(true)
    end
end
function lb.specButtons.hideAll()
    for i = 1 ,6 do
        lb.specButtons.SpecButtons[i]:SetVisible(false)
    end
end