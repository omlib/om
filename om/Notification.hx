package om;

#if (web||crx)

import haxe.Timer;

/**
*/
class Notification {

	var n : Dynamic;

	public function new( title : String, message : String, ?icon : String ) {
		n = untyped webkitNotifications.createNotification( icon, title, message );
	}

	public function show( time : Int = -1 ) {
		if( time > 0 ) {
			Timer.delay(function(){
				n.cancel();
			}, time );
		}
		n.show();
	}

	public function cancel() {
		n.cancel();
	}

	/*
	public static function create( m : String ) {
	}
	*/
	
}

#end
