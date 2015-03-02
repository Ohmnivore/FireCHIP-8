package engine;
import openfl.media.Sound;
import openfl.events.SampleDataEvent;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

/**
 * ...
 * @author Ohmnivore
 */
class Tone extends Sound
{
	private static inline var freq:Float = 510;
	
	public var channel:SoundChannel;
	
	public function new() 
	{
		super();
		
		addEventListener(SampleDataEvent.SAMPLE_DATA, genSound);
		
		channel = play();
		channel.stop();
	}
	
	public function doPlay():Void
	{
		if (channel == null)
		{
			channel = play(0);
		}
	}
	
	public function doStop():Void
	{
		if (channel != null)
		{
			channel.stop();
			channel = null;
		}
	}
	
	//Mostly taken from here:
	//http://stackoverflow.com/questions/5555933/how-to-synthesize-exact-frequencies-on-flash
	private function genSound(E:SampleDataEvent):Void
	{
		var i:Int = 0;
		while (i < 4092)
		{
			var n:Float = Math.sin((i + E.position) * freq * 2.0 * Math.PI / 44100.0);
			E.data.writeFloat(n);
			E.data.writeFloat(n);
			i++;
		}
	}
}