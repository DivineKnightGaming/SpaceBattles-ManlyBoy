package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
//import flixel.util.FlxMath;
import flixel.input.gamepad.FlxGamepad;
//import flixel.input.gamepad.XboxButtonID;
//import flixel.input.gamepad.OUYAButtonID;
import flash.system.System;

/**
 * A FlxState which can be used for the game's menu.
 */
class LogoState extends FlxState
{
	private var _switchTimer:Float;
	private var _gamePad:FlxGamepad;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		SaveScores.load();
		
		if(Reg.fullScreen)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		FlxG.mouse.visible = false;
		FlxG.cameras.bgColor = 0xffacacac;
		
		Reg.manlyBoySp = new FlxSprite( 0, 0, Reg.manlyBoy);
		add(Reg.manlyBoySp);
		
		Reg.dkLogoSp = new FlxSprite( 0, 0, Reg.dkLogo);
		Reg.dkLogoSp.x = (FlxG.width / 2) - (Reg.dkLogoSp.width / 2);
		Reg.dkLogoSp.y = (FlxG.height / 2) - (Reg.dkLogoSp.height / 2);
		add(Reg.dkLogoSp);
		
		_switchTimer = 2.5;
	}
	
	private function goToMenu():Void
	{
		FlxG.switchState(new MenuState());
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
		super.update(elapsed);
		
		_gamePad = FlxG.gamepads.lastActive;
		if (_gamePad == null)
		{
			// Make sure we don't get a crash on neko when no gamepad is active
			_gamePad = FlxG.gamepads.getByID(0);
			Reg.usegamepad = false;
			Reg.controls = "Keyboard";
			Reg.dpad="Arrows";
			Reg.buttonO="Space";
			Reg.buttonU="Q";
			Reg.buttonY="G";
			Reg.buttonA="Z";
		}
		
		_switchTimer -= FlxG.elapsed;
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || ( Reg.usegamepad && _gamePad.justPressed.A) || _switchTimer < 0)
		{
			this.goToMenu();
		}
		if (FlxG.keys.anyJustPressed(["ESCAPE"]))
		{
			SaveScores.save();
			System.exit(0);
		}
	}	
}
