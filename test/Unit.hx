
class Unit {

	static var TESTS : Array<Class<haxe.unit.TestCase>> = [

		#if sys
		//TestFileSync

		#elseif nodejs

		#elseif js
		//TestStateMachine,
		//TestDOMTools

		#end
	];

	static function start() {

		var r = new haxe.unit.TestRunner();
		for( test in TESTS ) r.add( Type.createInstance( test, [] ) );
		r.run();

		#if (js&&!nodejs)
		js.Browser.document.body.textContent = r.result.toString();
		#end
	}

	static function main() {
		#if (sys||nodejs)
		start();
		#elseif js
		js.Browser.window.onload = function(_){
			js.Browser.document.body.innerHTML = '';
			start();
		}
		#end
	}

}
