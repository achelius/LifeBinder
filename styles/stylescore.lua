
--planned functions:
--initializeStylesCore   > initializes the styles container and do other initializations and controls
--scanForStyles   > scans for styles (depends from the implementation I choose: separate addons for styles or just integrated with the main project)
--addStyleToMemory(initializeFunction, drawFunction, resetFunctions)  > to be defined more specifically when implementing the styles files
--applyStyle(styleName) > executes the relative function of the style
--initializeStyle(styleName) > executes the relative function of the style
--resetStyle(styleName) > executes the relative function of the style

--Functions called outside initialization
--setHealth(styleName,unit) > send health value to the style, to  let draw like it wants (ex: horizontal or vertical or other weird ways)
-- for the other statuses:
--first option
--      setStatus(styleName,unit) > value type to be defined
--second option
--      setAggro(styleName,unit) > set aggro status
--      setLos(styleName,unit) > set los status
--      setOor(styleName,unit) > set oor status (will not be implemented before 1.8)
--      setDisconnected(styleName,unit) > set disconnected status
lb.currentStyle=nil -- name of the current style, different from the lbValues.CurrentStyle because i have to consider future disable addons

function lb.styles.initializeStylesCore()
    -- styles table
    
end

function lb.styles.applySelectedStyle()
	if lb.styles.hasStyle(lbValues.CurrentStyle) then
		lb.currentStyle=lbValues.CurrentStyle
	else
		print("style:"..tostring(lbValues.CurrentStyle).." not found, using standard")
		lb.currentStyle="standard"		
	end
	
	lb.styles.applyStyle(lb.currentStyle)
	
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

function lb.styles.getStyleOptions(styleName)
	if lb.styles.hasStyle(lbValues.CurrentStyle) then
		lb.currentStyle=lbValues.CurrentStyle
	else
		print("style:"..tostring(lbValues.CurrentStyle).." not found, using standard")
		lb.currentStyle="standard"		
	end
end

function lb.styles.applyStyle(styleName)
	lb.styles[styleName].initialize()
end





