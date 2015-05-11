package om;

import js.Browser.window;

class Device {

	public static function getPixelRatio() : Float {
		return if( window.devicePixelRatio <= 1 || ( window.devicePixelRatio > 1 && window.devicePixelRatio < 1.5 ) ) 1;
		else if( window.devicePixelRatio >= 1.5 && window.devicePixelRatio < 2 ) 1.5;
		else if( window.devicePixelRatio >= 2 && window.devicePixelRatio < 3 ) 2;
		else 3;
	}

	@:overload(function( pattern : Array<Int> ):Void{})
	public static inline function vibrate( pattern : Int ) {
		if( untyped navigator.vibrate != null )
			untyped navigator.vibrate( pattern );
	}

}
