package om.sys;

@:enum
abstract TermColor(Int) from Int to Int {
    var def = 39;
    var black = 30;
    var red = 31;
    var green = 32;
    var yellow = 33;
    var blue = 34;
    var magenta = 35;
    var cyan = 36;
    var grey_light = 37;
    var grey_dark = 90;
    var white = 97;
}
