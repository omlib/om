package om;

using Lambda;

/**
	Global log
*/
class Log {

	static var handlers = new Array<LogHandler>();

	public static function addHandler( h : LogHandler ) {
		if( handlers.has( h ) )
			return;
		handlers.push( h );
		h.start();
	}

	public static function removeHandler( h : LogHandler ) : Bool {
		if( !handlers.remove( h ) )
			return false;
		h.stop();
		return true;
	}
	
	public static function clearHandlers() {
		for( h in handlers ) h.stop();
		handlers = new Array();
	}

	public static function log( v : Dynamic ) {
		for( h in handlers ) h.l( v );
	}

	public static function debug( v : Dynamic ) {
		for( h in handlers ) h.d( v );
	}

	public static function info( v : Dynamic ) {
		for( h in handlers ) h.i( v );
	}

	public static function warn( v : Dynamic ) {
		for( h in handlers ) h.w( v );
	}

	public static function error( v : Dynamic ) {
		for( h in handlers ) h.e( v );
	}

	public static inline function l( v : Dynamic ) log(v);
	public static inline function d( v : Dynamic ) debug(v);
	public static inline function i( v : Dynamic ) info(v);
	public static inline function w( v : Dynamic ) warn(v);
	public static inline function e( v : Dynamic ) error(v);

}
