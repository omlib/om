package om.social;

using StringTools;

class Twitter {

    public static inline var BASE_URL = 'https://twitter.com';
    public static inline var BASE_TWEET_URL = BASE_URL+'/intent/tweet?';

    /**
        Usage example: window.open( Twitter.createTweetURL( 'My text to tweet', 'http://disktree.net' ), '', 'width=618,height=382' );
    */
    public static function createTweetURL( ?text : String, ?url : String, ?via : String ) : String {
        var str = BASE_TWEET_URL;
        if( text != null ) str += '&text=' + text.urlEncode();
        if( url != null ) str += '&url=' + url.urlEncode();
        if( via != null ) str += '&via=' + via.urlEncode();
        return str;
    }

}
