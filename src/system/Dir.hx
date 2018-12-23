package system;
import haxe.Json;
import haxe.crypto.Base64;
import lime.system.System;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.PNGEncoderOptions;
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
	public static var image:Array<String> = [];
	public static var name:String;
	
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
		ui.Style.data = parsedData;
		//get tilesets
		var first:Bool = true;
		for (name in FileSystem.readDirectory(path + "/assets/tilesets"))
		{
			var extension = name.substring(name.lastIndexOf("."), name.length);
			if (extension == ".png" || extension == ".jpg")
			{
				//Tiles.set.push(new TilesetType().
				BitmapData.loadFromFile(path + "/assets/tilesets/" + name).onComplete(function(data:BitmapData)
				{
					trace("push bmd");
					var rect = data.rect;
					var bytes = data.encode(rect, new PNGEncoderOptions());
					var string = Base64.encode(bytes);
					image.push(string);
					Main.tiles.updateBitmap(BitmapData.fromBytes(Base64.decode(string)));
					Dir.name = name;
					first = false;
				});
			}
		}
	}
	
}