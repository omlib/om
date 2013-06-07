package om.util;

class MathUtil {

	public static inline function clamp( v : Int, min : Int, max : Int ) : Int {
		return ( v < min ) ? min : ( v > max ) ? max : v;
	}

	public static function interpolate( f : Float, min = 0.0, max = 100.0, ?equation : Float->Float ) : Int {
		if( equation == null )
			equation = function(v:Float) return v;
		return Math.round( min + equation(f) * ( max - min ) );
	}

}
