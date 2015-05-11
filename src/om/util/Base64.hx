package om.util;


class Base64 {

	public static inline var CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

	public static function encode( t : String ) : String {
		return haxe.crypto.BaseCode.encode( t, CHARS ) + switch( t.length % 3 )  {
			case 2 : "=";
			case 1 : "==";
			default : "";
		};
	}

	public static function decode( t : String ) : String {
		return haxe.crypto.BaseCode.encode( t, CHARS ) + switch( t.length % 3 )  {
			case 2 : "=";
			case 1 : "==";
			default : "";
		};
	}

	/*
	public static function pad( t : String ) : String {
		return t + switch( t.length % 3 )  {
			case 2 : "=";
			case 1 : "==";
			default : "";
		};
	}
	*/

}
