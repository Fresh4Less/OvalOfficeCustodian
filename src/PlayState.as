package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class PlayState extends FlxState 
	{
		
		[Embed(source = "oval office.png")] private var ovalBackgroundImg:Class;
		[Embed(source = "oval light.png")] private var ovalLightImg:Class;
		[Embed(source = "tabl.png")] private var tableImg:Class;
		[Embed(source = "trash_chip.png")] private var trashChipImg:Class;
		[Embed(source = "trash_trash.png")] private var trashPaperImg:Class;
		[Embed(source = "potted plant.png")] private var plantImg:Class;
		[Embed(source = "couch.png")] private var couchImg:Class;
		[Embed(source = "chair.png")] private var chairImg:Class;
		[Embed(source = "presidentialseal.png")] private var stampImg:Class;
		
		[Embed(source = "yummy chip.mp3")] private var chipSound:Class;
		[Embed(source = "paper.mp3")] private var paperSound:Class;
		[Embed(source = "vacuum.mp3")] private var vaccumSound:Class;
		[Embed(source = "door.mp3")] private var doorSound:Class;
		[Embed(source = "door_close.mp3")] private var doorCloseSound:Class;
		[Embed(source = "countdown.mp3")] private var countdownSound:Class;
		[Embed(source = "stampSound.mp3")] private var stampSound:Class;
		
		private var trashArray:Array =
		[trashChipImg, trashPaperImg];
		private var trashSoundArray:Array = 
		[chipSound, paperSound];
		
		private var player:Player;
		private var obstacles:FlxGroup;
		private var trashes:FlxGroup;
		
		private var exitDoor:FlxSprite;
		private var ovalBackground:FlxSprite;
		private var ovalLight:FlxSprite;
		
		private var walls:FlxGroup;
		
		private var timer:Number;
		private var timerText:FlxText;
		private var koreanText:FlxText = null;
		
		private var introSequenceOn:Boolean;
		private var introSequenceTimer:Number;
		private var readyText:FlxText;
		private var readyTextTimer:Number = 0.0;
		
		private var introE1:Boolean = false;
		private var introE2:Boolean = false;
		private var introE3:Boolean = false;
		private var introE4:Boolean = false;
		private var introE5:Boolean = false;
		private var introE6:Boolean = false;
		
		private var outroSequenceOn:Boolean = false;
		private var outroSequenceTimer:Number = 0.0;
		private var outroE1:Boolean = false;
		private var outroE2:Boolean = false;
		private var outroE3:Boolean = false;
		private var doneText:FlxText;
		
		private var stamp:FlxSprite;
		
		override public function create():void
		{
			walls = new FlxGroup();
			var leftWall:FlxSprite = new FlxSprite(0, 0);
			leftWall.makeGraphic(10, 480, 0xff000000);
			leftWall.immovable = true;
			var rightWall:FlxSprite = new FlxSprite(630, 0);
			rightWall.makeGraphic(10, 480, 0xff000000);
			rightWall.immovable = true;
			var upWall:FlxSprite = new FlxSprite(0, 0);
			upWall.makeGraphic(640, 10, 0xff000000);
			upWall.immovable = true;
			var downWall1:FlxSprite = new FlxSprite(0, 470);
			downWall1.makeGraphic(320-50, 10, 0xff000000);
			downWall1.immovable = true;
			var downWall2:FlxSprite = new FlxSprite(320+50, 470);
			downWall2.makeGraphic(320-50, 10, 0xff000000);
			downWall2.immovable = true;
			walls.add(leftWall)
			walls.add(rightWall)
			walls.add(upWall)
			walls.add(downWall1)
			walls.add(downWall2)
			
			player = new Player(FlxG.width / 2 - 32, 640);
			obstacles = new FlxGroup();
			
			obstacles.add(new Obstacle(130, 180, tableImg));
			obstacles.add(new Obstacle(400, 280, couchImg));
			obstacles.add(new Obstacle(80, 220, chairImg));
			obstacles.add(new Obstacle(300, 100, plantImg));
			obstacles.add(new Obstacle(420, 370, plantImg));
			var couch2:Obstacle = new Obstacle(400, 120, couchImg);
			couch2.angle = 180;
			obstacles.add(couch2);
			var chair2:Obstacle = new Obstacle(220, 130, chairImg);
			chair2.angle = 180 - 35;
			obstacles.add(chair2);
			var chair3:Obstacle = new Obstacle(350, 250, chairImg);
			chair3.angle = 360-45;
			obstacles.add(chair3);
			
			trashes = new FlxGroup();
			
			for (var i:int = 0; i < 8; i++)
			{
				for (var j:int = 0; j < 6; j++)
				{
					var type:int = Math.floor(Math.random() * trashArray.length);
					trashes.add(new Trash(50 + (Math.random() * 250) + (i * ((640 - 280) / 8)), 50 + (Math.random() * 200) + (j * ((480 - 280) / 6)) ,
						trashArray[type], trashSoundArray[type]));
				}
			}
			
			exitDoor = new FlxSprite(320-50, 470);
			exitDoor.makeGraphic(100, 10, 0xff992211);
			exitDoor.immovable = true;
			
			ovalBackground = new FlxSprite();
			ovalBackground.loadGraphic(ovalBackgroundImg);
			
			ovalLight = new FlxSprite();
			ovalLight.loadGraphic(ovalLightImg);
			ovalLight["alpha"] = 0.4;
			
			timer = 0.0;
			
			introSequenceOn = true;
			introSequenceTimer = 0.0;
			
			stamp = new FlxSprite(410, 260);
			//stamp.makeGraphic(100, 100, 0xffffff00);
			//stamp.loadGraphic(stampImg, true, false, 100, 100);
			//stamp.addAnimation("press", [0, 1], 10, false);
			stamp.loadGraphic(stampImg);
			stamp.angle = 330;
			
			add(ovalBackground);
			add(walls);
			add(obstacles);
			add(trashes);
			add(player);
			add(exitDoor);
			add(ovalLight);
			
			
			//add(timerText);
			//FlxG.playMusic(vaccumSound);
			
			//FlxG.visualDebug = true;
			
			
		}
		
		override public function update():void
		{
			if (introSequenceOn)
			{
				updateIntroSequence();
				super.update();
			}
			else if (outroSequenceOn)
			{
				updateOutroSequence();
				super.update();
			}
			else
			{
				/*
				if (FlxG.keys.X)
				{
					trashes.kill()
					getTrash(trashes.members[0], player);
				}
				*/
				timer += FlxG.elapsed;
				timerText.text = timer.toFixed(3);
				if (timer > 60.0 && koreanText == null)
				{
					timerText.color = 0xffff0000;
					koreanText = new FlxText(0, 60, 640, "THE NORTH KOREAN AMBASSADORS ARE WAITING!");
					koreanText.alignment = "center";
					koreanText.size = 32;
					koreanText.color = 0xffff0000;
					koreanText.outline = 0xff000000
					add(koreanText);
				}
				if (timer > 60.0 && Math.floor(timer) % 6 == 0)
				{
					koreanText.color = 0xffff0000;
				}
				else if (timer > 60.0 && Math.floor(timer) % 6 == 3)
				{
					koreanText.color = 0xffffffff;
				}
					
				readyTextTimer += FlxG.elapsed;
				if (readyTextTimer >= 0.25)
				{
					if (readyText)
					{
						remove(readyText);
						readyText.destroy();
						readyText = null;
					}
				}
				
				super.update();
				
				if (player.y > FlxG.height - 64 && trashes.countLiving() == 0 && player.canMove) //finished!
				{
					player.canMove = false;
					FlxG.music.stop();
					exitDoor.x -= exitDoor.width - 20;
					exitDoor.y -= exitDoor.width * Math.sin(exitDoor.angle * Math.PI / 180) / 2;
					exitDoor.angle = 0;
					FlxG.play(doorCloseSound);
					doneText = new FlxText(0, 200, 640, "DONE!");
					doneText.alignment = "center";
					doneText.color = 0xffffffff;
					doneText.outline = 0xff000000;
					doneText.size = 64;
					add(doneText);
					timerText.y = 300;
					timerText.size = 64;
					if (koreanText)
					{
						remove(koreanText);
						koreanText.destroy();
						koreanText = null;
					}
					outroSequenceOn = true;
				}
				
				FlxG.overlap(trashes, player, getTrash);
				if (FlxG.collide(obstacles, player))
				{
					player.maxVelocity.x = 5;
					player.maxVelocity.y = 5;
				}
				else
				{
					player.maxVelocity.x = 80;
					player.maxVelocity.y = 80;
				}
				FlxG.collide(walls, obstacles);
				FlxG.collide(walls, player);
				FlxG.collide(obstacles, obstacles);
				if(exitDoor.angle == 0)
					FlxG.collide(exitDoor, player);
			}
		}
		
		public function getTrash(trash:Trash, player:Player):void
		{
			if (trash.m_sound)
				FlxG.play(trash.m_sound);
			trash.kill();
			if (trashes.countLiving() == 0)
			{
				openDoor();
			}
		}
		
		public function openDoor():void
		{
			exitDoor.angle = 315;
			exitDoor.x += exitDoor.width - 20;
			exitDoor.y += exitDoor.width * Math.sin(exitDoor.angle * Math.PI / 180) / 2;
			FlxG.play(doorSound);
		}
		
		public function closeDoor():void
		{
			exitDoor.x -= exitDoor.width - 20;
			exitDoor.y -= exitDoor.width * Math.sin(exitDoor.angle * Math.PI / 180) / 2;
			exitDoor.angle = 0;
			FlxG.play(doorSound);
		}
		
		public function updateIntroSequence():void
		{
			introSequenceTimer += FlxG.elapsed;
			if (!introE3)
			{
				player.moveForward();
			}
			if (!introE1 && introSequenceTimer >= 2.0) //open door
			{
				introE1 = true;
				openDoor();
			}
			if (!introE2 && introSequenceTimer >= 3.5) //close door
			{
				introE2 = true;
				closeDoor();
			}
			if (!introE3 && introSequenceTimer >= 5.5) //stop movement
			{
				introE3 = true;
			}
			if (!introE4 && introSequenceTimer >= 6.5) //ready
			{
				introE4 = true;
				readyText = new FlxText(0, 200, 640, "READY");
				readyText.alignment = "center";
				readyText.size = 64;
				readyText.outline = 0xff000000;
				add(readyText);
				FlxG.play(countdownSound);
			}
			if (!introE5 && introSequenceTimer >= 7.45) //set
			{
				introE5 = true;
				readyText.text = "SET";
			}
			if (!introE6 && introSequenceTimer >= 8.4)
			{
				introE6 = true;
				readyText.text = "VACCUM!";
				player.canMove = true;
				timerText = new FlxText(0, 10, 640, "0");
				timerText.alignment = "center";
				timerText.size = 32;
				timerText.color = 0xff00dd00;
				add(timerText);
				FlxG.playMusic(vaccumSound);
				introSequenceOn = false;
			}
		}
		
		public function updateOutroSequence():void
		{
			outroSequenceTimer += FlxG.elapsed;
			if (!outroE1 && outroSequenceTimer >= 1.0)
			{
				outroE1 = true;
			}
			if (timer<=60.0 && !outroE2 && outroSequenceTimer >= 2.0)
			{
				outroE2 = true;
				add(stamp);
				//stamp.play("press");
				FlxG.play(stampSound);
			}
			if (!outroE3 && outroSequenceTimer >= 6.0)
			{
				outroE3 = true;
				if(timer <= 60.0)
					NewspaperState.s_win = true;
				else
					NewspaperState.s_win = false;
				FlxG.switchState(new NewspaperState);
			}
		}
		
	}

}