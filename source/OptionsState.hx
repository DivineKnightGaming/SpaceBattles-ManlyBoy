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
class OptionsState extends FlxState
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
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY,160,"Instructions");
		Reg.text.size = 16;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+18,160,Reg.dpad+" to move. "+Reg.buttonO+" to shoot.");
		Reg.text.size = 8;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.sprite = new FlxSprite(Reg.windowX+4, Reg.windowY+40, Reg.life);
		add(Reg.sprite);
		
		Reg.livesText = new FlxText(Reg.windowX+12,Reg.windowY+36,160,"Pick these up for extra lives.");
		Reg.livesText.size = 8;
		add(Reg.livesText); 
		
		Reg.sprite = new FlxSprite(Reg.windowX+4, Reg.windowY+50, Reg.shield);
		add(Reg.sprite);
		
		Reg.shieldText = new FlxText(Reg.windowX+12,Reg.windowY+46,160,"Pick shields up to take more hits without losing a life. Can hold only 1 shield.");
		Reg.shieldText.size = 8;
		add(Reg.shieldText); 
		
		Reg.sprite = new FlxSprite(Reg.windowX+4, Reg.windowY+80, Reg.power);
		add(Reg.sprite);
		
		Reg.powerText = new FlxText(Reg.windowX+12,Reg.windowY+76,160,"Pick up power boosts to fire more shots. Can only shoot 2 extra shots.");
		Reg.powerText.size = 8;
		add(Reg.powerText); 
		
		Reg.sprite = new FlxSprite(Reg.windowX+4, Reg.windowY+110, Reg.bomb);
		add(Reg.sprite);
		
		Reg.powerText = new FlxText(Reg.windowX+12,Reg.windowY+106,150,"Press "+Reg.buttonA+" to kill all enemies. Can hold only 1 bomb.");
		Reg.powerText.size = 8;
		add(Reg.powerText); 
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+130,164,"Press "+Reg.buttonO+" to go back.");
		Reg.text.size = 8;
		Reg.text.alignment = "center";
		add(Reg.text); 
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
		if (FlxG.keys.anyJustPressed(["ESCAPE"]))
		{
			SaveScores.save();
			System.exit(0);
		}
	}	
	
	private function goToPlay():Void
	{
		FlxG.switchState(new MenuState());
	}
}
