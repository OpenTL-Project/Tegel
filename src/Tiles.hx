package;

import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

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
	public var preview:TilePreview;
	public var select:Shape;
	public var selectMinX:Int = 0;
	public var selectMinY:Int = 0;
	public var selectMaxY:Int = 0;
	public var selectMaxX:Int = 0;
	public var selectInit:Bool = false;
	public var mouseBool:Bool = false;
	public function new()
	{
		super();
		y = 20;
		bitmap = new Bitmap();
		addChild(bitmap);
		graphic = new Shape();
		graphic.cacheAsBitmap = true;
		addChild(graphic);
		select = new Shape();
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
	}
	
	public function updateBitmap(data:BitmapData)
	{
		bitmap.bitmapData = data;
		tab.width = bitmap.width;
	}
	
	public function update(e:Event)
	{
		if (mouseBool)
		{
		var size = preview.data.size;
		var dataWidth = preview.data.width;
		var dataHeight = preview.data.height;
		//select.width = size;
		//select.height = size;
		var iX = Math.floor(mouseX/size);
		var iY = Math.floor((mouseY - bitmap.y) / size);
		if (iX > 0 && iX < dataWidth) //&& iY > 0 && iY < dataHeight)
		{
			if (selectInit)
			{
				selectMinX = iX;
				selectMinY = iY;
				selectInit = false;
			}
			if (selectMinX > iX) selectMinX = iX;
			if (selectMinY > iY) selectMinY = iY;
			selectMaxX = iX;
			selectMaxY = iY;
			select.graphics.clear();
			//select.graphics.beginFill(0, 0.4);
			select.graphics.lineStyle(2, 0);
			select.graphics.drawRect(selectMinX * size, selectMinY * size,(selectMaxX - selectMinX + 1) * size,(selectMaxY - selectMinY + 1) * size);
		}
		}
	}
	
	public function mouseDown(e:MouseEvent)
	{
		if (mouseY < 20)
		{
			startDrag();
		}else{
			mouseBool = true;
			selectMinX = 0;
			selectMinY = 0;
			selectMaxX = 0;
			selectMaxY = 0;
			selectInit = true;
			select.graphics.clear();
		}
	}
	public function mouseUp(e:MouseEvent)
	{
		stopDrag();
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
typedef TileType = {width:Int, height:Int, image:BitmapData, size:Int}
typedef Point = {x:Int,y:Int}