package importer;
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
class OpenFLImporter
{

	public static function create(path:String,pathImage:String):Tilemap
	{
		var data:FileContent = Json.parse(File.getContent(path));
		var image:BitmapData = BitmapData.fromFile(System.applicationDirectory + pathImage + data.name);
		//add rects
		var rectArray:Array<Rectangle> = [];
		for (j in 0...Math.floor(image.height/data.size))
		{
			for (i in 0...Math.floor(image.width/data.size))
			{
				rectArray.push(new Rectangle(i * data.size, j * data.size, data.size, data.size));
			}
		}
		var tilemap:Tilemap = new Tilemap(image.width, image.height, new Tileset(image, rectArray));
		//add tiles
		var int:Int = 0;
		for (j in 0...data.mapY)
		{
			for (i in 0...data.mapX)
			{
				var id = data.array[int++];
				if (id >= 0) tilemap.addTile(new Tile(id, i * data.size, j * data.size));
			}
		}
		return tilemap;
	}
	
}
typedef FileContent = {array:Array<Int>,mapX:Int,mapY:Int,size:Int,name:String}