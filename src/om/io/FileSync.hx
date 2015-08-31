package om.io;

#if sys

import sys.FileSystem;
import sys.FileSystem.exists;
import sys.FileSystem.isDirectory;
import sys.FileSystem.createDirectory;
import sys.FileSystem.readDirectory;
import sys.io.File;
import sys.io.File.copy;

using om.io.FileUtil;

class FileSync {

	/**
		Returns true if target file doesn't exist or is older as source file.
	*/
	public static function needsUpdate( source : String, target : String ) : Bool {
		return !exists( target ) ? true : source.modTime() > target.modTime();
	}

	/**
	*/
	public static function syncFile( source : String, target : String ) : Bool {
		if( !exists( source ) || isDirectory( source ) )
			return false;
		if( needsUpdate( source, target ) ) {
			copy( source, target );
			return true;
		}
		return false;
	}

	/**
	*/
	public static function syncDirectory( source : String, target : String, recursive = true ) : Bool {
		if( !exists( source ) )
			throw 'Source directory not found ($source)';
		if( !exists( target ) )
			createDirectory( target );
		for( f in readDirectory( source ) ) {
			var sp = '$source/$f';
			var tp = '$target/$f';
			if( isDirectory( sp ) ) {
				//if( !exists( target ) ) createDirectory( target );
				if( recursive ) syncDirectory( sp, tp );
			} else {
				if( exists( tp ) ) {
					if( needsUpdate( sp, tp ) ) copy( sp, tp );
				} else {
					copy( sp, tp );
				}
			}
		}
		return true;
	}
}

#end
