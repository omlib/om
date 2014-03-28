
/*
	Om - Application meditation
*/
class Om {
	
	public static inline var VERSION = '0.1.1';

	#if js

	/**
		//Shim taken from: http://webreflection.blogspot.com.au/2009/11/195-chars-to-help-lazy-loading.html
	*/
	public static function ready( f : Void->Void ) {
		untyped __js__('(function(h,a,c,k){if(h[a]==null&&h[c]){h[a]="loading";h[c](k,c=function(){h[a]="complete";h.removeEventListener(k,c,!1)},!1)}})(document,"readyState","addEventListener","DOMContentLoaded")');
		Reflect.setField( untyped window, 'checkReady', checkReady );
		checkReady(f);
	}

	static function checkReady( f : Void->Void ) {
		untyped __js__( '/in/.test(document.readyState)?setTimeout(function(){checkReady(f)},9):f()' );		
	}


	public static function init( root : String, f : Void->Void ) {
		createCSS();
		ready(f);
	}

	#end

	/*
	macro static function createCSS() {
		var e = macro "Hello".toLowerCase();
		return e;
	}
	*/

}
