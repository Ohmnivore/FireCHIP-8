package emu;

/**
 * ...
 * @author Ohmnivore
 */
class Util
{
	public static function fillArr(Arr:Array<Int>, Length:Int):Void
	{
		var i:Int = Arr.length;
		while (i <= Length - Arr.length)
		{
			Arr.push(0);
			
			i++;
		}
	}
	
	private static var dt:Float = 0;
	public static function getMsElapsed():Int
	{
		#if flash
		return flash.Lib.getTimer();
		#elseif (neko || cpp || java || python || php || cs)
		var t:Float = Sys.cpuTime();
		var ret:Float = dt - t;
		dt = t;
		return Math.floor(ret * 1000);
		#else
		return 16;
		#end
	}
}