package om.social;

import js.Browser.window;

class Twitter {

    public static function createTweetURL( ?text : String, ?url : String, ?via : String ) : String {
        var str = 'https://twitter.com/intent/tweet?';
        if( text != null ) str += 'text=$text';
        if( url != null ) str += 'url=$url';
        if( via != null ) str += 'via=$via';
        return str;
    }

}
