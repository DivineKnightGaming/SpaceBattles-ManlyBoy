package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
//import flixel.util.FlxMath;
import flixel.FlxCamera;
import flixel.input.gamepad.FlxGamepad;
//import flixel.input.gamepad.XboxButtonID;
//import flixel.input.gamepad.OUYAButtonID;
import flash.system.System;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
    private var state:UInt = 1;
    private var starField:StarField;
	private var _gamePad:FlxGamepad;
    
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
		
		Reg.manlyBoySp = new FlxSprite( 0, 0, Reg.manlyBoy);
		add(Reg.manlyBoySp);
		
		Reg.dkLogoSp = new FlxSprite( 0, Reg.windowY+20, Reg.spaceBattlesLogo);
		Reg.dkLogoSp.x = (FlxG.width / 2) - (Reg.dkLogoSp.width / 2);
		add(Reg.dkLogoSp);
		
		/*Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+4,160,"Space Battles");
		Reg.text.size = 16;
		Reg.text.alignment = "center";
		add(Reg.text); */
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+74,160,"Kill all the enemy ships before they kill you.");
		Reg.text.size = 8;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.livesText = new FlxText(Reg.windowX+12,Reg.windowY+106,160,"Press "+Reg.buttonO+" to start.");
		Reg.livesText.size = 8;
		add(Reg.livesText); 
		
		Reg.shieldText = new FlxText(Reg.windowX+12,Reg.windowY+126,160,"Press "+Reg.buttonU+" for instructions.");
		Reg.shieldText.size = 8;
		add(Reg.shieldText); 
		
		FlxG.sound.playMusic("assets/music/spacetheme.wav", 1, true);
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
		}
		
		if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || ( Reg.usegamepad && _gamePad.justPressed.A))
		{
			this.goToPlay();
		}
		if (FlxG.keys.justPressed.Q || ( Reg.usegamepad && _gamePad.justPressed.X))
		{
			this.goToOptions();
		}
		if (FlxG.keys.anyJustPressed(["ESCAPE"]))
		{
			SaveScores.save();
			System.exit(0);
		}
	}	
	
	private function goToPlay():Void
	{
		FlxG.switchState(new PlayState());
	}
	
	private function goToOptions():Void
	{
		FlxG.switchState(new OptionsState());
	}
}
