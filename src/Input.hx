package;
import fsignal.Signal1;
import fsignal.Signal2;
import fsignal.Signal3;
import sdl.Event;
import sdl.Keycodes;
import sdl.SDL.SDLEventType;

/**
 * ...
 * @author Andreas Rønning
 */
typedef MousePosition = { x:Float, y:Float };
class Input
{
	static var _keys = new Map<UInt, Bool>();
	static var _mouseButtons = new Map<Int,Bool>();
	static var _mousePos:MousePosition = { x:0, y:0 };
	
	public static var onMouseMove = new Signal2<Float, Float>();
	public static var onMouseDown = new Signal3<Float, Float, UInt>();
	public static var onMouseUp = new Signal3<Float,Float, UInt>();
	public static var onKeyDown = new Signal1<UInt>();
	public static var onKeyUp = new Signal1<UInt>();
	
	static public function update(e:Event) 
	{
		switch(e.type) {
			case SDLEventType.SDL_KEYDOWN:
				_keys[e.key.keysym.sym] = true;
				onKeyDown.dispatch(e.key.keysym.sym);
			case SDLEventType.SDL_KEYUP:
				_keys[e.key.keysym.sym] = false;
				onKeyUp.dispatch(e.key.keysym.sym);
			case SDLEventType.SDL_MOUSEMOTION:
				_mousePos.x = e.motion.x;
				_mousePos.y = e.motion.y;
				onMouseMove.dispatch(e.motion.x, e.motion.y);
			case SDLEventType.SDL_MOUSEBUTTONDOWN:
				_mouseButtons[e.button.button] = true;
				onMouseDown.dispatch(e.motion.x, e.motion.y, e.button.button);
			case SDLEventType.SDL_MOUSEBUTTONUP:
				_mouseButtons[e.button.button] = false;
				onMouseUp.dispatch(e.motion.x, e.motion.y, e.button.button);
			default:
		}
	}
	
	static public function reset() {
		onMouseDown.removeAll();
		onMouseUp.removeAll();
		onMouseMove.removeAll();
		onKeyDown.removeAll();
		onKeyUp.removeAll();
		_mouseButtons = new Map<Int,Bool>();
		_keys = new Map<Int,Bool>();
	}
	
	static public function mouseButtonIsDown(button:UInt) 
	{
		return _mouseButtons[button] == true;
	}
	
	static public function keyIsDown(key:UInt) 
	{
		return _keys[key] == true;
	}
	
	static public function getMousePosition():MousePosition {
		return _mousePos;
	}
	
}