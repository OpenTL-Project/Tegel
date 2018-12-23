package system;
import openfl.ui.Keyboard;

/**
 * ...
 * @author ...
 */
class Binding 
{
	public static var up:Array<Int> = [Keyboard.UP];
	public static var down:Array<Int> = [Keyboard.DOWN];
	public static var left:Array<Int> = [Keyboard.LEFT];
	public static var right:Array<Int> = [Keyboard.RIGHT];
	public static var visible:Array<Int> = [Keyboard.V];
	public static var upSelect:Array<Int> = [Keyboard.W];
	public static var downSelect:Array<Int> = [Keyboard.S];
	public static var leftSelect:Array<Int> = [Keyboard.A];
	public static var rightSelect:Array<Int> = [Keyboard.D];
	public static var keyDown:Bool = false;
	
	public static function key(code:Int,bool:Bool)
	{
		//movement
		if (up.indexOf(code) >= 0) Main.up = bool;
		if (down.indexOf(code) >= 0) Main.down = bool;
		if (left.indexOf(code) >= 0) Main.left = bool;
		if (right.indexOf(code) >= 0) Main.right = bool;
		//select move
		if (upSelect.indexOf(code) >= 0) Main.upSelect = bool;
		if (downSelect.indexOf(code) >= 0) Main.downSelect = bool;
		if (leftSelect.indexOf(code) >= 0) Main.leftSelect = bool;
		if (rightSelect.indexOf(code) >= 0) Main.rightSelect = bool;
		//visible
		if (visible.indexOf(code) >= 0 && bool) 
		{
			Main.vis = !Main.vis;
			Main.tile.shape.visible = Main.vis;
		}
		keyDown = bool;
	}
}