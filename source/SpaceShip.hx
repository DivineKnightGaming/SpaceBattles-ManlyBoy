package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.gamepad.FlxGamepad;
//import flixel.input.gamepad.XboxButtonID;
//import flixel.input.gamepad.OUYAButtonID;

/**
 * Class declaration for the player's little ship
 */
class SpaceShip extends FlxSprite		
{
    private var _shotClock:Float;
	private var _gamePad:FlxGamepad;
	/**
	 * Constructor for the player - just initializing a simple sprite using a graphic.
	 */ 
	public function new(shipSprite:String)
	{
		// This initializes this sprite object with the graphic of the ship and
		// positions it in the middle of the screen.
		super(72, 112, shipSprite);
		resetShotClock();
	}
	
	/**
	 * Basic game loop function again!
	 */
	override public function update(elapsed:Float):Void
	{
		
		_gamePad = FlxG.gamepads.lastActive;
		if (_gamePad == null)
		{
			// Make sure we don't get a crash on neko when no gamepad is active
			_gamePad = FlxG.gamepads.getByID(0);
		}
		
		//Controls!
		velocity.x = 0;				//Default velocity to zero
		if(FlxG.keys.pressed.LEFT || ( Reg.usegamepad && _gamePad.pressed.DPAD_LEFT))
		{
			velocity.x -= 30;		//If the player is pressing left, set velocity to left 100
		}
		if(FlxG.keys.pressed.RIGHT || ( Reg.usegamepad && _gamePad.pressed.DPAD_RIGHT ))	
		{
			velocity.x += 30;		//If the player is pressing right, then right 100
		}
		velocity.y = 10;				//Default velocity to zero
		if(FlxG.keys.pressed.UP || ( Reg.usegamepad && _gamePad.pressed.DPAD_UP))
		{
			velocity.y -= 40;		//If the player is pressing up, set velocity to up 100
		}
		if(FlxG.keys.pressed.DOWN || ( Reg.usegamepad && _gamePad.pressed.DPAD_DOWN))	
		{
			velocity.y += 20;		//If the player is pressing down, then down 100
		}
		
		//Just like in PlayState, this is easy to forget but very important!
		//Call this to automatically evaluate your velocity and position and stuff.
		super.update(elapsed);
		
		//Here we are stopping the player from moving off the screen,
		// with a little border or margin of 420 pixels.
		if(x > (160)-width)
		{
			x = (160)-width; //Checking and setting the right side boundary
		}
		if(x < 0)
		{
			x = 0;					//Checking and setting the left side boundary
		}
		
		//Here we are stopping the player from moving off the screen,
		// with a little border or margin of 4 pixels.
		if(y > 112)
		{
			y = 112; //Checking and setting the bottom side boundary
		}
		if(y < 0)
		{
			y = 0;					//Checking and setting the top side boundary
		}
		
		
		_shotClock -= FlxG.elapsed; 
		
		//Finally, we gotta shoot some bullets amirite?  First we check to see if the
		// space bar was just pressed (no autofire in space invaders you guys)
		
		if((FlxG.keys.justPressed.SPACE || ( Reg.usegamepad && _gamePad.justPressed.A)) && _shotClock <= 0)
		{
			//Space bar was pressed!  FIRE A BULLET
			FlxG.sound.play(Reg.playerShootWav);
			resetShotClock();
			
			if(cast(FlxG.state, SpacePlayState).powers == 0 || cast(FlxG.state, SpacePlayState).powers == 2)
			{
				var bullet:FlxSprite = cast(cast(FlxG.state, SpacePlayState).player1Bullets.recycle(), FlxSprite);	
				bullet.loadGraphic(Reg.bullets, true, 8, 8);
				bullet.animation.add("fire", [0,1], 4, true);	
				bullet.animation.play("fire");
				bullet.reset(x + width/2 - bullet.width/2, y-bullet.height);
				bullet.velocity.y = -200;
			}
			if(cast(FlxG.state, SpacePlayState).powers >= 1)
			{
				var bullet:FlxSprite = cast(cast(FlxG.state, SpacePlayState).player1Bullets.recycle(), FlxSprite);	
				bullet.loadGraphic(Reg.bullets, true, 8, 8);
				bullet.animation.add("fire", [0,1], 4, true);	
				bullet.animation.play("fire");
				bullet.reset(x - bullet.width/2, y-bullet.height);
				bullet.velocity.y = -200;
				
				var bullet:FlxSprite = cast(cast(FlxG.state, SpacePlayState).player1Bullets.recycle(), FlxSprite);	
				bullet.loadGraphic(Reg.bullets, true, 8, 8);
				bullet.animation.add("fire", [0,1], 4, true);	
				bullet.animation.play("fire");
				bullet.reset(x + width - bullet.width/2, y-bullet.height);
				bullet.velocity.y = -200;
			}
		}
		
		super.update(elapsed);
	}
	/**
	 * This function just resets our bullet logic timer to a random value between 1 and 11
	 */
	public function resetShotClock(time:Float=.2):Void
	{
		_shotClock = time;
	}
}
