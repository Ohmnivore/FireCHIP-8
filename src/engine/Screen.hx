package engine;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

/**
 * ...
 * @author Ohmnivore
 */
class Screen extends Bitmap
{
	public function new() 
	{
		super(new BitmapData(64, 32, false, 0xFF000000));
		
		scaleX = 5;
		scaleY = 5;
	}
	
	public function drawArray(Arr:Array<Int>):Void
	{
		var iY:Int = 0;
		while (iY < 32)
		{
			var iX:Int = 0;
			while (iX < 64)
			{
				var value:Int = Arr[iY * 64 + iX];
				
				if (value == 0)
				{
					bitmapData.setPixel(iX, iY, 0x000000);
				}
				else
				{
					bitmapData.setPixel(iX, iY, 0xFFFFFF);
				}
				
				iX++;
			}
			
			iY++;
		}
	}
}