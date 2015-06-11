package om;

import js.Browser.window;

@:enum abstract ScreenOrientation(String) to String {
	var landscape = "landscape";
	var portrait = "portrait";
}

class Device {

	public static function getScreenOrientation() : ScreenOrientation {
		return window.matchMedia( "(orientation:landscape)" ).matches ? landscape : portrait;
	}

	public static function getPixelRatio() : Float {
		var r = window.devicePixelRatio;
		return if( r <= 1 || ( r > 1 && r < 1.5 ) ) 1;
		else if( r >= 1.5 && r < 2 ) 1.5;
		else if( r >= 2 && r < 3 ) 2;
		else 3;
	}

	@:overload(function( pattern : Array<Int> ):Void{})
	public static inline function vibrate( pattern : Int ) {
		if( untyped navigator.vibrate != null )
			untyped navigator.vibrate( pattern );
	}
}
