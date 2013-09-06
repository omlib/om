package om.xml.rss;

/**
	Optional sub element of channel.
	The purpose of the <textInput> element is something of a mystery.
	You can use it to specify a search engine box. Or to allow a reader to provide feedback.
	Most aggregators ignore it.
*/
typedef TextInput = {
	var title : String;
	var description : String;
	var name : String;
	var link : String;
}
