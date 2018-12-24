package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.text.TextFormatAlign;
import system.Binding;
import system.Dir;
import ui.Style;
import ui.bar.Header;
import ui.bar.InfoBar;
import ui.Snow;
import ui.tile.TileStage;
import ui.tile.Tiles;

/**
 * ...
 * @author 
 */
class Main extends Sprite
{
	var tileStage:Array<ui.tile.TileStage> = [];
	public static var tiles:ui.tile.Tiles;
	public static var tile:ui.tile.TileStage;
	public static var infoBar:ui.bar.InfoBar;
	var header:ui.bar.Header;
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
		new system.Dir();
		stage.color = ui.Style.data.window_object;
		//particles
		var bmd:BitmapData = Assets.getBitmapData("assets/icons/snow.png");
		particles = new Tilemap(stage.stageWidth, stage.stageHeight, new Tileset(bmd, [bmd.rect]));
		particles.y = 40;
		for (i in 0...100) particles.addTile(new ui.Snow());
		addChild(particles);
		//objects
		tiles = new ui.tile.Tiles();
		tiles.y = 40;
		tile = new ui.tile.TileStage();
		addChild(tile);
		tileStage.push(tile);
		addChild(tiles);
		
		infoBar = new ui.bar.InfoBar();
		addChild(infoBar);
		
		header = new ui.bar.Header();
		addChild(header);
		
		addEventListener(Event.ENTER_FRAME, update);
		stage.addEventListener(Event.RESIZE, resize);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	private function keyDown(e:KeyboardEvent)
	{
		system.Binding.key(e.keyCode, true);
		//set select move
		var select:Sprite = Main.tiles.select;
		var size:Int = Main.tiles.size;
		if (Main.upSelect) select.y += -size;
		if (Main.downSelect) select.y += size;
		if (Main.leftSelect) select.x += -size;
		if (Main.rightSelect) select.x += size;
			
		if (select.y + select.height > Main.tiles.bitmap.height + size) select.y += -size;
		if (select.y < 0) select.y += size;
		if (select.x + select.width > Main.tiles.bitmap.width + size) select.x += -size;
		if (select.x < 0) select.x += size;
	}
	private function keyUp(e:KeyboardEvent)
	{
		system.Binding.key(e.keyCode, false);
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
		//particles
		for (i in 0...particles.numTiles)
		{
			cast(particles.getTileAt(i),Snow).update();
		}
	}
	

}
