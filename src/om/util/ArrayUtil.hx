package om.util;

class ArrayUtil {

	/*
	public static function merge<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		//return a = a.concat( b );
		for( v in b ) a.push(v);
		return a;
	}
	*/

	public static inline function append<T>( a : Array<T>, b : Array<T> ) {
		a = a.concat(b);
	}

	/*
	public static function append<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		for( v in b ) a.push(v);
		return a;
	}

	public static function prepend<T>( a : Array<T>, b : Array<T> ) : Array<T> {
		for( v in b ) a.unshift(v);
		return a;
	}
	*/

	macro public static function pluck<T,TOut>( arr : ExprOf<Array<T>>, expr : ExprOf<TOut> ) : ExprOf<Array<TOut>>
		return macro $e{arr}.map( function(_) return ${expr} );
	
}
