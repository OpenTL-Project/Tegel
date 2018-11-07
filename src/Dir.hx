package;
import haxe.Json;
import lime.system.System;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.net.SharedObject;
import sys.FileSystem;
import sys.io.File;
/**
 * ...
 * @author 
 */
class Dir 
{
	public static var global:SharedObject;
	public static var local:SharedObject;
	
	public function new() 
	{
		global = SharedObject.getLocal("global");
		local = SharedObject.getLocal("local");
		
		var path = StringTools.replace(System.applicationDirectory, "\\", "/");
		//get styles
		var array = FileSystem.readDirectory(path + "/assets/styles");
		var temp = Json.parse(File.getContent(path + "/assets/styles" + "/" + array[0]));
		var parsedData:Dynamic = {};
		for (field in Reflect.fields(temp))
		{
			Reflect.setProperty(parsedData, field, Std.parseInt(Reflect.getProperty(temp, field)));
		}
		Style.data = parsedData;
		//get tilesets
		var first:Bool = true;
		for (name in FileSystem.readDirectory(path + "/assets/tilesets"))
		{
			var extension = name.substring(name.lastIndexOf("."), name.length);
			if (extension == ".png" || extension == ".jpg")
			{
				//Tiles.set.push(new TilesetType().
				BitmapData.loadFromFile(path + "/assets/tilesets/" + name).onComplete(function(bmd:BitmapData)
				{
					trace("push bmd");
					Main.tiles.preview.bmdArray.push(bmd);
					if (first) Main.tiles.preview.start();
					first = false;
				});
			}
		}
	}
	
}