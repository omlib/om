package om.io;

import sys.FileSystem;
import sys.io.File;

class FileUtil {

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
		if( !FileSystem.exists( path ) )
			return;
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

}
