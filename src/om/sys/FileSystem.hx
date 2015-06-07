package om.sys;

#if sys
typedef FileSystem = sys.FileSystem;

#elseif nodejs

import js.node.Fs;
import js.node.Path;

typedef FileStat = {
	/** the user group id for the file **/
	var gid : Int;
	/** the user id for the file **/
	var uid : Int;
	/** the last access time for the file (when enabled by the file system) **/
	var atime : Date;
	/** the last modification time for the file **/
	var mtime : Date;
	/** the creation time for the file **/
	var ctime : Date;
	/** the size of the file **/
	var size : Int;
	var dev : Int;
	var ino : Int;
	var nlink : Int;
	var rdev : Int;
	var mode : Int;
}

/**
    Emulates sys.FileSystem api.
*/
class FileSystem {

    public static inline function absolutePath( relPath : String ) : String {
        return Path.resolve( relPath );
    }

    public static inline function createDirectory( path : String ) {
        Fs.mkdirSync( path );
    }

    public static inline function deleteDirectory( path : String ) {
        Fs.rmdirSync( path );
    }

    public static inline function deleteFile( path : String ) {
        Fs.unlinkSync( path );
    }

    public static inline function exists( path : String ) : Bool {
        return Fs.existsSync( path );
    }

    public static inline function fullPath( relPath : String ) : String {
        return Path.resolve( relPath ); //TODO?
    }

    public static inline function isDirectory( path : String ) : Bool {
        return Fs.lstatSync( path ).isDirectory();
    }

    public static inline function readDirectory( path : String ) : Array<String> {
        return Fs.readdirSync( path );
    }

    public static inline function rename( path : String, newPath : String ) {
        return Fs.renameSync( path, newPath );
    }

    public static inline function stat( path : String ) : FileStat {
        return Fs.statSync( path );
    }
}

#end
