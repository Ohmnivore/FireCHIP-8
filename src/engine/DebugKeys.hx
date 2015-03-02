package engine;
import openfl.display.Stage;
import openfl.events.KeyboardEvent;

/**
 * ...
 * @author Ohmnivore
 */
class DebugKeys
{
	public var doRun:Bool = false;
	public var doNext:Bool = false;
	public var doFPS:Bool = false;
	
	public function new(S:Stage)
	{
		S.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
	}
	
	public function consumeNext():Void
	{
		doNext = false;
	}
	
	private function onKeyUp(evt:KeyboardEvent):Void
	{
		if (evt.keyCode == 32) //SPACEBAR
			doRun = !doRun;
		else if (evt.keyCode == 38) //UP ARROW
			doFPS = !doFPS;
		else if (evt.keyCode == 39) //RIGHT ARROW
			doNext = true;
	}
}