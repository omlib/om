package om.unit.color;

import om.color.RGB;

using om.util.ColorUtil;

abstract Hex(Int) from Int to Int {

	inline function new( i : Int )
		this = i;

	/*
	@:to
	public inline function toRGB() : RGB return hex2rgb();
	*/

	/*
	@:from
	public static inline function rgbToHex( rgb : RGB ) : Hex {
		return new Hex( rgb.rgb2hex() );
	}
	*/


}
