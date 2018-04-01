package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

/**
 * Class declaration for the squid monster class
 */
class Saucer extends FlxSprite
{	
	
    private var _shotClock:Float;
	/**
	 * This is the constructor for the squid monster.
	 * We are going to set up the basic values and then create a simple animation.
	 */
	public function new()
	{
		super(0, 0);
		// Load this animated graphic file
		loadGraphic(Reg.saucer, true);	
		
		var side:Int = FlxG.random.int(0, 2);
		x = 160 - width;
		if (side == 0)
		{
			x = 0;
		}
		// Initialize sprite object
		y = FlxG.random.int(0,Std.int(128-height-20));		
		// Time to create a simple animation! "alien.png" has 3 frames of animation in it.
		// We want to play them in the order 1, 2, 3, 1 (but of course this stuff is 0-index).
		// To avoid a weird, annoying appearance the framerate is randomized a little bit
		// to a value between 6 and 10 (6+4) frames per second.
		//addAnimation("Default", [0, 1, 0, 2], Math.floor(6 + FlxG.random.float() * 4));
		
		// Now that the animation is set up, it's very easy to play it back!
		//play("Default");
		
		// Everybody move to the right!
		//velocity.y = FlxG.random.intRanged(50,100);
		var sign:Int = 1;
		if (side == 1)
		{
			sign = -1;
		}
		velocity.x = sign * FlxG.random.int(20,50);
		
		resetShotClock();
	}
	
	/*override public function kill():Void
	{
		super.kill();
		this.init(FlxG.random.intRanged(500, FlxG.width-500), 280);
	}*/
	
	/**
	 * Basic game loop is BACK y'all
	 */
	override public function update(elapsed:Float):Void
	{
		// If alien has moved too far to the left, reverse direction and increase speed!
		if (x < 0 || x > 160-width)
		{
			velocity.x = -velocity.x;
		}
		if(y > 128-height-20 || y < 0)
		{
			velocity.y = -velocity.y;
		}
		
		_shotClock -= FlxG.elapsed; 
		
		if (_shotClock <= 0)
		{
			// We counted down to zero, so it's time to shoot a bullet!
			resetShotClock();
			FlxG.sound.play(Reg.enemyShootWav);
			var bullet:FlxSprite = cast(cast(FlxG.state, PlayState).enemyBullets.recycle(), FlxSprite);
			bullet.loadGraphic(Reg.enemybullets, true, 8, 8);
			bullet.reset(x + width / 2 - bullet.width / 2, y+height);
			bullet.animation.add("fire", [0,1], 4, true);	
			bullet.animation.play("fire");
			bullet.velocity.y = 65;
		}
		
		super.update(elapsed);
	}
	
	/**
	 * This function just resets our bullet logic timer to a random value between 1 and 11
	 */
	private function resetShotClock():Void
	{
		_shotClock = 1;
	}
}
