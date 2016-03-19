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
	om_Tween.step(time);
};
App.main = function() {
	window.onload = function(_) {
		App.position = { x : 100, y : 100, rotation : 0};
		App.target = window.document.getElementById("target");
		var tween = new om_Tween(App.position).to({ x : 700, y : 200, rotation : 359},2000).delay(500).easing(om_easing_Linear.None).onUpdate(App.animate);
		var tweenBack = new om_Tween(App.position).to({ x : 100, y : 100, rotation : 0},3000).easing(om_easing_Elastic.Out).onUpdate(App.animate);
		tween.chain([tweenBack]);
		tweenBack.chain([tween]);
		tween.start();
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
var om_Tween = function(object) {
	this._onStartCallbackFired = false;
	this._chainedTweens = [];
	this._interpolationFunction = om_tween_Interpolation.linear;
	this._easingFunction = om_easing_Linear.None;
	this._startTime = 0.0;
	this._delayTime = 0.0;
	this._reversed = false;
	this._yoyo = false;
	this._repeat = 0;
	this._valuesStartRepeat = { };
	this._valuesEnd = { };
	this._valuesStart = { };
	this.isPlaying = false;
	this.object = object;
};
om_Tween.__name__ = true;
om_Tween.step = function(time) {
	if(om_Tween.list.length == 0) return false;
	var i = 0;
	while(i < om_Tween.list.length) if(om_Tween.list[i].update(time)) i++; else om_Tween.list.splice(i,1);
	return true;
};
om_Tween.prototype = {
	to: function(properties,duration) {
		if(duration == null) duration = 1000.0;
		this.duration = duration;
		this._valuesEnd = properties;
		return this;
	}
	,start: function(time) {
		om_Tween.list.push(this);
		this.isPlaying = true;
		this._onStartCallbackFired = false;
		this._startTime = time != null?time:window.performance.now();
		this._startTime += this._delayTime;
		var _g = 0;
		var _g1 = Reflect.fields(this._valuesEnd);
		while(_g < _g1.length) {
			var property = _g1[_g];
			++_g;
			if((Reflect.field(this._valuesEnd,property) instanceof Array) && Reflect.field(this._valuesEnd,property).__enum__ == null) {
				if(Reflect.field(this._valuesEnd,property).length == 0) continue;
				var value = [Reflect.field(this.object,property)].concat(Reflect.field(this._valuesEnd,property));
				this._valuesEnd[property] = value;
			}
			var value1 = Reflect.field(this.object,property);
			this._valuesStart[property] = value1;
			if(!((Reflect.field(this._valuesStart,property) instanceof Array) && Reflect.field(this._valuesStart,property).__enum__ == null)) {
				var value2 = Reflect.field(this._valuesStart,property) * 1.0;
				this._valuesStart[property] = value2;
			}
			var v = Reflect.field(this._valuesStart,property);
			this._valuesStartRepeat[property] = v != null?v:0;
		}
		return this;
	}
	,delay: function(time) {
		this._delayTime = time;
		return this;
	}
	,easing: function(easing) {
		this._easingFunction = easing;
		return this;
	}
	,chain: function(args) {
		this._chainedTweens = args;
		return this;
	}
	,onUpdate: function(callback) {
		this._onUpdateCallback = callback;
		return this;
	}
	,update: function(time) {
		if(time < this._startTime) return true;
		if(!this._onStartCallbackFired) {
			if(this._onStartCallback != null) this._onStartCallback();
			this._onStartCallbackFired = true;
		}
		var elapsed = (time - this._startTime) / this.duration;
		elapsed = elapsed > 1?1:elapsed;
		var value = this._easingFunction(elapsed);
		var _g = 0;
		var _g1 = Reflect.fields(this._valuesEnd);
		while(_g < _g1.length) {
			var property = _g1[_g];
			++_g;
			var start = Reflect.field(this._valuesStart,property);
			if(start == null) start = 0;
			var end = Reflect.field(this._valuesEnd,property);
			if((end instanceof Array) && end.__enum__ == null) {
				var value1 = this._interpolationFunction(end,value);
				this.object[property] = value1;
			} else {
				if(typeof(end) == "string") end = start + parseFloat(end,10);
				if(typeof(end) == "number") this.object[property] = start + (end - start) * value;
			}
		}
		if(this._onUpdateCallback != null) this._onUpdateCallback();
		if(elapsed == 1) {
			if(this._repeat > 0) {
				if(isFinite(this._repeat)) this._repeat--;
				var _g2 = 0;
				var _g11 = Reflect.fields(this._valuesStartRepeat);
				while(_g2 < _g11.length) {
					var property1 = _g11[_g2];
					++_g2;
					if(typeof(Reflect.field(this._valuesEnd,property1)) == "string") this._valuesStartRepeat[property1] = this._valuesStartRepeat[property1] + parseFloat(this._valuesEnd[property1],10);
					if(this._yoyo) {
						var tmp = Reflect.field(this._valuesStartRepeat,property1);
						var value2 = Reflect.field(this._valuesEnd,property1);
						this._valuesStartRepeat[property1] = value2;
						this._valuesEnd[property1] = tmp;
					}
					var value3 = Reflect.field(this._valuesEnd,property1);
					this._valuesStart[property1] = value3;
				}
				if(this._yoyo) this._reversed = !this._reversed;
				this._startTime = time + this._delayTime;
				return true;
			} else {
				this.isPlaying = false;
				if(this._onCompleteCallback != null) this._onCompleteCallback();
				var _g3 = 0;
				var _g12 = this._chainedTweens;
				while(_g3 < _g12.length) {
					var tween = _g12[_g3];
					++_g3;
					tween.start(time);
				}
				return false;
			}
		}
		return true;
	}
};
var om_easing_Elastic = function() { };
om_easing_Elastic.__name__ = true;
om_easing_Elastic.Out = function(k) {
	var s = null;
	var a = 0.1;
	if(k == 0) return 0;
	if(k == 1) return 1;
	a = 1;
	s = 0.1;
	return a * Math.pow(2,-10 * k) * Math.sin((k - s) * (2 * Math.PI) / 0.4) + 1;
};
var om_easing_Linear = function() { };
om_easing_Linear.__name__ = true;
om_easing_Linear.None = function(k) {
	return k;
};
var om_tween_Interpolation = function() { };
om_tween_Interpolation.__name__ = true;
om_tween_Interpolation.linear = function(v,k) {
	var m = v.length - 1;
	var f = m * k;
	var i = Math.floor(f);
	var fn = om_tween_InterpolationUtils.linear;
	if(k < 0) return fn(v[0],v[1],f);
	if(k > 1) return fn(v[m],v[m - 1],m - f);
	return fn(v[i],v[i + 1 > m?m:i + 1],f - i);
};
var om_tween_InterpolationUtils = function() { };
om_tween_InterpolationUtils.__name__ = true;
om_tween_InterpolationUtils.linear = function(p0,p1,t) {
	return (p1 - p0) * t + p0;
};
String.__name__ = true;
Array.__name__ = true;
om_Tween.list = [];
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map