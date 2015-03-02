package emu;
import haxe.Timer;
import openfl.Assets;
import openfl.utils.ByteArray;

/**
 * ...
 * @author Ohmnivore
 */
class Chip8
{
	private static inline var CYCLE_PER_SEC:Float = 60.0;
	
	public var cpu:CPU;
	public var mem:Memory;
	public var gfx:Gfx;
	public var keys:Keys;
	
	private var timer:Timer;
	private var dt:Int = 0;
	
	public var onDraw:Void->Void;
	
	public function new() 
	{
		init(true);
	}
	
	private function init(AutoRun:Bool = false):Void
	{
		mem = new Memory();
		gfx = new Gfx();
		keys = new Keys();
		cpu = new CPU(mem, gfx, keys);
		
		if (AutoRun)
		{
			timer = new Timer(cast 1000.0 / CYCLE_PER_SEC);
			timer.run = run;
		}
	}
	
	public function loadGame(Game:ByteArray):Void
	{
		gfx.clear();
		cpu.init();
		mem.init();
		
		mem.loadGame(Game);
	}
	
	public function run():Void
	{
		dt += Util.getMsElapsed();
		var max:Int = Math.floor(dt / 2);
		if (max > 20)
			max = 20;
		var i:Int = 0;
		while (i < max)
		{
			cpu.runCycle();
			if (onDraw != null && cpu.drawFlag)
			{
				onDraw();
			}
			i++;
		}
		
		dt = dt % 2;
	}
}