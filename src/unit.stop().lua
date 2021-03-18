--Script Information
--Version: 0.1
--Created by:
	-- Discord: Kronius12#3176
	-- DU in-game: Kronius
--GitHub: https://github.com/kronius12/DU-BreathingLights-Lua
--Distributed under GNU General Public License version 3

-- based on script by Mucus

if debugLevel > 0  then
    system.print("Stopping: #lights="..#lights.." brightnessWhenOff="..brightnessWhenOff) 
end

for i = 1, #lights do
	if brightnessWhenOff > 0 then
		lights[i].setRGBColor(brightnessWhenOff,brightnessWhenOff,brightnessWhenOff)
	else
		lights[i].deactivate()
	end
    if debugLevel > 1 then system.print("Light "..i.." RGB set to "..brightnessWhenOff) end
end
