package om.util;

/**
    http://www.html5rocks.com/en/tutorials/workers/basics/#toc-inlineworkers
*/
class WorkerUtil {

    public static inline function createInlineWorkerURL( script : String ) : String {
        return untyped js.Browser.window.URL.createObjectURL( new js.html.Blob([script]) );
    }

    public static inline function revokeInlineWorkerURL( url : String ) {
        untyped js.Browser.window.URL.revokeObjectURL( url );
    }

}
