package om;

class Console {


	#if js

	public static inline function log( v : Dynamic ) {
		untyped console.log( v );
	}

	public static inline function debug( v : Dynamic ) {
		untyped console.debug( v );
	}

	public static inline function info( v : Dynamic ) {
		untyped console.info( v );
	}

	public static inline function warn( v : Dynamic ) {
		untyped console.warn( v );
	}

	public static inline function error( v : Dynamic ) {
		untyped console.error( v );
	}

	public static inline function l( v : Dynamic ) {
		untyped console.log( v );
	}

	public static inline function d( v : Dynamic ) {
		untyped console.debug( v );
	}

	public static inline function i( v : Dynamic ) {
		untyped console.info( v );
	}

	public static inline function w( v : Dynamic ) {
		untyped console.warn( v );
	}

	public static inline function e( v : Dynamic ) {
		untyped console.error( v );
	}


	#elseif sys

	//TODO determine correct colors
	
	public static inline var COLOR_DEBUG = 1;
	public static inline var COLOR_INFO = 92;
	public static inline var COLOR_WARN = 91;
	public static inline var COLOR_ERROR = 31;

	/** Color mode on/off */
	public static var colored = true;

	/** Default color to use */
	//public static var color Int;

	/** Append line breaks */
	//public static var line = true;

	public static inline function log( v : Dynamic ) {
		Sys.println( v );
	}

	public static inline function debug( v : Dynamic ) {
		println( v, COLOR_DEBUG );
	}

	public static inline function info( v : Dynamic ) {
		println( v, COLOR_INFO );
	}

	public static inline function warn( v : Dynamic ) {
		println( v, COLOR_WARN );
	}

	public static inline function error( v : Dynamic ) {
		println( v, COLOR_ERROR );
	}

	public static inline function l( v : Dynamic ) {
		log( v );
	}

	public static inline function d( v : Dynamic ) {
		debug( v );
	}

	public static inline function i( v : Dynamic ) {
		info( v );
	}

	public static inline function w( v : Dynamic ) {
		warn( v );
	}

	public static inline function e( v : Dynamic ) {
		error( v );
	}

	public static inline function print( v : Dynamic, ?color : Int ) {

		Sys.print( colorize( v, color ) );
	}

	public static inline function println( v : Dynamic, ?color : Int ) {
		Sys.println( colorize( v, color ) );
	}

	public static function colorize( v : Dynamic, color : Null<Int> ) : String {
		if( !colored || color == null )
			return v;
		var b = new StringBuf();
		b.add( "\033[" );
		b.add( Std.string( color ) );
		b.add( "m" );
		b.add( v );
		b.add( "\033[" );
		b.add( "m" );
		return b.toString();
	}

	#end

}
