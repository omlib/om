package om.util;

import om.unit.TermColor;

/**
    Terminal colorizing.

    Usage:
        Sys.print( TermColor.red('abc') );
        Sys.print( 'abc'.red() );
*/
class TermColorUtil {

    public static function color( str : String, color : TermColor ) : String {
        var buf = new StringBuf();
        buf.add( '\033[' );
        buf.add( color );
        buf.add( 'm' );
        buf.add( str );
        buf.add( '\033[' );
        buf.add( 'm' );
        return buf.toString();
    }

    public static inline function def( str : String ) return color( str, TermColor.def );
    public static inline function black( str : String ) return color( str, TermColor.black );
    public static inline function red( str : String ) return color( str, TermColor.red );
    public static inline function green( str : String ) return color( str, TermColor.green );
    public static inline function yellow( str : String ) return color( str, TermColor.yellow );
    public static inline function blue( str : String ) return color( str, TermColor.blue );
    public static inline function magenta( str : String ) return color( str, TermColor.magenta );
    public static inline function cyan( str : String ) return color( str, TermColor.cyan );
    public static inline function grey_light( str : String ) return color( str, TermColor.grey_light );
    public static inline function grey_dark( str : String ) return color( str, TermColor.grey_dark );
    public static inline function white( str : String ) return color( str, TermColor.white );

    #if sys

    public static function isSupported() : Bool {
        if( Sys.systemName() == 'Windows' )
            return false;
        if( Sys.getEnv( 'COLORTERM' ) != null )
            return true;
        var term = Sys.getEnv( 'TERM' );
        if( term == 'dumb' )
            return false;
        return ~/^screen|^xterm|^vt100|color|ansi|cygwin|linux/i.match( term );
    }

    #end

}
