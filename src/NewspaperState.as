package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	public class NewspaperState extends FlxState
	{
		public static var s_win:Boolean = false;
		
		[Embed(source = "successnews.png")] private var paperWinImg:Class;
		[Embed(source = "failurenews.png")] private var paperLoseImg:Class;
		
		[Embed(source = "starSpangled.mp3")] private var winMusic:Class;
		[Embed(source = "Glory to NK.mp3")] private var loseMusic:Class;
		
		public var newspaper:FlxSprite;
		private var spinTimer:Number = 0.0;
		private var spinDone:Boolean = false;
		
		override public function create():void
		{
			newspaper = new FlxSprite();
			newspaper.origin.x = 320;
			newspaper.origin.y = 240;
			newspaper.scale.x = 0.0;
			newspaper.scale.y = 0.0;
			if (s_win)
			{
				newspaper.loadGraphic(paperWinImg);
				FlxG.playMusic(winMusic);
			}
			else
			{
				newspaper.loadGraphic(paperLoseImg);
				FlxG.playMusic(loseMusic);
			}
			
			add(newspaper);
		}
		
		override public function update():void
		{
			if (spinTimer < 2.0)
			{
				spinTimer += FlxG.elapsed
				newspaper.angle = (360.0*3.0) * (spinTimer / 2.0);
				newspaper.scale.x = 1.0 * (spinTimer / 2.0);
				newspaper.scale.y = 1.0 * (spinTimer / 2.0);
			}
			else if (!spinDone)
			{
				spinDone = true;
				newspaper.angle = 0.0;
				newspaper.scale.x = 1.0;
				newspaper.scale.y = 1.0;
			}
		}
		
	}

}