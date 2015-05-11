package om.tween.ease;

class Circular {

	public static inline function In( k : Float ) : Float {
		return 1 - Math.sqrt( 1 - k * k );
	}

	public static inline function Out( k : Float ) : Float {
		return Math.sqrt( 1 - ( --k * k ) );
	}

	public static function InOut( k : Float ) : Float {
		if ( ( k *= 2 ) < 1) return - 0.5 * ( Math.sqrt( 1 - k * k) - 1);
		return 0.5 * ( Math.sqrt( 1 - ( k -= 2) * k) + 1);
	}
}
