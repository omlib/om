package om;

//import js.html.Audio;

class Sound {

	/** The audio format used (ogg,mp3) */
	//public static inline var AUDIOFORMAT = "ogg"; // TODO if( UserAgent.browser.mozilla ) "ogg" else "ogg"; 

	public static var on = true;
	public static var list = new Hash<Audio>();
	//public static var volume : Float; //TODO

	public static function load( ids : Array<String>,
								 path : String = "sound/", preload : Bool = true ) {
		for( id in ids ) {
			var a =  new Audio( path+id+".ogg" );
			if( preload )
				a.preload = true;
			list.set( id, a );
		}
	}

	public static inline function clear() {
		list = new Hash();
	}

	public static function play( id : String ) {
		if( !on )
			return;
		var s = list.get( id );
		if( s == null ) {
			#if DEBUG
			trace( 'sound with id ['+id+'] not found', 'warn' );
			#end
			return;
		}
		s.play();
	}

}
