package source;
import haxe.Json;
import sys.io.File;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author 
 */
class HaxeFlixelExporter 
{
	public static function create(path:String,pathImage:String):FlxTilemap
	{
		var data:FileContent = Json.parse(File.getContent(path));
		var tilemap = new FlxTilemap();
		tilemap.loadMapFromArray(data.array, data.mapX,data.mapY, pathImage + data.name, data.size, data.size);
		return tilemap;
	}
}
typedef FileContent = {array:Array<Int>,mapX:Int,mapY:Int,size:Int,name:String}