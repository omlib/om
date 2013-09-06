package om;

class EventDispatcher<T> {

	public var numHandlers(get,null) : Int;

	var handlers : Array<T->Void>;
	var _stop : Bool;

	public function new() {
		handlers = new Array();
		_stop = false;
	}

	inline function get_numHandlers() : Int return handlers.length;

	public function bind( h : T->Void ) : EventDispatcher<T> {
		handlers.push( h );
		return this;
	}

	public function once( h : T->Void ) : EventDispatcher<T> {
		var _h = null;
		_h = function(v:T) {
			remove( _h );
			h( v );
		};
		bind( _h );
		return this;
	}

	public function remove( h : T->Void ) : Bool {
		for( i in 0...handlers.length ) {
			if( Reflect.compareMethods( handlers[i], h ) ) {
				handlers.splice( i, 1)[0];
				return true;
			}
		}
		return false;
		//return this;
	}

	public function has( ?h : T->Void ) : Bool {
		if( h == null )
			return handlers.length > 0;
		for( _h in handlers )
			if( _h == h )
				return true;
		return false;
	}

	public function dispatch( e : T ) : EventDispatcher<T> {
		var list = handlers.copy();
		for( h in list ) {
			if( _stop ) {
				_stop = false;
				break;
			}
			h( e );
		}
		return this;
	}

	/*TODO
	public function dispatchAndAutomate(e : T)
	{
		dispatch(e);
		handlers = [];
		add = function(h : T -> Void)
		{
			h(e);
			return h;
		};
	}
	*/

	public function stop() {
		_stop = true;
	}

	public function clear() {
		handlers = new Array();
	}
	
}
