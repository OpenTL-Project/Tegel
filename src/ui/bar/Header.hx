package ui.bar;

import haxe.Serializer;
import haxe.Unserializer;
import haxe.crypto.Base64;
import lime.system.System;
import lime.ui.FileDialog;
import lime.ui.FileDialogType;
import lime.utils.Resource;
import openfl.Assets;
import openfl.Lib;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.events.MouseEvent;
import openfl.text.TextFormatAlign;
import sys.io.File;
import system.Dir;
import ui.Text;

/**
 * ...
 * @author ...
 */
class Header extends Sprite 
{
	var shape:Shape;
	var int:Int = 0;
	var buttonWidth:Int = 100;
	var totalWidth:Int = 0;
	var setX:Int = 10;
	public function new() 
	{
		super();
		buttonMode = true;
		shape = new Shape();
		shape.cacheAsBitmap = true;
		addChild(shape);
		addEventListener(MouseEvent.CLICK, click);
		add("Load");
		add("Save");
		add("Export");
	}
	private function add(string:String)
	{
		var text = new ui.Text(setX + int * buttonWidth, 2, buttonWidth, string, 12, Style.data.panel_text, TextFormatAlign.LEFT);
		text.height = 15;
		addChild(text);
		int ++;
		totalWidth = setX + int * buttonWidth;
	}
	private function click(_)
	{
		var id = Math.floor((mouseX - setX) / buttonWidth);
		var dialog = new FileDialog();
		switch(id)
		{
			case 0:
			//load
			dialog.browse(FileDialogType.OPEN, "tegel", System.applicationStorageDirectory, "Open Tegel");
			dialog.onSelect.add(function(path:String)
			{
				var string = File.getContent(path);
				try
				{
					var data:FileContent = Unserializer.run(string);
					Main.tiles.updateBitmap(Assets.getBitmapData("assets/tilesets/" + data.name));
					Main.tiles.size = data.size;
					Main.tile.size();
					Main.infoBar.rowInput.text = "" + Main.tiles.size;
					var id:Int = 0;
					for (j in 0...Math.floor(data.array.length/data.row))
					{
						for (i in 0...data.row)
						{
							Main.tile.tilemap.addTile(new Tile(data.array[id++], i * Main.tiles.size, j * Main.tiles.size));
						}
					}
					trace("data: " + data);
				}catch (e:Dynamic)
				{
					trace("error: " + e);
				}
			});
			case 1:
			//save
			dialog.browse(FileDialogType.SAVE, "tegel", System.applicationStorageDirectory, "Open Tegel");
			dialog.onSelect.add(function(path:String)
			{
				var row:Int = Math.floor(Main.tiles.bitmap.width / Main.tiles.size);
				var array:Array<Int> = [for (i in 0...Math.floor(Main.tiles.bitmap.height / Main.tiles.size) * row) -1];
				for (i in 0...Main.tile.tilemap.numTiles)
				{
					var tile = Main.tile.tilemap.getTileAt(i);
					var id:Int = Math.floor(tile.x / Main.tiles.size) + Math.floor(tile.y / Main.tiles.size) * row;
					trace("id " + id);
					array[id] = tile.id;
				}
				File.saveContent(path,Serializer.run({array:array,size:Main.tiles.size,row:row,name:system.Dir.name}));
			});
			case 2:
			//export
			var xml = Xml.createDocument();
			var map = Xml.createElement("map");
			map.set("version", "1.0");
			map.set("orientation", "orthogonal");
			map.set("renderorder", "right-down");
			map.set("width", Std.string(Main.tiles.bitmap.width));
			map.set("height", Std.string(Main.tiles.bitmap.height));
			map.set("tilewidth", Std.string(Main.tiles.size));
			map.set("tileheight", Std.string(Main.tiles.size));
			map.set("nextobjectid", "29");
			xml.addChild(map);
			var source = Xml.createElement("image");
			source.set("source", system.Dir.name);
			
			trace(xml.toString());
			
		}
	}
	
	public function resize()
	{
		var setHeight:Float = stage.stageHeight / 40;
		y = 0;
		shape.graphics.clear();
		shape.graphics.beginFill(Style.data.panel_background);
		shape.graphics.drawRect(0, 0, stage.stageWidth, setHeight);
	}
	
}

typedef FileContent = {array:Array<Int>,row:Int,size:Int,name:String}