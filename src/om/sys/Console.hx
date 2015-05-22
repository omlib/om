package om.sys;

class Console {

	//public static var noColors = false;

    public static inline function log( o : Dynamic ) println( Std.string(o) );
    public static inline function info( o : Dynamic ) println( Std.string(o) );
    public static inline function debug( o : Dynamic ) println( Std.string(o) );
    public static inline function warn( o : Dynamic ) println( Std.string(o) );
    public static inline function error( o : Dynamic ) println( Std.string(o) );
    public static inline function print( str : String ) Sys.print( str );
    public static inline function println( str : String ) print( str+'\n' );

    public static function clear() Sys.command( 'command' );

    public static function readInput( untilCharCode = 13 ) : String {
        var str = '';
        while( true ) {
            var c = Sys.getChar( true );
            if( c == untilCharCode )
                return str;
            else
                str += String.fromCharCode(c);
        }
        return str;
    }

}
