package om.xml.rss;

/**
	Optional sub element of item.
	It has three required attributes. url says where the enclosure is located, length says how big it is in bytes,
	and type says what its type is, a standard MIME type.
	The url must be an http url.
*/
typedef Enclosure = {
	var url : String;
	var length : String;
	var type : String;
}
