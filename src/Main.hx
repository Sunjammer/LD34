package;

import cpp.Lib;
import sdl.Renderer;
import sdl.SDL;
import sdl.Window;
import sdl.Keycodes;

/**
 * ...
 * @author Andreas Rønning
 */
class Main 
{
	static var state : { window:Window, renderer:Renderer };
	
	static var game:Game;
	public static var running:Bool;
	
	static function main() 
	{
		Input.reset();
		game = new Game();
		
		SDL.init(SDL_INIT_VIDEO | SDL_INIT_EVENTS);
        state = SDL.createWindowAndRenderer(1280, 720, SDLWindowFlags.SDL_WINDOW_OPENGL);
		SDL.setWindowTitle(state.window, "LD34");
		running = true;
		while(running = update()) { }
	}
	
	static function update() {
		while (SDL.hasAnEvent()) {
			var e = SDL.pollEvent();
			if (e.type == SDL_QUIT) return false;
			Input.update(e);
			game.update(e);
			GameRenderer.update(game, state, e);
		}
		SDL.delay(33);
		return true;
	}
}