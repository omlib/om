package om;

import js.html.DOMParser;
import js.html.Element;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import js.html.Node;
import js.html.NodeList;
import js.Browser.document;
import js.Browser.window;
import om.Tween;

using StringTools;

/*
private class QCollection {

	var list : NodeList;

	public function new( list : NodeList ) {
		this.list = list;
	}
}
*/

/**
	DOM meditation
*/
@:require(js)
class Q {

	//static var parser = new DOMParser();

	public var e : Element;

	function new( e : Element ) {
		this.e = e;
	}


	/// --- Manipulate

	@:overload(function(content:Element):Q{})
	@:overload(function(content:Q):Q{})
	public function append( content : String ) : Q {
		if( isString( content ) ) {
			return appendHtml( content );
		} else {
			if( untyped content.nodeType == 1 )
				e.appendChild( untyped content );
			else
				e.appendChild( untyped content.e );
			return this;
		}
	}

	public inline function appendHtml( html : String ) : Q {
		e.appendChild( parseChildNode( html ) );
		return this;
	}

	@:overload(function(content:Element):Q{})
	@:overload(function(content:Q):Q{})
	public function prepend( content : String ) : Q {
		if( isString( content ) ) {
			return prependHtml( content );
		} else {
			if( untyped content.nodeType == 1 )
				e.insertBefore( untyped content, e.firstChild  );
			else
				e.insertBefore( untyped content.e, e.firstChild  );
			return this;
		}
	}

	public inline function prependHtml( html : String ) : Q {
		e.insertBefore( parseChildNode( html ), e.firstChild );
		return this;
	}

	public function empty() : Q {
		while( e.hasChildNodes() ) e.removeChild( e.firstChild );
		return this;
	}

	/* //TODO why is this not working
	@:overload(function():NodeList{})
	public function remove( selector : String ) : Q {
		if( untyped selector == null ) {
			e.parentNode.removeChild( e );
			return this;
		} else {
			 var list = document.querySelectorAll( untyped selector );
			 var i = 0;
			 while( i < list.length ) {
			 	var item = list.item(i++);
			 	item.parentNode.removeChild( item );
			 }
			 return cast list;
		}
	}
	*/

	public inline function remove() : Q {
		e.parentNode.removeChild( e );
		return this;
	}

	@:overload(function():String{})
	public function html( content : String ) : Q {
		if( content == null )
			return untyped e.innerHTML;
		else {
			e.innerHTML = content;
			return this;
		}
	}

	@:overload(function():String{})
	public function text( content : String ) : Q {
		if( content == null )
			return untyped e.textContent;
		else {
			e.textContent = content;
			return this;
		}
	}





	/// --- Manipulate

	//public static function replaceAll( selector ) {



	/// --- Select

	/*
	public static inline function select( selector : String ) : QCollection {
		return new QCollection( document.querySelectorAll( selector ) );
	}
	*/



	/// --- Construct

	/*
	public static function parse( html : String ) : Q {
		var e = new DOMParser().parseFromString( html, "text/xml" ).documentElement;
		trace(e);
		return new Q( cast e );
		//return new Q( cast parseChildNode( html ) );
	}
	*/

	public static function div( ?id : String, ?classes : String ) : Q {
		var e = document.createDivElement();
		if( id != null ) e.id = id;
		if( classes != null ) e.setAttribute( 'class', classes );
		return new Q(e);
	}

	public static function span( ?id : String, ?classes : String ) : Q {
		var e = document.createSpanElement();
		if( id != null ) e.id = id;
		if( classes != null ) e.setAttribute( 'class', classes );
		return new Q(e);
	}


	/// --- Traversing

	public static function each( selector : String, f : Q->Void ) {
		var el = document.querySelectorAll( selector );
		var i = 0;
		while( i < el.length )
			f( new Q( cast el.item(i++) ) );
	}



	/// --- Events

	public inline function on<T>( types : String, f : T->Void ) : Q {
		e.addEventListener( types, f );
		return this;
	}

	public inline function keydown( f : KeyboardEvent->Void ) : Q {
		on( 'keydown', f );
		return this;
	}

	public inline function keyup( f : KeyboardEvent->Void ) : Q {
		on( 'keyup', f );
		return this;
	}

	public inline function keypress( f : KeyboardEvent->Void ) : Q {
		on( 'keypress', f );
		return this;
	}

	public function click( f : MouseEvent->Void ) {
		on( 'click', f );
		return this;
	}

	public function dbclick( f : MouseEvent->Void ) {
		on( 'dbclick', f );
		return this;
	}

	//TODO
	//public function hover( f : MouseEvent->Void ) {

	public function mousedown( f : MouseEvent->Void ) {
		on( 'mousedown', f );
		return this;
	}

	public function mouseenter( f : MouseEvent->Void ) {
		on( 'mouseenter', f );
		return this;
	}

	public function mouseleave( f : MouseEvent->Void ) {
		on( 'mouseleave', f );
		return this;
	}

	public function mousemove( f : MouseEvent->Void ) {
		on( 'mousemove', f );
		return this;
	}

	public function mouseover( f : MouseEvent->Void ) {
		on( 'mouseover', f );
		return this;
	}

	public function mouseup( f : MouseEvent->Void ) {
		on( 'mouseup', f );
		return this;
	}

	//TODO
	//public function toggle( f : MouseEvent->Void ) {



	/// --- Style

	@:overload(function(prop:String):String{})
	public inline function style( prop : String, value : String ) : String {
		if( value == null )
			return Reflect.field( e.style, prop );
		else {
			Reflect.setField( e.style, prop, value );
			return cast this;
		}
	}

	@:overload(function():String{})
	public inline function color( v : String ) : Q {
		return untyped style( 'color', v );
	}

	@:overload(function():String{})
	public inline function background( v : String ) : Q {
		return untyped style( 'background', v );
	}

	@:overload(function():Float{})
	public inline function alpha( v : Float ) : Q {
		if( v == null )
			return Reflect.field( e.style, 'opacity' );
		else {
			Reflect.setField( e.style, 'opacity', v );
			return cast this;
		}
	}

	@:overload(function():Float{})
	public inline function width( v : Float ) : Q {
		if( v == null )
			return Reflect.field( e.style, 'width' );
		else {
			Reflect.setField( e.style, 'width', v );
			return cast this;
		}
	}

	@:overload(function():Float{})
	public inline function height( v : Float ) : Q {
		if( v == null )
			return Reflect.field( e.style, 'height' );
		else {
			Reflect.setField( e.style, 'height', v );
			return cast this;
		}
	}

	public inline function addClass( name : String ) : Q {
		e.classList.add( name );
		return this;
	}

	public inline function removeClass( tokens : String ) : Q {
		e.classList.remove( tokens );
		return this;
	}

	public inline function hasClass( name : String ) : Bool {
		return e.classList.contains( name );
	}

	public inline function show() : Q {
		e.style.opacity = '1';
		return this;
	}

	public inline function hide() : Q {
		e.style.opacity = '0';
		return this;
	}



	/// --- Animation

	public function tween( duration : Float, startValue : Float, endValue : Float,
						   onUpdate : Float->Void, ?onEnd : Float->Void,
						   ?ease : TweenEase ) {
		var t = new Tween( duration );
		t.onUpdate = onUpdate;
		t.onEnd = onEnd;
		t.start( startValue, endValue );
		return this;
	}

	public inline function fadeIn( duration : Int = 400, ?cb : Q->Void ) : Q {
		tween( duration, Std.parseFloat( e.style.opacity ), 1,
			function(f) {
				e.style.opacity = Std.string(f);
			},
			function(f) {
				e.style.opacity = Std.string(f);
				if( cb != null )
					cb( this );
			}
		);
		return this;
	}

	public inline function fadeOut( duration : Int = 400, ?cb : Q->Void ) : Q {
		tween( duration, Std.parseFloat( e.style.opacity ), 0,
			function(f) {
				e.style.opacity = Std.string(f);
			},
			function(f) {
				e.style.opacity = Std.string(f);
				if( cb != null )
					cb( this );
			}
		);
		return this;
	}

	public inline function fadeTo( v : Float, duration : Int = 400, ?cb : Q->Void ) : Q {
		trace(Std.parseFloat( e.style.opacity ));
		var startValue =
		tween( duration, Std.parseFloat( e.style.opacity ), v,
			function(f) {
				e.style.opacity = Std.string(f);
			},
			function(f) {
				e.style.opacity = Std.string(f);
				if( cb != null )
					cb( this );
			}
		);
		return this;
	}


	/* TODO
	public inline function slideUp( duration : Int = 400, ?cb : Q->Void ) : Q {
		Reflect.setField( e, 'height', 'auto' );
		tween( duration, Std.parseFloat( e.style.height ), 0,
			function(f) {
				e.style.height = Std.string(f);
			},
			function(f) {
				e.style.opacity = Std.string(f);
				if( cb != null )
					cb( this );
			}
		);
		return this;
	}
	*/



	/// --- Utils

	static function parseChildNode( child ) : Node {
		return new DOMParser().parseFromString( child, "text/xml" ).firstChild;
	}

	public static function typeof( t : Dynamic ) : String {
		return untyped __js__('typeof t');
	}

	public static function isString( t : Dynamic ) : Bool {
		return typeof( t ) == 'string';
	}

	public static function ready( f : Void->Void ) {
		// Shim taken from: http://webreflection.blogspot.com.au/2009/11/195-chars-to-help-lazy-loading.html
		untyped __js__('(function(h,a,c,k){if(h[a]==null&&h[c]){h[a]="loading";h[c](k,c=function(){h[a]="complete";h.removeEventListener(k,c,!1)},!1)}})(document,"readyState","addEventListener","DOMContentLoaded")');
		Reflect.setField( window, 'checkReady', checkReady );
		checkReady(f);
	}

	static function checkReady( f : Void->Void ) {
		untyped __js__( '/in/.test(document.readyState)?setTimeout(function(){checkReady(f)},9):f()' );		
	}

	public static var body(get,null) : Q;
	static inline function get_body() : Q return new Q( document.body );

}
