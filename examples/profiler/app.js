(function (console, $global) { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var MyApp = function() {
	om_MethodProfiler.start("MyApp","new");
	om_MethodProfiler.end("MyApp","new");
	return;
};
MyApp.__name__ = true;
MyApp.prototype = {
	doSomething: function(n) {
		if(n == null) n = 10000000;
		om_MethodProfiler.start("MyApp","doSomething");
		var q = 0.0;
		var _g = 0;
		while(_g < n) {
			var i = _g++;
			q += 3.14159;
		}
		om_MethodProfiler.end("MyApp","doSomething");
		return;
	}
	,doSomethingElse: function(x) {
		om_MethodProfiler.start("MyApp","doSomethingElse");
		try {
			if(x == 0) {
				var ___temp_profiling_return_value__ = 0;
				om_MethodProfiler.end("MyApp","doSomethingElse");
				return ___temp_profiling_return_value__;
			} else if(x == 1) throw new js__$Boot_HaxeError("derp");
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			if( js_Boot.__instanceof(e,String) ) {
				var ___temp_profiling_return_value__1 = 1;
				om_MethodProfiler.end("MyApp","doSomethingElse");
				return ___temp_profiling_return_value__1;
			} else throw(e);
		}
		var ___temp_profiling_return_value__2;
		switch(x) {
		case 2:
			___temp_profiling_return_value__2 = 2;
			break;
		case 3:
			___temp_profiling_return_value__2 = 3;
			break;
		default:
			___temp_profiling_return_value__2 = 4;
		}
		om_MethodProfiler.end("MyApp","doSomethingElse");
		return ___temp_profiling_return_value__2;
	}
	,__class__: MyApp
};
var AnotherApp = function() {
	om_MethodProfiler.start("AnotherApp","new");
	om_MethodProfiler.end("AnotherApp","new");
	return;
};
AnotherApp.__name__ = true;
AnotherApp.prototype = {
	doSomething: function(n) {
		if(n == null) n = 10000000;
		om_MethodProfiler.start("AnotherApp","doSomething");
		var q = 0.0;
		var _g = 0;
		while(_g < n) {
			var i = _g++;
			q += 3.14159;
		}
		om_MethodProfiler.end("AnotherApp","doSomething");
		return;
	}
	,doSomethingElse: function(x) {
		om_MethodProfiler.start("AnotherApp","doSomethingElse");
		try {
			if(x == 0) {
				var ___temp_profiling_return_value__ = 0;
				om_MethodProfiler.end("AnotherApp","doSomethingElse");
				return ___temp_profiling_return_value__;
			} else if(x == 1) throw new js__$Boot_HaxeError("derp");
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			if( js_Boot.__instanceof(e,String) ) {
				var ___temp_profiling_return_value__1 = 1;
				om_MethodProfiler.end("AnotherApp","doSomethingElse");
				return ___temp_profiling_return_value__1;
			} else throw(e);
		}
		var ___temp_profiling_return_value__2;
		switch(x) {
		case 2:
			___temp_profiling_return_value__2 = 2;
			break;
		case 3:
			___temp_profiling_return_value__2 = 3;
			break;
		default:
			___temp_profiling_return_value__2 = 4;
		}
		om_MethodProfiler.end("AnotherApp","doSomethingElse");
		return ___temp_profiling_return_value__2;
	}
	,__class__: AnotherApp
};
var App = function() { };
App.__name__ = true;
App.update = function(time) {
	window.requestAnimationFrame(App.update);
	App.myApp.doSomething();
	App.myApp.doSomethingElse(0);
	App.myApp.doSomethingElse(1);
	App.myApp.doSomethingElse(2);
	App.anotherApp.doSomething();
	App.anotherApp.doSomethingElse(0);
	App.anotherApp.doSomethingElse(1);
	App.anotherApp.doSomethingElse(2);
	App.gui.addData();
};
App.main = function() {
	App.gui = new om_MethodProfilerGUI(window.document.body);
	App.myApp = new MyApp();
	App.anotherApp = new AnotherApp();
	window.requestAnimationFrame(App.update);
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Lambda = function() { };
Lambda.__name__ = true;
Lambda.count = function(it,pred) {
	var n = 0;
	if(pred == null) {
		var $it0 = $iterator(it)();
		while( $it0.hasNext() ) {
			var _ = $it0.next();
			n++;
		}
	} else {
		var $it1 = $iterator(it)();
		while( $it1.hasNext() ) {
			var x = $it1.next();
			if(pred(x)) n++;
		}
	}
	return n;
};
Math.__name__ = true;
var haxe_IMap = function() { };
haxe_IMap.__name__ = true;
var haxe_ds__$StringMap_StringMapIterator = function(map,keys) {
	this.map = map;
	this.keys = keys;
	this.index = 0;
	this.count = keys.length;
};
haxe_ds__$StringMap_StringMapIterator.__name__ = true;
haxe_ds__$StringMap_StringMapIterator.prototype = {
	hasNext: function() {
		return this.index < this.count;
	}
	,next: function() {
		return this.map.get(this.keys[this.index++]);
	}
	,__class__: haxe_ds__$StringMap_StringMapIterator
};
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__name__ = true;
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,existsReserved: function(key) {
		if(this.rh == null) return false;
		return this.rh.hasOwnProperty("$" + key);
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
	,iterator: function() {
		return new haxe_ds__$StringMap_StringMapIterator(this,this.arrayKeys());
	}
	,__class__: haxe_ds_StringMap
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js_Boot.__nativeClassName(o);
		if(name != null) return js_Boot.__resolveNativeClass(name);
		return null;
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) return true;
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var om_MethodProfiler = function() { };
om_MethodProfiler.__name__ = true;
om_MethodProfiler.get_numProfiles = function() {
	var n = 0;
	var $it0 = om_MethodProfiler.profiles.iterator();
	while( $it0.hasNext() ) {
		var p = $it0.next();
		n += Lambda.count(p);
	}
	return n;
};
om_MethodProfiler.start = function(className,methodName) {
	var cProfile = om_MethodProfiler.profiles.get(className);
	if(cProfile == null) om_MethodProfiler.profiles.set(className,cProfile = new haxe_ds_StringMap());
	var mProfile = null;
	if(mProfile == null) cProfile.set(methodName,mProfile = { calls : 0, timeStart : 0, timeElapsed : 0});
	if(om_MethodProfiler.debug) console.log("> start " + className + "." + methodName);
	mProfile.timeStart = window.performance.now();
	mProfile.calls++;
};
om_MethodProfiler.end = function(className,methodName) {
	var cProfile = om_MethodProfiler.profiles.get(className);
	if(cProfile == null || !(__map_reserved[methodName] != null?cProfile.existsReserved(methodName):cProfile.h.hasOwnProperty(methodName))) throw new js__$Boot_HaxeError("om.MethodProfiler.end called on a function that was never started [" + className + "." + methodName + "]");
	var mProfile;
	mProfile = __map_reserved[methodName] != null?cProfile.getReserved(methodName):cProfile.h[methodName];
	mProfile.timeElapsed += window.performance.now() - mProfile.timeStart;
	if(om_MethodProfiler.debug) console.log("< end   " + className + "." + methodName);
};
om_MethodProfiler.result = function(resetProfiles) {
	if(resetProfiles == null) resetProfiles = true;
	var result = { time : 0.0, classes : []};
	var $it0 = om_MethodProfiler.profiles.keys();
	while( $it0.hasNext() ) {
		var cName = $it0.next();
		var cProfile = om_MethodProfiler.profiles.get(cName);
		var cProfileResult = { name : cName, time : 0.0, methods : []};
		var $it1 = cProfile.keys();
		while( $it1.hasNext() ) {
			var mName = $it1.next();
			var mProfile;
			mProfile = __map_reserved[mName] != null?cProfile.getReserved(mName):cProfile.h[mName];
			cProfileResult.methods.push({ name : mName, time : mProfile.timeElapsed, calls : mProfile.calls});
		}
		result.classes.push(cProfileResult);
	}
	if(resetProfiles) om_MethodProfiler.profiles = new haxe_ds_StringMap();
	return result;
};
om_MethodProfiler.toString = function(resetProfiles) {
	if(resetProfiles == null) resetProfiles = true;
	if(om_MethodProfiler.get_numProfiles() == 0) return "0 profiles";
	var str = "";
	var totalTime = 0.0;
	var $it0 = om_MethodProfiler.profiles.keys();
	while( $it0.hasNext() ) {
		var cName = $it0.next();
		var cProfile = om_MethodProfiler.profiles.get(cName);
		var cTime = 0.0;
		str += cName + "\n";
		var $it1 = cProfile.keys();
		while( $it1.hasNext() ) {
			var methodName = $it1.next();
			var mProfile;
			mProfile = __map_reserved[methodName] != null?cProfile.getReserved(methodName):cProfile.h[methodName];
			var info = "\t." + methodName + ": " + mProfile.timeElapsed + " (" + mProfile.calls + " call";
			if(mProfile.calls != 1) info += "s";
			info += ")";
			str += info + "\n";
			cTime += mProfile.timeElapsed;
		}
		str += "---\n" + cTime + "s";
		totalTime += cTime;
	}
	str += "\nTotal time: " + totalTime;
	if(resetProfiles) om_MethodProfiler.profiles = new haxe_ds_StringMap();
	return str;
};
om_MethodProfiler.toHTML = function(resetProfiles,precision) {
	if(precision == null) precision = 5;
	if(resetProfiles == null) resetProfiles = true;
	var totalTime = 0.0;
	var str = "<div>";
	var $it0 = om_MethodProfiler.profiles.keys();
	while( $it0.hasNext() ) {
		var cName = $it0.next();
		var cProfile = om_MethodProfiler.profiles.get(cName);
		var cTime = 0.0;
		str += "<div>" + cName + "</div>";
		var $it1 = cProfile.keys();
		while( $it1.hasNext() ) {
			var methodName = $it1.next();
			var mProfile;
			mProfile = __map_reserved[methodName] != null?cProfile.getReserved(methodName):cProfile.h[methodName];
			var info = "" + methodName + ": " + om_MethodProfiler.formatTimeValue(mProfile.timeElapsed,precision) + " (" + mProfile.calls + " call";
			if(mProfile.calls != 1) info += "s";
			info += ")";
			str += "<div style=\"margin-left:10px;\">" + info + "</div>";
			cTime += mProfile.timeElapsed;
		}
		totalTime += cTime;
		str += "<div>---</div>";
		str += "<div>" + om_MethodProfiler.formatTimeValue(cTime,precision) + "</div>";
	}
	str += "<div>Total time: " + om_MethodProfiler.formatTimeValue(totalTime,precision) + "</div>";
	str += "</div>";
	if(resetProfiles) om_MethodProfiler.profiles = new haxe_ds_StringMap();
	return str;
};
om_MethodProfiler.reset = function() {
	om_MethodProfiler.profiles = new haxe_ds_StringMap();
};
om_MethodProfiler.formatTimeValue = function(v,precision) {
	var s;
	if(v == null) s = "null"; else s = "" + v;
	var len = s.indexOf(".") + precision;
	return HxOverrides.substr(s,0,len);
};
var om_MethodProfilerGUI = function(container) {
	var _this = window.document;
	this.element = _this.createElement("div");
	container.appendChild(this.element);
};
om_MethodProfilerGUI.__name__ = true;
om_MethodProfilerGUI.prototype = {
	addData: function() {
		this.element.innerHTML = om_MethodProfiler.toHTML();
	}
	,__class__: om_MethodProfilerGUI
};
var om_Time = function() { };
om_Time.__name__ = true;
om_Time.now = function() {
	return window.performance.now();
};
function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
var __map_reserved = {}
App.__meta__ = { statics : { update : { noProfile : null}, main : { noProfile : null}}};
js_Boot.__toStr = {}.toString;
om_MethodProfiler.profiles = new haxe_ds_StringMap();
om_MethodProfiler.debug = false;
App.main();
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
