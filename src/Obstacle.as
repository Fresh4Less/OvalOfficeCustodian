package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	public class Obstacle extends FlxSprite
	{
		public function Obstacle(X:int, Y:int, graphic:Class = null) 
		{
			super(X, Y);
			if (graphic)
				loadGraphic(graphic);
			else
				makeGraphic(7, 7, 0xffffffff);
			
			maxVelocity.x = 20;
			maxVelocity.y = 20
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
		}
	}

}