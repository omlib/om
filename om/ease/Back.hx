package om.ease;

class Back {
	
	static inline var S_VALUE = 1.70158;
	
	public static function i( t : Float, b : Float, c : Float, d : Float, ?s : Null<Float> ) : Float {
		if( s == null ) s = S_VALUE;
		return c * ( t /= d ) * t * ( ( s + 1 ) *  t - s ) + b;
	}
	
	public static function o( t : Float, b : Float, c : Float,  d : Float, ?s : Null<Float> ) : Float {
		if( s == null ) s = S_VALUE;
		return c * ( ( t = t / d - 1 ) * t * ( ( s + 1 ) *  t + s ) + 1 ) + b;
	}
	
	public static function io( t : Float, b : Float, c : Float, d : Float, ?s : Null<Float> ) : Float {
		if( s == null) s = S_VALUE; 
		if( ( t /= d / 2 ) < 1 ) return c / 2 * ( t * t * ( ( ( s *= ( 1.525 ) ) + 1 ) * t - s ) ) + b;
		return c / 2 * ( ( t -= 2 ) * t * ( ( ( s *= ( 1.525 ) ) + 1 ) * t + s ) + 2 ) + b;
	}
	
}
