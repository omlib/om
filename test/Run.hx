
import js.Browser.document;
import js.Browser.window;

class Run {

	static function main() {

		window.onload = function(_){

			var r = new haxe.unit.TestRunner();
			r.add( new TestBase64() );
			r.run();

			document.body.textContent = r.result.toString();
		}
		
	}

}
