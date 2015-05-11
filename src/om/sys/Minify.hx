package om.sys;

#if sys

import sys.FileSystem;
import sys.io.File;
import sys.io.Process;
import Tron.PATH;

class Minify {

	public static inline var YUI = 'yuicompressor-2.4.8.jar';
	public static inline var CLOSURE = 'closure.jar';

	public static var YUIPATH = '$PATH/bin/$YUI';
	public static var CLOSUREPATH = '$PATH/bin/$CLOSURE';

	public static inline function js( src : String, ?dst : String ) : Int {
		return run( src, dst );
	}

	public static inline function css( src : String, ?dst : String ) : Int {
		if( dst == null ) dst = src;
		var p = new Process( 'java', ['-jar', YUIPATH, src, '-o', dst] );
		return exec( p );
	}

	public static function run( src : String, ?dst : String ) : Int {
        if( dst == null ) dst = src;
		var srcTemp : String = null;
		if( src == dst ) {
			srcTemp = src+'.temp';
			File.copy( src, srcTemp );
			src = srcTemp;
		}
        var args = [ '-jar', CLOSUREPATH, '--js', src, '--js_output_file', dst, '--language_in=ECMASCRIPT5_STRICT', '-O', 'SIMPLE'  ];
        var p = new Process( 'java', args );
		var exitCode = exec( p );
		if( srcTemp != null ) FileSystem.deleteFile( srcTemp );
		return exitCode;
	}

	static function exec( p : Process ) : Int {
		var err = p.stderr.readAll().toString();
        var out = p.stdout.readAll().toString();
        var exitCode = p.exitCode();
        if( exitCode > 0 ) {
            Sys.print( err );
        } else {
            Sys.print( out );
        }
		p.close();
		return exitCode;
	}
}

#end
