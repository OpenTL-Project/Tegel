package export;
import haxe.Json;
import lime.system.System;
import openfl.display.BitmapData;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Rectangle;
import sys.io.File;

/**
 * ...
 * @author 
 */
class OpenFLExporter
{

	public static function create(path:String,pathImage:String):Tilemap
	{
		var data:Dynamic = Json.parse(File.getContent(path));
		var image:BitmapData = BitmapData.fromFile(System.applicationDirectory + pathImage + data.name);
		var row = data.row;
		var size = data.size;
		//add rects
		var rectArray:Array<Rectangle> = [];
		for (j in 0...Math.floor(image.height/size))
		{
			for (i in 0...row)
			{
				rectArray.push(new Rectangle(i * size, j * size, size, size));
			}
		}
		var tilemap:Tilemap = new Tilemap(image.width, image.height, new Tileset(image, rectArray));
		//add tiles
		var int:Int = 0;
		for (j in 0...Math.floor(data.array.length/data.row))
		{
			for (i in 0...data.row)
			{
				var id = data.array[int++];
				if (id >= 0) tilemap.addTile(new Tile(id, i * Main.tiles.size, j * Main.tiles.size));
			}
		}
		return tilemap;
	}
	
}