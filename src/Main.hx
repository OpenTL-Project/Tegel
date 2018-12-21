package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.Tilemap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author 
 */
class Main extends Sprite
{
	var tileStage:Array<TileStage> = [];
	public static var tiles:Tiles;
	var infoBar:InfoBar;
	
	public function new() 
	{
		super();
		new Dir();
		stage.color = Style.data.window_object;
		//objects
		tiles = new Tiles();
		addChild(tiles);
		tileStage.push(new TileStage());
		
		infoBar = new InfoBar();
		addChild(infoBar);
		
		addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(Event.RESIZE, resize);
	}
	
	private function resize(e:Event)
	{
		infoBar.resize();
	}
	private function update(e:Event)
	{
		infoBar.update();
	}

}
