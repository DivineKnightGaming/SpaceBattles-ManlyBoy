import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxVector;
import flixel.group.FlxGroup;
 
/**
 * A class for the starfield
 */
class StarField extends FlxObject {
    private static var NUM_STARS:UInt = 75;
    private var _stars:FlxGroup;
     
    /**
     * @param   ang This is the angle that the starField will be rotating (in degrees)
     * @param   speedMultiplier
     */
    public function new(ang:Float = 90, speedMultiplier:Float = 4):Void {          
        angle = ang;
        _stars = new FlxGroup(NUM_STARS);
          
        var radang:Float = angle * Math.PI / 180;
        var cosang:Float = Math.cos(radang);
        var sinang:Float = Math.sin(radang);
          
        for (i in 0...NUM_STARS) {
            var str:FlxSprite = new FlxSprite(Math.random() * FlxG.width, Math.random() * FlxG.height);
            var vel:Float = Math.random() * -16 * speedMultiplier;
              
            // change the transparency of the star based on it's velocity
            var transp:UInt = (Math.round(16 * (-vel / speedMultiplier) - 1) << 24);
              
            str.makeGraphic(2, 2, 0x00ffffff | transp);
            str.velocity.x = cosang * vel;
            str.velocity.y = sinang * vel;
            _stars.add(str);
        }
         
        super();
    }
     
    /**
     * Rotate the starField
     * @param   howMuch Input the amount of rotation in degrees
     */
    public function rotate(howMuch:Float = 1):Void {
        for (i in 0...NUM_STARS) {
            var str:FlxSprite = cast _stars.members[i];
            var velVector:FlxVector = new FlxVector(str.velocity.x, str.velocity.y);
             
            velVector.rotateByDegrees(howMuch);
         
            str.velocity = velVector;
        }
    }
      
    override public function update(elapsed:Float):Void {
        _stars.update(elapsed);
          
        for (i in 0..._stars.members.length) {
            var star:FlxSprite = cast _stars.members[i];
            if (star.x > FlxG.width) {
                star.x = 0;
            } else if (star.x < 0) {
                star.x = FlxG.width;
            }
            if (star.y > FlxG.height) {
                star.y = 0;
            } else if (star.y < 0) {
                star.y = FlxG.height;
            }
        }
    }
     
    override public function draw():Void {
        _stars.draw();
    }
}
