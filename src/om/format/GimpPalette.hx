package om.format;

using StringTools;

typedef GimpPaletteColor = {
	var r : Int;
	var g : Int;
	var b : Int;
	var name : String;
}

/**
	Quick implementation for the gimp palette (gpl) file format.
	Use at own risk!
*/
class GimpPalette {

	public var name : String;
	public var columns : Int;
	public var colors : Array<GimpPaletteColor>;

	public function new( name : String, columns : Int, ?colors : Array<GimpPaletteColor> ) {
		this.name = name;
		this.columns = columns;
		this.colors = (colors != null) ? colors : [];
	}

	public function toString() : String {
		var str = 'GIMP Palette\nName: $name\nColumns: $columns\n#\n';
		for( c in colors ) str += c.r+' '+c.g+' '+c.b+' '+c.name+'\n';
		return str;
	}

	public static function read( str : String ) : GimpPalette {

		var lines = str.split( '\n' );

		var name = lines[1];
		name = name.substr( name.indexOf(':')+1 ).trim();

		var _columns = lines[2];
		_columns = _columns.substr( _columns.indexOf(':')+1 ).trim();
		var columns = Std.parseInt( _columns );

		var palette = new GimpPalette( name, columns );

		for( i in 4...lines.length-1 ) {
			var parts = lines[i].split( String.fromCharCode(9) );
			palette.colors.push({
				r: Std.parseInt( parts[0] ),
				g: Std.parseInt( parts[1] ),
				b: Std.parseInt( parts[2] ),
				name: parts[3]
			});
		}

		return palette;
	}

}
