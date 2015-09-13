package om.easing;

@:keep
class Exponential {

	public static inline function In( k : Float ) : Float {
		return k == 0 ? 0 : Math.pow( 1024, k - 1 );
	}

	public static inline function Out( k : Float ) : Float {
		return k == 1 ? 1 : 1 - Math.pow( 2, - 10 * k );
	}

	public static function InOut( k : Float ) : Float {
		if( k == 0 ) return 0;
		if( k == 1 ) return 1;
		if( ( k *= 2 ) < 1 ) return 0.5 * Math.pow( 1024, k - 1 );
		return 0.5 * ( - Math.pow( 2, - 10 * ( k - 1 ) ) + 2 );
	}

}
