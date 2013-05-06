package om.ease;

class Quadric {
	
	public static function i( t : Float, b : Float, c : Float, d : Float) : Float {
		return c * ( t /= d ) * t + b;
	}
	
	public static function o( t : Float, b : Float, c : Float, d : Float) : Float {
		return -c * ( t /= d ) * ( t - 2 ) + b;
	}
	
	public static function io( t : Float, b : Float, c : Float, d : Float) : Float {
		if( ( t /= d / 2 ) < 1 ) return c / 2 * t * t + b;
		return -c / 2 * ( ( --t ) * ( t - 2 ) - 1 ) + b;
	}
	
}
