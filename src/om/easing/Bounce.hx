package om.easing;

@:keep
class Bounce {

	public static inline function In( k : Float ) : Float {
		return 1 - Bounce.Out( 1 - k );
	}

	public static inline function Out( k : Float ) : Float {
		if ( k < ( 1 / 2.75 ) ) {
				return 7.5625 * k * k;
		} else if ( k < ( 2 / 2.75 ) ) {
			return 7.5625 * ( k -= ( 1.5 / 2.75 ) ) * k + 0.75;
		} else if ( k < ( 2.5 / 2.75 ) ) {
			return 7.5625 * ( k -= ( 2.25 / 2.75 ) ) * k + 0.9375;
		} else {
			return 7.5625 * ( k -= ( 2.625 / 2.75 ) ) * k + 0.984375;
		}
	}

	public static function InOut( k : Float ) : Float {
		if ( k < 0.5 ) return Bounce.In( k * 2 ) * 0.5;
		return Bounce.Out( k * 2 - 1 ) * 0.5 + 0.5;
	}
}
