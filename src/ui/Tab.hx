package ui;

import openfl.display.Shape;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * ...
 * @author 
 */
class Tab extends Sprite 
{
	public var titleText:TextField;
	public var exandButton:Shape;
	
	public function new(title:String,setWidth:Int=320,setHeight:Int=912) 
	{
		super();
		titleText = new ui.Text(36, 8, setWidth - 36 * 2, title, 16, Style.data.panel_text);
		addChild(titleText);
		//graphics
		graphics.lineStyle(2, Style.data.borders);
		graphics.beginFill(Style.data.panel_window);
		graphics.drawRoundRect(0, 0, setWidth, setHeight, 8, 8);
		trace("data " + Style.data.panel_window);
	}
	
}