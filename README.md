### [DEMO](http://fouramgames.com/swf/FireCHIP8.swf)
* P1 controls: 1 and Q
* P2 controls: 4 and R
* You'll see the screen (sorta) flickering. I'm not sure what's causing this, it's probably the delay for
the clr command, but other emulators have it too so it probably was this way on the original machines as well.

## What's CHIP-8 anyways?
* Basically an interpreted language in which Pong was originally written
* [Wikipedia entry](http://en.wikipedia.org/wiki/CHIP-8)

## What's FireCHIP-8?
* Just a CHIP-8 emulator
* Written in Haxe -> cross-platform
* The core, contained in the "src/emu" package, is independant from any libraries. This way
you can use interface it with the engine you need.
* The "src/engine" package contains classes that interface the core with the OpenFL engine.

## TODO:
* Figure out why the Stars demo isn't working, and why the Division Test program isn't finishing correctly
* Embedded program selector and load program from disk functionalities
* Test the rest of the games
* Sound (fixed frequency tone)

## References used:
* http://devernay.free.fr/hacks/chip8/C8TECH10.HTM
* http://devernay.free.fr/hacks/chip8/chip8def.htm
* http://www.multigesture.net/articles/how-to-write-an-emulator-chip-8-interpreter/
* http://en.wikipedia.org/wiki/CHIP-8#Opcode_table