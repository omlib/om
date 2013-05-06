package om.ease;

class Sine {
	
	public static function i( t : Float, b : Float, c : Float, d : Float ) : Float {
		return -c * Math.cos( t / d * ( Math.PI / 2 ) ) + c + b;
	}
	
	public static function o( t : Float, b : Float, c : Float, d : Float ) : Float {
		return c * Math.sin( t / d * ( Math.PI / 2 ) ) + b;
	}
	
	public static function io( t : Float, b : Float, c : Float, d : Float ) : Float {
		return -c / 2 * ( Math.cos( Math.PI * t / d ) - 1 ) + b;
	}
	
}
