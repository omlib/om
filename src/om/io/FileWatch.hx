package om.io;

import js.node.Fs;
import js.node.fs.FSWatcher;
import haxe.crypto.Md5;
import haxe.ds.StringMap;

using Lambda;
using om.io.FileUtil;

typedef WatchOptions = {
    @:optional var persistent : Bool;
    @:optional var recursive : Bool;
    @:optional var ignored : Array<String>;
}

typedef FileSystemEvent = {
    var type : String;
    var path : String;
}

/**
    Watches given filesystem path for changes.
    It uses a md5-sum map to compare if files have changed for real since the nodejs implementation of fs.watch is that shitty and reports every event twice.
*/
class FileWatch {

    public var active(default,null) : Bool;
    public var numWatches(get,null) : Int;

    var watches : Array<FSWatcher>;
    var sums : StringMap<String>;

    public function new() {
        active = false;
        watches = [];
        sums = new StringMap();
    }

    inline function get_numWatches() : Int return watches.length;

    public function start( path : String, ?options : WatchOptions, callback : FileSystemEvent->Void ) {
        active = true;
        if( path.isDirectory() )
            watchDirectory( path, options, callback );
        else
            watchFile( path, options, callback );
    }

    public function stop() {
        for( watch in watches )
            watch.close();
        watches = [];
        sums = new StringMap();
    }

    function watchFile( path : String, ?options : WatchOptions, callback : FileSystemEvent->Void ) {
        if( options != null && options.ignored != null ) {
            if( options.ignored.has( path ) ) {
                trace( "IGNORED: "+path );
                return;
            }
        }
        var watch = Fs.watch( path, function(e,f) {
            var sum = md5( path );
            if( sums.exists( path ) ) {
                if( sums.get( path ) != sum ) {
                    sums.set( path, sum );
                    callback( { type:e, path:path } );
                }
            } else {
                sums.set( path, sum );
                callback( { type:e, path:path } );
            }
        });
        watches.push( watch );
    }

    function watchDirectory( path : String, ?options : WatchOptions, callback : FileSystemEvent->Void ) {
        for( f in path.readDirectory() ) {
            if( options != null && options.ignored != null ) {
                if( options.ignored.has( f ) ) {
                    trace("IGNORED: "+f );
                    continue;
                }
            }
            var p = '$path/$f';
            if( p.isDirectory() ) {
                /*
                Fs.watch( p, {persistent:true,recursive:true}, function(e,f){
                    callback( { type:e, path:'$p/$f' } );
                });
                */
                watchDirectory( p, options, callback );
            } else {
                watchFile( p, options, callback );
            }
        }
    }

    static function md5( path : String ) : String {
        return Md5.encode( Fs.readFileSync( path, {encoding:'utf8'} ) );
    }
}
