package om.net;

class PortCheck {

    /**
        Reports boolean if the given port is in use or null if not sure.
    */
    public static function isPortInUse( port : Int, ?host : String, callback : Bool->Void ) {
        if( host == null ) host = '127.0.0.1';
        var server = js.node.Net.createServer( function(_){} );
        var onListen : Void->Void;
        var onError : Dynamic->Void;
        onListen = function() {
            server.removeListener( 'error', onError );
            server.close();
            callback( false );
        }
        onError = function(e) {
            server.removeListener( 'listening', onListen );
            callback( (e.code == 'EADDRINUSE') ? true : null );
        }
        server.once( 'error', onError );
        server.once( 'listening', onListen );
        server.listen( port, host );
    }

}
