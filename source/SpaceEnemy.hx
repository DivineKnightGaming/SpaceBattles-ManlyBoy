package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

/**
 * Class declaration for the squid monster class
 */
class SpaceEnemy extends FlxSprite
{	
	
	/**
	 * This is the constructor for the squid monster.
	 * We are going to set up the basic values and then create a simple animation.
	 */
	public function new(X:Int, Y:Int)
	{
		// Initialize sprite object
		super(X, Y);		
		// Load this animated graphic file
		loadGraphic(Reg.demon, true);	
		
		// Time to create a simple animation! "alien.png" has 3 frames of animation in it.
		// We want to play them in the order 1, 2, 3, 1 (but of course this stuff is 0-index).
		// To avoid a weird, annoying appearance the framerate is randomized a little bit
		// to a value between 6 and 10 (6+4) frames per second.
		//addAnimation("Default", [0, 1, 0, 2], Math.floor(6 + FlxG.random.float() * 4));
		
		// Now that the animation is set up, it's very easy to play it back!
		//play("Default");
		
		// Everybody move to the right!
		velocity.y = FlxG.random.int(50,100);
		velocity.x = FlxG.random.sign() * FlxG.random.int(50,100);
	}
	
	/*override public function kill():Void
	{
		super.kill();
		this.init(FlxG.random.intRanged(500, FlxG.width-500), 280);
	}*/
	
	public function init(xPos:Int, yPos:Int):Void
	{
		switch(FlxG.random.intRanged(0, 6))
		{
			case 0:
				loadGraphic(Reg.vampireBat, true);	
			case 1:
				loadGraphic(Reg.batSkeleton, true);	
			case 2:
				loadGraphic(Reg.demon, true);	
			case 3:
				loadGraphic(Reg.demonSkeleton, true);	
			case 4:
				loadGraphic(Reg.imp, true);	
			case 5:
				loadGraphic(Reg.devilWinged, true);	
			case 6:
				loadGraphic(Reg.arcDeath, true);	
			default:
				loadGraphic(Reg.vampireBat, true);	
		}
		velocity.y = FlxG.random.int(50,100);
		velocity.x = FlxG.random.sign() * FlxG.random.int(50, 100);
		x = xPos;
		y = yPos;
	}
	
	/**
	 * Basic game loop is BACK y'all
	 */
	override public function update(elapsed:Float):Void
	{
		// If alien has moved too far to the left, reverse direction and increase speed!
		if (x < 420 || x > FlxG.width-width-420)
		{
			velocity.x = -velocity.x;
		}
		if(y > FlxG.height-height-100 || y < 180)
		{
			velocity.y = -velocity.y;
		}
		
		// Then do some bullet shooting logic
		/*if (y > FlxG.height * 0.35)
		{
			// Only count down if on the bottom two-thirds of the screen
			_shotClock -= FlxG.elapsed; 
		}
		
		if (_shotClock <= 0)
		{
			// We counted down to zero, so it's time to shoot a bullet!
			resetShotClock();
			var bullet:FlxSprite = cast(cast(FlxG.state, PlayState).alienBullets.recycle(), FlxSprite);
			bullet.reset(x + width / 2 - bullet.width / 2, y);
			bullet.velocity.y = 65;
		}*/
		
		super.update(elapsed);
	}
	
	/**
	 * This function just resets our bullet logic timer to a random value between 1 and 11
	 */
	/*private function resetShotClock():Void
	{
		_shotClock = 1 + FlxG.random.float() * 10;
	}*/
}
