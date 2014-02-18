package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*
	[SWF(width = "640", height = "480", backgroundColor = "#00000000")]
	[Frame(factoryClass="Preloader")]
	
	public class CustodianGame extends FlxGame
	{
	
		public function CustodianGame() 
		{
			super(640, 640, StartMenuState);
		}
		
	}

}