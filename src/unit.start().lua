--Script Information
--Version: 0.1
--Created by:
	-- Discord: Kronius12#3176
	-- DU in-game: Kronius
--GitHub: https://github.com/kronius12/DU-BreathingLights-Lua
--Distributed under GNU General Public License version 3

-- based on scripts by Mucus, Jey123456, Rost, Igor Skoric

--Script parameters
debugLevel       = 0     -- Level 1: basic messages - Level 2: verbose
pseudoRandom     = 1    --export: 1 gives same sequence for the given seed, 0 makes the sequence different every time and on every board
pseudoRandomSeed = 9564 --export: If pseudoRandom=1 above, boards with this seed will produce the same sequence of colours
breathRate       = 1    --export: Rate of breathing Multiplier
changeFrame      = 1201 --export: Frame colour and channel cycle
brightnessWhenOff = 122 --export: White level when program is turned off (0..255)

--Initialize global variables
r, g, b, prngM, prngA, prngC, prngX = 0, 0, 0, 0, 0, 0, 0

function round(num, numDecimalPlaces)
	-- Igor Skoric (i.skoric@student.tugraz.at)
    local mult = 10^(numDecimalPlaces or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

function initializePseudoRandom(pseudoRandomSeed)
	-- Initialize pseudo-random number generator...
	-- See Wikipedia for how to select these parameters.
	prngM = 134456 
	prngA = 8121
	prngC = 28411
	prngX = round(math.abs(pseudoRandomSeed) * prngM / 256, 0)
	if debugLevel > 1 then system.print("initializePseudoRandom("..pseudoRandomSeed..")") end
	return getPseudoRandom(1) -- consume the seed value to start the sequence
end

function getPseudoRandom(maxValue) 
	-- returns an integer in 0..maxValue
	prngX = (prngA * prngX + prngC) % prngM
	if debugLevel > 1 then system.print("getPseudoRandom("..maxValue..") = "..(math.floor(maxValue * prngX / prngM))) end
	return math.floor((maxValue + 1) * prngX / prngM)
end

function initializeRGB() 
	-- resets global rgb values
	if pseudoRandom == 0 then
		r               = math.random(255) -- setup channels
		g               = math.random(255)
		b               = math.random(255)
	else
		r               = getPseudoRandom(255)
		g               = getPseudoRandom(255)
		b               = getPseudoRandom(255)
	end
	if debugLevel > 1 then system.print("initializeRGB: "..r..","..g..","..b) end
end

function chooseRgbIndex()
	-- picks a channel to vary next
	local rgbIndex=0
	if pseudoRandom == 0 then
		rgbIndex = round(math.random(2)) -- choose channel to breathe
	else
		rgbIndex = getPseudoRandom(2)
	end
	if debugLevel > 1 then system.print("chooseRgbIndex: "..rgbIndex) end
	return rgbIndex
end

function detectLinkedElements(list, classNameContains)
	-- populates list with elements of classNameContains
	list = list or {}
	for key, value in pairs(unit) do
	  if type(value) == "table" and type(value.export) == "table" then -- `value` is an element and `key` is the slot name
		if value.getElementClass then --if it has a class
		  if string.find(string.lower(value.getElementClass()), classNameContains) then --if its element class contains classNameContains
			   list[#list + 1] = value 
			   if debugLevel > 1 then system.print(value.getElementClass().."["..#list.."] found") end
		  end
		end
	  end
	end 

	if debugLevel > 0 then system.print(classNameContains.." links found: "..#list) end
	return list
end

lights = detectLinkedElements({}, "light")
if lights then
    for i = 1, #lights do
        lights[i].activate()
		lights[i].setRGBColor(255,255,255)
    end
	origRgb = lights[1].getRGBColor() -- stores the colour of the original light if you want to reset lights on exit
	if debugLevel > 0 then system.print("origRgb = "..origRgb) end
else

	system.print("ERROR: No lights found. Please link some lights to the program board.")
	origRgb = {0,0,0}

end

-- initialize heartbeat sequence

bClock          = system.getTime() -- start clock
frameCount      = 0
initializePseudoRandom(pseudoRandomSeed)
rgbIndex = chooseRgbIndex()
initializeRGB()
-- unit.hide() -- hides programming board if desired (doesn't seem to work most of the time)

-- release memory to reduce lag - Jey123456 - 12 Oct 2020 in #du-lua https://dualuniverse.chat/
json = nil
vec3 = nil
AxisCommandManager = nil
-- utils = nil
Navigator = nil
constants = nil
-- database = nil
SGui = nil
sgui = nil
ClickableArea = nil
axisCommandType = nil
getAxisAngleRad = nil
AxisCommand = nil
collectgarbage("collect")
