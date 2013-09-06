package om.ease;

class Elastic {
	
	public static function i( t : Float, b : Float, c : Float, d : Float,
								   ?a : Null<Float>, ?p : Null<Float> ) : Float {
		if( t == 0 ) return b;
		if( ( t /= d ) == 1 ) return b + c;
		if( p == null ) p = d * 0.3;
		
		var s : Float;
		if( a == null || a < util.MathUtil.abs( c ) ) {
			a = c;
			s = p / 4;
		} else {
			s = p / ( 2 * Math.PI ) * Math.asin( c / a );
		}

		return -( a * Math.pow( 2, 10 * ( t -= 1 ) ) *
				 Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) ) + b;
	}
	
	public static function o( t : Float, b : Float, c : Float, d : Float,
								    ?a : Null<Float>, ?p : Null<Float> ) : Float{
		if( t == 0 ) return b;	
		if( ( t /= d ) == 1 ) return b + c;
		if( p == null ) p = d * 0.3;

		var s : Float;
		if( a == null || a < util.MathUtil.abs( c ) ) {
			a = c;
			s = p / 4;
		} else {
			s = p / ( 2 * Math.PI ) * Math.asin( c / a );
		}
		
		return a * Math.pow( 2, -10 * t ) *  Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) + c + b;
	}
	
	public static function io( t : Float, b : Float, c : Float, d : Float,
									  ?a : Null<Float>, ?p : Null<Float>) : Float {
		if( t == 0 ) return b;
		if( ( t /= d / 2 ) == 2 ) return b + c;	
		if( p == null ) p = d * ( 0.3 * 1.5 );

		var s : Float;
		if( a == null || a < util.MathUtil.abs( c ) ) {
			a = c;
			s = p / 4;
		} else {
			s = p / ( 2 * Math.PI ) * Math.asin( c / a );
		}

		if( t < 1 ) {
			return -0.5 * ( a * Math.pow( 2, 10 * ( t -= 1 ) ) *
				   Math.sin( ( t * d - s ) * ( 2 * Math.PI) / p ) ) + b;
		}
		
		return a * Math.pow( 2, -10 * ( t -= 1 ) ) *
			   Math.sin( ( t * d - s ) * ( 2 * Math.PI ) / p ) * 0.5 + c + b;
	}
	
}
