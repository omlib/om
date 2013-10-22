package thx.sys;

@:require(sys)
typedef FileSystem =
	#if cpp cpp.FileSystem;
	#elseif cs cs.FileSystem;
	#elseif neko neko.FileSystem;
	#elseif java java.FileSystem;
	#elseif php php.FileSystem;
	#end
