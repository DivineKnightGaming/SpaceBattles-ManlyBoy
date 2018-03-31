package;

import flixel.util.FlxSave;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
//import flixel.effects.FlxSpriteFilter;
import flixel.group.FlxGroup;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	/**
	 * Generic levels Array that can be used for cross-state stuff.
	 * Example usage: Storing the levels of a platformer.
	 */
	public static var levels:Array<Dynamic> = [];
	/**
	 * Generic level variable that can be used for cross-state stuff.
	 * Example usage: Storing the current level number.
	 */
	public static var level:Int = 0;
	/**
	 * Generic scores Array that can be used for cross-state stuff.
	 * Example usage: Storing the scores for level.
	 */
	public static var scores:Array<Dynamic> = [];
	/**
	 * Generic score variable that can be used for cross-state stuff.
	 * Example usage: Storing the current score.
	 */
	public static var score:Int = 0;
	public static var highScore:Int = 0;
	
	/**
	 * Generic bucket for storing different FlxSaves.
	 * Especially useful for setting up multiple save slots.
	 */
	public static var saves:Array<FlxSave> = [];
	
	public static var gameZoom:Int = 4;
	
	public static var text:FlxText;
	public static var controlsText:FlxText;
	public static var scoreText:FlxText;
	public static var livesText:FlxText;
	public static var shieldText:FlxText;
	public static var powerText:FlxText;
	public static var bombText:FlxText;
	public static var sprite:FlxSprite;
	public static var button:FlxButton;
	
	public static var manlyBoy="assets/images/manly_boy.png";
	public static var manlyBoySp:FlxSprite;
	
	public static var windowX = 80;
	public static var windowY = 18;
	
	public static var dkLogo="assets/images/dklogo_bw_sm.png";
	public static var dkLogoSp:FlxSprite;
	
	public static var spaceBattlesLogo="assets/images/spaceBattles.png";
	
	public static var spaceship="assets/images/spaceship.png";
	public static var spaceshipSp:FlxSprite;
	public static var shieldActive="assets/images/shield_active.png";
	public static var shieldActiveSp:FlxSprite;
	public static var bullets="assets/images/bullets.png";
	public static var life="assets/images/life.png";
	public static var shield="assets/images/shield.png";
	public static var power="assets/images/power.png";
	public static var bomb="assets/images/bomb.png";
	
	public static var cross="assets/images/cross.png";
	public static var saucer="assets/images/saucer.png";
	public static var manta="assets/images/manta.png";
	public static var dart="assets/images/dart.png";
	public static var dreadnaut="assets/images/dreadnaut.png";
	public static var enemybullets="assets/images/enemybullets.png";
	public static var highScores:Array<Float> = [0,0,0,0,0,0,0,0,0,0];
	
	public static var hud="assets/images/blankhud.png";
	public static var hudSp:FlxSprite;
	
	public static var startWav="assets/sounds/start.wav";
	public static var winWav="assets/sounds/win.wav";
	public static var selectWav="assets/sounds/select.wav";
	public static var shipKilledWav="assets/sounds/playerkilled.wav";
	public static var enemyKilledWav="assets/sounds/enemykilled.wav";
	public static var shieldHitWav="assets/sounds/shieldhit.wav";
	public static var playerShootWav="assets/sounds/playershoot.wav";
	public static var enemyShootWav="assets/sounds/enemyshoot.wav";
	public static var lifeWav="assets/sounds/lifepickup.wav";
	public static var shieldWav="assets/sounds/shieldpickup.wav";
	public static var powerWav="assets/sounds/powerpickup.wav";
	public static var bombWav="assets/sounds/bombpickup.wav";
	public static var explodeWav="assets/sounds/bomb.wav";
	public static var dartWav="assets/sounds/dartlaunch.wav";
	public static var crossWav="assets/sounds/crossbounce.wav";
	
	public static var fullScreen:Bool = false;
	
	
	/*public static var buttonO="A";
	public static var buttonU="X";
	public static var buttonY="Start";
	public static var buttonA="B";*/
	
	public static var controls="Keyboard";
	public static var dpad="Arrows";
	public static var buttonO="Space";
	public static var buttonU="Q";
	public static var buttonY="G";
	public static var buttonA="Z";
	public static var usegamepad:Bool = true;
		
	
}
