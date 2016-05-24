package om.extra;

import sys.FileSystem;
import sys.io.File;
import haxe.Template;

class Examples {

	static function build() {

		///// Build /examples/index.html

		var path = 'examples';
		var examples = new Array<String>();
		for( g in FileSystem.readDirectory( path ) ) {
			if( !FileSystem.isDirectory( '$path/$g' ) )
				continue;
			for( f in FileSystem.readDirectory( '$path/$g' ) ) {
				examples.push( '$g/$f' );
			}
		}
		var ctx = {
			examples: examples
		};
		var tpl = new Template( File.getContent( 'res/html/examples-index.html' ) );
		var html = tpl.execute( ctx );
		var out = 'examples/index.html';
		File.saveContent( out, html );

	}
}
