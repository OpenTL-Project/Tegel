package ui.tile;

import openfl.display.CapsStyle;
import openfl.display.LineScaleMode;
import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import openfl.ui.Keyboard;
import ui.Pannel;

/**
 * ...
 * @author 
 */

class TileData 
{
	public function new(x:Int,y:Int,width:Int,height:Int,selectX:Int,selectY:Int,add:Bool)
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		this.selectX = selectX;
		this.selectY = selectY;
		this.add = add;
	}
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	public var selectX:Int;
	public var selectY:Int;
	public var add:Bool;
}

class TileStage extends ui.Pannel
{
	
	var moveSpeed:Float = 5;
	public var intX:Int = 10;
	public var intY:Int = 10;
	var mouseBool:Bool = false;
	var rightBool:Bool = false;
	public var tilemap:Tilemap;
	public var shape:Shape;
	var iX:Int = 0;
	var iY:Int = 0;
	var selectWidth:Float = 0;
	var selectHeight:Float = 0;
	var lastX:Int = -1;
	var lastY:Int = -1;
	var select:Shape;
	var history:History<TileData>;
	var setHistoryBool:Bool = false;
	
	public function new() 
	{
		super();
		buttonMode = true;
		tilemap = new Tilemap(0,0);
		addChild(tilemap);
		shape = new Shape();
		shape.cacheAsBitmap = true;
		addChild(shape);
		size();
		select = new Shape();
		select.alpha = 0.5;
		select.cacheAsBitmap = true;
		addChild(select);
		addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
	}
	private function keyDown(e:KeyboardEvent)
	{
		if (e.controlKey)
		{
			switch(e.keyCode)
			{
				case Keyboard.Z:
				//undo
				setHistory(history.undo(), false);
				case Keyboard.Y:
				//redo
				setHistory(history.redo(), true);
			}
		}
	}
	private function setHistory(data:TileData, bool:Bool)
	{
		setHistoryBool = true;
		if (data != null) 
		{
			if (bool)
			{
				//redo
				bool = data.add;
			}else{
				//undo
				bool = !data.add;
			}
			trace("bool " + bool + " pos " + data.x + " " + data.y);
			addTile(data.x, data.y, bool, true, data.width, data.height, data.selectX, data.selectY);
		}
	}
	private function addTile(iX:Int,iY:Int,add:Bool=true,historyBool:Bool=false,tileWidth:Int=0,tileHeight:Int=0,tileX:Int=0,tileY:Int=0)
	{
		var tile:Tile = null;
		var tH:Int = Math.floor(Main.tiles.select.height / Main.tiles.size);
		var tW:Int = Math.floor(Main.tiles.select.width / Main.tiles.size);
		var mX:Float = mouseX;
		var mY:Float = mouseY;
		if (historyBool)
		{
			mX = iX;
			mY = iY;
			tW = tileWidth;
			tH = tileHeight;
		}
		for (j in 0...tH)
		{
			for (i in 0...tW)
			{
				tile = getTile(mX + i * Main.tiles.size, mY + j * Main.tiles.size);
				if (add)
				{
					//addition of tiles
					if (tile != null)
					{
						var id = getTileId(i, j,tileX,tileY);
						if (tile.id != id)
						{
							tile.id = getTileId(i, j,tileX,tileY);
							continue;
						}
					}else{
						tile = new Tile(getTileId(i, j,tileX,tileY), iX + i * Main.tiles.size, iY + j * Main.tiles.size);
						tilemap.addTile(tile);
					}
				}else{
					//remove of tiles
					tilemap.removeTile(tile);
				}
			}
		}
		if (tile != null && !historyBool)
		{
			if (setHistoryBool)
			{
				trace("reset");
				history = new History<TileData>(100);
				setHistoryBool = false;
			}
			history.add(new TileData(iX, iY,tW,tH,Math.floor(Main.tiles.select.x / Main.tiles.size),Math.floor(Main.tiles.select.y / Main.tiles.size),add));
		}
	}
	private function getTileId(iX:Int=0,iY:Int=0,sX:Int=0,sY:Int=0):Int
	{
		var idX:Int = Math.floor(Main.tiles.select.x / Main.tiles.size) + iX;
		var idY:Int = Math.floor(Main.tiles.select.y / Main.tiles.size) + iY;
		if (sX > 0) idX = sX + iX;
		if (sY > 0) idY = sY + iY;
		var row:Int = Math.floor(Main.tiles.bitmap.width / Main.tiles.size);
		if (idY < 0) idY = 0;
		return idX + idY * row;
	}
	private function removeTile()
	{
		var tile = getTile(mouseX, mouseY);
		if (tile != null)
		{
			tilemap.removeTile(tile);
		}
	}
	private function getTile(iX:Float, iY:Float):Tile
	{
		for (i in 0...tilemap.numTiles)
		{
			var tile = tilemap.getTileAt(i);
			if (tile.x == Math.floor(iX / Main.tiles.size) * Main.tiles.size && tile.y == Math.floor(iY / Main.tiles.size) * Main.tiles.size)
			{
				return tile;
			}
		}
		return null;
	}
	public function size()
	{
		var rectArray:Array<Rectangle> = [];
		iX = Math.floor(Main.tiles.bitmap.width / Main.tiles.size);
		iY = Math.floor(Main.tiles.bitmap.height / Main.tiles.size);
		for (i in 0...iX)
		{
			for (j in 0...iY)
			{
				rectArray.push(new Rectangle( j * Main.tiles.size,i * Main.tiles.size, Main.tiles.size, Main.tiles.size));
			}
		}
		tilemap.tileset = new Tileset(Main.tiles.bitmap.bitmapData, rectArray);
		gridSize(false);
		tilemap.removeTiles(0, tilemap.numTiles);
		//history
		history = new History<TileData>(100);
	}
	public function gridSize(delete:Bool=true)
	{
		shape.graphics.clear();
		drawGrid();
		drawBorder();
		tilemap.width = intX * Main.tiles.size - 1;
		tilemap.height = intY * Main.tiles.size - 1;
		if (delete)
		{
			//delete tiles outside of tilemap
			for (i in 0...tilemap.numTiles)
			{
				var tile = tilemap.getTileAt(i);
				if (tile != null)
				{
					if (tile.x < 0 || tile.y < 0 || tile.x + Main.tiles.size > tilemap.width || tile.y + Main.tiles.size > tilemap.height)
					{
						tilemap.removeTile(tile);
						tile = null;
					}
				}
			}
		}
	}
	override function update(_) 
	{
		super.update(_);
		//move
		if (Main.up) y += moveSpeed;
		if (Main.down) y += -moveSpeed;
		if (Main.left) x += moveSpeed;
		if (Main.right) x += -moveSpeed;
		
		iX =Math.floor(mouseX / Main.tiles.size) * Main.tiles.size;
		iY = Math.floor(mouseY / Main.tiles.size) * Main.tiles.size;
		if (iX != lastX || iY != lastY)
		{
			if (!mouseBool)
			{
				//mouseover
				if (selectWidth != Main.tiles.select.width || selectHeight != Main.tiles.select.height)
				{
					select.graphics.clear();
					select.graphics.drawGraphicsData(Main.tiles.select.graphics.readGraphicsData());
					selectWidth = Main.tiles.select.width;
					selectHeight = Main.tiles.select.height;
				}
				select.x = iX;
				select.y = iY;
				if (select.x > shape.width) select.x = shape.width;
				if (select.y > shape.height) select.y = shape.height;
				if (select.x < -selectWidth) select.x = -selectWidth;
				if (select.y < -selectHeight) select.y = -selectHeight;
			}
			//mousedown
			if (mouseBool)addTile(iX, iY);
			//right down
			if (rightBool) addTile(iX, iY,false);
			//last
			lastX = iX;
			lastY = iY;
		}
	}
	override function mouseDown(e:MouseEvent) 
	{
		super.mouseDown(e);
		mouseBool = true;
		rightBool = false;
		lastX = -1;
		lastY = -1;
	}
	override function mouseUp(e:MouseEvent) 
	{
		super.mouseUp(e);
		mouseBool = false;
	}
	public function drawGrid()
	{
		shape.graphics.lineStyle(1, 0xFFFFFF,1,true,LineScaleMode.NORMAL,CapsStyle.SQUARE);
		for (i in 0...intX)
		{
			for (j in 0...intY)
			{
				shape.graphics.moveTo(Main.tiles.size * (i + 1), Main.tiles.size * (j + 0));
				shape.graphics.lineTo(Main.tiles.size * (i + 1), Main.tiles.size * (j + 1));
				shape.graphics.lineTo(Main.tiles.size * (i + 0), Main.tiles.size * (j + 1));
			}
		}
	}
	override function rightDown(e:MouseEvent) 
	{
		super.rightDown(e);
		rightBool = true;
		mouseBool = false;
		lastX = -1;
		lastY = -1;
	}
	override function rightUp(e:MouseEvent) 
	{
		super.rightUp(e);
		rightBool = false;
	}
	private function drawBorder()
	{
		var borderWidth:Int = intX * Main.tiles.size;
		var borderHeight:Int = intY * Main.tiles.size;
		shape.graphics.beginFill(0, 0);
		shape.graphics.lineStyle(1, 0xFFFFFF,1,true,LineScaleMode.NORMAL,CapsStyle.SQUARE);
		shape.graphics.drawRect(0, 0, borderWidth, borderHeight);
	}
	
	public function resize()
	{
		x = (stage.stageWidth - width) / 2;
		y = (stage.stageHeight - height) / 2;
	}
}