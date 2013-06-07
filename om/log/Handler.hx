package om.log;

/**
	Abstract base type of a log handler
*/
class Handler {

	function new() {}

	public function start() {} 
	public function stop() {} 

	public function log( v : Dynamic ) {}
	public function debug( v : Dynamic ) {}
	public function info( v : Dynamic ) {}
	public function warn( v : Dynamic ) {}
	public function error( v : Dynamic ) {}

	public function l( v : Dynamic ) {}
	public function d( v : Dynamic ) {}
	public function i( v : Dynamic ) {}
	public function w( v : Dynamic ) {}
	public function e( v : Dynamic ) {}

}
