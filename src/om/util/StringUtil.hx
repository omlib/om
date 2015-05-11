package om.util;

class StringUtil {

	public static inline function formatTimePart( i : Int ) : String {
		return (i < 10) ? '0$i' : Std.string(i);
	}


	public static inline function count( str : String, seperator : String ) : Int {
		return str.split( seperator ).length;
	}

	public static inline function countLines( str : String ) : Int {
		return count( str, '\n' );
	}

	public static inline function removeLinebreaks( str : String ) : String {
		return str.split( '\n' ).join( '' );
	}


}
