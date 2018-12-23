package ui;

import haxe.Timer;
import openfl.Lib;
import openfl.display.Tile;
import openfl.geom.ColorTransform;

/**
 * ...
 * @author ...
 */
class Snow extends Tile 
{
	var speedX:Float = 0;
	var speedY:Float = 0;
	var setBool:Bool = false;
	public function new(x:Float=0, y:Float=0) 
	{
		super(0, x, y,0.1,0.1);
		set();
		colorTransform = new ColorTransform(100, 100, 100,0.4);
	}
	private function set()
	{
		if (setBool) return;
		setBool = true;
		var time = new Timer(Math.random() * 1000);
		time.run = function()
		{
			speedY = 6 + Math.random() * 3;
			speedX = (1 + Math.random() * 2) * -1;
			x = Math.random() * Lib.current.stage.stageWidth * 1.2;
			y = -20;
			setBool = false;
			time.stop();
			time = null;
		}
	}
	
	public function update()
	{
		y += speedY;
		speedY *= 0.994;
		x += speedX;
		if (y > Lib.current.stage.stageHeight || x < 0)
		{
			set();
		}
	}
	
}