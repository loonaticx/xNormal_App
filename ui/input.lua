--[[
	xNormal LUA utils
	(c) 2005-2018 S.Orgaz.
--]]

-- ---------------------------------------------------------------------------------------------	
-- Inpout state ( xNormal will update this structure each frame with the current input state )
-- ---------------------------------------------------------------------------------------------
inputState =
{
	F1Released = false,	-- true if the user just released the F1 key
	F8Released = false, -- true if the user just released the F8 key
	F9Released = false, -- true if the user just released the F9 key
	
	mouseX = 0, -- mouse X position in screen coordinates(top-left origin)
	mouseY = 0, -- mouse Y position in screen coordinates(top-left origin)
	
	mouseLeftButtonDown = false,	 -- true if the mouse left button is pressed at the moment
	mouseLeftButtonReleased = false,  -- true if the mouse left button is juast released
	
	mouseRightButtonDown = false	 -- true if the mouse right button is pressed at the moment
}
