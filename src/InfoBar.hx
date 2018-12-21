package;

import openfl.display.DisplayObjectContainer;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TextEvent;
import openfl.text.TextFieldType;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author ...
 */
class InfoBar extends DisplayObjectContainer
{
	var positionText:Text;
	var sizeText:Text;
	var sizeInput:Text;
	var shape:Shape;

	public function new() 
	{
		super();
		//shape
		shape = new Shape();
		shape.cacheAsBitmap = true;
		addChild(shape);
		//pos
		positionText = new Text(10, 10, 300, "", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		addChild(positionText);
		//size
		sizeText = new Text(10 + 120, 10, 50, "size:", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		sizeInput = new Text(10 + 170, 10, 100, "16", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		sizeInput.type = TextFieldType.INPUT;
		sizeInput.mouseEnabled = true;
		sizeInput.selectable = true;
		sizeInput.restrict = "0-9";
		addChild(sizeText);
		addChild(sizeInput);
	}
	public function resize()
	{
		trace("resize");
		var setHeight:Float = stage.stageHeight / 20;
		y = stage.stageHeight - setHeight;
		shape.graphics.clear();
		shape.graphics.beginFill(Style.data.panel_background);
		shape.graphics.drawRect(0, 0, stage.stageWidth, setHeight);
		//center text
		positionText.y = (setHeight - (positionText.defaultTextFormat.size + 16)) / 2;
		sizeText.y = (setHeight - (sizeText.defaultTextFormat.size + 16)) / 2;
		sizeInput.y = (setHeight - (sizeInput.defaultTextFormat.size + 16 - 2)) / 2;
		sizeInput.addEventListener(TextEvent.TEXT_INPUT, function(e:TextEvent)
		{
			var int = Std.parseInt(sizeInput.text + e.text);
			if (int != null)
			{
				trace("INT " + int);
				Main.tiles.size = int;
			}
		});
		
	}
	public function update()
	{
		positionText.text = "x:" + stage.mouseX + ",y:" + stage.mouseY;
	}
	
}