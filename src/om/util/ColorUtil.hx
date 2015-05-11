package om.util;

class ColorUtil {

	//public static function rgb2hex( r : Int, g : Int, b : Int ) : Int {
	//public static function rgb2hex( rgb : TRGB ) : Int {

	/*
	public static function rgb2hex( rgb : TRGB ) : Int {
		return ( Math.round(rgb.r) << 16) | (Math.round(rgb.g) << 8 ) | Math.round(rgb.b);
	}


	public static function hex2rgb( hex : Int ) : TRGB {
		return {
			r: hex >> 16 & 0xFF,
			g: hex >> 8 & 0xFF,
			b: hex & 0xFF
		};
	}
	*/

	public static inline function rgbToInt( r : Int, g : Int, b : Int ) : Int {
		return (r<<16) | (g<<8) | b;
	}

	public static inline function strToInt( s : String ) : Int {
		return Std.parseInt( '0x'+s.substr(1) );
	}

}
