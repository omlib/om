package om.xml.rss;

/**
	Optional sub element of item.
	The purpose of this element is to propagate credit for links, to publicize the sources of news items.
	It can be used in the Post command of an aggregator.
	It should be generated automatically when forwarding an item from an aggregator to a weblog authoring tool.
*/
typedef Source = {
	var url : String;
	var value : String;
}
