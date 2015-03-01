package ;

import emu.Chip8;
import engine.DebugKeys;
import engine.DebugScreen;
import engine.KeyboardKeys;
import engine.Screen;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.Assets;
import openfl.display.FPS;

/**
 * ...
 * @author Ohmnivore
 */

class Main extends Sprite 
{
	private var screen:Screen;
	private var chip8:Chip8;
	private var debug:DebugScreen;
	private var debugKeys:DebugKeys;
	private var keys:KeyboardKeys;
	private var fps:FPS;
	
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
		chip8 = new Chip8();
		
		//Games
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Games/Airplane.ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Games/Pong [Paul Vervalin, 1990].ch8"));
		
		//Non-tested or non-working demos and programs
		chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Stars [Sergey Naydenov, 2010].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Division Test [Sergey Naydenov, 2010].ch8"));
		
		//Working demos and programs
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Zero Demo [zeroZshadow, 2007].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Particle Demo [zeroZshadow, 2008].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Maze [David Winter, 199x].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Maze (alt) [David Winter, 199x].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Trip8 Demo (2008) [Revival Studios].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Sierpinski [Sergey Naydenov, 2010].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Demos/Sirpinski [Sergey Naydenov, 2010].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Fishie [Hap, 2005].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/BMP Viewer - Hello (C8 example) [Hap, 2005].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Chip8 emulator Logo [Garstyciuks].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Chip8 Picture.ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/SQRT Test [Sergey Naydenov, 2010].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Jumping X and O [Harry Kleinberg, 1977].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Framed MK1 [GV Samways, 1980].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Framed MK2 [GV Samways, 1980].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/IBM Logo.ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Random Number Test [Matthew Mikolay, 2010].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Minimal game [Revival Studios, 2007].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Clock Program [Bill Fisher, 1981].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Delay Timer Test [Matthew Mikolay, 2010].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Keypad Test [Hap, 2006].ch8"));
		//chip8.loadGame(Assets.getBytes("assets/chip8/Chip-8 Programs/Life [GV Samways, 1980].ch8"));
		
		chip8.onDraw = drawScreen;
		
		screen = new Screen();
		screen.x = stage.stageWidth - screen.width;
		addChild(screen);
		
		fps = new FPS(5, 5, 0xFFFFFF);
		fps.x = stage.stageWidth - fps.width;
		addChild(fps);
		
		debugKeys = new DebugKeys(stage);
		debug = new DebugScreen(this);
		keys = new KeyboardKeys(stage);
		
		addEventListener(Event.ENTER_FRAME, everyFrame);
	}
	
	private function drawScreen():Void
	{
		screen.drawArray(chip8.gfx.getGfx());
	}
	
	private function everyFrame(E:Event):Void
	{
		if (debugKeys.doRun)
			runChip8();
		else if (debugKeys.doNext)
		{
			debugKeys.consumeNext();
			runChip8();
		}
	}
	
	private function runChip8():Void
	{
		keys.setKeys(chip8.keys);
		chip8.run();
		debug.update(chip8.cpu.curOp, chip8.cpu.reg);
	}
	
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
