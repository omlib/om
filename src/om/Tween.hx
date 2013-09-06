package om;

import haxe.Timer;

typedef TweenEase = Float->Float->Float->Float->Float;

/**
	A simple tween engine
*/
class Tween {

	public static inline var interval = 16;
	
	static var intervalTime : Float;
	static var _tweens = new Array<Tween>();
	static var _timer : Timer;
	static var _active = false;
	
	static function addTween( t : Tween ) {
		_tweens.push( t );
		intervalTime = Timer.stamp();
		if( !_active ) {
			_active = true;
			_timer = new Timer( interval );
			_timer.run = _update;
		}
	}
	
	static inline function remove( t : Tween ) {
		_tweens.remove( t );
	}
	
	static function _update( ) {
		intervalTime = Timer.stamp();
		if( _tweens.length == 0 ) {
			_active = false;
			_timer.stop();
		} else for( t in _tweens ) t.update();
	}
	
	public static inline function defaultEasing( t : Float, b : Float, c : Float, d : Float ) : Float {
		return c / 2 * ( Math.sin( Math.PI * ( t / d - 0.5 ) ) + 1 ) + b;
	}
	
	public dynamic function onUpdate( f : Float ) {}
	public dynamic function onEnd( f : Float ) {}
	
	public var active(default,null) : Bool;
	public var value : Float;
	public var duration : Float;
	public var equation : TweenEase;
	public var startValue : Float;
	public var endValue : Float;
	
	var startTime : Float;
	var updateTime : Float;
	
	public function new( duration : Float = 1.0, ?equation : Dynamic ) {
		this.duration = duration;
		this.equation = equation == null ? defaultEasing : equation;
		active = false;
	}
	
	public function start( startValue : Float, endValue : Float ) : Tween {
		this.startValue = value = startValue;
		this.endValue = endValue;
		return run();
	}
	
	public function run() : Tween {
		startTime = updateTime = Timer.stamp();
		Tween.addTween( this );
		active = true;
		return this;
	}
	
	public function stop() : Tween {
		if( !active )
			return this;
		Tween.remove( this );
		reset();
		return this;
	}
	
	function reset() {
		active = false;
		startTime = startValue = endValue = updateTime = 0;
	}
	
	function update() {
		var time = ( Timer.stamp() - startTime ) * 1000;
		if( time >= duration ) {
			active = false;
			Tween.remove( this );
			var v = endValue;
			reset();
			onEnd( v );
		} else {
			value = equation( time, startValue, endValue-startValue, duration );
			onUpdate( value );
		}
	}
	
}
