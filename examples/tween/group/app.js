(function (console) { "use strict";
var App = function() { };
App.__name__ = true;
App.animate = function() {
	App.target.style.left = Std.string(App.position.x) + "px";
	App.target.style.top = Std.string(App.position.y) + "px";
	App.target.style.transform = "rotate(" + Math.floor(App.position.rotation) + "deg)";
};
App.update = function(time) {
	window.requestAnimationFrame(App.update);
	om__$TweenGroup_TweenGroup_$Impl_$.update(App.group,time);
};
App.main = function() {
	window.onload = function(_) {
		App.position = { x : 100, y : 100, rotation : 0};
		App.target = window.document.getElementById("target");
		App.group = [];
		var tween = new om_Tween2(App.position).to({ x : 700, y : 200, rotation : 359},2000).onUpdate(App.animate);
		tween.start();
		App.group.push(tween);
		window.requestAnimationFrame(App.update);
	};
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		return null;
	}
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
var om_Tween2 = function(target) {
	this.repeat = 0;
	this.easingFunction = om_easing_Linear.None;
	this.delayTime = 0.0;
	this.startTime = 0.0;
	this.isPlaying = false;
	this.target = target;
};
om_Tween2.__name__ = true;
om_Tween2.prototype = {
	to: function(properties,duration) {
		if(duration == null) duration = 1000.0;
		this.duration = duration;
		this.valuesEnd = properties;
		return this;
	}
	,start: function(time) {
		om_Tween2.list.push(this);
		this.isPlaying = true;
		this.onStartCallbackFired = false;
		this.startTime = time != null?time:window.performance.now();
		this.startTime += this.delayTime;
		this.valuesStart = { };
		var _g = 0;
		var _g1 = Reflect.fields(this.valuesEnd);
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			var value = Reflect.field(this.target,f);
			this.valuesStart[f] = value;
		}
		return this;
	}
	,update: function(time) {
		if(time < this.startTime) return true;
		if(!this.onStartCallbackFired) {
			if(this.onStartCallback != null) this.onStartCallback();
			this.onStartCallbackFired = true;
		}
		var elapsed = (time - this.startTime) / this.duration;
		elapsed = elapsed > 1?1:elapsed;
		var value = this.easingFunction(elapsed);
		var _g = 0;
		var _g1 = Reflect.fields(this.valuesEnd);
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			var start = Reflect.field(this.valuesStart,f);
			if(start == null) start = 0;
			var end = Reflect.field(this.valuesEnd,f);
			this.target[f] = start + (end - start) * value;
		}
		if(this.onUpdateCallback != null) this.onUpdateCallback();
		if(elapsed == 1) {
			if(this.repeat > 0) {
			} else {
				this.isPlaying = false;
				if(this.onCompleteCallback != null) this.onCompleteCallback();
				return false;
			}
		}
		return true;
	}
	,onUpdate: function(fun) {
		this.onUpdateCallback = fun;
		return this;
	}
};
var om__$TweenGroup_TweenGroup_$Impl_$ = {};
om__$TweenGroup_TweenGroup_$Impl_$.__name__ = true;
om__$TweenGroup_TweenGroup_$Impl_$.update = function(this1,time) {
	if(this1.length == 0) return false;
	var i = 0;
	while(i < this1.length) if(this1[i].update(time)) i++; else this1.splice(i,1);
	return true;
};
var om_easing_Linear = function() { };
om_easing_Linear.__name__ = true;
om_easing_Linear.None = function(k) {
	return k;
};
String.__name__ = true;
Array.__name__ = true;
om_Tween2.list = [];
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map