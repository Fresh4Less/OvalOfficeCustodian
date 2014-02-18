package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	public class Player extends FlxSprite
	{
		[Embed(source = "guyz.png")] private var guyImg:Class;
		
		public var canMove:Boolean;
		public function Player(X:int, Y:int) 
		{
			super(X, Y);
			canMove = false;
			//makeGraphic(7, 7, 0xff1133ff);
			//loadRotatedGraphic(guyImg, 8);
			loadGraphic(guyImg, true, false, 64, 78);
			width = 40;
			height = 40;
			offset.x = (64 - width) / 2;
			origin.x = 32;
			origin.y = 16;
			
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [1, 2], 10, true);
			maxVelocity.x = 80;
			maxVelocity.y = 80
			drag.x = maxVelocity.x * 4;
			drag.y = maxVelocity.y * 4;
			maxAngular = 150;
			angularDrag = maxAngular * 4;
		}
		
		override public function update():void
		{
			acceleration.x = 0;
			acceleration.y = 0;
			angularAcceleration = 0;
			
			//keyboard input
			if (canMove)
			{
				if (FlxG.keys.LEFT)
				{
					turnLeft();
				}
				if (FlxG.keys.RIGHT)
				{
					turnRight();
				}
				if (FlxG.keys.UP)
				{
					moveForward();
				}
				if (FlxG.keys.DOWN)
				{
					moveBackward();
				}
			}
			/*
			if (FlxG.keys.LEFT)
				acceleration.x = - maxVelocity.x * 4;
			if (FlxG.keys.RIGHT)
				acceleration.x = maxVelocity.x * 4;
			if (FlxG.keys.UP)
				acceleration.y =  -maxVelocity.y * 4;
			if (FlxG.keys.DOWN)
				acceleration.y = maxVelocity.y * 4;
				*/
			if (velocity.x != 0 || velocity.y != 0 || angularVelocity != 0)
			{
				play("walk");
			}
			else
			{
				play("idle");
			}
			
			//move bounding box
			
			
			//set sprite rotation
			/*
			if (velocity.x > 0)
			{
				angle = 90;
				offset.x = 64 - (64-width)/2;
				offset.y = 32 + (64-height)/2;
				if (velocity.y > 0)
				{
					angle += 45;
					offset.y = 64 + (64-height)/2;
				}
				else if (velocity.y < 0)
				{
					angle -= 45;
					offset.y = 0 + (64-height)/2;
				}
			}
			else if (velocity.x < 0)
			{
				angle = 270;
				offset.x = -25;
				offset.y = 32 + (64-height)/2;
				if (velocity.y > 0)
				{
					angle -= 45;
					offset.y = 64 + (64-height)/2;
				}
				else if (velocity.y < 0)
				{
					angle += 45;
					offset.y = (64-height)/2;
				}
			}
			else if (velocity.y > 0)
			{
				angle = 180;
				offset.x = (64 - width)/2;
				offset.y = 64 + (64-height);
			}
			else if (velocity.y < 0)
			{
				angle = 0;
				offset.x = (64-width)/2;
				offset.y = 0;
			}
			*/
		}
		
		public function moveForward():void
		{
			velocity.x = maxVelocity.x  * Math.sin(angle * Math.PI / 180);
			velocity.y = -maxVelocity.y * Math.cos(angle * Math.PI / 180);
		}
		public function moveBackward():void
		{
			velocity.x = -maxVelocity.x * Math.sin(angle * Math.PI / 180);
			velocity.y = maxVelocity.y * Math.cos(angle * Math.PI / 180);
		}
		public function turnLeft():void
		{
			angularAcceleration = -maxAngular * 4;
		}
		public function turnRight():void
		{
			angularAcceleration = maxAngular * 4;
		}
	}

}