--[[
	xNormal default LUA interface
	(c) 2005-2018 S.Orgaz.
--]]

-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------
-- xNormal exports to LUA the following functions:
--
--		xn_break_cage_selection()	-> Make the extrusion direction equal to the vertex normal
--
--		xn_average_cage_selection()	-> Make the extrusion direction equal to the vertex normal (averaged)
--
--		xn_set_show_vdm_seams([bool])	 -> Show vector displacement mapping seams
--		[bool]xn_get_show_vdm_seams()   -> Returns TRUE if the VDM seams must be drawn of FALSE if not
--
--		[bool]xn_get_max_tessellation_level()	 -> Get [number] with the maximum tessellation level
--		xn_set_max_tessellation_level([number]tl) -> Set the maximum tessellation level in range [0,6]
--
--		[bool]xn_get_show_blockers()	 -> Get [bool] with the show blockers as initial settings
--		xn_set_show_blockers([bool]show) -> Show blockers or not
--
--		[bool]xn_get_ssao_enabled() -> Get is the SSAO is enabled or disabled
--		xn_set_ssao_enabled([bool]enable) -> Enable or disable SSAO
--
--		[number]xn_get_ssao_blur_size() -> Returns the SSAO blur size, in pixels
--		xn_set_ssao_blur_size([number]bs) -> Set the SSAO blur size, in pixels
--
--		[number]xn_get_ssao_bright() -> Returns the SSAO bright in range [0,4]
--		xn_set_ssao_bright([number]b) -> Set the SSAO bright in range [0,4]
--
--		[number]xn_get_ssao_contrast() -> Returns the SSAO contrast in range [0,4]
--		xn_set_ssao_contrast([number]c) -> Set the SSAOcontrast in range [0,4]
--
--		[number]xn_get_ssao_atten() -> Returns the SSAO atten in range [0,2]
--		xn_set_ssao_atten([number]atten) -> Set the SSAO atten in range [0,2]
--
--		[number]xn_get_ssao_radius() -> Returns the SSAO radius(relative to the model set) in range [0,1]
--		xn_set_ssao_radius([number]radius) -> Set the SSAO radius(relative to the model set) in range [0,1]
--
--		[r,g,b]xn_get_light_secondary_color()	->	Returns the current light secondary color as RGB 3 component variable stack (in sRGB)
--		xn_set_light_secondary_color(r,g,b) -> Sets the light secondary color with RGB colors in [0,1] range (in sRGB)
--
--		[r,g,b]xn_get_light_tertiary_color()	->	Returns the current light tertiary color as RGB 3 component variable stack  (in sRGB)
--		xn_set_light_tertiary_color(r,g,b) -> Sets the light tertiary color with RGB colors in [0,1] range  (in sRGB)
--
--		[number]xn_get_hdr_threshold() -> Get the HDR threshold intensity in range [0,1]
--		xn_set_hdr_threshold([number]) -> Set the HDR threshold intensity in range [0,1]. Any value in the
--							framebuffer greater or equal to that will "glow"
--
--		[number]xn_get_exposure() -> Get the HDR exposure intensity in range [0,1]
--		xn_set_exposure([number]) -> Set the HDR exposure intensity in range [0,1]
--
--      [number]xn_get_maximum_cage_extrussion() -> Return the maximum cage extrussion for the model set
--
--
--      [bool] xn_is_video_capture_enabled() -> Return TRUE if is enabled of FALSE if not
--      xn_enable_video_capture([bool]enable) -> Enable or disable video capture
--
--      [bool] xn_get_camera_autocenter() ->Get the camera autocenter status
--      xn_set_camera_autocenter([bool]enable) -> Enable/disable camera center to the mass center of all the meshes
--      
--      xn_set_reel_mode ([number, 0=camera, 1=light]camOrLight,[bool]enable) -> Enables or disables the demo reel mode
--
--		[bool]xn_is_gamepad_in_use() -> Return TRUE if the user is using a Xbox 360 gamepad controller or FALSE if
--									is using keyboard+mouse
--
--		xn_draw_cursor(x,y,width,
--			height,texFile,colR,colG,
--			colB,colA,startU,startV,
--			endU,endV)					->	Draw the cursor in the screen. Screen origin is at TOP-LEFT. Colors are in sRGB
--
--
--		xn_frameAll() -> Auto-positions camera and light to frame all the scene
--
--		xn_set_camera_orbit_distance([number]dist) -> Sets the camera orbiting distance. Usually this value goes in range [0,1] and is relative to the far distance
--
--		[number]xn_get_camera_orbit_distance() -> Gets the camera orbiting distance. Usually this value goes in range [0,1] and is relative to the far distance
--
--		[string]xn_get_string([string]id) -> Get a string from the current localization file
--
--		[bool]xn_is_rightToLeftCulture() -> Get if we are using a right-to-left culture like Arabic or not
--
--		[bool,number,number,number] 
--		xn_color_browse([number]oldR,[number]oldG,[number]oldB) -> Open a color dialog and return 3 numbers with the colors
--													selected. These colors are in range [0.0,1.0], the boolean is
--													"true" if the user selected a color or "false" if aborted(and in
--													this case the colors will be all 1.0). Colors are in sRGB space, 
--													not in linear-space
--
--		xn_reset_cage_selection()	-> Reset cage vertex extrussion 
--
--      xn_clear_selection()				-> Clear the selected vertices in the cage
--
--		[number]xn_get_fps()				-> Get the FPS(frames per second)
--
--		[number]xn_get_shadow_area()		-> Get the initial shadows area light radius
--
--		xn_set_shadow_area([number]area)	-> Set the shadows area light radius(relative to modelRadio/50).
--											Usually this value in range [0,1]
--
--		[number]xn_get_shadow_bias()		-> Get the initial shadows bias
--
--		xn_set_shadow_bias([number]bias)	-> Set the shadows bias. Usually this value in range [0,1]
--
--		[bool]xn_get_cast_shadows()			   -> Get the initial cast-shadows value
--	    xn_set_cast_shadows([bool]castShadows) -> Set if you want to cast shadows or not
--
--		[number]xn_get_diffuseGI_intensity() -> Get the diffuse global illumination cubemap intensity ( in range [0,1] )
--
--		xn_set_diffuseGI_intensity(
--			[number]intensity )				-> Set the diffuse global illumination cubemap intensity ( in range [0,1] )
--
--		xn_disable_fresnel([boolean])		-> Disable fresnel reflections
--
--		xn_save_meshes()					-> Save all the lowpoly meshes
--
--		xn_get_ui_path()					-> Get the UI path. Useful to call "require" lua keyword.
--											   It ALWAYS ends with the directory separator char ( "\" or "/" )
--
--		[number]xn_get_camera_rotation_sensibility()	-> Get the the camera mouse rotation sensibility(modulate factor)
--		
--		xn_set_camera_rotation_sensibility
--			([number]sens)					-> Set the camera mouse rotation sensibility(modulate factor)
--
--
--		[number]xn_get_camera_advance_sensibility()	-> Get the the camera advance sensibility(modulate factor)
--		
--		xn_set_camera_advance_sensibility
--			([number]sens)						-> Set the camera mouse advance sensibility(modulate factor)
--
--		[number]xn_get_numtris_alpha_sorted()	-> Get the number of alpha-sorted triangles rendered.
--
--		xn_set_glow_intensity([number]i)		-> Set glow intensity in range [0,5]
--		
--		[number]xn_get_glow_intensity()			-> Get initial intensity for glow in range [0,5]
--
--		xn_cage_extrude([number]units)			-> Extrude the cage a [number] units
--
--		xn_cage_selection_extrude([number])		-> Extrude the current selected vertices a [number] units
--
--		xn_set_edit_cage([bool])				-> Edit or not the cage. 
--
--		xn_set_show_cage(,[bool])				-> Show or not the cage
--
--		xn_get_cage_opacity ()					-> Get the cage opacity in range [0,1]. 
--		
--		xn_set_cage_opacity ([number]opacity)	-> Set the cage opacity in range [0,1]. 
--
--		{r=,g=,b=} xn_get_cage_color(
--				[number])					-> Get the cage color as a table in format {r=[0,1],g=[0,1],b=[0,1]}
--											   Use 0 as param for front cage and 1 for back cage	
--
--		xn_set_cage_color([table])	        -> Set the cage color(in sRGB) as a table in format {r=[0,1],g=[0,1],b=[0,1]}.
--
--		xn_set_show_lowpolys([bool])		-> Set if we must show the lowpolygon models or not
--
--		xn_set_show_highpolys([bool])		-> Set if we must show the highpolygon models or not
--
--		xn_set_show_ao([bool])	            -> Set if we must show the (matte) models ambient occlusion
--
--		xn_get_ntris_high()					-> Get the total triangles of the highpoly models
--
--		xn_take_screenshot()				-> Take a screenshot and put in in the xN_screenshots folder
--
--		xn_get_used_vram()					-> Get the approximate VRAM used in bytes. It includes ONLY
--											   the textures + meshes. The framebuffer and depth buffer is NOT
--											   included in the computation.
--
--		xn_reload_textures()				-> Reload the mesh textures
--
--		xn_reload_models()					-> Reload the mesh 3d models
--
--		[number,number] xn_measure_text()	-> Get [number,width], [number,height] with the text size
--
--		xn_get_parallax_strength()			-> Get the initial parallax strength factor from the settings
--											   This will be always in range [0,1]
--
--		xn_set_parallax_strength([number])	-> Set the parallax strength factor in range [0,1].
--
--		xn_get_screen_width()				-> Get the total screen width
-- 
--		xn_get_screen_height()				-> Get the total screen height
--
--		xn_get_models_max_radius()			-> Get the max radius of all the loaded models
--
--		[r,g,b] xn_get_grid_color()	-> Get the grid color as RGB in range [0,1]
--
--		xn_set_grid_color([number]r,[number]g,[number]b)	-> Set the grid color as RGB in range [0,1]
--
--		[r,g,b]xn_get_background_color()	-> Get the background color (in sRGB)
--
--		xn_set_background_color(r,g,b)		-> Set the background color as RGB in range [0,1] (in sRGB)
--
--		xn_get_show_tangent_basis()			-> Get [bool] with the tangent basis check as initial settings
--
--		xn_set_show_tangent_basis(show)		-> Show tangent, normal and binormals for the model if the
--											   'show' param is true
--
--		xn_get_show_wireframe()				-> Get [bool] with the show wireframe as initial settings
--
--		xn_set_show_wireframe(show)			-> Show wireframed model when 'show' is true
--
--		xn_get_show_starfield()				-> Get [bool] with the show starfield check as initial settings
--		xn_set_show_starfield([bool]show)	-> Show the starfield when 'show' param is true
--
--		xn_get_show_grid()					-> Get [bool] with the show grid check as initial settings
--		xn_set_show_grid([bool]show)		-> Show the grid and origin matrix when 'show' param is true
--
--		xn_get_show_normals()				-> Get [bool] with the show normals check as initial settings
--
--		xn_set_show_normals(show)			->  Show normals on model when 'show' param is true
--
--		xn_get_camera_position()			->	Returns the current camera position as a table {x=,y=,z=}
--
--		xn_get_light_position()				->	Returns the current light position as a table {x=,y=,z=}
--
--		xn_set_light_position([table]p)		->	Sets the current light position using a table {x=,y=,z=}
--
--
--		xn_get_light_indirect_intensity()			->	Get the light indirect intensity in range [0,2] as a number
--		xn_set_light_indirect_intensity(val)			->	Set the light indirect intensity. 'val' is a [number] in range [0,2]
--
--		xn_get_light_intensity()			->	Get the light intensity in range [0,2] as a number
--		xn_set_light_intensity(val)			->	Set the light intensity. 'val' is a [number] in range [0,2]
--
--		[r,g,b]xn_get_light_ambient_color()	->	Returns the current light ambient color as 3 RGB stacked variables
--
--		xn_set_light_ambient_color(r,g,b)   ->	Sets the current light ambient color using sRGB
--
--		[r,g,b]xn_get_light_diffuse_color()	->	Returns the current light diffuse color as 3 sRGB stacked variables
--
--		xn_set_light_diffuse_color(r,g,b)   ->  Sets the current light diffuse color using sRGB values in range [0,1]
--
--		[r,g,b]xn_get_light_specular_color()	->	Returns the current light specular color as sRGB 3 component variable stack
--
--		xn_set_light_specular_color(
--			[number]r,[number]g,number[b])		->	Sets the current light specular color using sRGB values
--
--		xn_load_texture(texFile)		    ->	Loads the texture specified in 'texFile' parameter
--												Path must be relative to the xNormal UI folder, in
--												platform-specific format
--
--		xn_draw_text(x,y,text,colR,
--			colG,colB,colA,rightToLeft)		->	Draw a text in the screen. xNormal maps screen 
--												with origin at TOP-LEFT. 'colR/G/B/A' specifies the
--												text color ( colA controls opacity ). Text characters
--												are always 11x11 pixels.
--
--		xn_draw_overlay(x,y,width,
--			height,texFile,colR,colG,
--			colB,colA,startU,startV,
--			endU,endV)					->	Draw an overlay in the screen. Screen origin is at TOP-LEFT.
--											To know screen size call xn_get_screen_width/height() function.
--											'x', 'y', 'Width' and 'height' are specified in pixels.
--											'texFile' is the filename of the texture with to
--											texture-map the overlay ( must be loaded in the
--											init() method calling xn_load_texture(texFile) ) or
--											"" if you don't want to apply a texture.
--											'colR/G/B/A' specifies the overlay color ( colA
--											controls opacity ). The overlay color is MODULATED
--											or MULTIPLIED using these colR/G/B/A.
--											The startU,startV,endU,endV controls the UV(st)
--											texture coordinates as:
--									
--													(startU,startV)
--															*------------*
--															|			 |
--															^			 |
--															*-->---------*
--																	(endU,endV)
--
--											xNormal uses texture coord (0,0) at BOTTOM-LEFT like 
--											OpenGL, 3DSMAX, XSI and Maya does.
--
--											The colR/G/B/A are assumed to be in linear-space, NOT sRGB space.
--
-- Also, there must exists a table called "inputState" like the one in input.lua, so xNormal can put
-- there the current input state.
--
-- Any UI must implement three functions:
--
--		init()							->	Initialize and load resources for the UI
--
--		setup(dTime)					->	'dTime' is the time(in seconds) passed from last call
--											xNormal maps screen origin at TOP-LEFT.
--											To know screen size call xn_get_screen_width/height() function.
--
--		draw()							->	Draw the UI
--
--
-- If you want to override this UI just implement the init(), setup() and draw() methods in yours.
-- Then rename the original ui.lua to old_ui.lua and yours as ui.lua.
-- ------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------

-- Include controls.lua and input.lua
dofile ( xn_get_ui_path() .. "controls.lua" )
dofile ( xn_get_ui_path() .. "input.lua" )

-- ----------------------------------------------------------------------------
-- Some useful constants
-- ----------------------------------------------------------------------------
UI_TEXTURE = "ui.png"

g_debug = false
g_mouseX = 0.0
g_mouseY = 0.0

-- F1 causes this to be TRUE to display the UI. F1 again makes this FALSE and hide the UI.
g_showUI = true

-- Left margin for controls
xOrigin = 10

-- ----------------------------------------------------------------------------
-- UI controls
-- ----------------------------------------------------------------------------
closeButton = button:new
{
	x=xOrigin, y=xn_get_screen_height()-35, width=130, height = 30,
	
	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
	
	text = xn_get_string("Close"),
	
    Setup = function ( self, dTime )
		self.y = xn_get_screen_height()-35
		button.Setup ( self, dTime )
	end,
}

---------------------------------------------------------------------------------------------------
lightToCamButton = button:new
{
	x=xOrigin+80, y=5, width=55, height=32,

	uvRect = { startU=0.02, startV=0.98, endU=0.24, endV=0.85 },
	mouseOverUVRect = { startU=0.02, startV=0.85, endU=0.24, endV=0.724 },

	text = "",
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_set_light_position ( xn_get_camera_position() )
		end
	end
}

---------------------------------------------------------------------------------------------------
frameAllButton = button:new
{
	x=lightToCamButton.x+lightToCamButton.width, y=lightToCamButton.y, width=55, height=32,

	uvRect = { startU=0.24, startV=0.98, endU=0.46, endV=0.85 },
	mouseOverUVRect = { startU=0.24, startV=0.85, endU=0.46, endV=0.724 },

	text = "",
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_frameAll()
		end
	end
}

---------------------------------------------------------------------------------------------------
lockLightToCameraChk = checkbox:new
{
	x=xOrigin, y=lightToCamButton.y+lightToCamButton.height+5, width=200, height=15,
	
    text = xn_get_string("LockLightToCamera"),
    
   	Setup = function ( self, dTime )
   	    local w,h = xn_measure_text(xn_get_string("LockLightToCamera"))
   	    self.width = w+60;
   	    
   		checkbox.Setup(self,dTime)
   		if ( self.checked )
   		then
   		    xn_set_light_position ( xn_get_camera_position() )
   		end
	end	
}

---------------------------------------------------------------------------------------------------
cameraAutoCenterChk = checkbox:new
{
	x=xOrigin, y=lockLightToCameraChk.y+lockLightToCameraChk.height, width=200, height=15,

    text = xn_get_string("CameraAutoOrbitCenter"),
    
   	Setup = function ( self, dTime )
   	    local w,h = xn_measure_text(xn_get_string("CameraAutoOrbitCenter"))
   	    self.width = w+60;
   	    
   		checkbox.Setup(self,dTime)
   		xn_set_camera_autocenter ( self.checked )
	end	
}

---------------------------------------------------------------------------------------------------
backgroundColorBrowser = colorBrowser:new
{
	x=xOrigin, y=cameraAutoCenterChk.y+cameraAutoCenterChk.height+5, width=170, height=11,

    text = xn_get_string("BackgroundColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_background_color ( self.r, self.g, self.b )
   		end
	end
}

gridColorBrowser = colorBrowser:new
{
	x=xOrigin, y=backgroundColorBrowser.y+backgroundColorBrowser.height+5, width=170, height=11,

    text = xn_get_string("GridColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_grid_color ( self.r, self.g, self.b )
   		end
	end
}

---------------------------------------------------------------------------------------------------
showNormalsChk = checkbox:new
{
	x=xOrigin, y=gridColorBrowser.y+gridColorBrowser.height+10, width=190, height=15,

    text = xn_get_string("ShowLowpolyNormals"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_normals(self.checked)
   		
   		if ( self.checked )
   		then
   		    -- Uncheck the showAO because showNormals and that are mutually exclusive
   		    showAOChk.checked = false
   		    xn_set_show_ao(false)
   		end
	end
}

showGridChk = checkbox:new
{
	x=xOrigin, y=showNormalsChk.y+showNormalsChk.height, width=190, height=15,

	checked = true,
	
    text = xn_get_string("DrawGrid"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_grid(self.checked)
	end
}

showWireframeChk = checkbox:new
{
	x=xOrigin, y=showGridChk.y+showGridChk.height, width=190, height=15,

    text = xn_get_string("ShowLowpolyWireframe"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime )
   		xn_set_show_wireframe(self.checked)
	end
}

showTangentsChk = checkbox:new
{
	x=xOrigin, y=showWireframeChk.y+showWireframeChk.height, width=190, height=15,

    text = xn_get_string("ShowLowpolyTangents"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_tangent_basis(self.checked)
	end
}

showLowpolysChk = checkbox:new
{
	x=xOrigin, y=showTangentsChk.y+showTangentsChk.height, width=190, height=15,

    text = xn_get_string("ShowLowpolyMeshes"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_lowpolys(self.checked)
	end
}

showHighpolysChk = checkbox:new
{
	x=xOrigin, y=showLowpolysChk.y+showLowpolysChk.height, width=190, height=15,

    text = xn_get_string("ShowHighpolyMeshes"),
    
    Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_highpolys(self.checked)
	end
}

showAOChk = checkbox:new
{
	x=xOrigin, y=showHighpolysChk.y+showHighpolysChk.height, width=190, height=15,

    text = xn_get_string("ShowAO");
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_ao(self.checked)
   		
   		if ( self.checked )
   		then
   		    -- Uncheck the showNormals because showAO and that are mutually exclusive
   		    showNormalsChk.checked = false
   		    xn_set_show_normals(false)		
   		end
	end
}

showStarsChk = checkbox:new
{
	x=xOrigin, y=showAOChk.y+showAOChk.height, width=190, height=15,

	checked = true,
	
    text = xn_get_string("DrawStarfield"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_starfield(self.checked)
	end
}

showVDMSeamsChk = checkbox:new
{
	x=xOrigin, y=showStarsChk.y+showStarsChk.height, width=190, height=15,

    text = xn_get_string("ShowVDMSeams"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		xn_set_show_vdm_seams(self.checked)
	end
}


---------------------------------------------------------------------------------------------------
diffuseGIIntensity = horizontalSlider:new
{
	x=xOrigin, y=showVDMSeamsChk.y+showVDMSeamsChk.height, width=130, height=30,

    text = xn_get_string("DiffuseGIIntensity"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue*2.0
   		xn_set_diffusetGI_intensity(self.drawValue)
	end
}

lightIntensitySlider = horizontalSlider:new
{
	x=xOrigin, y=diffuseGIIntensity.y+diffuseGIIntensity.height, width=130, height=30,

    text = xn_get_string("LightIntensity"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue*2.0
   		xn_set_light_intensity(self.drawValue)
	end
}

lightIndirectIntensitySlider = horizontalSlider:new
{
	x=xOrigin, y=lightIntensitySlider.y+lightIntensitySlider.height, width=130, height=30,

    text = xn_get_string("LightIndirectIntensity"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue*2.0
   		xn_set_light_indirect_intensity(self.drawValue)
	end
}

lightOrbitDistanceSlider = centeredSlider:new
{
	x=xOrigin, y=lightIndirectIntensitySlider.y+lightIndirectIntensitySlider.height, width=130, height=30,

    text = xn_get_string("LightOrbitDistance"),
    
   	Setup = function ( self, dTime )
   		centeredSlider.Setup ( self, dTime )
   	
   		local radius = xn_get_models_max_radius()
   		local inc = self.hincrement * (radius/2.0)
   		if ( math.abs(inc)>0 )
   		then   		
	   		local lightPos = xn_get_light_position()
   			local len = math.sqrt ( (lightPos.x*lightPos.x) + (lightPos.y*lightPos.y) + (lightPos.z*lightPos.z) )
   			if ( inc>0 or len>radius*0.05 )
   			then
   				-- normalize
	   			local lightPosVector = { x=lightPos.x, y=lightPos.y, z=lightPos.z }
   				lightPosVector.x = lightPosVector.x / len
   				lightPosVector.y = lightPosVector.y / len
   				lightPosVector.z = lightPosVector.z / len
   			
   				lightPos.x = lightPos.x + (lightPosVector.x * inc)
   				lightPos.y = lightPos.y + (lightPosVector.y * inc)
   				lightPos.z = lightPos.z + (lightPosVector.z * inc)
   		
   				xn_set_light_position ( lightPos )
   			end
   		end
	end
}

lightAmbientColorPicker = colorBrowser:new
{
	x=xOrigin, y=lightOrbitDistanceSlider.y+lightOrbitDistanceSlider.height+5, width=210, height=11,

    text = xn_get_string("LightAmbientColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_light_ambient_color (self.r,self.g,self.b)
   			self.colorChanged = false
   		end
	end
}

lightDiffuseColorPicker = colorBrowser:new
{
	x=xOrigin, y=lightAmbientColorPicker.y+lightAmbientColorPicker.height+5, width=210, height=11,

    text = xn_get_string("LightDiffuseColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_light_diffuse_color (self.r,self.g,self.b)
   			self.colorChanged = false
   		end
	end
}

lightSpecularColorPicker = colorBrowser:new
{
	x=xOrigin, y=lightDiffuseColorPicker.y+lightDiffuseColorPicker.height+5, width=210, height=11,

    text = xn_get_string("LightSpecularColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_light_specular_color ( self.r, self.g, self.b )
   			self.colorChanged = false
   		end
	end
}

lightSecondaryColor = colorBrowser:new
{
	x=xOrigin, y=lightSpecularColorPicker.y+lightSpecularColorPicker.height+5, width=210, height=11,

    text = xn_get_string("LightSecondaryColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_light_secondary_color ( self.r, self.g, self.b )
   			self.colorChanged = false
   		end
	end
}

lightTertiaryColor = colorBrowser:new
{
	x=xOrigin, y=lightSecondaryColor.y+lightSecondaryColor.height+5, width=210, height=11,

    text = xn_get_string("LightTertiaryColor"),
    
   	Setup = function ( self, dTime )
   		colorBrowser.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_light_tertiary_color ( self.r, self.g, self.b )
   			self.colorChanged = false
   		end
	end
}

exposureSlider = horizontalSlider:new
{
	x=xOrigin, y=lightTertiaryColor.y+lightTertiaryColor.height+10, width=130, height=30,

    text = xn_get_string("Exposure"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue
   		xn_set_exposure(self.drawValue)
   		
   		self.text = xn_get_string("Exposure");
   		
   		if ( self.hvalue<=0.00001 )
   		then
   			self.text = self.text .. " AUTO";
   		end
	end
}

hdrThresholdSlider = horizontalSlider:new
{
	x=xOrigin, y=exposureSlider.y+exposureSlider.height, width=130, height=30,

    text = xn_get_string("HDRThreshold"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue
   		xn_set_hdr_threshold(self.drawValue)
	end
}

---------------------------------------------------------------------------------------------------
saveMeshesButton = button:new
{
	x=xn_get_screen_width()-240, y=115, width=235, height=30,

	text = xn_get_string("SaveMeshes"),

	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		self.x = xn_get_screen_width()-240
		
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_save_meshes()
		end
	end
}

reloadTexturesButton = button:new
{
	x=xn_get_screen_width()-240, y=saveMeshesButton.y+saveMeshesButton.height, width=235, height=30,

	text = xn_get_string("ReloadTextures"),

	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		self.x = xn_get_screen_width()-240
		
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_reload_textures()
		end
	end
}

reloadModelButton = button:new
{
	x=xn_get_screen_width()-240, y=reloadTexturesButton.y+reloadTexturesButton.height, width=235, height=30,

	text = xn_get_string("ReloadMeshes"),
	
	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		self.x = xn_get_screen_width()-240
		
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_reload_models()
		end
	end
}

---------------------------------------------------------------------------------------------------
castShadowsChk = checkbox:new
{
	x=xn_get_screen_width()-180, y=reloadModelButton.y+reloadModelButton.height+5, width=130, height=20,

    text = xn_get_string("CastShadows"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		self.x = xn_get_screen_width()-180
   		xn_set_cast_shadows(self.checked)
	end
}

shadowBias = horizontalSlider:new
{
	x=xn_get_screen_width()-180, y=castShadowsChk.y+castShadowsChk.height, width=130, height=30,

    text = xn_get_string("ShadowBias"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.x = xn_get_screen_width()-180
   		
   		self.drawValue = self.hvalue
   		xn_set_shadow_bias(self.drawValue)
	end
}

shadowArea = horizontalSlider:new
{
	x=xn_get_screen_width()-180, y=shadowBias.y+shadowBias.height, width=130, height=30,

    text = xn_get_string("AreaLightRadius"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.x = xn_get_screen_width()-180
   		
   		self.drawValue = self.hvalue
   		xn_set_shadow_area(self.drawValue)
	end
}

---------------------------------------------------------------------------------------------------
disableFresnelChk = checkbox:new
{
	x=xn_get_screen_width()-240, y=shadowArea.y+shadowArea.height+5, width=130, height=20,

    text = xn_get_string("DisableFresnelReflections"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		self.x = xn_get_screen_width()-240
   		xn_disable_fresnel(self.checked)
	end
}

---------------------------------------------------------------------------------------------------
useGlowChk = checkbox:new
{
	x=xn_get_screen_width()-240, y=disableFresnelChk.y+disableFresnelChk.height+5, width=130, height=20,

    text = xn_get_string("UseEmissiveGlow"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime)
   		self.x = xn_get_screen_width()-240
   		xn_set_use_glow(self.checked)
	end
}

glowIntensitySlider = horizontalSlider:new
{
	x=xn_get_screen_width()-240, y=useGlowChk.y+useGlowChk.height, width=130, height=30,

    text = xn_get_string("EmissiveGlowIntensity"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.x = xn_get_screen_width()-240
   		
   		self.drawValue = self.hvalue*8.0 --max is 8
   		xn_set_glow_intensity(self.drawValue)
	end
}

---------------------------------------------------------------------------------------------------
parallaxSlider = horizontalSlider:new
{
	x=xn_get_screen_width()-240, y=glowIntensitySlider.y+glowIntensitySlider.height, width=130, height=30,

    text = xn_get_string("ParallaxStrength"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.x = xn_get_screen_width()-240
   		
   		self.drawValue = self.hvalue
   		xn_set_parallax_strength ( self.hvalue )
	end
}

tessSlider = horizontalSlider:new
{
	x=xn_get_screen_width()-240, y=glowIntensitySlider.y+glowIntensitySlider.height+90, width=130, height=30,

    text = "Tessellation",
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.x = xn_get_screen_width()-240
   		
   		self.drawValue = self.hvalue*6
   		xn_set_max_tessellation_level ( self.drawValue )
	end
}

---------------------------------------------------------------------------------------------------
blockersShowChk = checkbox:new
{
	x=frameAllButton.x+frameAllButton.width+65, y=frameAllButton.y+2, width=130, height=20,

    text = xn_get_string("ShowBlockers"),
    
   	Setup = function ( self, dTime )
   		local oldChecked = self.checked
   		checkbox.Setup(self,dTime)
   		
   		if ( oldChecked~=self.checked )
   		then
   			xn_set_show_blockers(self.checked)
   		end
	end
}

cageShowChk = checkbox:new
{
	x=frameAllButton.x+frameAllButton.width+65, y=blockersShowChk.y+blockersShowChk.height, width=130, height=20,

    text = xn_get_string("ShowCage"),
    
   	Setup = function ( self, dTime )
   		local oldChecked = self.checked
   		checkbox.Setup(self,dTime)
   		
   		if ( oldChecked~=self.checked )
   		then
			xn_clear_selection()
   			xn_set_show_cage(self.checked)
			xn_set_edit_cage(false)  	
   		end
	end
}

cageEditChk = checkbox:new
{
	x=cageShowChk.x, y=cageShowChk.y+cageShowChk.height, width=130, height=20,

    text = xn_get_string("EditCage"),
    
   	Setup = function ( self, dTime )
   		local oldChecked = self.checked
   		checkbox.Setup(self,dTime )
   		
   		if ( oldChecked~=self.checked )
   		then
			xn_clear_selection()
   			xn_set_edit_cage(self.checked)
   		end
	end
}

cageOpacity = horizontalSlider:new
{
	x=cageShowChk.x, y=cageEditChk.y+cageEditChk.height, width=130, height=30,

    text = xn_get_string("CageOpacity"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue
   		xn_set_cage_opacity ( self.hvalue )
	end
}

cageColor = colorPicker:new
{
	x=cageOpacity.x, y=cageOpacity.y+cageOpacity.height, width=135, height=60,

    text = xn_get_string("CageColor"),
    
   	Setup = function ( self, dTime )
   		colorPicker.Setup(self, dTime)
   		if ( self.colorChanged )
   		then
   			xn_set_cage_color ( self.cval )
   			self.colorChanged = false
   		end
	end
}

cageExtrude = centeredSlider:new
{
	x=cageColor.x, y=cageColor.y+cageColor.height, width=225, height=30,

    text = xn_get_string("CageGlobalExtrussion"),
    
   	Setup = function ( self, dTime )
   		centeredSlider.Setup ( self, dTime )
   		xn_cage_extrude ( self.hincrement * (xn_get_models_max_radius()/25.0) )
	end
}

-- ------------------------------------------------------
cageSelectionExtrude = centeredSlider:new
{
	x=cageExtrude.x, y=cageExtrude.y+cageExtrude.height+1, width=225, height=30,

	color = { r=1.0, g=0.0, b=0.0, a=1.0},
	ballColor = {r=1.0, g=0.0, b=0.0, a=1.0},
	
    text = xn_get_string("SelectionExtrussion"),
    
   	Setup = function ( self, dTime )
   		centeredSlider.Setup ( self, dTime )
   		xn_cage_selection_extrude ( self.hincrement * (xn_get_models_max_radius()/25.0) )
	end
}

cageSelectionCulling = checkbox:new
{
	x=cageSelectionExtrude.x, y=cageSelectionExtrude.y+cageSelectionExtrude.height+44, width=225, height = 20,

    text = xn_get_string("IgnoreHiddenFacesForSelection"),
    
   	Setup = function ( self, dTime )
   		checkbox.Setup(self,dTime )
		xn_selection_ignore_backfaces(self.checked)
	end
}

cageSelectionMoveX = centeredSlider:new
{
	x=cageSelectionCulling.x, y=cageSelectionCulling.y+cageSelectionCulling.height, width=225, height=30,

	color = {r=1.0,g=0.0,b=0.0,a=1.0},
	ballColor = {r=1.0,g=0.0,b=0.0,a=1.0},
	
    text = xn_get_string("SelectionMoveX"),
    
   	Setup = function ( self, dTime )
   		centeredSlider.Setup ( self, dTime )
   		xn_cage_selection_move(0, self.hincrement * (xn_get_models_max_radius()/25.0) )
	end
}

cageSelectionMoveY = centeredSlider:new
{
	x=cageSelectionMoveX.x, y=cageSelectionMoveX.y+cageSelectionMoveX.height, width=225, height=30,

	color = {r=1.0,g=0.0,b=0.0,a=1.0},
	ballColor = {r=0.0,g=1.0,b=0.0,a=1.0},
	
    text = xn_get_string("SelectionMoveY"),
    
   	Setup = function ( self, dTime )
   		centeredSlider.Setup ( self, dTime )
   		xn_cage_selection_move(1, self.hincrement * (xn_get_models_max_radius()/25.0) )
	end
}

cageSelectionMoveZ = centeredSlider:new
{
	x=cageSelectionMoveY.x, y=cageSelectionMoveY.y+cageSelectionMoveY.height, width=225, height=30,

	color = {r=1.0,g=0.0,b=0.0,a=1.0},
	ballColor = {r=0.0,g=0.0,b=1.0,a=1.0},
	
    text = xn_get_string("SelectionMoveZ"),
    
   	Setup = function ( self, dTime )
   		centeredSlider.Setup ( self, dTime )
   		xn_cage_selection_move(2, self.hincrement * (xn_get_models_max_radius()/25.0) )
	end
}

resetCageSelection = button:new
{
	x=cageSelectionMoveZ.x, y=cageSelectionMoveZ.y+cageSelectionMoveZ.height+10, width=100, height=30,

	color = {r=1.0,g=0.0,b=0.0,a=1.0},
	
	text = xn_get_string("ResetCageSelectionValues"),
	
	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_reset_cage_selection()
		end
	end
}

breakCageSelection = button:new
{
	x=resetCageSelection.x+resetCageSelection.width+5, y=resetCageSelection.y, width=60, height=30,

	color = {r=1.0,g=0.0,b=0.0,a=1.0},
	
	text = xn_get_string("BreakCageSelectionValues"),
	
	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_break_cage_selection()
		end
	end
}

averageCageSelection = button:new
{
	x=breakCageSelection.x+breakCageSelection.width+5, y=breakCageSelection.y, width=60, height=30,

	color = {r=1.0,g=0.0,b=0.0,a=1.0},
	
	text = xn_get_string("AverageCageSelectionValues"),
	
	uvRect = { startU=0.025, startV=0.375, endU=0.422, endV=0.246 },
	mouseOverUVRect = { startU=0.531, startV=0.383, endU=0.951, endV=0.24 },
    
    Setup = function ( self, dTime )
		button.Setup ( self, dTime )
		
		if ( inputState.mouseLeftButtonReleased and self.mouseOver )
		then
			xn_average_cage_selection()
		end
	end
}

------------------------------------------------------
cameraAdvanceSensibility = horizontalSlider:new
{
	x=cageOpacity.x+cageOpacity.width+110, y=blockersShowChk.y, width=125, height=25,

	color = {r=1.0,g=1.0,b=0.0,a=1.0},
	ballColor = {r=0.0,g=0.0,b=1.0,a=1.0},

    text = xn_get_string("CameraAdvanceSensibility"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		if ( self.hvalue<0.02 )
   		then
   			self.hvalue = 0.02 -- Don't allow user to set it to ZERO. Keep it above a minimum
   		end

   		self.drawValue = self.hvalue*2.0
   		xn_set_camera_advance_sensibility ( self.hvalue*2.0 )
	end
}

cameraRotationSensibility = horizontalSlider:new
{
	x=cameraAdvanceSensibility.x, y=cameraAdvanceSensibility.y+cameraAdvanceSensibility.height, width=125, height=25,

	color = {r=1.0,g=1.0,b=0.0,a=1.0},
	ballColor = {r=0.0,g=0.0,b=1.0,a=1.0},
	
    text = xn_get_string("CameraRotationSensibility"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		if ( self.hvalue<0.02 )
   		then
   			self.hvalue = 0.02 -- Don't allow user to set it to ZERO. Keep it above a minimum
   		end
   		
   		self.drawValue = self.hvalue * 2.0
   		xn_set_camera_rotation_sensibility ( self.hvalue*2.0 )
	end
}

axisScale = horizontalSlider:new
{
	x=cameraRotationSensibility.x, y=cameraRotationSensibility.y+cameraRotationSensibility.height, width=125, height=25,

	color = {r=1.0,g=1.0,b=0.0,a=1.0},
	ballColor = {r=0.0,g=0.0,b=1.0,a=1.0},
	
    text = xn_get_string("AxisDebugScale"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		if ( self.hvalue<0.001 )
   		then
   			self.hvalue = 0.001 -- Don't allow user to set it to ZERO. Keep it above a minimum
   		end
   		
   		self.drawValue = self.hvalue / 4.0 --Keep it in range [0,0.25]
   		xn_set_axis_scale ( self.drawValue ) 
	end
}

cameraOrbitDistance = horizontalSlider:new
{
	x=cameraRotationSensibility.x, y=axisScale.y+axisScale.height, width=125, height=25,

	color = {r=1.0,g=1.0,b=0.0,a=1.0},
	ballColor = {r=0.0,g=0.0,b=1.0,a=1.0},
	
    text = xn_get_string("CameraOrbitDistance"),
    
   	Setup = function ( self, dTime )
   		horizontalSlider.Setup ( self, dTime )
   		if ( self.hvalue<0.001 )
   		then
   			self.hvalue = 0.001 -- Don't allow user to set it to ZERO. Keep it above a minimum
   		end
   		
   		self.drawValue = self.hvalue;
   		xn_set_camera_orbit_distance ( self.drawValue ) 
	end
}

reelCamera = checkbox:new
{
	x=xn_get_screen_width()-90, y=parallaxSlider.y+parallaxSlider.height+15, width=70, height = 15,
	
	text = "ReelC",
	
    Setup = function ( self, dTime )
		self.x = xn_get_screen_width()-80
		checkbox.Setup(self,dTime)
        xn_set_reel_mode(0,self.checked) --reel the camera
	end,
}

reelLight = checkbox:new
{
	x=xn_get_screen_width()-90, y=reelCamera.y+reelCamera.height+5, width=70, height = 15,
	
	text = "ReelL",
	
    Setup = function ( self, dTime )
		self.x = xn_get_screen_width() - 80
		checkbox.Setup(self,dTime)
        xn_set_reel_mode(1,self.checked) --reel the camera
	end,
}

-- ---------------------------------------------------------------------------------------------
ssaoChk = checkbox:new
{
	x=cageOpacity.x, y=xn_get_screen_height()-150, width=70, height = 20,

	color = {r=0.7,g=0.0,b=0.1,a=1.0},
	
	text = xn_get_string("SSAOEnable"),
	
    Setup = function ( self, dTime )
		self.y = xn_get_screen_height() - 150
		
		checkbox.Setup(self,dTime)
        xn_set_ssao_enabled(self.checked)
	end,
}

ssaoBlurRadiusSlider = horizontalSlider:new
{
	x=cageOpacity.x, y=xn_get_screen_height()-125, width=125, height=20,

	color = {r=0.7,g=0.1,b=0.1,a=1.0},
	ballColor = {r=0.0,g=1.0,b=0.0,a=1.0},

    text = xn_get_string("SSAOBlurRadius"),
    
   	Setup = function ( self, dTime )
		self.y = xn_get_screen_height()-125

   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue*20.0
   		xn_set_ssao_blur_radius ( self.drawValue )
	end
}

ssaoBrightSlider = horizontalSlider:new
{
	x=cageOpacity.x, y=xn_get_screen_height()-105, width=125, height=20,

	color = {r=0.7,g=0.1,b=0.1,a=1.0},
	ballColor = {r=0.0,g=1.0,b=0.0,a=1.0},

    text = xn_get_string("SSAOBright"),
    
   	Setup = function ( self, dTime )
		self.y = xn_get_screen_height() - 105
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue * 4.0
   		xn_set_ssao_bright ( self.drawValue )
	end
}

ssaoContrastSlider = horizontalSlider:new
{
	x=cageOpacity.x, y=xn_get_screen_height()-85, width=125, height=20,

	color = {r=0.7,g=0.1,b=0.1,a=1.0},
	ballColor = {r=0.0,g=1.0,b=0.0,a=1.0},

    text = xn_get_string("SSAOContrast"),
    
   	Setup = function ( self, dTime )
		self.y = xn_get_screen_height() - 85
   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue * 4.0
   		xn_set_ssao_contrast ( self.drawValue )
	end
}

ssaoAttenSlider = horizontalSlider:new
{
	x=cageOpacity.x, y=xn_get_screen_height()-65, width=125, height=20,

	color = {r=0.7,g=0.1,b=0.1,a=1.0},
	ballColor = {r=0.0,g=1.0,b=0.0,a=1.0},

    text = xn_get_string("SSAOAtten"),
    
   	Setup = function ( self, dTime )
		self.y = xn_get_screen_height()-65

   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue*2.0
   		xn_set_ssao_atten ( self.drawValue )
	end
}

ssaoRadiusSlider = horizontalSlider:new
{
	x=cageOpacity.x, y=xn_get_screen_height()-45, width=125, height=20,

	color = {r=0.7,g=0.1,b=0.1,a=1.0},
	ballColor = {r=0.0,g=1.0,b=0.0,a=1.0},

    text = xn_get_string("SSAORadius"),
    
   	Setup = function ( self, dTime )
		self.y = xn_get_screen_height()-45

   		horizontalSlider.Setup ( self, dTime )
   		self.drawValue = self.hvalue
   		xn_set_ssao_radius ( self.hvalue )
	end
}

-- ---------------------------------------------------------------------------------------------	
-- Interface implementation 
-- ---------------------------------------------------------------------------------------------	

function init ()
	-- Load the UI tga texture
	xn_load_texture(UI_TEXTURE)
	
	-- Get the diffuse GI light probe intensity
	diffuseGIIntensity.hvalue = xn_get_diffuseGI_intensity() / 2.0
	diffuseGIIntensity.drawValue = diffuseGIIntensity.hvalue
	
	-- Get the light intensity.
	lightIntensitySlider.hvalue = xn_get_light_intensity() / 2.0
	lightIntensitySlider.drawValue = xn_get_light_intensity()
	lightIndirectIntensitySlider.hvalue = xn_get_light_indirect_intensity() / 2.0
	lightIndirectIntensitySlider.drawValue = xn_get_light_indirect_intensity()
		
	-- Get the initial light colors
	lightAmbientColorPicker.r, lightAmbientColorPicker.g, lightAmbientColorPicker.b = xn_get_light_ambient_color()
	lightDiffuseColorPicker.r, lightDiffuseColorPicker.g, lightDiffuseColorPicker.b = xn_get_light_diffuse_color()
	lightSpecularColorPicker.r, lightSpecularColorPicker.g, lightSpecularColorPicker.b  = xn_get_light_specular_color()
	lightSecondaryColor.r, lightSecondaryColor.g, lightSecondaryColor.b  = xn_get_light_secondary_color()
	lightTertiaryColor.r, lightTertiaryColor.g, lightTertiaryColor.b  = xn_get_light_tertiary_color()
	
	-- Get the DX1 effects control initial values
	exposureSlider.hvalue = xn_get_exposure()
	exposureSlider.drawValue = exposureSlider.hvalue
	hdrThresholdSlider.hvalue = xn_get_hdr_threshold()
	hdrThresholdSlider.drawValue = hdrThresholdSlider.hvalue

	-- Get the initial background and grid color
	backgroundColorBrowser.r, backgroundColorBrowser.g, backgroundColorBrowser.b = xn_get_background_color()
	gridColorBrowser.r, gridColorBrowser.g, gridColorBrowser.b = xn_get_grid_color()
	
	-- Get the SSAO settings
	ssaoChk.checked = xn_get_ssao_enabled()
	ssaoBlurRadiusSlider.drawValue = xn_get_ssao_blur_radius()
	ssaoBlurRadiusSlider.hvalue = ssaoBlurRadiusSlider.drawValue/20.0
	ssaoBrightSlider.drawValue = xn_get_ssao_bright()
	ssaoBrightSlider.hvalue = ssaoBrightSlider.drawValue*0.25
	ssaoContrastSlider.drawValue = xn_get_ssao_contrast()
	ssaoContrastSlider.hvalue = ssaoContrastSlider.drawValue*0.25
	ssaoAttenSlider.drawValue = xn_get_ssao_atten()
	ssaoAttenSlider.hvalue = xn_get_ssao_atten()*0.5
	ssaoRadiusSlider.drawValue = xn_get_ssao_radius()
	ssaoRadiusSlider.hvalue = xn_get_ssao_radius()
	
	-- Get the checkbox initial settings from xNormal settings file
	showNormalsChk.checked = xn_get_show_normals()
	showGridChk.checked = xn_get_show_grid()
	showWireframeChk.checked = xn_get_show_wireframe()
	showTangentsChk.checked = xn_get_show_tangent_basis()
	showLowpolysChk.checked = true
	showHighpolysChk.checked = true
	showAOChk.checked = false
	showStarsChk.checked = xn_get_show_starfield()
	showVDMSeamsChk.checked = xn_get_show_vdm_seams()
	
	-- Get the parallax strength initial settings ( sure slider is in range [0,1] )
	parallaxSlider.hvalue = xn_get_parallax_strength()
	tessSlider.hvalue = xn_get_max_tessellation_level() / 6.0
	
	-- Get the cage/blockers initial settings
	blockersShowChk.checked = xn_get_show_blockers()
	cageShowChk.checked = false
	cageEditChk.checked = false
	cageColor.cval = xn_get_cage_color()
	cageOpacity.hvalue = xn_get_cage_opacity()
	cageSelectionCulling.checked = true

	-- Get the glow initial settings
	useGlowChk.checked = xn_get_use_glow()
	glowIntensitySlider.hvalue = xn_get_glow_intensity() / 8.0
		
	-- Get the initial camera sensibility ( and setup it in range [0,2] )
	cameraAdvanceSensibility.hvalue = xn_get_camera_advance_sensibility () / 2.0
	cameraRotationSensibility.hvalue = xn_get_camera_rotation_sensibility () / 2.0
	
	-- Get the initial axis scale
	axisScale.hvalue = xn_get_axis_scale() * 4.0
	
	-- Get the initial camera orbit distance
	cameraOrbitDistance.hvalue = xn_get_camera_orbit_distance()

	-- Get the initial cast shadows value
	castShadowsChk.checked = xn_get_cast_shadows()
	shadowBias.hvalue = xn_get_shadow_bias()
	shadowArea.hvalue = xn_get_shadow_area()
	
	-- Get the initial camera autocenter
	cameraAutoCenterChk.checked = xn_get_camera_autocenter()
end

function setup ( dTime )

	g_mouseX = mouseX
	g_mouseY = mouseY

	-- Test is we wanna draw the UI or not...
	if ( inputState.F1Released )
	then
		g_showUI = not g_showUI
	end
	
	if ( g_showUI )
	then
		-- Setup background and grid color picker
		backgroundColorBrowser:Setup(dTime)
		gridColorBrowser:Setup(dTime)
		
		-- Test mouse over the light-to-camera and frameAll buttons
		lightToCamButton:Setup(dTime)
		frameAllButton:Setup(dTime)
		lockLightToCameraChk:Setup(dTime)
		cameraAutoCenterChk:Setup(dTime)
		
		-- Test mouse over the close button
		closeButton:Setup(dTime)
		if ( inputState.mouseLeftButtonReleased and closeButton.mouseOver )
		then
			-- We clicked the close button. Return false so we will exit the interface!!!
			return false
		end
		
		-- Setup "display" checkboxes
		showNormalsChk:Setup(dTime)
		showGridChk:Setup(dTime)
		showWireframeChk:Setup(dTime)
		showTangentsChk:Setup(dTime)
		showLowpolysChk:Setup(dTime)
		showHighpolysChk:Setup(dTime)
		showAOChk:Setup(dTime)
		showStarsChk:Setup(dTime)
		showVDMSeamsChk:Setup(dTime)

		-- Setup light intensity slider and color ones
		diffuseGIIntensity:Setup(dTime)
		lightIntensitySlider:Setup(dTime)
		lightIndirectIntensitySlider:Setup(dTime)
		lightOrbitDistanceSlider:Setup(dTime)
		
		lightAmbientColorPicker:Setup(dTime)
		lightDiffuseColorPicker:Setup(dTime)
		lightSpecularColorPicker:Setup(dTime)
		lightSecondaryColor:Setup(dTime)
		lightTertiaryColor:Setup(dTime)
		
		-- Setup DX10 HDR effects
		exposureSlider:Setup(dTime)
		hdrThresholdSlider:Setup(dTime)
		
		-- Setup DX10 SSAO effects
		ssaoChk:Setup(dTime)
		if ( ssaoChk.checked )
		then
			ssaoBlurRadiusSlider:Setup(dTime)
			ssaoBrightSlider:Setup(dTime)
			ssaoContrastSlider:Setup(dTime)
			ssaoAttenSlider:Setup(dTime)
			ssaoRadiusSlider:Setup(dTime)
		end
		
		-- Setup the parallax strength slider and checkbox
		parallaxSlider:Setup(dTime)
		tessSlider:Setup(dTime)
		
		-- Setup cage/blockers things
		blockersShowChk:Setup(dTime)
		cageShowChk:Setup(dTime)
		if ( cageShowChk.checked )			
		then
			cageEditChk:Setup(dTime)
			cageOpacity:Setup(dTime)
			cageColor:Setup(dTime)
			cageExtrude:Setup(dTime)
		
			if ( cageEditChk.checked )
			then
				cageSelectionExtrude:Setup(dTime)
				cageSelectionCulling:Setup(dTime)
			
				cageSelectionMoveX:Setup(dTime)
				cageSelectionMoveY:Setup(dTime)
				cageSelectionMoveZ:Setup(dTime)
			
				resetCageSelection:Setup(dTime)
				breakCageSelection:Setup(dTime)
				averageCageSelection:Setup(dTime)
			end
		end

		-- Setup glow slider
		useGlowChk:Setup(dTime)
		if ( useGlowChk.checked )
		then
			glowIntensitySlider:Setup(dTime)
		end
		
		-- Setup the cast shadows chk
		castShadowsChk:Setup(dTime)
		if ( castShadowsChk.checked )
		then
			shadowBias:Setup(dTime)
			shadowArea:Setup(dTime)
		end
		
		-- Setup disable fresnel chk
		disableFresnelChk:Setup(dTime)

		-- Setup reload/save meshes buttons
		saveMeshesButton:Setup(dTime)
		reloadTexturesButton:Setup(dTime)
		reloadModelButton:Setup(dTime)
		
		-- Setup camera sensibility sliders
		cameraAdvanceSensibility:Setup(dTime)
		cameraRotationSensibility:Setup(dTime)	
		
		-- Setup axis scale slider
		axisScale:Setup(dTime)
		
		-- Setup the camera's orbit distance
		cameraOrbitDistance:Setup(dTime)
		
		-- Setup reel mode
		reelCamera:Setup(dTime)
		reelLight:Setup(dTime)
	else
	    if ( lockLightToCameraChk.checked )
	    then
            -- Set light into camera position
	        xn_set_light_position ( xn_get_camera_position() )
	    end
	end

	-- Take screenshot/capture if required
	if ( inputState.F8Released )
	then
		xn_take_screenshot()
	end
	
	if ( inputState.F9Released )
	then
	    -- Toggle video capture on/off
		xn_enable_video_capture ( not xn_is_video_capture_enabled() )
	end

	-- Return true to continue callin the menu functions
	return true
end

function draw ()
	-- Get is the user is using a Xbox 360 gamepad
	local xbox360gamepad = xn_is_gamepad_in_use()
	
	-- Draw cursor/camera/light position if we are in debug mode
	if ( g_debug )
	then
		local s = string.format ( "mouse (%u,%u)", inputState.mouseX, inputState.mouseY )
		xn_draw_text ( 200, 200, s, 1.0, 0.0, 0.0, 1.0 )

		local cPos = xn_get_camera_position()
		s = string.format ( "camera (%4.3f;%4.3f;%4.3f)", cPos.x, cPos.y, cPos.z )
		xn_draw_text ( 200, 215, s, 1.0, 0.0, 0.0, 1.0 )

		local lPos = xn_get_light_position()
		s = string.format ( "light (%4.3f;%4.3f;%4.3f)", lPos.x, lPos.y, lPos.z )
		xn_draw_text ( 200, 230, s, 1.0, 0.0, 0.0, 1.0 )
	end
	
	local parallaxY = parallaxSlider.y+parallaxSlider.height+5
	local yText = xn_get_screen_height() - 75
	
	if ( g_showUI )
	then
		-- Draw the background and grid color picker
		backgroundColorBrowser:Draw()
		gridColorBrowser:Draw()
		
		if ( false==xbox360gamepad )
		then
			-- Draw the video capture text
			if ( xn_is_video_capture_enabled() )
			then
			    xn_draw_text ( xn_get_screen_width()-250, yText, xn_get_string("VideoCapturing"),
				    1.0, 0.0, 0.0, 1.0 )
		    else
			    xn_draw_text ( xn_get_screen_width()-250, yText, xn_get_string("F9ToVideoCapture"),
				    1.0, 1.0, 1.0, 1.0 )
		    end

			xn_draw_text ( xn_get_screen_width()-250, yText+11, xn_get_string("ASWDRMouseToMove"),
				1.0, 1.0, 1.0, 1.0 )
		
			xn_draw_text ( xn_get_screen_width()-250, yText+22, xn_get_string("CTRLRMouseToOrbitCam"),
				1.0, 1.0, 1.0, 1.0 )
			
			xn_draw_text ( xn_get_screen_width()-250, yText+33,  xn_get_string("ALTRMouseToOrbitLight"),
				1.0, 1.0, 1.0, 1.0 )
				
			xn_draw_text ( xn_get_screen_width()-250, yText+44, xn_get_string("F8ToTakeScreenshot"),
				1.0, 1.0, 1.0, 1.0)
		else
			-- Draw the gamepad image
			xn_draw_overlay ( xn_get_screen_width()-110, xn_get_screen_height()-80, 90, 60, UI_TEXTURE,
				1.0, 1.0, 1.0, 1.0,	0.527, 0.972, 0.878, 0.738 )
		end
		
		-- Draw the FPS
		local fps = xn_get_fps()
		local fpsStr = string.format ( xn_get_string("FPS") .. ": %4.3f", fps )
		local fpsW, fpsH = xn_measure_text(fpsStr)	
		local fpsX = xOrigin
		local fpsY = lightToCamButton.y + ((lightToCamButton.height-fpsH)/2)
		
		if ( fps>=50.0 )
		then
			xn_draw_text ( fpsX, fpsY, fpsStr, 0.0, 1.0, 0.0, 1.0) -- draw in green
		else
			if ( fps>=25.0 )
			then
				xn_draw_text ( fpsX, fpsY, fpsStr, 0.0, 0.0, 1.0, 1.0) -- draw in blue
			else
				xn_draw_text ( fpsX, fpsY, fpsStr, 1.0, 0.0, 0.0, 1.0) -- draw in red! too low FPS!
			end
		end
		
		-- Draw the light-to-camera and frameAll buttons
		lightToCamButton:Draw()
		frameAllButton:Draw()
		lockLightToCameraChk:Draw()
		cameraAutoCenterChk:Draw()
		
		-- Draw the close button
		closeButton:Draw()
		
		-- Draw the "display" checkboxes
		showNormalsChk:Draw()
		showGridChk:Draw()
		showWireframeChk:Draw()
		showTangentsChk:Draw()
		showLowpolysChk:Draw()
		showHighpolysChk:Draw()
		showAOChk:Draw()
		showStarsChk:Draw()
		showVDMSeamsChk:Draw()
		
		-- Draw reel mode
		reelCamera:Draw()
		reelLight:Draw()
		
		-- Draw the light intensity slider and color ones
		diffuseGIIntensity:Draw()
		lightIntensitySlider:Draw()
		lightIndirectIntensitySlider:Draw()
		lightOrbitDistanceSlider:Draw()

		lightAmbientColorPicker:Draw()
		lightDiffuseColorPicker:Draw()
		lightSpecularColorPicker:Draw()
		lightSecondaryColor:Draw()
		lightTertiaryColor:Draw()
		
		-- Draw the DX10 HDR effects controls
		exposureSlider:Draw()
		hdrThresholdSlider:Draw()
		
		-- Setup DX10 SSAO effects
		ssaoChk:Draw()
		if ( ssaoChk.checked )
		then
			ssaoBlurRadiusSlider:Draw()
			ssaoBrightSlider:Draw()
			ssaoContrastSlider:Draw()
			ssaoAttenSlider:Draw()
			ssaoRadiusSlider:Draw()
		end

		-- Draw the parallax strength
		parallaxSlider:Draw()
		tessSlider:Draw()
		
		-- Draw the cage/blockers things
		blockersShowChk:Draw()
		cageShowChk:Draw()
		if ( cageShowChk.checked )
		then
			cageEditChk:Draw(dTime)
			cageOpacity:Draw(dTime)
			cageColor:Draw(dTime)
			cageExtrude:Draw()
			
			if ( cageEditChk.checked )
			then
				cageSelectionExtrude:Draw()
			
				local cageExt = string.format ( xn_get_string("MaxCageExtrussion") .. ": %4.3f", xn_get_maximum_cage_extrussion())
				xn_draw_text ( cageSelectionExtrude.x, cageSelectionExtrude.y+cageSelectionExtrude.height, 
					cageExt, 1.0, 1.0, 0.0, 1.0)

				xn_draw_text ( cageSelectionExtrude.x, cageSelectionExtrude.y+cageSelectionExtrude.height+11, 
					xn_get_string("UseMButtonToSelectVertices"), 1.0, 1.0, 0.0, 1.0)

				xn_draw_text ( cageSelectionExtrude.x, cageSelectionExtrude.y+cageSelectionExtrude.height+22, 
					xn_get_string("HoldShiftToMultiSelect"), 1.0, 1.0, 0.0, 1.0)

				cageSelectionCulling:Draw()

				cageSelectionMoveX:Draw()
				cageSelectionMoveY:Draw()
				cageSelectionMoveZ:Draw()
				
				resetCageSelection:Draw()
				breakCageSelection:Draw()
				averageCageSelection:Draw()
			end
		end

		-- Draw the glow intensity things
		useGlowChk:Draw()
		if ( useGlowChk.checked )
		then		
			glowIntensitySlider:Draw()
		end
		
		-- Draw the cast shadows chk
		castShadowsChk:Draw()
		if ( castShadowsChk.checked )
		then
			shadowBias:Draw()
			shadowArea:Draw()
		end
		
		-- Draw the disable fresnel chk
		disableFresnelChk:Draw()
		
		-- Draw the reload/save meshes buttons
		saveMeshesButton:Draw()
		reloadTexturesButton:Draw()
		reloadModelButton:Draw()
		
		-- Draw camera sensibility sliders
		cameraAdvanceSensibility:Draw()
		cameraRotationSensibility:Draw()
		
		-- Draw axis scale slider and the camera orbit distance
		axisScale:Draw()
		cameraOrbitDistance:Draw()
	
		-- Draw number of verts , number of faces, object radius and VRAM used
		local radius = string.format ( xn_get_string("Radius") .. ": %4.3f", xn_get_models_max_radius())
		xn_draw_text ( xn_get_screen_width()-240, parallaxY, radius, 0.0, 1.0, 1.0, 1.0)
		local vramUsed = string.format ( "VRAM: " .. ": %4.3fMb", xn_get_used_vram()/(1024.0*1024.0) )
		xn_draw_text ( xn_get_screen_width()-240, parallaxY+11, vramUsed, 1.0, 1.0, 0.0, 1.0)
		local nLow = string.format ( "#vertl %u #trisl %u", xn_get_nverts(), xn_get_ntris() )
		xn_draw_text ( xn_get_screen_width()-240, parallaxY+22, nLow, 0.0, 1.0, 0.0, 1.0 )
		local nHigh = string.format ( "#trih %u #alphatri %u", xn_get_ntris_high(), xn_get_numtris_alpha_sorted() )
		xn_draw_text ( xn_get_screen_width()-240, parallaxY+33, nHigh, 0.0, 0.0, 1.0, 1.0 )
	end
	
	if ( false==xbox360gamepad )
	then
		-- Draw the press F1 to hide/show the UI
		xn_draw_text ( xn_get_screen_width()-250, yText+55, xn_get_string("F1ToShowHideUI"), 
			1.0, 1.0, 1.0, 1.0)
	end
		
	-- Draw mouse cursor if we aren't heading the camera
	if ( false==inputState.mouseRightButtonDown )
	then
		xn_draw_cursor ( inputState.mouseX, inputState.mouseY, 14, 20, UI_TEXTURE, 1.0, 1.0, 1.0, 1.0,
			0.376, 0.694, 0.431, 0.615 )
	end
end

