package om;

import js.Browser.window;
import om.tween.Interpolation;
import om.tween.ease.Linear;

class Tween {

	static var _tweens = new Array<Tween>();

	public static inline function add( tween : Tween ) _tweens.push( tween );

	public static function remove( tween : Tween ) {
		var i = _tweens.indexOf( tween );
		if( i != -1 ) _tweens.splice( i, 1 );
	}

	public static inline function getAll() : Array<Tween> return _tweens;

	public static inline function removeAll() _tweens = new Array<Tween>();

	public static function __update__( time : Float ) : Bool {
		if( _tweens.length == 0 )
			return false;
		var i = 0;
		while( i < _tweens.length ) {
			if( _tweens[i].step( time ) ) {
				i++;
			} else {
				_tweens.splice( i, 1 );
			}
		}
		return true;
	}

	////////////////////////////////////////////////////////////////////////////

	public var isPlaying(default,null) = false;
	public var duration(default,null) : Float;

	var _object : Dynamic;
	var _valuesStart : Dynamic = {};
	var _valuesEnd : Dynamic = {};
	var _valuesStartRepeat : Dynamic = {};

	var _repeat = 0;
	var _yoyo = false;
	var _reversed = false;
	var _delayTime = 0.0;
	var _startTime = 0.0;
	var _easingFunction = Linear.None;
	var _interpolationFunction = Interpolation.linear;
	var _chainedTweens = new Array<Dynamic>();

	var _onStartCallback : Void->Void;
	var _onStartCallbackFired = false;
	var _onUpdateCallback : Void->Void;
	var _onCompleteCallback : Void->Void;
	var _onStopCallback : Void->Void;

	public function new( object : Dynamic ) {
		_object = object;
	}

	public function to( properties : Dynamic, duration = 1000.0 ) : Tween {
		this.duration = duration;
		_valuesEnd = properties;
		return this;
	}

	public function start( ?time : Float ) : Tween {

		Tween.add( this );

		isPlaying = true;
		_onStartCallbackFired = false;

		_startTime = (time != null) ? time : Time.now();
		_startTime += _delayTime;

		for( property in Reflect.fields( _valuesEnd ) ) {
			if( Std.is( Reflect.field( _valuesEnd, property ), Array ) ) {
				if( Reflect.field( _valuesEnd, property ).length == 0 ) {
					continue;
				}
				Reflect.setField( _valuesEnd, property, [ Reflect.field( _object, property ) ].concat( Reflect.field( _valuesEnd, property ) ) );
			}
			Reflect.setField( _valuesStart, property, Reflect.field( _object, property ) );
			if( !Std.is( Reflect.field( _valuesStart, property ), Array ) ) {
				Reflect.setField( _valuesStart, property, Reflect.field( _valuesStart, property ) * 1.0 );
			}
			var v = Reflect.field( _valuesStart, property );
			Reflect.setField( _valuesStartRepeat, property, (v != null) ? v : 0 );
		}

		return this;
	}

	public function stop() : Tween {
		if( !isPlaying )
			return this;
		Tween.remove( this );
		isPlaying = false;
		if( _onStopCallback != null ) _onStopCallback();
		stopChainedTweens();
		return this;
	}

	public function stopChainedTweens() {
		for( t in _chainedTweens ) t.stop();
	}

	public function delay( amount : Float ) : Tween {
		_delayTime = amount;
		return this;
	}

	public function repeat( times : Int ) : Tween {
		_repeat = times;
		return this;
	}

	public function yoyo( yoyo : Bool ) : Tween {
		_yoyo = yoyo;
		return this;
	}

	public function easing( easing : Dynamic ) : Tween {
		_easingFunction = easing;
		return this;
	}

	public function interpolation( interpolation : Dynamic ) : Tween {
		_interpolationFunction = interpolation;
		return this;
	}

	public function chain( args : Array<Tween> ) : Tween {
		_chainedTweens = args;
		return this;
	}

	public function onStart( callback : Void->Void ) : Tween {
		_onStartCallback = callback;
		return this;
	}

	public function onUpdate( callback : Void->Void ) : Tween {
		_onUpdateCallback = callback;
		return this;
	}

	public function onComplete( callback : Void->Void ) : Tween {
		_onCompleteCallback = callback;
		return this;
	}

	public function onStop( callback : Void->Void ) : Tween {
		_onStopCallback = callback;
		return this;
	}

	public function step( time : Float ) : Bool {
		//var property;

		if( time < _startTime )
			return true;

		if( !_onStartCallbackFired ) {
			if( _onStartCallback != null ) {
				//_onStartCallback.call( _object );
				_onStartCallback();
			}
			_onStartCallbackFired = true;
		}

		var elapsed = ( time - _startTime ) / duration;
		elapsed = elapsed > 1 ? 1 : elapsed;
		var value = _easingFunction( elapsed );
		for( property in Reflect.fields( _valuesEnd ) ) {
			//var property = Reflect.field( f, _valuesEnd );
			var start = Reflect.field( _valuesStart, property );
			if( start == null ) start = 0;
			var end = Reflect.field( _valuesEnd, property );
			if( Std.is( end, Array ) ) {
				Reflect.setField( _object, property, _interpolationFunction( end, value ) );
			} else {
				if( Std.is( end, String ) ) {
					untyped end = start + parseFloat( end, 10 );
				}
				if( Std.is( end, Float ) ) {
					untyped Reflect.setField( _object, property, start + ( end - start ) * value );
				}
			}
		}

		if( _onUpdateCallback != null ) {
			//_onUpdateCallback.call( _object, value );
			_onUpdateCallback();
		}

		if( elapsed == 1 ) {
			if( _repeat > 0 ) {
				if( untyped isFinite( _repeat ) ) {
					_repeat--;
				}
				for( property in Reflect.fields( _valuesStartRepeat ) ) {
					if( Std.is( Reflect.field( _valuesEnd, property ), String ) ) {
						untyped _valuesStartRepeat[ property ] = _valuesStartRepeat[ property ] + parseFloat(_valuesEnd[ property ], 10);
					}
					if( _yoyo ) {
						var tmp = Reflect.field( _valuesStartRepeat, property );
						Reflect.setField( _valuesStartRepeat, property, Reflect.field( _valuesEnd, property ) );
						Reflect.setField( _valuesEnd, property, tmp );
						//_valuesStartRepeat[ property ] = _valuesEnd[ property ];
						//_valuesEnd[ property ] = tmp;
					}
					Reflect.setField( _valuesStart, property, Reflect.field( _valuesEnd, property ) );
				}
				if( _yoyo ) {
					_reversed = !_reversed;
				}
				_startTime = time + _delayTime;
				return true;
			} else {
				if ( _onCompleteCallback != null )
					_onCompleteCallback();
				for( tween in _chainedTweens ) tween.start( time );
				return false;
			}
		}
		return true;
	}

}
