package om;

import haxe.macro.Context;
import haxe.macro.Compiler;
import haxe.macro.Expr;
import sys.FileSystem;
import sys.io.Process;
import sys.io.File;
import Sys.print;
import Sys.println;

using StringTools;
using haxe.io.Path;

class Doc {

	public static function build( dst = 'haxedoc.xml' ) {

		var hxml = 'doc.hxml';
		var cwd = Sys.getCwd().removeTrailingSlashes();
		var parts = cwd.split( '/' );
		parts.pop();
		var dir = parts.join( '/' );

		var libs = om.Lib.search( dir );
		print( libs.length+' libraries found' );
		/*
		trace( libs );
		var i = 0;
		while( i < libs.length ) {
			FileSystem.exists( '$dir/${libs[i]}/$hxml' ) ? i++ : libs.splice( i, 1 );
		}
		*/

		var i = 0;
		while( i < libs.length ) {
			var lib = libs[i];
			var hxmlPath = '$dir/${lib.name}/$hxml';
			if( FileSystem.exists( hxmlPath ) ) {
				i++;
			} else {
				libs.splice( i, 1 );
			}
		}

		println( ', '+libs.length+' have a doc.hxml' );
		println( 'Generate xml' );

		for( i in 0...libs.length ) {
			var lib = libs[i];
			println( '[${i+1}/${libs.length}] '+lib.name+'/doc' );
			var args = ['--cwd','$dir/'+lib.name,hxml];
			var proc = new Process( 'haxe', args );
			var code = proc.exitCode();
			if( code != 0 ) {
				var error = proc.stderr.readAll().toString().trim();
				trace( 'ERROR '+lib.name+': $error' );
			}
		}

		println( 'Merging api' );

		var api : Xml = null;
		for( i in 0...libs.length ) {
			var lib = libs[i];
			var path = '$dir/${lib.name}/doc';
			println( '[${i+1}/${libs.length}] '+lib.name );
			if( FileSystem.exists( path ) ) {
				for( f in FileSystem.readDirectory( path ) ) {
					var file = '$path/$f';
					if( !FileSystem.isDirectory( file ) && f.extension() == 'xml' ) {
						println( '  '+file.withoutDirectory() );
						var xml = Xml.parse( File.getContent( '$path/$f' ) ).firstElement();
						//var platform = f.withoutExtension();
						if( api == null ) api = xml else {
							for( a in xml.elements() ) {
								var	added = false;
								for( b in api.elements() ) {
									if( a.get( 'path' ) == b.get( 'path' ) ) {
										added = true;
										break;
									}
								}
								if( !added ) api.addChild( a );
							}
						}
					}
				}
			}
		}

		File.saveContent( dst, api.toString() );
	}

}
