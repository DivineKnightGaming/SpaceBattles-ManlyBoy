package;


import openfl.Assets;
import flash.geom.Rectangle;
import flash.net.SharedObject;

import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.util.FlxPath;
import flixel.util.FlxSave;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.math.FlxRandom;
import flixel.util.FlxCollision;
import flixel.FlxCamera;
import flixel.effects.FlxFlicker;
import flixel.input.gamepad.FlxGamepad;
//import flixel.input.gamepad.XboxButtonID;
//import flixel.input.gamepad.OUYAButtonID;
import flash.system.System;

import flixel.addons.display.FlxExtendedSprite;

class SpacePlayState extends FlxState
{
    private var state:UInt = 1;
    private var starField:StarField;
	private var _gamePad:FlxGamepad;
	/**
	 * Refers to the bullets you shoot
	 */
	public var player1Bullets:FlxGroup;
	public var enemies:FlxGroup;
	public var enemyBullets:FlxGroup;
	public var lifeDrops:FlxGroup;
	public var shieldDrops:FlxGroup;
	public var powerDrops:FlxGroup;
	public var bombDrops:FlxGroup;
	
	private var _spawnTimer:Float;
	private var _spawnInterval:Float = 1;
	
	private var hudCam:FlxCamera;
	private var playerCam:FlxCamera;
	private var mbCam:FlxCamera;
	
	private var dreadnautExists:Bool = false;
	
	private var lives:Int = 3;
	private var shields:Int = 0;
	public var bombs:Int = 0;
	public var powers:Int = 0;
	/**
	 * Refers to the little player ship at the bottom
	 */ 
	private var _player1:SpaceShip;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		FlxG.cameras.bgColor = 0xff565656;
		
        starField = new StarField(270);
        add(starField);
		
		Reg.manlyBoySp = new FlxSprite( 0, 1000, Reg.manlyBoy);
		add(Reg.manlyBoySp);
		mbCam = new FlxCamera(0, 0, 320, 180);
		mbCam.setScrollBoundsRect(0, 1000, 320, 180);
		mbCam.follow(Reg.manlyBoySp);
		FlxG.cameras.add(mbCam);
		
		// First we will instantiate the bullets you fire at your enemies.
		var numPlayerBullets:Int = 10;
		// Initializing the array is very important and easy to forget!
		player1Bullets = new FlxGroup(numPlayerBullets);
		var sprite:FlxSprite;
		
		// Create 8 bullets for the player to recycle
		for(i in 0...numPlayerBullets)			
		{
			// Instantiate a new sprite offscreen
			sprite = new FlxSprite( -100, -100, Reg.bullets);		
			sprite.loadGraphic(Reg.bullets, true, 8, 8);
			sprite.animation.add("fire", [0,1], 4, true);	
			sprite.exists = false;
			// Add it to the group of player bullets
			player1Bullets.add(sprite);			
		}
		
		add(player1Bullets);
		
		var numenemyBullets:Int = 20;
		enemyBullets = new FlxGroup(numenemyBullets);
		
		// Create 8 bullets for the player to recycle
		for(i in 0...numenemyBullets)			
		{
			// Instantiate a new sprite offscreen
			sprite = new FlxSprite( -100, -100, Reg.enemybullets);		
			sprite.loadGraphic(Reg.enemybullets, true, 8, 8);
			sprite.animation.add("fire", [0,1], 4, true);	
			sprite.exists = false;
			// Add it to the group of player bullets
			enemyBullets.add(sprite);			
		}
		
		add(enemyBullets);
		
		var numDrops:Int = 4;
		lifeDrops = new FlxGroup(numDrops);
		for(i in 0...numDrops)			
		{
			// Instantiate a new sprite offscreen
			sprite = new FlxSprite( -100, -100, Reg.life);		
			sprite.exists = false;
			// Add it to the group of player bullets
			lifeDrops.add(sprite);			
		}
		
		add(lifeDrops);
		
		powerDrops = new FlxGroup(numDrops);
		for(i in 0...numDrops)			
		{
			// Instantiate a new sprite offscreen
			sprite = new FlxSprite( -100, -100, Reg.power);		
			sprite.exists = false;
			// Add it to the group of player bullets
			powerDrops.add(sprite);			
		}
		
		add(powerDrops);
		
		shieldDrops = new FlxGroup(numDrops);
		for(i in 0...numDrops)			
		{
			// Instantiate a new sprite offscreen
			sprite = new FlxSprite( -100, -100, Reg.shield);	
			sprite.exists = false;
			// Add it to the group of player bullets
			shieldDrops.add(sprite);			
		}
		
		add(shieldDrops);
		
		bombDrops = new FlxGroup(numDrops);
		for(i in 0...numDrops)			
		{
			// Instantiate a new sprite offscreen
			sprite = new FlxSprite( -100, -100, Reg.bomb);	
			sprite.exists = false;
			// Add it to the group of player bullets
			bombDrops.add(sprite);			
		}
		
		add(bombDrops);
		
		//NOTE: what we're doing here with bullets might seem kind of complicated but
		// it is a good thing to get into the practice of doing. What we are doing
		// is creating a big pile of bullets that we can recycle, because there are only
		// ever like 10 bullets or something on screen at once anyways.
		
		// Now that we have a list of bullets, we can initialize the player (and give them the bullets)
		_player1 = new SpaceShip(Reg.spaceship);
		// Adds the player to the state
		add(_player1);	
		
		playerCam = new FlxCamera(Reg.windowX*Reg.gameZoom, Reg.windowY*Reg.gameZoom, 160, 128);
		playerCam.setScrollBoundsRect(0, 0, 160, 128);
		playerCam.follow(_player1, LOCKON, 1);
		FlxG.cameras.add(playerCam);
		//playerCam.style = FlxCamera.STYLE_LOCKON;
		
		Reg.shieldActiveSp = new FlxSprite( -100, -100, Reg.shieldActive);
		Reg.shieldActiveSp.loadGraphic(Reg.shieldActive, true, 22, 22);
		Reg.shieldActiveSp.animation.add("wave", [0,1], 4, true);	
		Reg.shieldActiveSp.animation.play("wave");
		add(Reg.shieldActiveSp);
		
		var numEnemies:Int = 5;
		enemies = new FlxGroup();
		
		//for (i in 0...(numEnemies))
		//{
			this.createEnemy();
		//}
		add(enemies);
		this.resetSpawnTimer();
		
		Reg.score = 0;
		
		Reg.hudSp = new FlxSprite(0, 576, Reg.hud);
		add(Reg.hudSp);
		
		Reg.sprite = new FlxSprite(50, 580, Reg.life);
		add(Reg.sprite);
		
		Reg.livesText = new FlxText(58,576,100,"x3");
		Reg.livesText.size = 8;
		add(Reg.livesText); 
		
		Reg.sprite = new FlxSprite(80, 580, Reg.shield);
		add(Reg.sprite);
		
		Reg.shieldText = new FlxText(88,576,100,"x0");
		Reg.shieldText.size = 8;
		add(Reg.shieldText); 
		
		Reg.sprite = new FlxSprite(105, 580, Reg.power);
		add(Reg.sprite);
		
		Reg.powerText = new FlxText(113,576,100,"x0");
		Reg.powerText.size = 8;
		add(Reg.powerText); 
		
		Reg.sprite = new FlxSprite(130, 580, Reg.bomb);
		add(Reg.sprite);
		
		Reg.bombText = new FlxText(138,576,100,"x0");
		Reg.bombText.size = 8;
		add(Reg.bombText); 
		
		Reg.scoreText = new FlxText(0,576,100,"Pts: 0");
		Reg.scoreText.size = 8;
		add(Reg.scoreText); 
		
		hudCam = new FlxCamera(Reg.windowX*Reg.gameZoom, (Reg.windowY+128)*Reg.gameZoom, 160, 16);
		hudCam.setScrollBoundsRect(0, 576, 160, 16);
		hudCam.follow(Reg.hudSp);
		FlxG.cameras.add(hudCam);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		//FlxG.overlap(player1Bullets, enemies, stuffHitStuff);
		//FlxG.overlap(_player1, enemies, enemyHitPlayer);
		
		_gamePad = FlxG.gamepads.lastActive;
		if (_gamePad == null)
		{
			// Make sure we don't get a crash on neko when no gamepad is active
			_gamePad = FlxG.gamepads.getByID(0);
		}
		
		this.checkCollisions();
		_spawnTimer -= FlxG.elapsed;
		
		if (_spawnTimer < 0) 
		{			
			this.createEnemy();
			this.resetSpawnTimer();
		}
		
		if(Reg.score > 0 && Reg.score % 100 == 0 && dreadnautExists == false)
		{
			dreadnautExists = true;
			enemies.add(new Dreadnaut());
			enemies.add(new Dreadnaut());
			enemies.add(new Dreadnaut());
			enemies.add(new Dreadnaut());
		}
		else if(Reg.score > 0 && Reg.score % 50 == 0 && dreadnautExists == false)
		{
			dreadnautExists = true;
			enemies.add(new Dreadnaut());
			enemies.add(new Dreadnaut());
		}
		else if(Reg.score > 0 && Reg.score % 10 == 0 && dreadnautExists == false)
		{
			dreadnautExists = true;
			enemies.add(new Dreadnaut());
		}
		
		if(shields > 0)
		{
			//Reg.shieldActiveSp.exists = true;
			Reg.shieldActiveSp.x = _player1.x-3;
			Reg.shieldActiveSp.y = _player1.y-2;
			//Reg.shieldActiveSp.animation.play("wave");
		}
		else
		{
			//Reg.shieldActiveSp.exists = false;
			Reg.shieldActiveSp.x = -100;
		}
		
		
		if(Reg.score > 0 && Reg.score % 10 != 0)
		{
			dreadnautExists = false;
		}
		
		Reg.scoreText.text = "Pts: " + Reg.score;
		Reg.livesText.text = "x" + lives;
		Reg.shieldText.text = "x" + shields;
		Reg.powerText.text = "x" + powers;
		Reg.bombText.text = "x" + bombs;
		//Reg.healthText.text = "Health: " + Reg.p1Health;
		
		if((FlxG.keys.justPressed.Z || ( Reg.usegamepad && _gamePad.justPressed.B)) && bombs > 0)
		{
			//add bomb
			bombs--;
			playerCam.flash();
			FlxG.sound.play(Reg.explodeWav);
			for (i in 0...enemies.length) 
			{
				var enemy = enemies.members[i];

				// Only collide alive members
				if (!enemy.alive) continue;

				// We check collisions with the player seperately, since he's not in the group
				
				dropItem(cast(enemy, FlxSprite));
				//FlxG.sound.play(Reg.enemyKilledWav);
				enemy.kill();
				Reg.score = Reg.score + 1;

			}
		}
		
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed(["ESCAPE"]))
		{
			SaveScores.save();
			System.exit(0);
		}
	}	
	
	private function stuffHitStuff(enemy:FlxBasic, bullet:FlxBasic):Void
	{
		dropItem(cast(enemy, FlxSprite));
		FlxG.sound.play(Reg.enemyKilledWav);
		enemy.kill();
		Reg.score = Reg.score + 1;
		bullet.kill();
		//cast(enemies.recycle(Enemy), Enemy).init(FlxG.random.intRanged(500, FlxG.width-500), 280);
	}
	
	private function dropItem(enemy:FlxSprite):Void
	{
		var drop:Int = FlxG.random.int(0, 7);
		
		if(drop >= 7)
		{
			drop = FlxG.random.int(0, 8);
			switch(drop)
			{
				case 0:
					//drop shield
					var item:FlxSprite = cast(shieldDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 1:
					//drop shield
				
					var item:FlxSprite = cast(shieldDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 2:
					//drop shield
				
					var item:FlxSprite = cast(shieldDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 3:
					//drop power
				
					var item:FlxSprite = cast(powerDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 4:
					//drop power
				
					var item:FlxSprite = cast(powerDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 5:
					//drop power
				
					var item:FlxSprite = cast(powerDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 6:
					//drop bomb
				
					var item:FlxSprite = cast(bombDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 7:
					//drop shield
				
					var item:FlxSprite = cast(shieldDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
				case 8:
					//drop life
				
					var item:FlxSprite = cast(lifeDrops.recycle(), FlxSprite);
					item.reset(enemy.x + enemy.width / 2 - item.width / 2, enemy.y+enemy.height/2);
					item.velocity.y = 50;
			}
		}
	}
	
	private function enemyHitPlayer(enemy:FlxBasic, player:FlxBasic):Void
	{
		if(FlxFlicker.isFlickering(cast(player, FlxSprite)) == false)
		{
			if(shields == 0)
			{
				if(lives == 0)
				{
					FlxG.sound.play(Reg.shipKilledWav);
					FlxG.switchState(new LoseState());
				}
				else
				{
					lives--;
					powers = 0;
					FlxFlicker.flicker(cast(player, FlxSprite));
					cast(player, SpaceShip).resetShotClock(1);
					FlxG.sound.play(Reg.shipKilledWav);
				}
			}
			else
			{
				shields--;
				FlxFlicker.flicker(cast(player, FlxSprite));
				FlxG.sound.play(Reg.shieldHitWav);
			}
		}
		//Reg.p1Health = Reg.p1Health - 1;
		//cast(enemies.recycle(Enemy), Enemy).init(FlxG.random.intRanged(500, FlxG.width-500), 280);
	}
	
	public function resetSpawnTimer():Void 
	{
		_spawnTimer = _spawnInterval;
		_spawnInterval *= 0.99;
		if (_spawnInterval < 0.2) 
		{
			_spawnInterval = 0.2;
		}
	}
	
	public function createEnemy():Void
	{
		
		switch(FlxG.random.int(0, 4))
		{
			case 0:
				enemies.add(new Saucer());
			case 1:
				enemies.add(new Dart(_player1.x,_player1));
			case 2:
				enemies.add(new Cross());
			case 3:
				enemies.add(new Manta());
		}
		
	}
	
	/**
	 * Pixel perfect collision check between all objects
	 */
	function checkCollisions():Void
	{

		for (i in 0...enemies.length) 
		{
			var enemy = enemies.members[i];

			// Only collide alive members
			if (!enemy.alive) continue;

			for (j in 0...player1Bullets.length) 
			{
				var bullet = player1Bullets.members[j];

				// Only collide alive members and don't collide an object with itself
				if (!bullet.alive) continue;

				// this is how we check if obj1 and obj2 are colliding
				if (FlxCollision.pixelPerfectCheck(cast(enemy, FlxSprite), cast(bullet, FlxSprite))) 
				{	
					stuffHitStuff(enemy, bullet);
				}
				
				if(cast(bullet, FlxSprite).alive && cast(bullet, FlxSprite).y < 0)
				{
					cast(bullet, FlxSprite).kill();
				}
			}

			// We check collisions with the player seperately, since he's not in the group
			if (cast(enemy, FlxSprite).alive && FlxCollision.pixelPerfectCheck(cast(enemy, FlxSprite), cast(_player1, FlxSprite)))
			{
				enemyHitPlayer(enemy, _player1);
			}

		}
		for (i in 0...enemyBullets.length) 
		{
			var enemy = enemyBullets.members[i];
			
			if (cast(enemy, FlxSprite).alive && FlxCollision.pixelPerfectCheck(cast(enemy, FlxSprite), cast(_player1, FlxSprite)))
			{
				cast(enemy, FlxSprite).kill();
				enemyHitPlayer(enemy, _player1);
			}
			
			if(cast(enemy, FlxSprite).alive && cast(enemy, FlxSprite).y > 128)
			{
				cast(enemy, FlxSprite).kill();
			}
		}
		
		for (i in 0...lifeDrops.length) 
		{
			var lifeitem = lifeDrops.members[i];
			
			if (cast(lifeitem, FlxSprite).alive && FlxCollision.pixelPerfectCheck(cast(lifeitem, FlxSprite), cast(_player1, FlxSprite)))
			{
				cast(lifeitem, FlxSprite).kill();
				lives++;
				FlxG.sound.play(Reg.lifeWav);
			}
			
			if(cast(lifeitem, FlxSprite).alive && cast(lifeitem, FlxSprite).y > 128)
			{
				cast(lifeitem, FlxSprite).kill();
			}
		}
		for (i in 0...shieldDrops.length) 
		{
			var shielditem = shieldDrops.members[i];
			
			if (cast(shielditem, FlxSprite).alive && FlxCollision.pixelPerfectCheck(cast(shielditem, FlxSprite), cast(_player1, FlxSprite)))
			{
				cast(shielditem, FlxSprite).kill();
				if(shields < 1)
				{
					shields++;
				}
				FlxG.sound.play(Reg.shieldWav);
			}
			
			if(cast(shielditem, FlxSprite).alive && cast(shielditem, FlxSprite).y > 128)
			{
				cast(shielditem, FlxSprite).kill();
			}
		}
		for (i in 0...powerDrops.length) 
		{
			var poweritem = powerDrops.members[i];
			
			if (cast(poweritem, FlxSprite).alive && FlxCollision.pixelPerfectCheck(cast(poweritem, FlxSprite), cast(_player1, FlxSprite)))
			{
				cast(poweritem, FlxSprite).kill();
				if(powers < 2)
				{
					powers++;
				}
				FlxG.sound.play(Reg.powerWav);
			}
			
			if(cast(poweritem, FlxSprite).alive && cast(poweritem, FlxSprite).y > 128)
			{
				cast(poweritem, FlxSprite).kill();
			}
		}
		for (i in 0...bombDrops.length) 
		{
			var bombitem = bombDrops.members[i];
			
			if (cast(bombitem, FlxSprite).alive && FlxCollision.pixelPerfectCheck(cast(bombitem, FlxSprite), cast(_player1, FlxSprite)))
			{
				cast(bombitem, FlxSprite).kill();
				if(bombs == 0)
				{
					bombs++;
				}
				FlxG.sound.play(Reg.bombWav);
			}
			
			if(cast(bombitem, FlxSprite).alive && cast(bombitem, FlxSprite).y > 128)
			{
				cast(bombitem, FlxSprite).kill();
			}
		}
	}
}
