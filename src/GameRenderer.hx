package;
import sdl.Event;
import sdl.Renderer;
import sdl.SDL;
import sdl.Window;

/**
 * ...
 * @author Andreas Rønning
 */
class GameRenderer
{
	
	static public function update(game:Game, state:{window:Window, renderer:Renderer}, e:Event) 
	{		
		SDL.setRenderDrawColor(state.renderer, 255,255,255,255);
		SDL.renderClear(state.renderer);
		SDL.renderPresent(state.renderer);
	}
	
}