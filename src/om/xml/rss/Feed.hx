package om.xml.rss;

/**
	Really Simple Syndication.

	Subordinate to the <rss> element is a single <channel> element,
	which contains information about the channel (metadata) and its contents.
*/
class Feed {
	
	public static inline var VERSION = "2.0";
	
	/** RSS namespaces */
	public var xmlns : Hash<String>;
	public var channel : Channel;
	
	public function new() {
		channel = new Channel();
		xmlns = new Hash();
	}

	public function toXml() : Xml {
		if( channel == null )
			throw "Missing channel element";
		var x = Xml.createElement( "rss" );
		x.set( "version", Feed.VERSION );
		x.addChild( channel.toXml() );
		return x;
	}
	
	public inline function toString() : String {
		return toXml().toString();
	}
	
	public static function parse( x : Xml ) : format.rss.Feed {
		if( x.get( "version" ) != VERSION )
			throw "RSS version has to be "+VERSION;
		var rss = new Feed();
		// parse RSS namespaces
		for( a in x.attributes() )
			if( a.substr( 0, 5 ) == "xmlns" )
				rss.xmlns.set( a.substr( 6 ), x.get( a ) );
		// parse channel
		var ch = x.firstElement();
		if( ch.nodeName != "channel" )
			throw "Channel element missing";
		rss.channel = Channel.parse( ch );
		return rss;
	}
	
	/*
	public static function isValid( src : Xml ) : Bool {
		var myRule : haxe.xml.Rule = RNode('rss',[Attrib.att("version")],
              						 	RNode('channel',[], RNode('channelChildsEReg',[],RData()) ) );
		return false;
	}
	*/
	
}
