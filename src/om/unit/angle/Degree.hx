package om.unit.angle;

import om.util.MathUtil.DEGREES_TO_RADIANS_FACTOR;

abstract Degree(Float) from Float to Float {

	public static inline var SYMBOL = "°";

	public inline function new( i : Float ) this = i;

	public inline function sin() return Math.sin( this );
	public inline function cos() return Math.cos( this );
	public inline function abs() return Math.abs( this );
	public inline function min(f:Float) return Math.min( this, f );
	public inline function max(f:Float) return Math.max( this, f );

	@:to public inline function toFloat() : Float return this;
	@:to public inline function toString() : String return this + SYMBOL;
	@:to public inline function toRadian() : Radian return this * DEGREES_TO_RADIANS_FACTOR;


	/*
  public function normalize() : Degree {
    var a = this % turn.toFloat();
    return a < 0 ? turn + a : a;
  }

  public function normalizeDirection() : Degree {
    var a = normalize();
    return a > 180 ? a - turn : a;
  }

  @:op( -A ) public inline function negate() : Degree
    return -this;
  @:op( A+B) public inline function add(other : Degree) : Degree
    return this + other.toFloat();
  @:op( A-B) public inline function subtract(other : Degree) : Degree
    return this - other.toFloat();
  @:op( A*B) public inline function multiply(other : Float) : Degree
    return this * other;
  @:op( A/B) public inline function divide(other : Float) : Degree
    return this / other;
  @:op( A%B) public inline function modulo(other : Float) : Degree
    return this % other;
  @:op(A==B) public inline function equal(other : Degree) : Bool
    return this == other;
  public function nearEquals(other : Degree) : Bool
    return Floats.nearEquals(this, other.toFloat());
  @:op(A!=B) public inline function notEqual(other : Degree) : Bool
    return this != other;
  @:op( A<B) public inline function less(other : Degree) : Bool
    return this < other.toFloat();
  @:op(A<=B) public inline function lessEqual(other : Degree) : Bool
    return this <= other.toFloat();
  @:op( A>B) public inline function more(other : Degree) : Bool
    return this > other.toFloat();
  @:op(A>=B) public inline function moreEqual(other : Degree) : Bool
    return this >= other.toFloat();

  @:to public inline function toBinaryDegree() : BinaryDegree
    return this * 0.711111111111111;
  @:to public inline function toGrad() : Grad
    return this * 1.11111111111111;
  @:to public inline function toHourAngle() : HourAngle
    return this * 0.0666666666666667;
  @:to public inline function toMinuteOfArc() : MinuteOfArc
    return this * 60;
  @:to public inline function toPoint() : Point
    return this * 0.0888888888888889;
  @:to public inline function toQuadrant() : Quadrant
    return this * 0.0111111111111111;
  @:to public inline function toRadian() : Radian
    return this * 0.0174532925199433;
  @:to public inline function toRevolution() : Revolution
    return this * 0.00277777777777778;
  @:to public inline function toSecondOfArc() : SecondOfArc
    return this * 3600;
  @:to public inline function toSextant() : Sextant
    return this * 0.0166666666666667;
  @:to public inline function toTurn() : Turn
    return this * 0.00277777777777778;

  @:to public inline function toString() : String
    return this + symbol;

  public static inline var symbol : String = "°";
*/
}
