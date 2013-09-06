package om.xml.rss;

import util.XMLUtil;

/**
	RSS2.0 channel.
*/
class Channel {
	
	public var title : String;
	public var link : String;
	public var description : String;
	//
	public var language : String;
	public var copyright : String;
	public var managingEditor : String;
	public var webMaster : String;
	public var pubDate : String;
	public var lastBuildDate : String;
	public var categories : Array<Category>;
	public var generator : String;
	public var docs : String;
	public var cloud : Cloud;
	public var ttl : String;
	public var image : Image;
	public var rating : String;
	public var textInput : TextInput;
	public var skipHours : Array<String>;
	public var skipDays : Array<String>;
	//
	public var items : Array<Item>;
	
	public function new( ?src : Xml ) {
		categories = new Array();
		skipHours = new Array();
		skipDays = new Array();
		items = new Array();
	}
	
	public function toXml() : Xml {
		var x = Xml.createElement( "channel" );
		if( title != null ) 		x.addChild( XMLUtil.createElement( "title", title ) );
		if( link != null ) 			x.addChild( XMLUtil.createElement( "link", link ) );
		if( description != null ) 	x.addChild( XMLUtil.createElement( "description", description ) );
		if( language != null ) 		x.addChild( XMLUtil.createElement( "language", language ) );
		if( copyright != null ) 	x.addChild( XMLUtil.createElement( "copyright", link ) );
		if( managingEditor != null )x.addChild( XMLUtil.createElement( "managingEditor", managingEditor ) );
		if( webMaster != null ) 	x.addChild( XMLUtil.createElement( "webMaster", title ) );
		if( pubDate != null ) 		x.addChild( XMLUtil.createElement( "pubDate", pubDate ) );
		if( lastBuildDate != null ) x.addChild( XMLUtil.createElement( "lastBuildDate", description ) );
//		if( categories.length > 0 ) //TODO
		if( generator != null ) 	x.addChild( XMLUtil.createElement( "generator", generator ) );
		if( docs != null ) 			x.addChild( XMLUtil.createElement( "docs", docs ) );
//		if( cloud != null )			//TODO x.addChild( createElement( "cloud", managingEditor ) );
		if( ttl != null ) 			x.addChild( XMLUtil.createElement( "ttl", ttl ) );
//		if( image != null ) 		//TODO x.addChild( createElement( "pubDate", link ) );
		if( rating != null ) 		x.addChild( XMLUtil.createElement( "rating", rating ) );
//		if( textInput != null ) 	//TODO x.addChild( createElement( "webMaster", title ) );
//		if( skipHours != null ) 	//x.addChild( createElement( "skipHours", skipHours ) );
//		if( skipDays != null ) 		//x.addChild( createElement( "skipDays", skipDays ) );
//		if( categories.length > 0 ) //?
		for( item in items )
			x.addChild( item.toXml() );
		return x;
	}
	
	public inline function toString() : String {
		return toXml().toString();
	}
	
	//function resolveSimple( f : String ) {
		//TODO
	//}
	
	public static function parse( x : Xml ) : Channel {
		var f = new haxe.xml.Fast( x );
		var hasNode = f.hasNode;
		var c = new Channel();
		if( !hasNode.title || !hasNode.link || !hasNode.description )
			throw "Missing title, link or description channel element";
		var n = f.node;
		c.title = n.title.innerData;
		c.description = n.description.innerData;
		c.link = n.link.innerData;
		if( hasNode.language ) c.language = n.language.innerData;
		if( hasNode.copyright ) c.copyright = n.copyright.innerData;
		if( hasNode.managingEditor ) c.managingEditor = n.managingEditor.innerData;
		if( hasNode.webMaster ) c.webMaster = n.webMaster.innerData;
		if( hasNode.pubDate ) c.pubDate = n.pubDate.innerData;
		if( hasNode.lastBuildDate ) c.lastBuildDate = n.lastBuildDate.innerData;
		for( p in f.nodes.category )
       		c.categories.push( { domain : p.att.domain, value :  p.innerData } ); 
		if( hasNode.generator ) c.generator = n.generator.innerData;
		if( hasNode.docs ) c.docs = n.docs.innerData;
		if( hasNode.cloud )	c.cloud = { domain : n.cloud.att.domain,
										port : Std.parseInt( n.cloud.att.port ),
										path : n.cloud.att.path,
										registerProcedure : n.cloud.att.registerProcedure,
										protocol : n.cloud.att.protocol };
		if( hasNode.ttl ) c.ttl = n.ttl.innerData;
		if( hasNode.image ) c.image = { title : n.image.node.title.innerData,
										url : n.image.node.url.innerData,
										link : n.image.node.link.innerData,
									 	width : Std.parseInt( n.image.node.width.innerData ),
										height : Std.parseInt( n.image.node.height.innerData ),
										description : n.image.node.description.innerData };
		if( hasNode.rating ) c.rating = n.rating.innerData;
		if( hasNode.textInput ) c.textInput = { title : n.textInput.node.title.innerData,
												description : n.textInput.node.description.innerData,
												name : n.textInput.node.name.innerData,
												link : n.textInput.node.link.innerData };
		if( hasNode.skipHours ) 
			for( hour in n.skipHours.nodes.hour )
				c.skipHours.push( hour.innerData );
		if( hasNode.skipDays ) 
			for( day in n.skipDays.nodes.day )
				c.skipDays.push( day.innerData );
		for( i in f.nodes.item )
			c.items.push( Item.parse( i.x ) );
		return c;
	}
	
}
