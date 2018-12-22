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
	var rowText:Text;
	public var rowInput:Text;
	var columnText:Text;
	var columnInput:Text;

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
		sizeText = new Text(130, 10, 50, "size:", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		sizeInput = new Text(170, 10, 100, "1", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		sizeInput.type = TextFieldType.INPUT;
		sizeInput.mouseEnabled = true;
		sizeInput.selectable = true;
		sizeInput.restrict = "0-9";
		addChild(sizeText);
		addChild(sizeInput);
		//row
		rowText = new Text(220, 10, 100, "row:", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		rowInput = new Text(260, 10, 100, "10", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		rowInput.type = TextFieldType.INPUT;
		rowInput.mouseEnabled = true;
		rowInput.selectable = true;
		rowInput.restrict = "0-9";
		addChild(rowText);
		addChild(rowInput);
		//column
		columnText = new Text(300, 10, 100, "column:", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		columnInput = new Text(360 + 20, 10, 100, "10", 20, Style.data.panel_text, TextFormatAlign.LEFT);
		columnInput.type = TextFieldType.INPUT;
		columnInput.mouseEnabled = true;
		columnInput.selectable = true;
		columnInput.restrict = "0-9";
		addChild(columnText);
		addChild(columnInput);
		//input events
		sizeInput.addEventListener(TextEvent.TEXT_INPUT, function(e:TextEvent)
		{
			var int = Std.parseInt(sizeInput.text + e.text);
			if (int != null)
			{
				if (Main.tiles.size != int && int > 4 && int < 200)
				{
					Main.tiles.size = int;
					Main.tiles.select.graphics.clear();
					Main.tile.size();
				}
			}
		});
		rowInput.addEventListener(TextEvent.TEXT_INPUT, function(e:TextEvent)
		{
			var int = Std.parseInt(rowInput.text + e.text);
			if (int != null)
			{
				if (Main.tile.intX != int && int > 1 && int <= 1000)
				{
					Main.tile.intX = int;
					Main.tile.gridSize();
				}
			}
		});
		columnInput.addEventListener(TextEvent.TEXT_INPUT, function(e:TextEvent)
		{
			var int = Std.parseInt(columnInput.text + e.text);
			if (int != null)
			{
				if (Main.tile.intY != int && int > 1 && int <= 1000)
				{
					Main.tile.intY = int;
					Main.tile.gridSize();
				}
			}
		});
	}
	public function resize()
	{
		var setHeight:Float = stage.stageHeight / 20;
		y = stage.stageHeight - setHeight;
		shape.graphics.clear();
		shape.graphics.beginFill(Style.data.panel_background);
		shape.graphics.drawRect(0, 0, stage.stageWidth, setHeight);
		//center text
		positionText.y = (setHeight - (positionText.defaultTextFormat.size + 16)) / 2;
		var infoY:Float = (setHeight - (sizeText.defaultTextFormat.size + 16)) / 2;
		sizeText.y = infoY;
		sizeInput.y = infoY;
		rowText.y = infoY;
		rowInput.y = infoY;
		columnText.y = infoY;
		columnInput.y = infoY;
	}
	public function update()
	{
		positionText.text = "x:" + stage.mouseX + ",y:" + stage.mouseY;
	}
	
}