

lb.currentStyle=nil -- name of the current style, different from the lbValues.CurrentStyle because i have to consider future disable addons

function lb.styles.initializeStylesCore()
    -- styles table
    if lbValues.CurrentStyle=="oldstyle" then
		lbValues.CurrentStyle="standard"
	end
end

function lb.styles.applySelectedStyle()
	if lbValues.CurrentStyle=="oldstyle" then
		lbValues.CurrentStyle="standard"
	end
	if lb.styles.hasStyle(lbValues.CurrentStyle) then
		lb.currentStyle=lbValues.CurrentStyle
	else
		print("style:"..tostring(lbValues.CurrentStyle).." not found, using standard")
		lb.currentStyle="standard"		
	end
	
	lb.styles.applyStyle(lb.currentStyle)
	
end
function lb.styles.styleFirstInitialization()
	if lbValues.CurrentStyle=="oldstyle" then
		lbValues.CurrentStyle="standard"
	end
	if lb.styles.hasStyle(lbValues.CurrentStyle) then
		lb.currentStyle=lbValues.CurrentStyle
	else
		print("style:"..tostring(lbValues.CurrentStyle).." not found, using standard")
		lb.currentStyle="standard"		
	end
	
	lb.styles.firstInitialize(lb.currentStyle)
end

function lb.styles.styleOnPlayerReady()
	if lbValues.CurrentStyle=="oldstyle" then
		lbValues.CurrentStyle="standard"
	end
	if lb.styles.hasStyle(lbValues.CurrentStyle) then
		lb.currentStyle=lbValues.CurrentStyle
	else
		print("style:"..tostring(lbValues.CurrentStyle).." not found, using standard")
		lb.currentStyle="standard"		
	end
	
	lb.styles.onPlayerReady(lb.currentStyle)
end

function lb.styles.hasStyle(styleName)
	for stid, style in pairs(lb.styles) do
		if stid==styleName then
			return true
		end
	end
	return false	
end 
function lb.styles.hasStyleOptions(styleName)
	for stid, style in pairs(lbStylesOptions) do
		if stid==styleName then
			return true
		end
	end
	return false	
end 

function lb.styles.getConfiguration(styleName)
	if lbStylesOptions[styleName]==nil then  lbStylesOptions[styleName]={} end
	return lbStylesOptions[styleName]
end 
function lb.styles.getCurrentStyleName()
	return lb.currentStyle	
end

function lb.styles.setCurrentStyleName(stylename)
	lbValues.CurrentStyle=stylename	
	lb.currentStyle	=stylename
end

function lb.styles.applyStyle(styleName)
	lb.styles[styleName].fastInitialize()
end
function lb.styles.firstInitialize(styleName)
	lb.styles[styleName].firstInitialization()
end

function lb.styles.onPlayerReady(styleName)
	lb.styles[styleName].onPlayerReady()
end


