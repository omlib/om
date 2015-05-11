package om;

class Time {

	public static inline function now() : Float {

		#if js
		return untyped window.performance.now();

		#elseif sys
		return Sys.time();

		#end
	}

}
