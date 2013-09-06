package om.ease;

class Circular {

	public static function i( t : Float, b : Float, c : Float, d : Float ) : Float {
		var m = Math;
		return -c * ( m.sqrt( 1 - ( t /= d ) * t ) - 1 ) + b;
	}
	
	public static function o( t : Float, b : Float, c : Float, d : Float ) : Float {
		var m = Math;
		return c * m.sqrt( 1 - ( t = t/d - 1 ) * t ) + b;
	}
	
	public static function io( t : Float, b : Float, c : Float, d : Float) : Float {
		var m = Math;
		if( ( t /= d / 2 ) < 1 ) return -c / 2 * ( m.sqrt( 1 - t * t ) - 1 ) + b;
		return c / 2 * ( m.sqrt( 1 - ( t -= 2 ) * t ) + 1 ) + b;
	}
	
}
