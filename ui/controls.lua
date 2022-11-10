--[[
	xNormal UI generic controls
	(c) 2005-2018 S.Orgaz.
--]]

dofile ( xn_get_ui_path() .. "utils.lua" )
dofile ( xn_get_ui_path() .. "input.lua" )

-- ---------------------------------------------------------------------------------------------	
-- Some custom controls
-- ---------------------------------------------------------------------------------------------
control = 
{
	x=0.0, y=0.0, width=100.0, height=100.0,
	
	color = { r=1.0, g=1.0, b=1.0, a=1.0},
	
	uvRect = { startU=0.0, startV=0.0, endU=1.0, endV=1.0 },
	
	text = "",

	Setup = function ( self, dTime )
	end,
	
	Draw = function ( self )
		xn_draw_overlay ( self.x, self.y, self.width, self.height, UI_TEXTURE,
			self.color.r, self.color.g, self.color.b, self.color.a, self.uvRect.startU, self.uvRect.startV,
			self.uvRect.endU, self.uvRect.endV )
			
		xn_draw_text ( self.x, self.y, self.text, self.color.r, self.color.g, self.color.b, self.color.a )
	end,

	share = function ( self, o )
		o = o or {}
		setmetatable(o, self)
		self.__index = self
		return o
	end,
	
	new = function ( self, o )
		--[[
			By default, LUA copies table by REFERENCE, not by value, so we need the copy_table function
			to copy tables by value.
			
			Do see it do this:
				table1 = {r=1.0, g=2.0, b=3.0}
				table2 = table1
				table2.g = 90.0
				print(table1.g) gives 90!
		--]]
		local obj = copy_table(self)
		
		for k,v in pairs(o) do
			obj[k] = v;
		end
		
		return obj
	end
}

button = control:new
{
	mouseOverUVRect = { startU=0.0, startV=0.0, endU=1.0, endV=1.0 },

	mouseOver = false,
	
	Setup = function ( self, dTime )
		self.mouseOver = ( inputState.mouseX>=self.x and inputState.mouseX<self.x+self.width and
			inputState.mouseY>=self.y and inputState.mouseY<self.y+self.height )
	end,
	
	Draw = function ( self )
		local dr = self.uvRect
		if ( self.mouseOver )
		then
			dr = self.mouseOverUVRect
		end
		
		xn_draw_overlay ( self.x, self.y, self.width, self.height, UI_TEXTURE, self.color.r, self.color.g,
			self.color.b, self.color.a,	dr.startU, dr.startV, dr.endU, dr.endV )
			
		local tWidth, tHeight = xn_measure_text(self.text)
		xn_draw_text ( self.x+((self.width-tWidth)/2), self.y+((self.height-tHeight)/2),
			self.text, self.color.r, self.color.g, self.color.b, self.color.a )
	end
}

checkbox = control:new
{
	checkedUVRect = { startU=30.0/255.0, startV=(255-79)/255.0, endU=48.0/255.0, endV=(255-97)/255.0 },
	uvRect		  = { startU=6.0/255.0, startV=(255-79)/255.0, endU=24.0/255.0, endV=(255-97)/255.0 },

	checked = false,
	
	Setup = function ( self, dTime )
		if ( inputState.mouseLeftButtonReleased and 
			 inputState.mouseX>=self.x and inputState.mouseX<self.x+self.width and
			 inputState.mouseY>=self.y and inputState.mouseY<self.y+self.height  )
		then
			self.checked = not self.checked
		end
	end,
	
	Draw = function ( self )
		-- Draw box checked or unchecked
		local dr = self.uvRect
		if ( self.checked )
		then
			dr = self.checkedUVRect
		end
		
		local xBox, xText
		local wText, hText = xn_measure_text(self.text)

		if ( xn_is_rightToLeftCulture() )
		then
			xBox = self.x+self.width-18
			xText = xBox - wText - 5
		else
			xBox = self.x
			xText = self.x+30+5
		end

		-- Draw box
		xn_draw_overlay ( xBox, self.y+1, 30, self.height-1, UI_TEXTURE, self.color.r, self.color.g,
			self.color.b, self.color.a, dr.startU, dr.startV, dr.endU, dr.endV )
		
		-- Draw text
		xn_draw_text ( xText, self.y+((self.height-hText)/2), self.text, self.color.r, self.color.g,
			self.color.b, self.color.a )
	end
}

horizontalSlider = control:new
{
	sliderUVRect = { startU=0.46, startV=0.704, endU=0.906, endV=0.673 },
	ballUVRect = { startU=0.648, startV=0.645, endU=0.711, endV=0.574 },

	ballColor = {r=1.0, g=1.0, b=1.0, a=1.0},
	
	hvalue = 1.0,
	drawValue = 1.0,
	
	Setup = function ( self, dTime )
		if ( inputState.mouseLeftButtonDown and inputState.mouseX>=self.x and inputState.mouseX<=self.x+self.width and
			 inputState.mouseY>=self.y+(self.height/2) and inputState.mouseY<=self.y+self.height )
		then
			-- Calculate value and then ball position
			self.hvalue = (inputState.mouseX-self.x) / self.width
		end
	end,
	
	Draw = function ( self )
		local sliderHeight = self.height/3
		local ballSize = (self.height/3)+6
		
		-- Draw label
		local labelX 
		
		if ( xn_is_rightToLeftCulture() )
		then
			local mX, mY = xn_measure_text(self.text)
			labelX = self.x + self.width - mX
		else
			labelX = self.x
		end
		
		xn_draw_text ( labelX, self.y, self.text, self.color.r, self.color.g, self.color.b, self.color.a )
		
		--Draw slider
		local ySlider = self.y+self.height-sliderHeight
		
		xn_draw_overlay ( self.x, ySlider, self.width, sliderHeight, UI_TEXTURE,
			self.color.r, self.color.g, self.color.b, self.color.a,
			self.sliderUVRect.startU, self.sliderUVRect.startV, self.sliderUVRect.endU,	self.sliderUVRect.endV )
		
		-- Draw ball
		xn_draw_overlay ( self.x + (self.hvalue*self.width) - (ballSize/2), ySlider-3, ballSize, ballSize,
			UI_TEXTURE,	self.ballColor.r, self.ballColor.g, self.ballColor.b, self.ballColor.a,
			self.ballUVRect.startU,	self.ballUVRect.startV, self.ballUVRect.endU, self.ballUVRect.endV )
			
		-- Draw numeric text value
		valText = string.format ( "%4.3f", self.drawValue )
		local textWidth, textHeight = xn_measure_text(valText)

		xn_draw_text ( self.x+self.width+(ballSize/2)+1, ySlider+((sliderHeight-textHeight)*0.5), valText,
			self.color.r, self.color.g, self.color.b, 1.0 )
	end	
}

centeredSlider = control:new
{
	-- A slider in value range [-1,1] that autocenters ( so really detects movement increments )
	
	sliderUVRect = { startU=0.053, startV=0.223, endU=0.906, endV=0.15 },
	ballUVRect = { startU=0.217, startV=0.699, endU=0.281, endV=0.625 },

	ballColor = {r=1.0, g=1.0, b=1.0, a=1.0},
	
	hvalue = 0.0,
	hincrement = 0.0,
	
	lastX = -1.0,

	Setup = function ( self, dTime )
		if ( inputState.mouseLeftButtonDown and inputState.mouseX>=self.x and inputState.mouseX<self.x+self.width and
			 inputState.mouseY>=self.y+11 and inputState.mouseY<self.y+self.height )
		then
			-- Calculate value and then ball position
			self.hvalue = (inputState.mouseX-self.x) / self.width
			self.hvalue = 2.0 * ( self.hvalue - 0.5 )
			
			if ( self.lastX~=-1.0 )
			then
				self.hincrement = (inputState.mouseX - self.lastX) / self.width;
			else
				self.hincrement = 0.0
			end
			self.lastX = inputState.mouseX
		else
			-- Autocenter positions
			self.hvalue = 0.0
			self.hincrement = 0.0
			self.lastX = -1.0
		end
	end,
	
	Draw = function ( self )
		local ballSize = (self.height-11) - 3

		-- Draw label
		local labelX
		if ( xn_is_rightToLeftCulture() )
		then
			local mX, mY = xn_measure_text(self.text)
			labelX = self.x + self.width - mX
		else
			labelX = self.x
		end
		
		xn_draw_text ( labelX, self.y, self.text, self.color.r, self.color.g, self.color.b, self.color.a )
		
		--Draw slider
		xn_draw_overlay ( self.x, self.y+11, self.width, self.height-11, UI_TEXTURE,
			self.color.r, self.color.g, self.color.b, self.color.a,
			self.sliderUVRect.startU, self.sliderUVRect.startV, self.sliderUVRect.endU,	self.sliderUVRect.endV )
		
		-- Draw ball
		local perc = 0.5 + (self.hvalue*0.5)
		xn_draw_overlay ( self.x + (perc*self.width) - (ballSize/2), self.y + self.height - ballSize,
			ballSize, ballSize, UI_TEXTURE,	self.ballColor.r, self.ballColor.g, self.ballColor.b, self.ballColor.a,
			self.ballUVRect.startU,	self.ballUVRect.startV, self.ballUVRect.endU, self.ballUVRect.endV )
	end	
}

colorPicker = control:new
{
	sliderUVRect = { startU=0.46, startV=0.704, endU=0.906, endV=0.673 },
	ballUVRect = { startU=0.648, startV=0.645, endU=0.711, endV=0.574 },

	cval = {r=1.0,g=1.0,b=1.0},
	colorChanged = false,
	
	Setup = function ( self, dTime )
		local ballSize = (self.height/5)+6

		if ( inputState.mouseLeftButtonDown and inputState.mouseX>=self.x and inputState.mouseX<=self.x+self.width )
		then
			local y2height5 = self.y+(2.0*self.height/5.0)
			local y3height5 = self.y+(3.0*self.height/5.0)

			if ( inputState.mouseY>=y2height5 and inputState.mouseY<y3height5 )
			then
				self.cval.r = (inputState.mouseX-self.x) / self.width
				self.colorChanged = true
			else
				local y4height5 = self.y+(4.0*self.height/5.0)

				if ( inputState.mouseY>=y3height5 and inputState.mouseY<y4height5 )
				then
					self.cval.g = (inputState.mouseX-self.x) / self.width
					self.colorChanged = true
				else
					if ( inputState.mouseY>=y4height5 and inputState.mouseY<self.y+self.height )
					then
						self.cval.b = (inputState.mouseX-self.x) / self.width
						self.colorChanged = true
					end
				end
			end
		end
	end,
	
	Draw = function ( self )
		local sliderHeight = self.height/5
		local ballSize = (self.height/5)+6
		local r = {1.0,0.0,0.0}
		local g = {0.0,1.0,0.0}
		local b = {0.0,0.0,1.0}
		local val = {"r","g","b"}
		local ySlider
		local valText
		local textWidth, textHeight
		
		-- Draw label
		local labelX
		if ( xn_is_rightToLeftCulture() )
		then
			local mX, mY = xn_measure_text(self.text)
			labelX = self.x + self.width - mX
		else
			labelX = self.x
		end
		
		xn_draw_text ( labelX, self.y, self.text, self.color.r, self.color.g, self.color.b, self.color.a )
		
		--Draw sliders and balls ( Lua starts arrays at 1 and for includes both ranges, remember! )
		for i=1,3 do
			ySlider = self.y + (sliderHeight*(i+1))

			-- Draw the color slider	
			xn_draw_overlay ( self.x, ySlider, self.width, sliderHeight, UI_TEXTURE,
				r[i], g[i], b[i], 1.0, self.sliderUVRect.startU, self.sliderUVRect.startV, self.sliderUVRect.endU,
				self.sliderUVRect.endV )
		
			-- Draw the ball slider
			xn_draw_overlay ( self.x + (self.cval[val[i]]*self.width) - (ballSize/2),
				 ySlider-3,	ballSize, ballSize,	UI_TEXTURE,	r[i], g[i], b[i], 1.0, self.ballUVRect.startU,
				self.ballUVRect.startV,	self.ballUVRect.endU, self.ballUVRect.endV )
				
			-- Draw the numeric value
			valText = string.format ( "%03u", math.floor(self.cval[val[i]]*255.0) )
			textWidth, textHeight = xn_measure_text(valText)

			xn_draw_text ( self.x+self.width+(ballSize/2)+1, ySlider+((sliderHeight-textHeight)*0.5), valText,
				r[i], g[i], b[i], 1.0 )
		end	
	end
}

colorBrowser = control:new
{
	r = 0.1, g = 0.1, b = 0.1,
	mouseOver = false,
	colorChanged = false,
	
	Setup = function ( self, dTime )
		self.colorChanged = false
		
		local xSelA, xSelB
		if ( xn_is_rightToLeftCulture() )
		then
			xSelA = self.x
			xSelB = self.x+40
		else
			xSelA = self.x+self.width-40
			xSelB = self.x+self.width
		end

		if ( inputState.mouseX>=xSelA and inputState.mouseX<xSelB and
			 inputState.mouseY>=self.y and inputState.mouseY<self.y+self.height )
		then
			self.mouseOver = true
			
			if ( inputState.mouseLeftButtonReleased )
			then
				local ok, rr, gg, bb = xn_color_browse(self.r,self.g,self.b)
				if ( ok )
				then
					self.r = rr
					self.g = gg
					self.b = bb
					self.colorChanged = true
				end
			end
		else
			self.mouseOver = false
		end
	end,
	
	Draw = function ( self )
		-- Draw label
		local labelX, boxX
		if ( xn_is_rightToLeftCulture() )
		then
			local mX, mY = xn_measure_text(self.text)
			labelX = self.x + self.width - mX
			boxX = self.x
		else
			labelX = self.x
			boxX = self.x+self.width-40
		end
		
		xn_draw_text ( labelX, self.y, self.text, self.color.r, self.color.g, self.color.b, self.color.a )
		
		--Draw a box filled with the color of the colorBrowser... if mouse is over draw a thick frame
		local rr = self.r * 0.5
		local gg = self.g * 0.5
		local bb = self.b * 0.5
		
		if ( false==self.mouseOver )
		then
			rr = 1.0 - self.r
			gg = 1.0 - self.g
			bb = 1.0 - self.b
		end
		
		xn_draw_overlay ( boxX, self.y+2, 40, self.height+1, "", rr, gg, bb, 1.0, 0.0, 0.0, 0.0, 0.0 )
		xn_draw_overlay ( boxX+1, self.y+3, 38, self.height-1, "", self.r, self.g, self.b, 1.0,
			0.0, 0.0, 0.0, 0.0 )
	end	
}


