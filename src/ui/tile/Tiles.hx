package ui.tile;

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
import system.Binding;
import ui.Pannel;
import ui.Style;

/**
 * ...
 * @author 
 */
class Tiles extends ui.Pannel
{
	public static var array:Array<TileType> = [];
	public var graphic:Shape;
	public var bitmap:Bitmap;
	public var tab:Shape;
	public var select:Sprite;
	public var selectDrag:Bool = false;
	public var keyInt:Int = 0;
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
		buttonMode = true;
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
		tab.graphics.drawRect(0, -15, 1, 15);
		addChild(tab);
	}
	
	public function updateBitmap(data:BitmapData)
	{
		bitmap.bitmapData = data;
		tab.width = bitmap.width;
	}
	
	override private function update(_)
	{
		if (system.Binding.keyDown && keyInt >  (bitmap.width/size) * 4)
		{
			if (Main.upSelect) select.y += -size;
			if (Main.downSelect) select.y += size;
			if (Main.leftSelect) select.x += -size;
			if (Main.rightSelect) select.x += size;
			
			if (select.y + select.height > bitmap.height + size) select.y += -size;
			if (select.y < 0) select.y += size;
			if (select.x + select.width > bitmap.width + size) select.x += -size;
			if (select.x < 0) select.x += size;
			keyInt = 0;
		}
		keyInt++;
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
			var selectX:Int = Math.floor(select.x / Main.tiles.size);
			var selectY:Int = Math.floor(select.y / Main.tiles.size);
			//manual set
			if (maxX > iX && selectX < iX) maxX = iX;
			if (maxY > iY && selectY < iY) maxY = iY;
			//if (minX < iX && selectX > iX) minX = iX;
			//if (minY < iY && selectY > iY) minY = iY;
			
			select.graphics.clear();
			select.graphics.beginFill(ui.Style.data.borders, 0.5);
			select.graphics.lineStyle(1, ui.Style.data.borders, 1, true, LineScaleMode.NORMAL, JointStyle.MITER);
			select.x = minX * size;
			select.y = minY * size;
			select.graphics.drawRect(0, 0, (maxX - minX + 1) * size, (maxY - minY + 1) * size);
			if (select.x + select.width > bitmap.width + size || select.y + select.height > bitmap.height + size) select.graphics.clear();
		}
		}
	}
	
	override private function mouseDown(e:MouseEvent)
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
	override private function mouseUp(e:MouseEvent)
	{
		stopDrag();
		selectDrag = false;
		mouseBool = false;
		leave();
	}
	
}
//width and height count
typedef TileType = {image:Bytes, size:Int}
typedef Point = {x:Int,y:Int}