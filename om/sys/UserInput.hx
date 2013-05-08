package om.sys;

#if cpp
import cpp.vm.Thread;
#elseif neko
import neko.vm.Thread;
#end

/**
	Reads users terminal input
*/
class UserInput {

	public static dynamic function onInput( line : String ) {}

	public static function read( ?f : String->Void ) {
		if( f != null )
			onInput = f;
		var t = Thread.create( _readUserInput );
		t.sendMessage( _onInput );
	}

	static function _onInput( line : String ) {
		if( onInput != null )
			onInput( line );
	}

	static function _readUserInput() {
		var f = Thread.readMessage( true );
		while( true ) {
			var t = Sys.stdin().readLine();
			if( t == "" )
				continue;
			f( t );
			break;
		}
	}

}
