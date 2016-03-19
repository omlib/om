
import js.Browser.document;
import js.Browser.window;
import om.Parallax;

class App {

    static var parallax : Parallax;
    static var numExamples : Int;
    static var exampleIndex : Int;

    static function update( time : Float ) {
        window.requestAnimationFrame( update );
        parallax.update();
    }

    static function handleWindowResize(e) {
    }

    static function handleMouseMove(e) {
        parallax.offsetX = e.clientX / window.innerWidth;
        parallax.offsetY = e.clientY / window.innerHeight;
    }

    static function handleClick(e) {
        if( ++exampleIndex == numExamples ) exampleIndex = 0;
        loadExample( exampleIndex );
    }

    static function loadExample( i : Int ) {

        if( parallax != null ) {
            parallax.clear();
            parallax.element.style.display = 'none';
        }

        var element = document.getElementById( 'example-$i' );
        element.style.display = 'block';
        parallax = Parallax.fromElement( element );
    }

    static function main() {

        window.onload = function(){

            numExamples = document.querySelectorAll( '.parallax' ).length;
            loadExample( exampleIndex = 0 );

            window.requestAnimationFrame( update );
            window.addEventListener( 'resize', handleWindowResize, false );
            window.addEventListener( 'mousemove', handleMouseMove, false );
            window.addEventListener( 'touchmove', handleMouseMove, false );
            window.addEventListener( 'click', handleClick, false );
        }
    }
}
