package emu;

/**
 * ...
 * @author Ohmnivore
 */
class Registers
{
	//8-bit registers
	public var V0:Int = 0;
	public var V1:Int = 0;
	public var V2:Int = 0;
	public var V3:Int = 0;
	public var V4:Int = 0;
	public var V5:Int = 0;
	public var V6:Int = 0;
	public var V7:Int = 0;
	public var V8:Int = 0;
	public var V9:Int = 0;
	public var VA:Int = 0;
	public var VB:Int = 0;
	public var VC:Int = 0;
	public var VD:Int = 0;
	public var VE:Int = 0;
	public var VF:Int = 0;
	
	//16-bit
	public var I:Int = 0;
	
	//Timers & sound
	public var DT:Int = 0;
	public var ST:Int = 0;
	
	//General
	public var PC:Int = 0x200; //Program counter
	public var SP:Int = 0; //Stack pointer
	public var stack:Array<Int> = [];
	
	public function new() 
	{
		Util.fillArr(stack, 16);
	}
	
	public function init():Void
	{
		var i:Int = 0;
		while (i <= 0xF)
		{
			setRegister(i, 0);
			i++;
		}
		DT = 0;
		ST = 0;
		PC = 0x200;
		SP = 0;
		stack = [];
	}
	
	public function incrementPC(By:Int = 2):Void
	{
		PC += By;
	}
	
	public function updateTimers():Void
	{
		DT--;
		ST--;
		
		if (DT < 0)
			DT = 0;
		if (ST < 0)
			ST = 0;
		
		if (ST > 0)
		{
			//play sound
		}
	}
	
	public function setRegister(ID:Int, Value:Int):Void
	{
		switch(ID)
		{
			case 0x0:
				V0 = Value;
			case 0x1:
				V1 = Value;
			case 0x2:
				V2 = Value;
			case 0x3:
				V3 = Value;
			case 0x4:
				V4 = Value;
			case 0x5:
				V5 = Value;
			case 0x6:
				V6 = Value;
			case 0x7:
				V7 = Value;
			case 0x8:
				V8 = Value;
			case 0x9:
				V9 = Value;
			case 0xA:
				VA = Value;
			case 0xB:
				VB = Value;
			case 0xC:
				VC = Value;
			case 0xD:
				VD = Value;
			case 0xE:
				VE = Value;
			case 0xF:
				VF = Value;
		}
	}
	
	public function getRegister(ID:Int):Int
	{
		switch(ID)
		{
			case 0x0:
				return V0;
			case 0x1:
				return V1;
			case 0x2:
				return V2;
			case 0x3:
				return V3;
			case 0x4:
				return V4;
			case 0x5:
				return V5;
			case 0x6:
				return V6;
			case 0x7:
				return V7;
			case 0x8:
				return V8;
			case 0x9:
				return V9;
			case 0xA:
				return VA;
			case 0xB:
				return VB;
			case 0xC:
				return VC;
			case 0xD:
				return VD;
			case 0xE:
				return VE;
			case 0xF:
				return VF;
		}
		
		return 0;
	}
}