package om.util;

class UserAgentUtil {

	public static inline function detectWebgl() : Bool {
		return untyped __js__("(function(){try{return !!window.WebGLRenderingContext&&!!document.createElement('canvas').getContext('experimental-webgl');}catch(e){return false;}})()" );
	}

	public static function detectMobile() : Bool {
		return untyped __js__('/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)') );
	}
	
}
