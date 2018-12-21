package;

/**
 * ...
 * @author ...
 */
class Static 
{

	public static function min(x:Int, y:Int):Int
	{
		if (x > y) return y;
		return x;
	}
	public static function max(x:Int, y:Int):Int
	{
		if (x > y) return x;
		return y;
	}
	
}