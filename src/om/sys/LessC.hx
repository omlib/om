package om.sys;

#if sys

import sys.io.Process;

/**
    http://lesscss.org/
*/
class LessC {

    public static var noColors = true;

    /**
        string -> file.css
    */
    public static function string( str : String, dst : String, compress = false ) : Int {
        var p = new Process( 'lessc', args( '-', dst, compress ) );
        p.stdin.writeString( str );
        return run( p );
    }

    /**
        file.less -> file.css
    */
    public static function file( src : String, dst : String,  compress = false ) : Int {
        return run( new Process( 'lessc', args( src, dst, compress ) ) );
    }

    /**
        [file1.less,file2.less,...] -> file.css
    public static function file( files : Array<String>, dst : String,  compress = false ) {
    }
    */

    static function run( p : Process ) : Int {
        var exitCode = p.exitCode();
        var err = p.stderr.readAll().toString();
        if( err.length > 0 )
            return throw err;
        while( true )
            try Sys.print( p.stdout.readLine() ) catch(e:haxe.io.Eof) break;
        p.close();
        return exitCode;
    }

    static function args( src : String, dst : String, compress = false ) {
        var args = [ src, dst ];
        if( compress ) {
            args.push( '--clean-css' );
            args.push( '-x' );
        }
        if( noColors ) args.push( '--no-color' );
        return args;
    }
}

#end
