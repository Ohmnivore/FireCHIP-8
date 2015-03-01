package emu;

/**
 * ...
 * @author Ohmnivore
 */
class Gfx
{
	private var gfx:Array<Int> = [];
	
	public function new() 
	{
		Util.fillArr(gfx, 2048);
	}
	
	public function clear():Void
	{
		var i:Int = 0;
		while (i < gfx.length)
		{
			gfx[i] = 0;
			
			i++;
		}
	}
	
	public function draw(X:Int, Y:Int, Height:Int, Reg:Registers, Cpu:CPU, Mem:Memory):Void
	{
		var x:Int = X;
		var y:Int = Y;
		var height:Int = Height;
		var pixel:Int = 0;
		
		Reg.VF = 0;
		
		var yline:Int = 0;
		while (yline < height)
		{
			pixel = Mem.get(Reg.I + yline);
			
			var xline:Int = 0;
			while (xline < 8)
			{
				if((pixel & (0x80 >> xline)) != 0)
				{
					if(gfx[(x + xline + ((y + yline) * 64))] == 1)
						Reg.VF = 1;                                 
					gfx[x + xline + ((y + yline) * 64)] ^= 1;
				}
				
				xline++;
			}
			
			yline++;
		}
		
		Cpu.drawFlag = true;
		Reg.incrementPC();
	}
	
	public function getGfx():Array<Int>
	{
		return gfx;
	}
}