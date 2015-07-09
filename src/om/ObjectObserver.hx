package om;

@:enum private abstract ChangeType(String) {
    var add = "add";
    var update = "update";
    var delete = "delete";
    var reconfigure = "reconfigure";
    var setPrototype = "setPrototype";
    var preventExtensions = "preventExtensions";
}

private typedef Change<O,T> = {
    var name : String;
    var object : O;
    var type : ChangeType;
    var oldValue : T;
}

/**
    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/observe
*/
class ObjectObserver {

    public static inline function observe<O,T>( obj : O, fun : Array<Change<O,T>>->Void, ?acceptList : Array<ChangeType> ) {
        if( acceptList == null ) acceptList = [];
        untyped Object.observe( obj, fun, acceptList );
    }

}
