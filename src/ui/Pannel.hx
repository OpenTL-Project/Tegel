package ui;

import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.Event;

/**
 * ...
 * @author ...
 */
class Pannel extends Sprite 
{
	
	public function new() 
	{
		super();
		addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		addEventListener(Event.ENTER_FRAME, update);
		addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		addEventListener(MouseEvent.MIDDLE_MOUSE_DOWN, middleMouseDown);
		addEventListener(MouseEvent.MIDDLE_MOUSE_UP, middleMouseUp);
		addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, rightDown);
		addEventListener(MouseEvent.RIGHT_MOUSE_UP, rightUp);
	}
	private function update(_)
	{
		
	}
	private function rightDown(e:MouseEvent)
	{
		
	}
	private function rightUp(e:MouseEvent)
	{
		
	}
	private function mouseDown(e:MouseEvent)
	{
		
	}
	private function mouseUp(e:MouseEvent)
	{
		
	}
	private function middleMouseDown(e:MouseEvent)
	{
		startDrag();
	}
	private function middleMouseUp(e:MouseEvent)
	{
		stopDrag();
		leave();
	}
	private function mouseWheel(e:MouseEvent)
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
		//scale
		if (scaleX > 8) scaleX = 8;
		if (scaleY > 8) scaleY = 8;
		if (scaleX < 0.1) scaleX = 0.1;
		if (scaleY < 0.1) scaleY = 0.1;
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