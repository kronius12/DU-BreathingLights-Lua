--Script Information
--Version: 0.1
--Created by:
	-- Discord: Kronius12#3176
	-- DU in-game: Kronius
--GitHub: https://github.com/kronius12/DU-BreathingLights-Lua
--Distributed under GNU General Public License version 3

-- based on script by Mucus

frameCount = frameCount + 1

if ( frameCount % changeFrame == 0 ) then --re-initialize rgb and channel
	initializeRGB()
	rgbIndex=chooseRgbIndex()
	frameCount=0
	if debugLevel > 0 then system.print("Colors reset: rgbIndex="..rgbIndex) end
end

nClock = system.getTime()
local timeSeconds = ( nClock - bClock)
local breath = round(( math.exp( math.sin(timeSeconds * breathRate )) - 0.36787944 )* 108.0)

if rgbIndex == 1 then

    r = breath

    elseif rgbIndex == 2 then

    g = breath

    else

    b = breath

end 
if debugLevel > 2 then system.print(frameCount..": "..r..","..g..","..b) end

-- set rgb colour of linked lights
	
if lights then

	for i = 1, #lights do
		lights[i].setRGBColor(r,g,b)
	end

end
