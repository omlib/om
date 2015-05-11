package om.unit.color;

import om.util.ColorUtil;

abstract RGB(Int) from Int to Int {

	public var r(get,never) : Int;
	public var g(get,never) : Int;
	public var b(get,never) : Int;

	public inline function new( i : Int ) this = i;

	inline function get_r() return this >> 16 & 0xFF;
	inline function get_g() return this >> 8 & 0xFF;
	inline function get_b() return this & 0xFF;

	public function interpolate( target : Int, ratio = 0.5 ) : RGB {
		var _target = new RGB( target );
		var _r = r;
		var _g = g;
		var _b = b;
		return ColorUtil.rgbToInt(
			Std.int( _r + (_target.r - _r) * ratio ),
			Std.int( _g + (_target.g - _g) * ratio ),
			Std.int( _b + (_target.b - _b) * ratio )
		);
	}

	@:arrayAccess
	inline function getPart( i : Int ) : Int {
		return switch i {
			case 0: r;
			case 1: g;
			case 2: b;
			default: throw 'Out of bounds';
		}
	}

	@:to
	inline function toArray() : Array<Int> {
		return [r,g,b];
	}

	@:to
	inline function toString() : String {
		return '#'+untyped this.toString(16);
	}

	@:from
	static inline function fromInt( i : Int ) : RGB {
		return new RGB(i);
	}

	@:from
	static inline function fromString( s : String ) : RGB {
		return new RGB( ColorUtil.strToInt( s ) );
	}

	@:from
	static inline function fromArray( a : Array<Int> ) : RGB {
		return new RGB( ColorUtil.rgbToInt( a[0], a[1], a[2] ) );
	}


}
