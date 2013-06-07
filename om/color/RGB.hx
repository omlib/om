package om.color;

using StringTools;
using om.util.MathUtil;

class RGB {
	
	public var red(default,null) : Int;
	public var green(default,null) : Int;
	public var blue(default,null) : Int;

	public function new( r : Int, g : Int, b : Int ) {
		red   = r.clamp( 0, 255 );
		green = g.clamp( 0, 255 );
		blue  = b.clamp( 0, 255 );
	}

	public function int() : Int {
		return ( ( red & 0xFF ) << 16 ) | ( ( green & 0xFF ) << 8 ) | ( ( blue & 0xFF ) << 0 );
	}

	public function hex( ?prefix = "" ) : String {
		return prefix + red.hex(2) + green.hex(2) + blue.hex(2);
	}

	public inline function css() : String {
		return hex('#');    
	}

	public inline function toRGBString() : String {
		return 'rgb($red,$green,$blue)';
	}

	public inline function toString() : String {
		return toRGBString();
	}

	public static function fromInt( v: Int ): RGB {
		return new RGB( (v >> 16) & 0xFF, (v >> 8) & 0xFF, (v >> 0 ) & 0xFF );
	}

	public static inline function fromFloats( r : Float, g : Float, b : Float ) : RGB {
		return new RGB( r.interpolate( 0, 255 ), g.interpolate( 0, 255 ), b.interpolate( 0, 255 ) );
	}

	public static function equals( a : RGB, b : RGB ) : Bool {
		return a.red == b.red && a.green == b.green && a.blue == b.blue;
	}

	public static function interpolate( a : RGB, b : RGB, t : Float, ?equation : Float->Float ) : RGB {
		return new RGB(
			t.interpolate( a.red, b.red, equation ),
			t.interpolate( a.green, b.green, equation ),
			t.interpolate( a.blue, b.blue, equation )
		);
	}

	/*
	public static function interpolatef( a : RGB, b : RGB, ?equation : Float->Float ) {
		var r = Ints.interpolatef( a.red, b.red, equation ),
			g = Ints.interpolatef( a.green, b.green, equation ),
			b = Ints.interpolatef( a.blue, b.blue, equation );
		return function(t) return new RGB( r(t), g(t), b(t) );
	}
	*/

	public static function darker( color : RGB, t : Float, ?equation : Float->Float ) : RGB {
		return new RGB(
			t.interpolate( color.red,   0, equation ),
			t.interpolate( color.green, 0, equation ),
			t.interpolate( color.blue,  0, equation )
		);
	}

	public static function lighter( color : RGB, t : Float, ?equation : Float->Float ) : RGB {
		return new RGB(
			t.interpolate( color.red,   255, equation ),
			t.interpolate( color.green, 255, equation ),
			t.interpolate( color.blue,  255, equation )
		);
	}

	/*
	public static function contrast( c : Rgb ) {
		var nc = Hsl.toHsl(c);
		if (nc.lightness < .5)
			return new Hsl(nc.hue, nc.saturation, nc.lightness + 0.5);
		else
			return new Hsl(nc.hue, nc.saturation, nc.lightness - 0.5);
	}
	
	public static function contrastBW(c : Rgb) {
		var g = Grey.toGrey(c);
		var nc = Hsl.toHsl(c);
		if (g.grey < .5)
			return new Hsl(nc.hue, nc.saturation, 1.0);
		else
			return new Hsl(nc.hue, nc.saturation, 0);
	}
	
	public static function interpolateBrightness(t : Float, ?equation : Float -> Float) return interpolateBrightnessf(equation)(t)
	public static function interpolateBrightnessf(?equation : Float -> Float) {
		var i = Ints.interpolatef(0, 255, equation);
		return function(t)
		{
			var g = i(t);
			return new Rgb(g, g, g);
		};
	}

	public static function interpolateHeat(t : Float, ?middle, ?equation : Float -> Float) return interpolateHeatf(middle, equation)(t)
	public static function interpolateHeatf(?middle : Rgb, ?equation : Float -> Float) {
		return interpolateStepsf([
			new Rgb(0, 0, 0),
			null != middle ? middle : new Rgb(255, 127, 0),
			new Rgb(255, 255, 255),
		], equation);
	}

	public static function interpolateRainbow(t : Float, ?equation : Float -> Float) return interpolateRainbowf(equation)(t)
	public static function interpolateRainbowf(?equation : Float -> Float) {
		return interpolateStepsf([
			new Rgb(0,   0,   255),
			new Rgb(0,   255, 255),
			new Rgb(0,   255, 0),
			new Rgb(255, 255, 0),
			new Rgb(255, 0,   0),
		], equation);
	}

	public static function interpolateStepsf(steps : Array<Rgb>, ?equation : Float -> Float) {
		if (steps.length <= 0)
			return throw new Error("invalid number of steps");
		else if (steps.length == 1)
			return function(t) return steps[0];
		else if (steps.length == 2)
			return interpolatef(steps[0], steps[1], equation);

		var len = steps.length - 1,
			step = 1 / len,
			f = [];
		for (i in 0...len)
			f[i] = interpolatef(steps[i], steps[i+1]);

		return function(t : Float)
		{
			if (t < 0)
				t = 0;
			else if(t > 1)
				t = 1;
			var pos = t == 1 ? (len - 1) : Math.floor(t / step);
			return f[pos](len * (t - (pos * step)));
		};
	}
    */

}
