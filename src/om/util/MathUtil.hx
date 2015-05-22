package om.util;

using Math;
using Std;
using om.util.MathUtil;

class MathUtil {

	//public static inline var PI = 3.141592653589793;
	public static inline var RADIANS_TO_DEGREES_FACTOR = 57.29577951308232; //180/PI
	public static inline var DEGREES_TO_RADIANS_FACTOR = 0.017453292519943295; //PI/180

	public static inline function degToRad( f : Float ) : Float {
		return f * DEGREES_TO_RADIANS_FACTOR;
	}

	public static inline function radToDeg( f : Float ) : Float {
		return f * RADIANS_TO_DEGREES_FACTOR;
	}

	public static inline function clampInt( value : Int, minOrMax1 : Int, minOrMax2 : Int ) : Int {
		return value.clamp( minOrMax1, minOrMax2 ).int();
	}

	public static function clamp( value : Float, minOrMax1 : Float, minOrMax2 : Float ) : Float {
		var min = Math.min( minOrMax1, minOrMax2 );
		var max = Math.max( minOrMax1, minOrMax2 );
		return value < min ? min : value > max ? max : value;
	}

	/*
	public static inline function clamp( v : Float, min : Float, max : Float ) : Float {
		return (v < min) ? min : (v > max) ? max : v;
	}
	*/

	public static function interpolate( f : Float, min = 0.0, max = 100.0, ?equation : Float->Float ) : Int {
		if( equation == null )
			equation = function(v:Float) return v;
		return Math.round( min + equation(f) * ( max - min ) );
	}

}
