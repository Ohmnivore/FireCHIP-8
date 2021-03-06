package emu;
import openfl.utils.ByteArray;
import openfl.utils.Endian;

/**
 * ...
 * @author Ohmnivore
 */
class Memory
{
	private var storage:Array<Int>;
	
	public function new()
	{
		init();
	}
	
	public function init():Void
	{
		storage = [
		0xF0, 0x90, 0x90, 0x90, 0xF0, //0
		0x20, 0x60, 0x20, 0x20, 0x70, //1
		0xF0, 0x10, 0xF0, 0x80, 0xF0, //2
		0xF0, 0x10, 0xF0, 0x10, 0xF0, //3
		0x90, 0x90, 0xF0, 0x10, 0x10, //4
		0xF0, 0x80, 0xF0, 0x10, 0xF0, //5
		0xF0, 0x80, 0xF0, 0x90, 0xF0, //6
		0xF0, 0x10, 0x20, 0x40, 0x40, //7
		0xF0, 0x90, 0xF0, 0x90, 0xF0, //8
		0xF0, 0x90, 0xF0, 0x10, 0xF0, //9
		0xF0, 0x90, 0xF0, 0x90, 0x90, //A
		0xE0, 0x90, 0xE0, 0x90, 0xE0, //B
		0xF0, 0x80, 0x80, 0x80, 0xF0, //C
		0xE0, 0x90, 0x90, 0x90, 0xE0, //D
		0xF0, 0x80, 0xF0, 0x80, 0xF0, //E
		0xF0, 0x80, 0xF0, 0x80, 0x80, //F
		];
		
		Util.fillArr(storage, 4096);
	}
	
	public function loadGame(B:ByteArray):Void
	{
		B.endian = Endian.BIG_ENDIAN;
		
		var i:Int = 0;
		while (B.bytesAvailable > 0)
		{
			var byte:Int = B.readByte() & 0xFF;
			//var byte:Int = B.readByte();
			storage[i + 0x200] = byte;
			
			i++;
		}
	}
	
	public function get(Addr:Int):Int
	{
		return storage[Addr];
	}
	
	public function set(Addr:Int, Value:Int):Void
	{
		storage[Addr] = Value;
	}
	
	public function getChar(Char:Int):Int
	{
		return 5 * Char;
	}
}