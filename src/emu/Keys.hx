package emu;
import flash.display.Stage;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author Ohmnivore
 */
class Keys
{
	public var K1:Bool = false;
	public var K2:Bool = false;
	public var K3:Bool = false;
	public var KC:Bool = false;
	public var K4:Bool = false;
	public var K5:Bool = false;
	public var K6:Bool = false;
	public var KD:Bool = false;
	public var K7:Bool = false;
	public var K8:Bool = false;
	public var K9:Bool = false;
	public var KE:Bool = false;
	public var KA:Bool = false;
	public var K0:Bool = false;
	public var KB:Bool = false;
	public var KF:Bool = false;
	
	public function new()
	{
		
	}
	
	public function getFirst():Int
	{
		var i:Int = 0;
		while (i <= 0xF)
		{
			if (get(i) == true)
				return i;
			i++;
		}
		return -1;
	}
	
	public function get(ID:Int):Bool
	{
		var ret:Bool = false;
		switch (ID)
		{
			case 0x0:
				ret = K0;
			case 0x1:
				ret = K1;
			case 0x2:
				ret = K2;
			case 0x3:
				ret = K3;
			case 0x4:
				ret = K4;
			case 0x5:
				ret = K5;
			case 0x6:
				ret = K6;
			case 0x7:
				ret = K7;
			case 0x8:
				ret = K8;
			case 0x9:
				ret = K9;
			case 0xA:
				ret = KA;
			case 0xB:
				ret = KB;
			case 0xC:
				ret = KC;
			case 0xD:
				ret = KD;
			case 0xE:
				ret = KE;
			case 0xF:
				ret = KF;
		}
		return ret;
	}
}