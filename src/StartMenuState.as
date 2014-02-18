package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	import org.flixel.*;
	public class StartMenuState extends FlxState
	{
		override public function create():void
		{
			FlxG.bgColor = 0xff000000;
			var title:FlxText = new FlxText(0, FlxG.stage.stageHeight * 0.3, FlxG.stage.stageWidth, "oval office custodian");
			title.size = 48;
			title.alignment = "center";
			add(title);
			var instructions:FlxText = new FlxText(0, FlxG.stage.stageHeight * 0.6, FlxG.stage.stageWidth, "press x to start");
			instructions.size = 16;
			instructions.alignment = "center";
			add(instructions);
		}
		
		override public function update():void
		{
			if(FlxG.keys.X)
				FlxG.switchState(new BriefingState);
			super.update();
		}
		
	}

}