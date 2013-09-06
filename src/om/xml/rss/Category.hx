package om.xml.rss;

/**
	Optional sub element of item.
	It has one optional attribute, domain, a string that identifies a categorization taxonomy.
	The value of the element is a forward-slash-separated string that identifies a hierarchic location in the indicated taxonomy.
	Processors may establish conventions for the interpretation of categories.
*/
typedef Category = {
	var value : String;
	var domain : String;
}
