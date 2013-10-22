package om.io;

@:require(sys)
typedef File =
	#if cpp cpp.io.File;
	#elseif cs cs.io.File;
	#elseif neko neko.io.File;
	#elseif java java.io.File;
	#elseif php php.io.File;
	#end
