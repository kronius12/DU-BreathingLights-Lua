# du-lightsheartbeat
Dual Universe (game) - lights beat in repeatable sequence

## Usage
1. Link a manual switch or detection zone to a relay \[to more relays] to programming boards to lights.
2. Open the du-lightsheartbeat.conf.txt file in a text editor, copy the contents.
3. On each program board right-click > Advanced > Paste Lua configuration. *Warning: this will replace any programs already on the board.*
4. Turn on the switch or enter the detector zone, and the lights will pulse in sequence.

## Parameters
Right-click > Advanced > Edit Lua parameters

* pseudoRandom     = **1** or 0: 1 gives same sequence for a given seed, 0 makes the sequence different every time and on every board
* pseudoRandomSeed = **9564** (integer): If pseudoRandom=1 is selected above, then boards with this seed value (integer) will produce the same sequence of colours; see Wikipedia article below for how this is selected.
* breathRate       = **1:** Rate of breathing Multiplier      ) In combination these two govern
* changeFrame      = **1201:** Frame colour and channel cycle ) how quickly the lights change.
* brightnessWhenOff = **122** \[0..255]: White level when program board is turned off

## Credits
Based on script by Mucus and incorporating snippets by other authors.
-- https://board.dualthegame.com/index.php?/topic/22118-lua-lights-rgb-breathe-script/

Release memory to reduce lag
-- Jey123456 - 12 Oct 2020 in #du-lua https://dualuniverse.chat/

Code fragment that detects elements
-- adapted a script seen somewhere, seeking author to credit

Linear Congruential random number generator
-- based on https://en.wikipedia.org/wiki/Linear_congruential_generator
