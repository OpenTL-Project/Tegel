package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
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
	public static var tile:TileStage;
	public static var infoBar:InfoBar;
	var header:Header;
	public static var up:Bool = false;
	public static var down:Bool = false;
	public static var left:Bool = false;
	public static var right:Bool = false;
	public static var upSelect:Bool = false;
	public static var downSelect:Bool = false;
	public static var leftSelect:Bool = false;
	public static var rightSelect:Bool = false;
	public static var vis:Bool = true;
	var particles:Tilemap;
	
	public function new() 
	{
		super();
		new Dir();
		stage.color = Style.data.window_object;
		//particles
		var bmd:BitmapData = Assets.getBitmapData("assets/icons/snow.png");
		particles = new Tilemap(stage.stageWidth, stage.stageHeight, new Tileset(bmd, [bmd.rect]));
		particles.addTile(new Snow());
		addChild(particles);
		//objects
		tiles = new Tiles();
		tiles.y = 40;
		tile = new TileStage();
		addChild(tile);
		tileStage.push(tile);
		addChild(tiles);
		
		infoBar = new InfoBar();
		addChild(infoBar);
		
		header = new Header();
		addChild(header);
		
		addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	private function keyDown(e:KeyboardEvent)
	{
		Binding.key(e.keyCode, true);
	}
	private function keyUp(e:KeyboardEvent)
	{
		Binding.key(e.keyCode, false);
	}
	
	private function resize(e:Event)
	{
		infoBar.resize();
		header.resize();
		for (tile in tileStage) tile.resize();
		
	}
	private function update(e:Event)
	{
		infoBar.update();
	}
	

}
