package engine;
import emu.Chip8;

/**
 * ...
 * @author Ohmnivore
 */
class DebugChip8 extends Chip8
{
	private var debugScreen:DebugScreen;
	private var debugKeys:DebugKeys;
	private var keyboardKeys:KeyboardKeys;
	
	public function new(DS:DebugScreen, DK:DebugKeys, K:KeyboardKeys) 
	{
		debugScreen = DS;
		debugKeys = DK;
		keyboardKeys = K;
		super();
	}
	
	override public function run():Void 
	{
		#if !debug
		runChip8();
		#else
		if (debugKeys.doRun)
			runChip8();
		else if (debugKeys.doNext)
		{
			debugKeys.consumeNext();
			runChip8();
		}
		#end
	}
	
	private function runChip8():Void
	{
		keyboardKeys.setKeys(keys);
		super.run();
		debugScreen.update(cpu.curOp, cpu.reg);
	}
}