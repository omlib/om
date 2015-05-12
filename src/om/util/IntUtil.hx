package om.util;

class IntUtil {

	public static inline function even( i : Int ) : Bool
		return i & 1 == 0;

	public static inline function uneven( i : Int ) : Bool
		return i & 1 == 1;

}
