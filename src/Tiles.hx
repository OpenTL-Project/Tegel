package;

import lime.utils.Bytes;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.JointStyle;
import openfl.display.LineScaleMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author 
 */
class Tiles extends Sprite 
{
	public static var array:Array<TileType> = [];
	public var graphic:Shape;
	public var bitmap:Bitmap;
	public var tab:Shape;
	public var select:Sprite;
	public var selectDrag:Bool = false;
	public var selectOffset:Point;
	public var selectX:Float = 0;
	public var selectY:Float = 0;
	public var minX:Int = 0;
	public var minY:Int = 0;
	public var maxY:Int = 0;
	public var maxX:Int = 0;
	public var mouseBool:Bool = false;
	public var size:Int = 16;
	public function new()
	{
		super();
		y = 20;
		bitmap = new Bitmap();
		addChild(bitmap);
		graphic = new Shape();
		graphic.cacheAsBitmap = true;
		addChild(graphic);
		select = new Sprite();
		select.buttonMode = true;
		select.mouseEnabled = true;
		select.addEventListener(MouseEvent.MOUSE_DOWN, function(e:MouseEvent)
		{
			trace("select down");
			selectDrag = true;
			selectOffset = {x:Math.floor(e.localX), y:Math.floor(e.localY)};
		});
		select.addEventListener(MouseEvent.MOUSE_UP, function(e:MouseEvent)
		{
			selectDrag = false;
			mouseBool = false;
		});
		//select.cacheAsBitmap = true;
		addChild(select);
		tab = new Shape();
		tab.alpha = 0.8;
		tab.cacheAsBitmap = false;
		tab.graphics.beginFill(0x32343C);
		tab.graphics.drawRect(0, -20, 1, 20);
		addChild(tab);
		addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		addEventListener(Event.ENTER_FRAME, update);
		addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, middleMouseDown);
		addEventListener(MouseEvent.MIDDLE_MOUSE_UP, middleMouseUp);
		addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	
	public function keyDown(e:KeyboardEvent)
	{
		selectDrag = false;
		mouseBool = false;
		switch(e.keyCode)
		{
			case Keyboard.UP:
			select.y += -size;
			case Keyboard.DOWN:
			select.y += size;
			case Keyboard.LEFT:
			select.x += -size;
			case Keyboard.RIGHT:
			select.x += size;
		}
		if (select.y + select.height > bitmap.height + size) select.y += -size;
		if (select.y < 0) select.y += size;
		if (select.x + select.width > bitmap.width + size) select.x += -size;
		if (select.x < 0) select.x += size;
	}
	public function keyUp(e:KeyboardEvent)
	{
		
	}
	
	public function updateBitmap(data:BitmapData)
	{
		bitmap.bitmapData = data;
		tab.width = bitmap.width;
	}
	
	public function update(e:Event)
	{
		if (selectDrag)
		{
			select.x = Math.floor((mouseX - selectOffset.x) / size) * size;
			select.y = Math.floor((mouseY - selectOffset.y) / size) * size;
			if (select.x + select.width >= bitmap.width) select.x = bitmap.width - select.width;
			if (select.y + select.height >= bitmap.height) select.y = bitmap.height - select.height;
			if (select.x < 0) select.x = 0;
			if (select.y < 0) select.y = 0;
		}
		if (mouseBool && !selectDrag)
		{
		var iX = Math.floor(mouseX / size);
		var iY = Math.floor((mouseY - bitmap.y) / size);
		if (iX >= 0 && iY >= 0 && iX < bitmap.width && iY < bitmap.height)
		{
			minX = Static.min(iX,minX);
			minY = Static.min(iY, minY);
			maxX = Static.max(iX, maxX);
			maxY = Static.max(iY, maxY);
			select.graphics.clear();
			select.graphics.beginFill(Style.data.borders, 0.5);
			select.graphics.lineStyle(1, Style.data.borders, 1, true, LineScaleMode.NORMAL, JointStyle.MITER);
			select.x = minX * size;
			select.y = minY * size;
			select.graphics.drawRect(0, 0, (maxX - minX + 1) * size, (maxY - minY + 1) * size);
			if (select.x + select.width > bitmap.width + size || select.y + select.height > bitmap.height + size) select.graphics.clear();
		}
		}
	}
	
	public function mouseDown(e:MouseEvent)
	{
		if (!selectDrag)
		{
			if (mouseY < 0)
			{
				startDrag();
			}else{
				mouseBool = true;
				minX = Math.floor(mouseX / size);
				minY = Math.floor(mouseY / size);
				maxX = 0;
				maxY = 0;
				select.graphics.clear();
			}
		}
	}
	public function mouseUp(e:MouseEvent)
	{
		stopDrag();
		selectDrag = false;
		mouseBool = false;
		leave();
	}
	public function middleMouseDown(e:MouseEvent)
	{
		startDrag();
	}
	public function middleMouseUp(e:MouseEvent)
	{
		stopDrag();
		leave();
	}
	public function mouseWheel(e:MouseEvent)
	{
		var scale = 0.1;
		if (e.delta > 0)
		{
			scaleX += scale;
			scaleY += scale;
		}else{
			scaleX += -scale;
			scaleY += -scale;
		}
	}
	
	public function leave()
	{
		//leave outside
		if (x < -width + 10 || y < 0 || x > stage.stageWidth || y > stage.stageHeight)
		{
			x = (stage.stageWidth - width) / 2;
			y = (stage.stageHeight - height) / 2;
		}
	}
	
}
//width and height count
typedef TileType = {image:Bytes, size:Int}
typedef Point = {x:Int,y:Int}