package om;

typedef LogHandler = {

	function start() : Void;
	function stop() : Void;

	function l( v : Dynamic ) : Void;
	function d( v : Dynamic ) : Void;
	function i( v : Dynamic ) : Void;
	function w( v : Dynamic ) : Void;
	function e( v : Dynamic ) : Void;
}
