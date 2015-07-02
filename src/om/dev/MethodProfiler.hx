package om.dev;

import haxe.ds.StringMap;
import om.Time;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.ExprTools;
import haxe.macro.Printer;
import om.macro.MacroTools;
import om.Console;

using om.macro.MacroFieldTools;

/*
enum ProfileMode {
	all;
	none;
	whitelist;
	blacklist;
}
*/

#end

using Lambda;

private typedef MethodProfile = {
	var calls : Int;
	var timeStart : Float;
	var timeElapsed : Float;
}

private typedef MethodProfileResult = {
	var name : String;
	var time : Float;
	var calls : Float;
}

private typedef ClassProfileResult = {
	var name : String;
	var time : Float;
	var methods : Array<MethodProfileResult>;
}

typedef ProfileResult = {
	var time : Float;
	var classes : Array<ClassProfileResult>;
}

/**
	Usage:

		Add build meta to the class you want to profile: @:build(om.dev.MethodProfiler.profile(true))
		For sub classes: @:autoBuild(om.dev.MethodProfiler.profile(true))

		Print results: MethodProfiler.print()

		By default all methods get profiled.
		Set @noProfile on the methods you want to exclude.
		Or pass false as argument to MethodProfiler.profile and enable methods to profile with @profile.
*/
class MethodProfiler {

	public static var profiles(default,null) = new StringMap<StringMap<MethodProfile>>();
	public static var numProfiles(get,null) : Int;
	public static var debug = false;

	static function get_numProfiles() : Int {
		var n = 0;
		for( p in profiles ) n += p.count();
		return n;
	}

	/**
	*/
	public static function start( className : String, methodName : String ) {

		var cProfile = profiles.get( className );
		if( cProfile == null )
			profiles.set( className, cProfile = new StringMap<MethodProfile>() );

		var mProfile : MethodProfile = null;
		if( mProfile == null )
			cProfile.set( methodName, mProfile = { calls:0, timeStart:0, timeElapsed:0 } );

		if( debug ) trace( '> start $className.$methodName' );

		mProfile.timeStart = Time.now();
		mProfile.calls++;
	}

	/**
	*/
	public static function end( className : String, methodName : String ) {

		var cProfile = profiles.get( className );
		if( cProfile == null || !cProfile.exists( methodName ) )
			throw 'MethodProfiler.end called on a function that was never started [$className.$methodName]';

		var mProfile = cProfile.get( methodName );
		mProfile.timeElapsed += Time.now() - mProfile.timeStart;

		if( debug ) trace( '< end   $className.$methodName' );
	}

	/**
	*/
	public static function result( resetProfiles = true ) : ProfileResult {
		var result = { time:0.0, classes:[] };
		for( cName in profiles.keys() ) {
			var cProfile = profiles.get( cName );
			var cProfileResult : ClassProfileResult = { name:cName, time:0.0, methods:[] };
			for( mName in cProfile.keys() ) {
				var mProfile = cProfile.get( mName );
				cProfileResult.methods.push( { name:mName, time:mProfile.timeElapsed, calls:mProfile.calls });
			}
			result.classes.push( cProfileResult );
		}
		if( resetProfiles ) reset();
		return result;
	}

	/**
	*/
	public static function toString( resetProfiles = true ) : String {
		if( numProfiles == 0 )
			return '0 profiles';
		var str = '';
		var totalTime = 0.0;
		for( cName in profiles.keys() ) {
			var cProfile = profiles.get( cName );
			var cTime = 0.0;
			str += cName+'\n';
			for( methodName in cProfile.keys() ) {
				var mProfile = cProfile.get( methodName );
				var info = '\t.$methodName: ${mProfile.timeElapsed} (${mProfile.calls} call';
				if( mProfile.calls != 1 ) info += 's';
				info += ')';
				str += info+'\n';
				cTime += mProfile.timeElapsed;
			}
			str += '---\n${cTime}s';
			totalTime += cTime;
		}
		str += '\nTotal time: $totalTime';
		if( resetProfiles ) reset();
		return str;
	}

	/**
	*/
	public static function toHTML( resetProfiles = true, precision = 5 ) : String {
		var totalTime = 0.0;
		var str = '<div>';
		for( cName in profiles.keys() ) {
			var cProfile = profiles.get( cName );
			var cTime = 0.0;
			str += '<div>$cName</div>';
			for( methodName in cProfile.keys() ) {
				var mProfile = cProfile.get( methodName );
				var info = '$methodName: '+formatTimeValue( mProfile.timeElapsed, precision )+' ('+mProfile.calls+' call';
				if( mProfile.calls != 1 ) info += 's';
				info += ')';
				str += '<div style="margin-left:10px;">$info</div>';
				cTime += mProfile.timeElapsed;
			}
			totalTime += cTime;
			str += '<div>---</div>';
			str += '<div>'+formatTimeValue( cTime, precision )+'</div>';
		}
		str += '<div>Total time: '+formatTimeValue( totalTime, precision )+'</div>';
		str += '</div>';
		if( resetProfiles ) reset();
		return str;
	}

	/**
	*/
	public static inline function reset() {
		profiles = new StringMap();
	}

	static function formatTimeValue( v : Float, precision : Int ) : String {
		var s = Std.string(v);
		return s.substr( 0, s.indexOf('.')+precision );
	}

	////////////////////////////////////////////////////////////////////////////

	#if macro

	static var clsName = "";
	static var methodName  = "";
	static var lastWasReturn = false;

	/**
		Inject profiling code at the beginning and ending of each function
	*/
	macro public static function profile( allMethods : Bool = true ) : Array<Field> {

		/*
		#if tron
		if( tron.Build.params.release ) {
			tron.Build.warn( 'Method profiler active in release build' );
		}
		#end
		*/

		clsName = MacroTools.getFullClassName( Context.getLocalClass().get() );
		var fields = Context.getBuildFields();
		for( field in fields ) {

			switch field.kind {
			case FFun(fun):
				//{  //TODO?

				if( (!allMethods && !field.hasMeta( 'profile' ) )
					|| field.hasMeta( 'noProfile' ) )
					continue;

				methodName = field.name;

				// Prepend the start code to the function
				fun.expr = macro {
					om.dev.MethodProfiler.start( $v{clsName}, $v{methodName} );
					${fun.expr};
				};

				// Start recursive expression transformation
				lastWasReturn = false;
				fun.expr = remapReturn( fun.expr );
				if( !lastWasReturn ) {
					fun.expr = macro {
						${fun.expr};
						om.dev.MethodProfiler.end( $v{clsName}, $v{methodName} );
						return;
					}
					}
				//} //TODO?
			default: //{}; //TODO?
			}
		}
		return fields;
	}

	/**
		Recursive function which tunnels into a function's expressions and replace any occurrances of a return expression with a custom profiling return expressions

		@param expr The expression to recursively search through
		@return	The transformed expression
	*/
	static function remapReturn( expr : Expr ) : Expr {
		lastWasReturn = false;
		switch expr.expr {
		case EReturn(retExpr):
			lastWasReturn = true;
			if( retExpr == null ) {
				return macro {
					om.dev.MethodProfiler.end( $v{clsName}, $v{methodName} );
					return;
				};
			} else {
				return macro {
					var ___temp_profiling_return_value__ = ${retExpr};
					om.dev.MethodProfiler.end( $v{clsName}, $v{methodName} );
					return ___temp_profiling_return_value__;
				};
			}
		case _:
			return ExprTools.map( expr, remapReturn );
		}
	}

	#end

}
