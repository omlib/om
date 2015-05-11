package om.util;

class MathUtil {

	public static inline var RADIANS_TO_DEGREES_FACTOR = 57.29577951308232; //180/PI
	public static inline var DEGREES_TO_RADIANS_FACTOR = 0.017453292519943295; //PI/180

	public static inline function degToRad( f : Float ) : Float {
		return f * DEGREES_TO_RADIANS_FACTOR;
	}

	public static inline function radToDeg( f : Float ) : Float {
		return f * RADIANS_TO_DEGREES_FACTOR;
	}

	public static inline function clamp( v : Float, min : Float, max : Float ) : Float {
		return (v < min) ? min : (v > max) ? max : v;
	}

	public static function interpolate( f : Float, min = 0.0, max = 100.0, ?equation : Float->Float ) : Int {
		if( equation == null )
			equation = function(v:Float) return v;
		return Math.round( min + equation(f) * ( max - min ) );
	}

}
