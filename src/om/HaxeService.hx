package om.sys;

#if sys
import sys.io.Process;
#end

class HaxeService {

	#if nodejs

	/**
        HACK Haxe exits with error code 1 when asked for version.
    */
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

    public static function isPortInUse( port : Int, cb : Bool->Void ) {
        spawn( 'lsof', ['-Pni4'],
            function(e) cb( new EReg( 'TCP [^:]+:$port [(]', '' ).match( e.toString() ) ),
            function(e) cb(false)
        );
	}

    public static function isPortUsedByHaxe( port : Int, cb : Bool->Void ) {
        spawn( 'lsof', ['-Pni4'],
            function(e) cb(  new EReg( '^haxe\\s+\\d+[^:]+[:]$port\\s+\\(LISTEN\\)', 'm' ).match( e.toString() ) ),
            function(e) cb(false)
        );
	}

    static function spawn( cmd : String, args : Array<String>, onData : String->Void, ?onError : String->Void ) {
        var proc = js.node.ChildProcess.spawn( cmd, args );
        proc.stdout.on( 'data', function(e) onData( e.toString() ) );
        if( onError!= null )
            proc.stderr.on( 'data', function(e) onError( e.toString() ) );
    }

	#elseif sys

	public static function isPortInUse( port : Int ) : Bool {
		var p = new Process('lsof', ['-Pni4']);
		var result = p.stdout.readAll().toString();
		p.close();
		return new EReg( 'TCP [^:]+:$port [(]', '' ).match( result );
	}

	public static function isPortUsedByHaxe( port : Int ) : Bool {
		var cmd = 'lsof -Pni4 | grep LISTEN';
		var p = new Process( 'lsof', ['-Pni4']);
		var result = p.stdout.readAll().toString();
		p.close();
		return new EReg( '^haxe\\s+\\d+[^:]+[:]$port', 'm' ).match( result );
	}

	public static function start( port : Int, background = true, verbose = false ) {
		//TODO
		var cmd = 'haxe --wait $port &';
		Sys.command( cmd );
	}

	public static function compile( hxml : String, ?params : Array<String>, ?port : Int, ?errorFile : String ) {
		var start = Sys.time();
		createErrorFile( errorFile, 'Running `haxe $hxml --connect port`' );
		var p = new Process( 'haxe', [hxml,'--connect','$port']);
		var exitCode = p.exitCode();
		var stderr = p.stderr.readAll().toString();
		var stdout = p.stdout.readAll().toString();
		Sys.println(stderr);
		Sys.println(stdout);
		switch exitCode {
		case 0:
			var timeTaken = Sys.time() - start;
			Sys.println( 'Compiled $hxml in $timeTaken' );
			if( errorFile != null ) FileSystem.deleteFile( errorFile );
		case exitCode:
			Sys.println( 'Failed to compile $hxml:' );
			Sys.println( 'Exit code: $exitCode' );
			createErrorFile( errorFile, '<h1>Error Compiling $hxml</h1><h3>Output:<pre>$stdout\n$stderr</pre>' );
		}
	}

	static function createErrorFile( errorFile : String, content : String ) {
		if( errorFile != null ) {
			var html = '<!DOCTYPE html><html>';
			html += '<head><title>ERROR</title><meta http-equiv="refresh" content="1" /></head>';
			html += '<body class="container">$content</body>';
			html += '</html>';
			File.saveContent( errorFile, html );
		}
	}

	#end

}
