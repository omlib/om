package om.xml.rss;

/**
	Optional sub element of channel.
	It specifies a web service that supports the rssCloud interface which can be implemented in HTTP-POST, XML-RPC or SOAP 1.1.
	Its purpose is to allow processes to register with a cloud to be notified of updates to the channel,
	implementing a lightweight publish-subscribe protocol for RSS feeds.
*/
typedef Cloud = {
	var domain : String;
	var port : Int;
	var path : String;
	var registerProcedure : String;
	var protocol : String;
}
