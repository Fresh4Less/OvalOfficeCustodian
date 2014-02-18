package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import adobe.utils.CustomActions;
	import org.flixel.*;
	public class BriefingState extends FlxState
	{
		[Embed(source = "president_debriefz.png")] private var presidentImg:Class;
		[Embed(source = "warmusic.mp3")] private var warMusic:Class;
		
		private var president:FlxSprite;
		private var presidentText:FlxText;
		private var pressXText:FlxText;
		private var currentText:int = 0;
		private var textBack:FlxSprite;
		private var textBack2:FlxSprite;
		
		private static var texts:Array = 
		["THIS OVAL OFFICE IS A MESS!",
		 "North Korea will be here in 60 seconds for a very important meeting.",
		 "You need to clean it up before they get here!",
		 "The Great Nation of the United States of America is counting on you.",
		 "Use the arrow keys to control the vaccum.",
		 "Make me proud."
		];
		
		
		override public function create():void
		{
			president = new FlxSprite();
			president.loadGraphic(presidentImg, true, false, 640, 480);
			president.addAnimation("idle", [0], 0);
			president.addAnimation("talk", [1, 0], 2);
			
			president.play("talk");
			
			presidentText = new FlxText(350, 20, 285, texts[0]);
			presidentText.color = 0xff2222ff;
			presidentText.size = 16;
			presidentText.alignment = "center";
			
			pressXText = new FlxText(500, 100, 285, "press x to continue");
			pressXText.color = 0xff000000;
			pressXText.size = 8;
			
			textBack = new FlxSprite(345, 20);
			textBack.makeGraphic(290, 100, 0xffffffff);
			
			textBack2 = new FlxSprite(340, 15);
			textBack2.makeGraphic(300, 110, 0xff000000);
			
			add(president);
			add(textBack2);
			add(textBack);
			add(presidentText);
			add(pressXText);
			
			FlxG.playMusic(warMusic);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("X"))
			{
				currentText++;
				if(currentText < texts.length)
					presidentText.text = texts[currentText];
				else
					FlxG.switchState(new PlayState);
			}
			super.update();
		}
	}

}