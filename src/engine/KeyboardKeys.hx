package engine;
import emu.Keys;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author Ohmnivore
 */
class KeyboardKeys
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
	
	public function new(S:Stage)
	{
		S.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		S.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	public function setKeys(K:Keys):Void
	{
		K.K0 = K0;
		K.K1 = K1;
		K.K2 = K2;
		K.K3 = K3;
		K.K4 = K4;
		K.K5 = K5;
		K.K6 = K6;
		K.K7 = K7;
		K.K8 = K8;
		K.K9 = K9;
		K.KA = KA;
		K.KB = KB;
		K.KC = KC;
		K.KD = KD;
		K.KE = KE;
		K.KF = KF;
	}
	
	private function onKeyDown(evt:KeyboardEvent):Void
	{
		switch (evt.keyCode)
		{
			case 49: //1 -> 1
				set(1);
			case 50: //2 -> 2
				set(2);
			case 51: //3 -> 3
				set(3);
			case 52: //4 -> C
				set(0xC);
			
			case 81: //Q -> 4
				set(4);
			case 87: //W -> 5
				set(5);
			case 69: //E -> 6
				set(6);
			case 82: //R -> D
				set(0xD);
			
			case 65: //A -> 7
				set(7);
			case 83: //S -> 8
				set(8);
			case 68: //D -> 9
				set(9);
			case 70: //F -> E
				set(0xE);
			
			case 90: //Z -> A
				set(0xA);
			case 88: //X -> 0
				set(0);
			case 67: //C -> B
				set(0xB);
			case 86: //V -> F
				set(0xF);
		}
	}
	
	private function onKeyUp(evt:KeyboardEvent):Void
	{
		switch (evt.keyCode)
		{
			case 49: //1 -> 1
				set(1, false);
			case 50: //2 -> 2
				set(2, false);
			case 51: //3 -> 3
				set(3, false);
			case 52: //4 -> C
				set(0xC, false);
			
			case 81: //Q -> 4
				set(4, false);
			case 87: //W -> 5
				set(5, false);
			case 69: //E -> 6
				set(6, false);
			case 82: //R -> D
				set(0xD, false);
			
			case 65: //A -> 7
				set(7, false);
			case 83: //S -> 8
				set(8, false);
			case 68: //D -> 9
				set(9, false);
			case 70: //F -> E
				set(0xE, false);
			
			case 90: //Z -> A
				set(0xA, false);
			case 88: //X -> 0
				set(0, false);
			case 67: //C -> B
				set(0xB, false);
			case 86: //V -> F
				set(0xF, false);
		}
	}
	
	private function set(ID:Int, Pressed:Bool = true):Void
	{
		switch (ID)
		{
			case 0x0:
				K0 = Pressed;
			case 0x1:
				K1 = Pressed;
			case 0x2:
				K2 = Pressed;
			case 0x3:
				K3 = Pressed;
			case 0x4:
				K4 = Pressed;
			case 0x5:
				K5 = Pressed;
			case 0x6:
				K6 = Pressed;
			case 0x7:
				K7 = Pressed;
			case 0x8:
				K8 = Pressed;
			case 0x9:
				K9 = Pressed;
			case 0xA:
				KA = Pressed;
			case 0xB:
				KB = Pressed;
			case 0xC:
				KC = Pressed;
			case 0xD:
				KD = Pressed;
			case 0xE:
				KE = Pressed;
			case 0xF:
				KF = Pressed;
		}
	}
}