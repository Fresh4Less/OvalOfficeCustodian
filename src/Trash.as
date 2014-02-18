package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	public class Trash extends FlxSprite
	{
		public var m_sound:Class;
		
		public function Trash(X:int, Y:int, graphic:Class = null, sound:Class = null) 
		{
			super(X, Y);
			m_sound = sound;
			if (graphic)
				loadGraphic(graphic);
			else
				makeGraphic(7, 7, 0xffff0000);
			
			maxVelocity.x = 0;
			maxVelocity.y = 0
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
		}
	}

}