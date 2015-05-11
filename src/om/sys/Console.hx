package om.sys;

@:enum
private abstract Color(Int) {
    var def = 39;
    var black = 30;
    var red = 31;
    var green = 32;
    var yellow = 33;
    var blue = 34;
    var magenta = 35;
    var cyan = 36;
    var grey_light = 37;
    var grey_dark = 90;
    var white = 97;
}

class Console {

	public static var noColors = false;

    public static var color_log = null;
    public static var color_info = Color.cyan;
    public static var color_debug = Color.grey_light;
    public static var color_error = Color.red;
    public static var color_warn = Color.magenta;

    public static function log( o : Dynamic )
        println( Std.string(o), color_log );

    public static function info( o : Dynamic )
        println( Std.string(o), color_info );

    public static function debug( o : Dynamic )
        println( Std.string(o), color_debug );

    public static function warn( o : Dynamic )
        println( Std.string(o), color_warn );

    public static function error( o : Dynamic ) {
        //print( 'ERROR ', color_error );
        println( Std.string(o), color_error );
    }

    public static function print( str : String, ?color : Color ) {
        if( noColors || color == null ) {
            Sys.print( str );
        } else {
            var buf = new StringBuf();
    		buf.add( "\033[" );
    		buf.add( color );
    		buf.add( "m" );
    		buf.add( str );
    		buf.add( "\033[" );
    		buf.add( "m" );
            Sys.print( buf.toString() );
        }
    }

    public static inline function println( str : String, ?color : Color )
        print( str+'\n', color );

    public static function setColor( color : Int )
        Sys.print( '\033['+color+'m' );

    public static function resetColor()
        Sys.print( '\033['+def+'m' );

    public static function clear()
		Sys.command( 'command' );

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
