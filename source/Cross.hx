package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

/**
 * Class declaration for the squid monster class
 */
class Cross extends FlxSprite
{	
	
	/**
	 * This is the constructor for the squid monster.
	 * We are going to set up the basic values and then create a simple animation.
	 */
	public function new()
	{
		super(0, 0);
		// Initialize sprite object	
		// Load this animated graphic file
		loadGraphic(Reg.cross, true);	
		x = FlxG.random.int(0,cast(160-width,Int));	
		
		// Time to create a simple animation! "alien.png" has 3 frames of animation in it.
		// We want to play them in the order 1, 2, 3, 1 (but of course this stuff is 0-index).
		// To avoid a weird, annoying appearance the framerate is randomized a little bit
		// to a value between 6 and 10 (6+4) frames per second.
		//addAnimation("Default", [0, 1, 0, 2], Math.floor(6 + FlxG.random.float() * 4));
		
		// Now that the animation is set up, it's very easy to play it back!
		//play("Default");
		
		// Everybody move to the right!
		velocity.y = FlxG.random.int(30,50);
		velocity.x = FlxG.random.sign() * FlxG.random.int(30,50);
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
			FlxG.sound.play(Reg.crossWav);
		}
		if(y > 128 - height || y < 0)
		{
			velocity.y = -velocity.y;
			FlxG.sound.play(Reg.crossWav);
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
	
	/*override public function kill():Void
	{
		
		var drop:Int = FlxG.random.intRanged(0, 9);
		
		if(drop == 9)
		{
			drop = FlxG.random.intRanged(0, 6);
			switch(drop)
			{
				case 0:
					//drop shield
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).shieldDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
				case 1:
					//drop shield
				
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).shieldDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
				case 2:
					//drop shield
				
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).shieldDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
				case 3:
					//drop power
				
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).powerDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
				case 4:
					//drop power
				
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).powerDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
				case 5:
					//drop power
				
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).powerDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
				case 6:
					//drop life
				
					var item:FlxSprite = cast(cast(FlxG.state, SpacePlayState).lifeDrops.recycle(), FlxSprite);
					item.reset(x + width / 2 - item.width / 2, y+height/2);
					item.velocity.y = 50;
			}
		}
		super.kill();
	}*/
	
	/**
	 * This function just resets our bullet logic timer to a random value between 1 and 11
	 */
	/*private function resetShotClock():Void
	{
		_shotClock = 1 + FlxG.random.float() * 10;
	}*/
}
