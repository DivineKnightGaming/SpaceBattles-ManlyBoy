package;

//import crashdumper.CrashDumper;
//import crashdumper.SessionData;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
//import flash.text.Font;
import flixel.system.FlxAssets;
import openfl.Assets;
#if (windows || mac || linux)
	//import openfl.events.UncaughtErrorEvent;
#elseif flash
	//import flash.events.UncaughtErrorEvent;
#end

//@:font("assets/data/solemnit.ttf")
//private class MyFont extends Font { }

class Main extends Sprite 
{
	var gameWidth:Int = 320; //320 Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 180; //180 Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = LogoState; // The FlxState the game starts with.
	var zoom:Float = 4; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	
	// You can pretty much ignore everything from here on - your code should go in your states.
	
	public static function main():Void
	{	
		Lib.current.addChild(new Main());
	}
	
	public function new() 
	{
		super();
		//Font.registerFont(MyFont);
		//FlxAssets.FONT_DEFAULT = "Solemnity";
		//var unique_id:String = SessionData.generateID("example_app_");
		#if flash
			//var crashDumper = new CrashDumper(unique_id, stage);
			Reg.gameZoom = 2;
			zoom = Reg.gameZoom;
		#else
			//var crashDumper = new CrashDumper(unique_id);
		#end
		
		//Here is where you would load your config and/or save data from file
		//(in this example, we just grab a fake config.xml from assets, 
		//but you should load them from wherever your app stores them)
		#if (windows || mac || linux)
			//var fakeConfigFile:String = Assets.getText("assets/config.xml");
			//crashDumper.session.files.set("config.xml", fakeConfigFile);
		#end
		
		if (stage != null) 
		{
			init();
		}
		else 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private function init(?E:Event):Void 
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		setupGame();
	}
	
	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
}
