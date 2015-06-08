package om.haxe;

class HaxeCompiler {

    #if sys
    //TODO

    #elseif nodejs

	/**
        HACK Haxe exits with error code 1 when asked for version.
    */
    /*
    public static inline function getVersion( onResult : String->Void, onError : String->Void ) {
        spawn( 'haxe', ['-version'],
            function(e){
                onResult( e.toString().trim() );
            },
            function(e){
                //TODO validate
                var err = e.toString().trim();
                onResult( err );
            }
        );
    }
    */

	public static function compile( params : Array<String>, cb : String->String->Void ) {
		spawn( 'haxe', params,
            function(e) cb( e, null ),
            function(e) cb( null, e )
		);
	}

    static function spawn( cmd : String, args : Array<String>, onError : String->Void, onData : String->Void ) {
        var proc = js.node.ChildProcess.spawn( cmd, args );
        //trace(proc.pid);
        proc.stderr.on( 'data', function(e) {
            onError( e.toString() );
            //try proc.kill( 'SIGKILL' ) catch(e:Dynamic) {}
        });
        proc.stdout.on( 'data', function(e) {
            onData( e.toString() );
            //try proc.kill( 'SIGKILL' ) catch(e:Dynamic) {}
        });
    }

    #end

}
