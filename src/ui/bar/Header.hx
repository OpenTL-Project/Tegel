package ui.bar;

import export.OpenFLExporter;
import haxe.Json;
import haxe.Serializer;
import haxe.Timer;
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
		add("Import");
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
			dialog.browse(FileDialogType.OPEN, "tegel", System.applicationDirectory, "Open Tegel");
			dialog.onSelect.add(function(path:String)
			{
				var string = File.getContent(path);
				try
				{
					var data:FileContent = Unserializer.run(string);
					Main.tiles.updateBitmap(Assets.getBitmapData("assets/tilesets/" + data.name));
					Main.tile.intX = data.mapX;
					Main.tile.intY = data.mapY;
					Main.tiles.size = data.size;
					Main.tile.size();
					Main.infoBar.rowInput.text = "" + Main.tiles.size;
					Main.infoBar.columnInput.text = "" + Main.tile.intX;
					Main.infoBar.columnInput.text = "" + Main.tile.intY;
					var int:Int = 0;
					for (j in 0...Main.tile.intY)
					{
						for (i in 0...Main.tile.intX)
						{
							var id = data.array[int++];
							if (id >= 0) Main.tile.tilemap.addTile(new Tile(id, i * Main.tiles.size, j * Main.tiles.size));
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
			dialog.browse(FileDialogType.SAVE, "tegel", System.applicationDirectory, "Open Tegel");
			dialog.onSelect.add(function(path:String)
			{
				var array:Array<Int> = [for (i in 0...Main.tile.intY * Main.tile.intX) -1];
				for (i in 0...Main.tile.tilemap.numTiles)
				{
					var tile = Main.tile.tilemap.getTileAt(i);
					var id:Int = Math.floor(tile.x / Main.tiles.size) + Math.floor(tile.y / Main.tiles.size) * Main.tile.intX;
					array[id] = tile.id;
				}
				File.saveContent(path,Serializer.run({array:array,size:Main.tiles.size,mapX:Main.tile.intX,mapY:Main.tile.intY,name:system.Dir.name}));
			});
			case 2:
			//export json
			var array:Array<Int> = [];
			for (i in 0...Main.tile.intX * Main.tile.intY) array.push( -1);
			for (i in 0...Main.tile.tilemap.numTiles)
			{
				var tile = Main.tile.tilemap.getTileAt(i);
				var id:Int = Math.floor(tile.x / Main.tiles.size) + Math.floor(tile.y / Main.tiles.size) * Main.tile.intX;
				array[id] = tile.id;
			}
			dialog.browse(FileDialogType.SAVE, "json", System.applicationDirectory, "Export Json");
			var data:Dynamic = Json.stringify({array:array, size:Main.tiles.size, mapX:Main.tile.intX,mapY:Main.tile.intY, name:Dir.name});
			dialog.onSelect.add(function(path:String)
			{
				File.saveContent(path, data);
			});
			trace("data " + data);
			case 3:
			//import json
			dialog.browse(FileDialogType.OPEN, "json", System.applicationDirectory, "Import Json");
			dialog.onSelect.add(function(path:String)
			{
				trace("import");
				var tilemap = OpenFLExporter.create(path, "assets/tilesets/");
				tilemap.x = 100;
				tilemap.y = 100;
				tilemap.cacheAsBitmap = true;
				var timer = new Timer(5 * 1000);
				timer.run = function()
				{
					Lib.current.removeChild(tilemap);
					tilemap = null;
					timer.stop();
					timer = null;
				}
				Lib.current.addChild(tilemap);
			});
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

typedef FileContent = {array:Array<Int>,mapX:Int,mapY:Int,size:Int,name:String}