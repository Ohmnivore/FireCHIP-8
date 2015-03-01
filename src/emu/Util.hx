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
}