package om.xml.rss;

/**
	Optional sub element of item.
	guid stands for globally unique identifier.
	It's a string that uniquely identifies the item.
	When present, an aggregator may choose to use this string to determine if an item is new.
*/
typedef Guid = {
	var isPermaLink : String;
	var value : String;
}
