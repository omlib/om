package om.style;

import js.html.Element;

using StringTools;

//@:build()
//enum AnimationType

/**
	TODO multiple elements
	TODO start/stop/restart cleanup
	TODO See: https://css-tricks.com/controlling-css-animations-transitions-javascript/
*/
class CSSAnimation {

	public var name(default,null) : String;
	public var duration(default,null) : Float;
	public var repeat(default,null) : Int;
	public var delay(default,null) : Float;
	public var playing(default,null) : Bool;
	public var element(default,null) : Element;

	var _onStart : Void->Void;
	var _onEnd : Void->Void;
	var _onIteration : Void->Void;

	public function new( name : String, duration = 1.0, repeat = 0, delay = 0.0 ) {
		this.name = name;
		this.duration = duration;
		this.repeat = repeat;
		this.delay = delay;
		playing = false;
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

	//public function start( elements : Array<Element> ) : CSSAnimation {
	public function start( element : Element ) : CSSAnimation {

		this.element = element;

		playing = true;

		element.addEventListener( "animationstart", handleStart, false );
		element.addEventListener( "animationend", handleEnd, false );
		element.addEventListener( "animationiteration", handleIteration, false );
		element.addEventListener( "webkitAnimationStart", handleStart, false );
		element.addEventListener( "webkitAnimationEnd", handleEnd, false );
		element.addEventListener( "webkitAnimationIteration", handleIteration, false );

		var style = element.style;
		untyped style.webkitAnimation = name;
		untyped style.webkitAnimationDuration = duration+'s';
		untyped style.webkitAnimationFillMode = 'forwards';
		if( repeat > 0 ) untyped style.webkitAnimationIterationCount = '$repeat';
		if( delay > 0 ) untyped style.webkitAnimationDelay = delay+'s';
		//trace( untyped target.style.webkitAnimationPlayState );

		return this;
	}

	/*
	public function stop() {
		//TODO
	}
	*/

	public function dispose() : CSSAnimation {

		element.removeEventListener( "animationstart", handleStart );
		element.removeEventListener( "animationend", handleEnd );
		element.removeEventListener( "animationiteration", handleIteration );
		element.removeEventListener( "webkitAnimationStart", handleStart );
		element.removeEventListener( "webkitAnimationEnd", handleEnd );
		element.removeEventListener( "webkitAnimationIteration", handleIteration );

		for( f in Reflect.fields( element.style ) )
			if( f.startsWith( 'webkitAnimation' ) )
				Reflect.setField( element.style, f, '' );

		return this;
	}

	function handleStart(e) {
		if( _onStart != null ) _onStart();
	}

	function handleEnd(e) {
		dispose();
		if( _onEnd != null ) _onEnd();
	}

	function handleIteration(e) {
		if( _onIteration != null ) _onIteration();
	}

}
