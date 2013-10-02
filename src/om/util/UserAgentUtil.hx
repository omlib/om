package om.util;

class UserAgentUtil {

	public static inline function detectWebgl() : Bool {
		return untyped __js__("(function(){try{return !!window.WebGLRenderingContext&&!!document.createElement('canvas').getContext('experimental-webgl');}catch(e){return false;}})()" );
	}
	
}
