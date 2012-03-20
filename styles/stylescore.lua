
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

function initializeStylesCore()
    -- styles table
    rhb.styles={}
end

