package om.style;

import js.html.Element;
import js.html.AnimationEvent;

using StringTools;

@:enum abstract AnimationDirection(String) from String to String {
	var normal = 'normal';
	var reverse = 'reverse';
	var alternate = 'alternate';
	var alternate_reverse = 'alternate-reverse';
}

/**
*/
class CSSAnimation {

	public var element(default,null) : Element;
	public var name(default,null) : String;
	public var duration(default,null) : Float;
	public var repeat(default,null) : Int;
	public var delay(default,null) : Float;
	public var playing(get,never) : Bool; //TODO animation playstate
	public var direction(default,null) : AnimationDirection;

	var _onStart : Void->Void;
	var _onEnd : Void->Void;
	var _onIteration : Void->Void;

	public function new( element : Element, name : String,
						 duration = 1.0, repeat = 1, delay = 0.0, ?direction : AnimationDirection ) {
		this.element = element;
		this.name = name;
		this.duration = duration;
		this.repeat = repeat;
		this.delay = delay;
		this.direction = direction;
	}

	function get_playing() : Bool {
		return element.style.animationPlayState == 'running';
	}

	public inline function onStart( cb : Void->Void ) : CSSAnimation {
		_onStart = cb;
		return this;
	}

	public inline function onEnd( cb : Void->Void ) : CSSAnimation {
		_onEnd = cb;
		return this;
	}

	public inline function onIteration( cb : Void->Void ) : CSSAnimation {
		_onIteration = cb;
		return this;
	}

	public function start() : CSSAnimation {

		var style = element.style;
		style.animation = name;
		style.animationDuration = duration+'s';
		style.animationFillMode = 'forwards';
		if( direction != null ) style.animationDirection = direction;
		if( repeat > 1 ) style.animationIterationCount = '$repeat';
		else if( repeat == 0 )  style.animationIterationCount = 'infinite';
		if( delay > 0 ) style.animationDelay = delay+'s';

		element.addEventListener( "animationstart", handleStart, false );
		element.addEventListener( "animationend", handleEnd, false );
		element.addEventListener( "animationiteration", handleIteration, false );

		return this;
	}

	public function stop() : CSSAnimation {

		element.removeEventListener( "animationstart", handleStart );
		element.removeEventListener( "animationend", handleEnd );
		element.removeEventListener( "animationiteration", handleIteration );

		for( f in Reflect.fields( element.style ) )
			if( f.startsWith( 'animation' ) )
				Reflect.setField( element.style, f, '' );

		return this;
	}

	public function pause() : CSSAnimation {
		element.style.animationPlayState = 'paused';
		return this;
	}

	public function resume() : CSSAnimation {
		element.style.animationPlayState = 'running';
		return this;
	}

	function handleStart( e : AnimationEvent ) {
		if( _onStart != null ) _onStart();
	}

	function handleEnd( e : AnimationEvent ) {
		stop();
		if( _onEnd != null ) _onEnd();
	}

	function handleIteration( e : AnimationEvent ) {
		if( _onIteration != null ) _onIteration();
	}

}
