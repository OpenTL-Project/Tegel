package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TextEvent;
import openfl.text.TextField;
import openfl.text.TextFieldType;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.ui.Keyboard;

/**
 * ...
 * @author 
 */
class TilePreview extends Sprite 
{
	public var bmdArray:Array<BitmapData> = [];
	public var bmdInt:Int = 0;
	public var sizeInput:TextField;
	public var data:Tiles.TileType;
	public var dataInt:Int;
	public function new() 
	{
		super();
		
	}
	
	public function start()
	{
		if (bmdArray[0] != null)
		{
			Main.tiles.updateBitmap(bmdArray[0]);
			sizeInput = new TextField();
			sizeInput.alpha = 0.8;
			sizeInput.type = TextFieldType.INPUT;
			//sizeInput.defaultTextFormat.color = 0;
			sizeInput.backgroundColor = 0xFFFFFF;
			sizeInput.background = true;
			sizeInput.height = 20;
			sizeInput.width = 80;
			sizeInput.defaultTextFormat = new TextFormat("_sans", 12, 0, null, null, null, null, null, TextFormatAlign.CENTER);
			sizeInput.restrict = "0-9";
			sizeInput.text = "0";
			sizeInput.setSelection(0, 1);
			addChild(sizeInput);
			setPosInput();
			data = {width:0, height:0, size:0, image:bmdArray[0]};
			dataInt = Tiles.array.push(data);
			sizeInput.addEventListener(Event.CHANGE, changeInput);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent)
			{
				switch(e.keyCode)
				{
					case Keyboard.LEFTBRACKET:
					changeTiles(-1);
					case Keyboard.RIGHTBRACKET:
					changeTiles(1);
					case Keyboard.ENTER:
					if (stage.focus == sizeInput && data.size > 0) sizeInput.visible = false;
					case Keyboard.BACKSPACE:
					if (!sizeInput.visible)
					{
						sizeInput.visible = true;
						stage.focus = sizeInput;
					}
				}
			});
		}
	}
	
	public function changeInput(_)
	{
		data.size = Std.parseInt(sizeInput.text);
			if (data.size != null && data.size > 4)
			{
				data.width = Math.floor(Main.tiles.bitmap.width / data.size) + 0;
				data.height = Math.floor(Main.tiles.bitmap.height / data.size) + 0;
				Main.tiles.graphic.graphics.clear();
				Main.tiles.graphic.graphics.lineStyle(1, 0xFFFFFF);
				for (i in 0...data.width)
				{
					for (j in 0...data.height)
					{
						Main.tiles.graphic.graphics.moveTo(data.size * i + data.size, data.size * j + data.size);
						Main.tiles.graphic.graphics.lineTo(data.size * i + data.size, data.size * j);
						Main.tiles.graphic.graphics.lineTo(data.size * i, data.size * j);
					}
				}
			data.image = Main.tiles.bitmap.bitmapData;
			//save to tiles data
			Tiles.array[dataInt] = data;
		}
	}
	
	public function changeTiles(change:Int=1)
	{
		//continue
		if (bmdArray[bmdInt + change] == null) return;
		bmdInt += change;
		//set data
		for (d in Tiles.array)
		{
			if (d.image == bmdArray[bmdInt]) data = d;
		}
		Main.tiles.updateBitmap(bmdArray[bmdInt]);
		setPosInput();
		Main.tiles.graphic.graphics.clear();
		sizeInput.visible = true;
		sizeInput.text = Std.string(data.size);
		sizeInput.setSelection(0, 1);
	}
	
	public function setPosInput()
	{
		sizeInput.x = (Main.tiles.bitmap.width - sizeInput.width) / 2;
		sizeInput.y = Main.tiles.bitmap.height - sizeInput.height;
	}
	
}