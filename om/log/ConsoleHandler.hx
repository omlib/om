package om.log;

/**
	Log handler printing to the console
*/
class ConsoleHandler extends Handler {

	public inline function new() {
		super();
	}

	public override inline function log( v : Dynamic ) Console.l( v );
	public override inline function debug( v : Dynamic ) Console.d( v );
	public override inline function info( v : Dynamic ) Console.i( v );
	public override inline function warn( v : Dynamic ) Console.w( v );
	public override inline function error( v : Dynamic ) Console.e( v );

	public override inline function l( v : Dynamic ) Console.l( v );
	public override inline function d( v : Dynamic ) Console.d( v );
	public override inline function i( v : Dynamic ) Console.i( v );
	public override inline function w( v : Dynamic ) Console.w( v );
	public override inline function e( v : Dynamic ) Console.e( v );

}
