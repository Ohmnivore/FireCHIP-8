package emu;

import haxe.Timer;

/**
 * ...
 * @author Ohmnivore
 */
class CPU
{
	public var reg:Registers;
	public var mem:Memory;
	public var gfx:Gfx;
	public var keys:Keys;
	
	public var drawFlag:Bool = false;
	public var curOp:Int = -1;
	
	public function new(Mem:Memory, G:Gfx, K:Keys) 
	{
		reg = new Registers();
		mem = Mem;
		gfx = G;
		keys = K;
	}
	
	public function init():Void
	{
		reg.init();
		drawFlag = false;
	}
	
	public function runCycle():Void
	{
		var opcode:Int = mem.get(reg.PC) << 8 | mem.get(reg.PC + 1);
		
		if (opcode != 0)
		{
			reg.updateTimers();
			execute(opcode);
		}
	}
	
	private function execute(Opcode:Int):Void
	{
		//trace(StringTools.hex(Opcode, 4));
		curOp = Opcode;
		drawFlag = false;
		
		//keys
		if (Opcode >= 0xE000 && Opcode < 0xF000)
		{
			var lastTwo:Int = Opcode & 0x00FF;
			var regID1:Int = (Opcode & 0x0F00) >> 8;
			
			if (lastTwo == 0x9E) //skpr k
			{
				if (keys.get(reg.getRegister(regID1)) == true)
				{
					trace("0x9E", reg.getRegister(regID1));
					reg.incrementPC();
				}
				reg.incrementPC();
			}
			else if (lastTwo == 0xA1) //skup k
			{
				if (keys.get(reg.getRegister(regID1)) == false)
				{
					trace("0xA1", reg.getRegister(regID1));
					reg.incrementPC();
				}
				reg.incrementPC();
			}
		}
		else if (Opcode & 0xF0FF == 0xF00A)
		{
			var regID:Int = (Opcode & 0x0F00) >> 8;
			var key:Int = keys.getFirst();
			if (key != -1)
			{
				reg.setRegister(regID, key);
				reg.incrementPC();
			}
		}
		
		//gfx
		if (Opcode == 0x00E0) //clr
		{
			gfx.clear();
			reg.incrementPC();
		}
		else if (Opcode >= 0xD000 && Opcode < 0xE000) //sprite rx,ry,s
		{
			var regID1:Int = (Opcode & 0x0F00) >> 8;
			var regID2:Int = (Opcode & 0x00F0) >> 4;
			var third:Int = Opcode & 0x000F;
			
			//gfx.draw(reg.getRegister(regID1), reg.getRegister(regID2), third, reg, this, mem);
			gfx.draw(reg.getRegister(regID1), reg.getRegister(regID2), third, reg, this, mem);
			drawFlag = true;
		}
		
		//jumps and calls
		else if (Opcode == 0x00EE) //rts
		{
			reg.SP--;
			reg.PC = reg.stack[reg.SP];
			reg.stack.pop();
		}
		else if (Opcode >= 0x1000 && Opcode < 0x2000) //jmp xxx
		{
			reg.PC = Opcode & 0x0FFF;
		}
		else if (Opcode >= 0x2000 && Opcode < 0x3000) //jsr xxx
		{
			reg.PC += 2;
			//reg.stack[reg.SP] = reg.PC;
			reg.stack.push(reg.PC);
			reg.SP++;
			reg.PC = Opcode & 0x0FFF;
		}
		else if (Opcode >= 0xB000 && Opcode < 0xC000) //jmp xxx + value in V0
		{
			//reg.stack[reg.SP] = reg.PC;
			//reg.SP++;
			//reg.PC = (Opcode & 0x0FFF) + reg.V0;
		}
		
		//compare and skips
		else if (Opcode >= 0x3000 && Opcode < 0x4000) //skeq vr, xx
		{
			var regID:Int = (Opcode & 0x0F00) >> 8;
			var const:Int = Opcode & 0x00FF;
			
			if (reg.getRegister(regID) == const)
			{
				reg.incrementPC();
			}
			
			reg.incrementPC();
		}
		else if (Opcode >= 0x4000 && Opcode < 0x5000) //skne vr, xx
		{
			var regID:Int = (Opcode & 0x0F00) >> 8;
			var const:Int = Opcode & 0x00FF;
			
			if (reg.getRegister(regID) != const)
			{
				reg.incrementPC();
			}
			
			reg.incrementPC();
		}
		else if (Opcode >= 0x5000 && Opcode < 0x6000) //skeq vr, vy
		{
			var regID1:Int = (Opcode & 0x0F00) >> 8;
			var regID2:Int = (Opcode & 0x00F0) >> 4;
			
			if (reg.getRegister(regID1) == reg.getRegister(regID2))
			{
				reg.incrementPC();
			}
			
			reg.incrementPC();
		}
		else if (Opcode >= 0x9000 && Opcode < 0xA000) //skne vr, vy
		{
			var regID1:Int = (Opcode & 0x0F00) >> 8;
			var regID2:Int = (Opcode & 0x00F0) >> 4;
			
			if (reg.getRegister(regID1) != reg.getRegister(regID2))
			{
				reg.incrementPC();
			}
			
			reg.incrementPC();
		}
		
		//reg ops
		else if (Opcode >= 0x6000 && Opcode < 0x7000) //mov vr, xxx
		{
			var regID:Int = (Opcode & 0x0F00) >> 8;
			var const:Int = Opcode & 0x00FF;
			
			reg.setRegister(regID, const);
			
			reg.incrementPC();
		}
		else if (Opcode >= 0x7000 && Opcode < 0x8000) //add vr, xx
		{
			var regID:Int = (Opcode & 0x0F00) >> 8;
			var const:Int = Opcode & 0x00FF;
			
			var regValue:Int = reg.getRegister(regID);
			//wraparound, simulate 8-bit register
			reg.setRegister(regID, (regValue + const) % (0xFF + 1));
			
			reg.incrementPC();
		}
		else if (Opcode >= 0xA000 && Opcode < 0xB000) //mvi xxx
		{
			var const:Int = Opcode & 0x0FFF;
			reg.I = const;
			
			reg.incrementPC();
		}
		else if (Opcode >= 0xB000 && Opcode < 0xC000) //jmi xxx
		{
			reg.PC = reg.getRegister(0) + (Opcode & 0x0FFF);
		}
		else if (Opcode >= 0xC000 && Opcode < 0xD000) //rand vr, xxx
		{
			var regID:Int = (Opcode & 0x0F00) >> 8;
			var const:Int = Opcode & 0x00FF;
			
			reg.setRegister(regID, Std.random(const + 1));
			
			reg.incrementPC();
		}
		
		//8xxx opcodes
		else if (Opcode >= 0x8000 && Opcode < 0x9000)
		{
			var regID1:Int = (Opcode & 0x0F00) >> 8;
			var regID2:Int = (Opcode & 0x00F0) >> 4;
			
			switch(Opcode & 0x000F)
			{
				case 0x0: //mov vr,vy
					reg.setRegister(regID1, reg.getRegister(regID2));
					
				case 0x1: //or rx,ry
					var regValue:Int = reg.getRegister(regID1);
					reg.setRegister(regID1, regValue | reg.getRegister(regID2));
					
				case 0x2: //and rx,ry
					var regValue:Int = reg.getRegister(regID1);
					reg.setRegister(regID1, regValue & reg.getRegister(regID2));
					
				case 0x3: //xor rx,ry
					var regValue:Int = reg.getRegister(regID1);
					reg.setRegister(regID1, regValue ^ reg.getRegister(regID2));
					
				case 0x4: //add vr,vy
					var regValue:Int = reg.getRegister(regID1);
					var sum:Int = regValue + reg.getRegister(regID2);
					if (sum > 0xFF)
						reg.VF = 1;
					else
						reg.VF = 0;
					//wraparound, simulate 8-bit register
					reg.setRegister(regID1, sum % (0xFF + 1));
					
				case 0x5: //sub vr,vy
					var regValue:Int = reg.getRegister(regID1);
					var regValue2:Int = reg.getRegister(regID2);
					var diff:Int = regValue - regValue2;
					if (regValue > regValue2)
						reg.VF = 1;
					else
						reg.VF = 0;
					if (diff < 0)
						diff += 0xFF + 1;
					//wraparound, simulate 8-bit register
					reg.setRegister(regID1, diff % (0xFF + 1));
					
				case 0x7: //rsb vr, vy
					var regValue:Int = reg.getRegister(regID2);
					var regValue2:Int = reg.getRegister(regID1);
					var diff:Int = regValue - regValue2;
					if (regValue > regValue2)
						reg.VF = 1;
					else
						reg.VF = 0;
					if (diff < 0)
						diff += 0xFF + 1;
					//wraparound, simulate 8-bit register
					reg.setRegister(regID1, diff % (0xFF + 1));
				
				case 0x6: //shr vr
					var regValue:Int = reg.getRegister(regID1);
					var rightBit:Int = regValue & 1;
					reg.VF = rightBit;
					reg.setRegister(regID1, regValue >> 1);
					
				case 0xE: //shl vr
					var regValue:Int = reg.getRegister(regID1);
					if (regValue >= 0x80) //128
						reg.VF = 1;
					else
						reg.VF = 0;
					reg.setRegister(regID1, regValue << 1);
			}
			
			reg.incrementPC();
		}
		
		else if (Opcode >= 0xF000)
		{
			var lastTwo:Int = Opcode & 0x00FF;
			var regID1:Int = (Opcode & 0x0F00) >> 8;
			var regID2:Int = (Opcode & 0x00F0) >> 4;
			
			switch(lastTwo)
			{
				case 0x07: //gdelay vr
					reg.setRegister(regID1, reg.DT);
					reg.incrementPC();
				
				case 0x15: //sdelay vr
					reg.DT = reg.getRegister(regID1);
					reg.incrementPC();
				
				case 0x18: //ssound vr
					reg.ST = reg.getRegister(regID1);
					reg.incrementPC();
				
				case 0x1E: //adi vr
					var regValue:Int = reg.getRegister(regID1);
					reg.I += regValue;
					reg.incrementPC();
				
				case 0x29: //font vr
					var char:Int = reg.getRegister(regID1);
					//var char:Int = regID1;
					reg.I = mem.getChar(char);
					reg.incrementPC();
				
				case 0x33: //bcd vr
					var value:Int = reg.getRegister(regID1);
					mem.set(reg.I, cast value / 100);
					mem.set(reg.I + 1, cast (value / 10) % 10);
					mem.set(reg.I + 2, (value % 100) % 10);
				    reg.incrementPC();
				
				case 0x55: //str v0-vr
					var i:Int = 0;
					while (i <= (Opcode & 0x0F00) >> 8)
					{
						mem.set(reg.I, reg.getRegister(i));
						
						i++;
						reg.I++;
					}
					reg.incrementPC();
				
				case 0x65: //ldr v0-vr
					var i:Int = 0;
					while (i <= (Opcode & 0x0F00) >> 8)
					{
						reg.setRegister(i, mem.get(reg.I));
						
						i++;
						reg.I++;
					}
					reg.incrementPC();
			}
		}
		
		else if (Opcode & 0xF000 == 0x0000)
		{
			reg.incrementPC();
		}
	}
}