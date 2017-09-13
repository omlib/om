package om;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;

class Lib {

	/*
	public var name : String;

	public function new( name : String ) {
	}
	*/

	public static function search( ?path : String ) : Array<Dynamic> {

		if( path == null ) path = Sys.getCwd();

		var regexp = ~/^om\.([a-z]+)$/;
		var dirs = new Array<String>();
		for( dir in FileSystem.readDirectory( path ) ) {
			if( regexp.match( dir ) )
				dirs.push( dir );
		}

		dirs.sort( (a,b) -> return ((a = a.toLowerCase()) < (b = b.toLowerCase())) ? -1 : (a > b) ? 1 : 0 );

		var libs = new Array<Dynamic>();
		for( dir in dirs ) {
			var p = '$path/$dir/haxelib.json';
			if( FileSystem.exists( p ) )
				libs.push( Json.parse( File.getContent( p ) ) );
		}

		return libs;
	}
}
