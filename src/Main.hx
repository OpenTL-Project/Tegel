package;

import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.Tilemap;
import openfl.events.KeyboardEvent;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author 
 */
class Main extends Sprite
{
	var tileStage:Array<TileStage> = [];
	public static var tiles:Tiles;
	
	public function new() 
	{
		super();
		new Dir();
		stage.color = Style.data.window_object;
		//objects
		tiles = new Tiles();
		addChild(tiles);
		tileStage.push(new TileStage());
		tiles.preview = new TilePreview();
		tiles.addChild(tiles.preview);
	}

}
