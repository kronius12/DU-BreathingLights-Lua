# DU-BreathingLights-Lua
**Dual Universe (game) - lights linked to multiple program boards pulse together in sequence**

GitHub: https://github.com/kronius12/DU-BreathingLights-Lua

## Description
This optionally uses a seeded pseudo-random number generator (PRNG) to ensure all boards 
with the same params produce the same sequences and timing. 

Background: Was unable to use library methods because other programming boards
within the game interfere with the sequence when they also call math.randomseed() & math.random(). 
The Linear Congruential Generator used is good enough for the purpose of making lights go different colours.
For PRNG explanation see [Wikipedia](https://en.wikipedia.org/wiki/Linear_congruential_generator).

## Usage
1. Link a manual switch or detection zone to a relay \[to more relays] to programming boards to lights.
1. Open DU-BreathingLights.conf.txt in a text editor, copy the contents.
1. On each program board right-click > Advanced > Paste Lua configuration. *Warning: this will replace any programs already on the board.*
1. Turn on the switch or enter the detector zone, and the lights will pulse in sequence.

## Parameters
Right-click > Advanced > Edit Lua parameters

* pseudoRandom     = **1** or 0: 1 gives same sequence for a given seed, 0 makes the sequence different every time and on every board
* pseudoRandomSeed = **9564** (integer): If pseudoRandom=1 above, boards with this seed will produce the same sequence of colours
* breathRate       = **1:** Rate of breathing Multiplier      ) In combination these two govern
* changeFrame      = **1201:** Frame colour and channel cycle ) how quickly the lights change.
* brightnessWhenOff = **122** \[0..255]: White level set when program board is turned off

## License
Distributed under GNU General Public License version 3

## Credits
Created by:
* github.com: @Kronius12
* Discord: Kronius12#3176
* In-game (Dual Universe): Kronius

Based on script by Mucus and incorporating snippets by other authors, with thanks. For a full list see [CREDITS.md](https://github.com/kronius12/DU-BreathingLights-Lua/CREDITS.md).

## TO DO
1. Use databank if one is connected, to save and read initialization values to ensure consistent timing across PBs.
1. Implement pseudo-random generator as a class rather than functions, so it can be more generally useful elsewhere.
1. Option to apply lights' original RGB and on/off state in unit.stop().
1. More standard way of distributing it to players.