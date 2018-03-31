package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;

/**
 * Class declaration for the squid monster class
 */
class Dart extends FlxSprite
{	
	
	private var _launchTimer:Float = 1.5;
	private var launched:Bool = false;
	
	private var targ:SpaceShip;
	/**
	 * This is the constructor for the squid monster.
	 * We are going to set up the basic values and then create a simple animation.
	 */
	public function new(X:Float,target:SpaceShip)
	{
		// Initialize sprite object
		super(X, -10);		
		// Load this animated graphic file
		loadGraphic(Reg.dart, true);	
		
		// Time to create a simple animation! "alien.png" has 3 frames of animation in it.
		// We want to play them in the order 1, 2, 3, 1 (but of course this stuff is 0-index).
		// To avoid a weird, annoying appearance the framerate is randomized a little bit
		// to a value between 6 and 10 (6+4) frames per second.
		//addAnimation("Default", [0, 1, 0, 2], Math.floor(6 + FlxG.random.float() * 4));
		
		// Now that the animation is set up, it's very easy to play it back!
		//play("Default");
		
		// Everybody move to the right!
		//velocity.y = -1 * FlxG.random.intRanged(50,100);
		//velocity.x = FlxG.random.sign() * FlxG.random.intRanged(50,100);
		
		targ = target;
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
		if (_launchTimer < 0 && !launched)
		{
			FlxG.sound.play(Reg.dartWav);
			velocity.y = 150;
			launched = true;
		}
		else
		{
			if(!launched)
			{
				x = targ.x;
				_launchTimer -= FlxG.elapsed;
			}
		}
		
		super.update(elapsed);
		
		if(y >= 128+16)
		{
			kill();
		}
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
