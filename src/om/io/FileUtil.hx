package om.io;

#if (sys||nodejs)

#if sys
import sys.FileSystem;
import sys.io.File;
#elseif nodejs
import js.node.Fs;
#end

using StringTools;
using haxe.io.Path;

/**
	File system helpers.
*/
class FileUtil {

	/**
		Returns the relative path to the given absolute path.
	*/
	public static function getRelativePath( absolutePath : String, ?cwd : String ) : String {
		if( cwd == null ) cwd = Sys.getCwd();
		if( absolutePath.startsWith( '/' ) ) absolutePath = absolutePath.substr(1);
		absolutePath = absolutePath.removeTrailingSlashes();
		if( cwd.startsWith( '/' ) ) cwd = cwd.substr(1);
		cwd = cwd.removeTrailingSlashes();
		var aParts = absolutePath.split( '/' );
		var cParts = cwd.split( '/' );
		var i = 0;
		while( i < aParts.length ) {
			if( aParts[i] != cParts[i] ) break else i++;
		}
		var n = cParts.length - i;
		var path = aParts.slice( i );
		for( i in 0...n ) path.unshift(  '..' );
		return path.join('/');
	}

	////////////////////////////////////////////////////////////////////////////

	#if sys

	public static inline function size( path : String ) : Int {
		return FileSystem.stat( path ).size;
	}

	public static inline function modTime( path : String ) : Float {
		return FileSystem.stat( path ).mtime.getTime();
	}

	public static function readDirectoryContent( path : String ) : String {
		var buf = new StringBuf();
		for( f in FileSystem.readDirectory( path ) )
			buf.add( File.getContent( '$path/$f' ) );
		return buf.toString();
	}

	public static function deleteDirectory( path : String, recursive = true ) {
		//if( !FileSystem.exists( path ) )
		//	return;
		for( f in FileSystem.readDirectory( path ) ) {
			var fp = '$path/$f';
			if( FileSystem.isDirectory( fp ) ) {
				if( recursive ) deleteDirectory( fp, recursive );
			} else {
				FileSystem.deleteFile( fp );
			}
		}
		FileSystem.deleteDirectory( path );
	}

	public static function directoryExistsOrCreate( path : String ) : Bool {
		if( !FileSystem.exists( path ) ) {
			FileSystem.createDirectory( path );
			return true;
		}
		#if dev
		else if( !FileSystem.isDirectory( path ) )
			Console.warn( 'Not a directory [$path]' );
		#end
		return false;
	}

	////////////////////////////////////////////////////////////////////////////

	#elseif nodejs

	//public static function deleteDirectory( path : String, recursive = true, cb : String->Void ) {

	public static function deleteDirectorySync( path : String, recursive = true ) {
        for( f in Fs.readdirSync( path ) ) {
            var p = '$path/$f';
            if( Fs.lstatSync( p ).isDirectory() ) {
				if( recursive ) deleteDirectorySync( p, recursive );
			} else Fs.unlinkSync( p );
        }
        Fs.rmdirSync( path );
    }

	public static function directoryExistsOrCreate( path : String, ?cb : Bool->Void ) {
		Fs.exists( path, function(exists){
			exists ? cb( true ) : Fs.mkdir( path, function(e) cb( false ) );
		});
	}

	public static function directoryExistsOrCreateSync( path : String ) : Bool {
		if( Fs.existsSync( path ) )
			return true;
		Fs.mkdirSync( path );
		return false;
	}

	#end

}

#end
