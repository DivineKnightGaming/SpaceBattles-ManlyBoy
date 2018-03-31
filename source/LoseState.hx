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
class LoseState extends FlxState
{
	public var min:String;
	public var sec:Int;
	public var secSt:String;
	private var _switchTimer:Float;
	private var _gamePad:FlxGamepad;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		FlxG.mouse.visible = false;
		FlxG.cameras.bgColor = 0xffacacac;
		
		Reg.manlyBoySp = new FlxSprite( 0, 0, Reg.manlyBoy);
		add(Reg.manlyBoySp);
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+0,160,"You Lose");
		Reg.text.size = 16;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+26,160,"Your Score: "+Reg.score);
		Reg.text.size = 8;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+40,160,"Best Scores: ");
		Reg.text.size = 8;
		Reg.text.alignment = "center";
		add(Reg.text);
		
		for (i in 0...Reg.highScores.length)
		{
			if(Reg.highScores[i] < Reg.score)
			{
				Reg.highScores.insert(i, Reg.score);
				break;
			}
		}
		
		for (i in 0...10)
		{
			if (i < 5)
			{
				Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+50+(i*10),80,(i+1)+": "+Reg.highScores[i]);
				Reg.text.size = 8;
				Reg.text.alignment = "center";
				add(Reg.text);
			}
			else
			{
				Reg.text = new FlxText(Reg.windowX+80,Reg.windowY+50+((i-5)*10),80,(i+1)+": "+Reg.highScores[i]);
				Reg.text.size = 8;
				Reg.text.alignment = "center";
				add(Reg.text);
			}
		}
		
		Reg.text = new FlxText(Reg.windowX+0,Reg.windowY+120,160,"Press "+Reg.buttonO+" To Play Again.");
		Reg.text.size = 8;
		Reg.text.alignment = "center";
		add(Reg.text); 
		
		_switchTimer = 2.5;
		FlxG.sound.play(Reg.shipKilledWav); 
		
		SaveScores.save();
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
		_switchTimer -= FlxG.elapsed;
		if ((FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || ( Reg.usegamepad && _gamePad.justPressed.A)) && _switchTimer <= 0)
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
		FlxG.switchState(new PlayState());
	}
}
