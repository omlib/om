package om.xml.rss;

import util.XMLUtil;

/**
	RSS2.0 item.
*/
class Item {
	
	public var title : String;
	public var link : String;
	public var description : String;
	public var content : String; // content:encoded
	public var author : String;
	public var categories : Array<Category>;
	public var comments : String;
	public var enclosure : Enclosure;
	public var guid : Guid;
	public var pubDate : String;
	public var source : Source;
	
	public function new() {
		categories = new Array();
	}
	
	public function toXml() : Xml {
		if( title == null && description == null )
			throw "At least one of title or description must be present";
		var x = Xml.createElement( "item" );
		if( title != null ) x.addChild( XMLUtil.createElement( "title", title ) );
		if( link != null ) x.addChild( XMLUtil.createElement( "link", link ) );
		if( description != null ) x.addChild( XMLUtil.createElement( "description", description ) );
		//if( content != null ) x.addChild( XMLUtil.createElement( "content:encoded", content ) );
		if( content != null ) x.addChild( XMLUtil.createElement( "content", content ) );
		if( author != null ) x.addChild( XMLUtil.createElement( "author", author ) );
		if( categories.length > 0 ) {
			for( c in categories ) {
				var cat = XMLUtil.createElement( "category", c.value );
				if( c.domain != null ) cat.set( "domain", c.domain );
				x.addChild( cat );
			}
		}
		if( comments != null ) x.addChild( XMLUtil.createElement( "comments", comments ) );
		if( enclosure != null ) {
			var e = Xml.createElement( "enclosure" );
			e.set( "url", enclosure.url );
			e.set( "length", enclosure.length );
			e.set( "type", enclosure.type );
			x.addChild( e );
		}
		if( guid != null ) 	{
			var g = XMLUtil.createElement( "guid", guid.value );
			if( guid.isPermaLink != null ) g.set( "isPermaLink", guid.isPermaLink );
			x.addChild( XMLUtil.createElement( "guid", guid.value ) );
		}
		if( pubDate != null ) x.addChild( XMLUtil.createElement( "pubDate", pubDate ) );
		if( source != null ) {
			var s = XMLUtil.createElement( "source", source.value );
			s.set( "url", source.url );
			x.addChild( s );
		}
		return x;
	}
	
	public inline function toString() : String {
		return toXml().toString();
	}
	
	public static function parse( x : Xml ) : Item {
		var i = new Item();
		for( e in x.elements() ) {
			switch( e.nodeName ) {
			case "title" : i.title = e.firstChild().nodeValue;
			case "description" : i.description = e.firstChild().nodeValue;
			case "content:encoded" : i.content = e.firstChild().nodeValue;
			case "link" : i.link = e.firstChild().nodeValue;
			case "author" : i.author = e.firstChild().nodeValue;
	//TODO		
	//		case "comments" : i.comments = e.firstChild().nodeValue;
	//		case "enclosure" : i.author = e.firstChild().nodeValue;
	//		case "guid" : i.guid = e.firstChild().nodeValue;
			case "pubDate" : i.pubDate = e.firstChild().nodeValue;
	//		case "source" : i.author = e.firstChild().nodeValue;
			}
		}
		return i;
	}
	
}