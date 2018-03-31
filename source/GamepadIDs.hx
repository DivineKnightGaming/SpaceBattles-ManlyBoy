package ;

/*import flixel.input.gamepad.XboxButtonID;
import flixel.input.gamepad.OUYAButtonID;
import flixel.input.gamepad.PS3ButtonID;*/

/**
 * NOTE: This should probably be inside FlxGamepad.
 * @author crazysam
 */
class GamepadIDs
{
	public static inline var A = #if (OUYA) OUYAButtonID.O #elseif (windows) XboxButtonID.A #else OUYAButtonID.O #end;
	public static inline var B = #if (OUYA) OUYAButtonID.A #elseif (windows) XboxButtonID.B #else OUYAButtonID.A #end;
	public static inline var X = #if (OUYA) OUYAButtonID.U #elseif (windows) XboxButtonID.X #else OUYAButtonID.U #end;
	public static inline var Y = #if (OUYA) OUYAButtonID.Y #elseif (windows) XboxButtonID.Y #else OUYAButtonID.Y #end;
	public static inline var LB = #if (OUYA) OUYAButtonID.LB #elseif (windows) XboxButtonID.LB #else OUYAButtonID.LB #end;
	public static inline var RB = #if (OUYA) OUYAButtonID.RB #elseif (windows) XboxButtonID.RB #else OUYAButtonID.RB #end;
	public static inline var START = #if (OUYA) OUYAButtonID.RIGHT_ANALOGUE #elseif (windows) XboxButtonID.START #else OUYAButtonID.RIGHT_ANALOGUE #end; // hax: there's no start button on the OUYA
	public static inline var SELECT = #if (OUYA) OUYAButtonID.LEFT_ANALOGUE #elseif (windows) XboxButtonID.BACK #else OUYAButtonID.LEFT_ANALOGUE #end;
	public static inline var LEFT_ANALOGUE = #if (OUYA) OUYAButtonID.LEFT_ANALOGUE #elseif (windows) XboxButtonID.LEFT_ANALOGUE #else OUYAButtonID.LEFT_ANALOGUE #end;
	public static inline var RIGHT_ANALOGUE = #if (OUYA) OUYAButtonID.RIGHT_ANALOGUE #elseif (windows) XboxButtonID.RIGHT_ANALOGUE #else OUYAButtonID.RIGHT_ANALOGUE  #end;
	public static inline var LEFT_ANALOGUE_X = #if (OUYA) OUYAButtonID.LEFT_ANALOGUE_X #elseif (windows) XboxButtonID.LEFT_ANALOGUE_X #else OUYAButtonID.LEFT_ANALOGUE_X #end;
	public static inline var LEFT_ANALOGUE_Y = #if (OUYA) OUYAButtonID.LEFT_ANALOGUE_Y #elseif (windows) XboxButtonID.LEFT_ANALOGUE_Y #else OUYAButtonID.LEFT_ANALOGUE_Y #end;
	public static inline var RIGHT_ANALOGUE_X = #if (OUYA) OUYAButtonID.RIGHT_ANALOGUE_X #elseif (windows) XboxButtonID.RIGHT_ANALOGUE_X #else OUYAButtonID.RIGHT_ANALOGUE_X #end;
	public static inline var RIGHT_ANALOGUE_Y = #if (OUYA) OUYAButtonID.RIGHT_ANALOGUE_Y #elseif (windows) XboxButtonID.RIGHT_ANALOGUE_Y #else OUYAButtonID.RIGHT_ANALOGUE_Y #end;
	
	#if !mobile
	public static inline var DPAD_LEFT = #if (OUYA) OUYAButtonID.DPAD_LEFT #else XboxButtonID.DPAD_LEFT #end ;
	public static inline var DPAD_RIGHT = #if (OUYA) OUYAButtonID.DPAD_RIGHT #else XboxButtonID.DPAD_RIGHT #end;
	public static inline var DPAD_UP = #if (OUYA) OUYAButtonID.DPAD_UP #else XboxButtonID.DPAD_UP #end;
	public static inline var DPAD_DOWN = #if (OUYA) OUYAButtonID.DPAD_DOWN #else XboxButtonID.DPAD_DOWN #end;
	#end
}
