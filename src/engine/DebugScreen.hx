package engine;
import emu.Registers;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.Font;
import openfl.Assets;

/**
 * ...
 * @author Ohmnivore
 */

@:font("Assets/fonts/Consolas.ttf")
class Consolas extends Font {}

class DebugScreen
{
	public static var fontName:Font = Assets.getFont("assets/fonts/Consolas.ttf");
	
	private var op:TextField;
	
	private var V0:TextField;
	private var V1:TextField;
	private var V2:TextField;
	private var V3:TextField;
	private var V4:TextField;
	private var V5:TextField;
	private var V6:TextField;
	private var V7:TextField;
	private var V8:TextField;
	private var V9:TextField;
	private var VA:TextField;
	private var VB:TextField;
	private var VC:TextField;
	private var VD:TextField;
	private var VE:TextField;
	private var VF:TextField;
	
	private var I:TextField;
	
	private var DT:TextField;
	private var ST:TextField;
	
	private var PC:TextField;
	private var SP:TextField;
	private var stack:TextField;
	
	private var yoffset:Int = 0;
	private var s:Sprite;
	
	public function new(S:Sprite) 
	{
		Font.registerFont(Consolas);
		s = S;
		
		op = initField("OP", op);
		V0 = initField("V0", V0);
		V1 = initField("V1", V1);
		V2 = initField("V2", V2);
		V3 = initField("V3", V3);
		V4 = initField("V4", V4);
		V5 = initField("V5", V5);
		V6 = initField("V6", V6);
		V7 = initField("V7", V7);
		V8 = initField("V8", V8);
		V9 = initField("V9", V9);
		VA = initField("VA", VA);
		VB = initField("VB", VB);
		VC = initField("VC", VC);
		VD = initField("VD", VD);
		VE = initField("VE", VE);
		VF = initField("VF", VF);
		I = initField("I", I);
		DT = initField("DT", DT);
		ST = initField("ST", ST);
		PC = initField("PC", PC);
		SP = initField("SP", SP);
		stack = initField("STACK", stack);
		
		op.textColor = 0xff0000;
		PC.textColor = 0xff0000;
		I.textColor = 0xff0000;
	}
	
	private function initField(Name:String, F:TextField):TextField
	{
		var fname:String = new Consolas().fontName;
		
		var n:TextField = new TextField();
		n.defaultTextFormat = new TextFormat(fname, 14, 0xffffff);
		n.embedFonts = true;
		n.x = 5;
		n.y = yoffset;
		n.text = Name + ": ";
		s.addChild(n);
		
		var F:TextField = new TextField();
		F.defaultTextFormat = new TextFormat(fname, 14, 0xffffff);
		F.embedFonts = true;
		F.x = n.x + 54;
		F.y = n.y;
		F.text = " ";
		s.addChild(F);
		
		yoffset += 14;
		return F;
	}
	
	public function update(CurOp:Int, Reg:Registers):Void
	{
		op.text = StringTools.hex(CurOp, 4);
		V0.text = StringTools.hex(Reg.V0, 2);
		V1.text = StringTools.hex(Reg.V1, 2);
		V2.text = StringTools.hex(Reg.V2, 2);
		V3.text = StringTools.hex(Reg.V3, 2);
		V4.text = StringTools.hex(Reg.V4, 2);
		V5.text = StringTools.hex(Reg.V5, 2);
		V6.text = StringTools.hex(Reg.V6, 2);
		V7.text = StringTools.hex(Reg.V7, 2);
		V8.text = StringTools.hex(Reg.V8, 2);
		V9.text = StringTools.hex(Reg.V9, 2);
		VA.text = StringTools.hex(Reg.VA, 2);
		VB.text = StringTools.hex(Reg.VB, 2);
		VC.text = StringTools.hex(Reg.VC, 2);
		VD.text = StringTools.hex(Reg.VD, 2);
		VE.text = StringTools.hex(Reg.VE, 2);
		VF.text = StringTools.hex(Reg.VF, 2);
		I.text = StringTools.hex(Reg.I, 2);
		DT.text = StringTools.hex(Reg.DT, 2);
		ST.text = StringTools.hex(Reg.ST, 2);
		PC.text = StringTools.hex(Reg.PC, 2);
		SP.text = StringTools.hex(Reg.SP, 2);
		stack.text = "";
		for (i in Reg.stack)
		{
			stack.text += StringTools.hex(i, 4) + ", ";
		}
	}
}