package om.extra;

import sys.FileSystem;
import sys.io.File;
import haxe.Template;

class Examples {

	static function build() {

		// Build /examples/index.html

		var path = 'examples';
		var examples = new Array<Dynamic>();
		for( f in FileSystem.readDirectory( path ) ) {
			var p = '$path/$f';
			if( !FileSystem.isDirectory( p ) )
				continue;
			examples.push( { name: f } );
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