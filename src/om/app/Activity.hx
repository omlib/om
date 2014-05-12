package om.app;

import js.Browser.document;
import js.html.Element;

@:require(js)
class Activity {

	public var id(default,null) : String;
	public var e(default,null) : Element;

	public function new( ?id : String ) {
		if( id == null ) {
			id = Type.getClassName( Type.getClass( this ) );
			id = id.substr( id.lastIndexOf(".")+1 );
			id = id.substr( 0, id.length-8 ).toLowerCase();
		}
		this.id = id;
	}

	function onCreate() {
		createRootElement();
	}

	function onStart() {
	}

	function onStop() {
	}

	function onDestroy() {
	}

	function createRootElement() {
		e = document.createDivElement();
		e.id = id;
	}

	static var container : Element;
	static var current : Activity;

	public static function init( container : Element ) {
		container.innerHTML = '';
		Activity.container = container;
	}

	public static function set( s : Class<Activity>, ?args : Array<Dynamic> ) {
		if( args == null ) args = new Array();
		if( current != null ) {
			current.onStop();
			current.e.remove();
			current.onDestroy();
		}
		var n : Activity = Type.createInstance( s, args );
		n.onCreate();
		current = n;
		container.appendChild( current.e );
		n.onStart();
	}

}
