(function (console) { "use strict";
var App = function() { };
App.__name__ = ["App"];
App.update = function(time) {
	window.requestAnimationFrame(App.update);
	om_Tween.step(time);
};
App.main = function() {
	window.onload = function(_) {
		var easeClasses = [om_easing_Back,om_easing_Bounce,om_easing_Circular,om_easing_Cubic,om_easing_Elastic,om_easing_Exponential,om_easing_Quadratic,om_easing_Quartic,om_easing_Quintic,om_easing_Sinusoidal];
		var easeTypes = ["In","Out","InOut"];
		var _g = 0;
		while(_g < easeClasses.length) {
			var easeClass = easeClasses[_g];
			++_g;
			var tmp;
			var _this = window.document;
			tmp = _this.createElement("div");
			var element = tmp;
			element.classList.add("group");
			var easeClassName = Type.getClassName(easeClass);
			var tmp1;
			var pos = easeClassName.lastIndexOf(".") + 1;
			tmp1 = HxOverrides.substr(easeClassName,pos,null);
			var easeName = tmp1;
			var _g1 = 0;
			while(_g1 < easeTypes.length) {
				var easeType = easeTypes[_g1];
				++_g1;
				if(Object.prototype.hasOwnProperty.call(easeClass,easeType)) {
					var graph = new _$App_Graph(easeClass,easeName,easeType);
					element.appendChild(graph.element);
				}
			}
			window.document.body.appendChild(element);
		}
		window.requestAnimationFrame(App.update);
	};
};
var _$App_Graph = function(easeClass,easeName,easeType) {
	var width = 200;
	var height = 100;
	var halfHeight = height / 2 | 0;
	var drawDuration = 500;
	var tmp;
	var _this = window.document;
	tmp = _this.createElement("div");
	this.element = tmp;
	this.element.classList.add("graph");
	var tmp1;
	var _this1 = window.document;
	tmp1 = _this1.createElement("div");
	var title = tmp1;
	title.classList.add("title");
	title.textContent = "" + easeName + "." + easeType;
	this.element.appendChild(title);
	var tmp2;
	var _this2 = window.document;
	tmp2 = _this2.createElement("canvas");
	var canvas = tmp2;
	canvas.width = width;
	canvas.height = height;
	canvas.style.width = width + "px";
	canvas.style.height = height + "px";
	this.element.appendChild(canvas);
	var ctx = canvas.getContext("2d",null);
	ctx.strokeStyle = "#002B36";
	ctx.lineWidth = 1;
	ctx.beginPath();
	ctx.moveTo(0,halfHeight);
	ctx.lineTo(width,halfHeight);
	ctx.closePath();
	ctx.stroke();
	var yIndent = 12;
	var position = { x : 0, y : halfHeight};
	var position_old_x = 0;
	var position_old_y = halfHeight;
	var easing = Reflect.field(easeClass,easeType);
	ctx.strokeStyle = "#fff";
	new om_Tween(position).to({ x : width},drawDuration).easing(om_easing_Linear.None).start();
	new om_Tween(position).to({ y : (width / 2 | 0) - yIndent},drawDuration).easing(easing).onUpdate(function() {
		ctx.beginPath();
		ctx.moveTo(position_old_x,position_old_y);
		ctx.lineTo(position.x,position.y);
		ctx.closePath();
		ctx.stroke();
		position_old_x = position.x;
		position_old_y = position.y;
	}).start();
};
_$App_Graph.__name__ = ["_App","Graph"];
var HxOverrides = function() { };
HxOverrides.__name__ = ["HxOverrides"];
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
Math.__name__ = ["Math"];
var Reflect = function() { };
Reflect.__name__ = ["Reflect"];
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
var Type = function() { };
Type.__name__ = ["Type"];
Type.getClassName = function(c) {
	var a = c.__name__;
	if(a == null) return null;
	return a.join(".");
};
var om_Time = function() { };
om_Time.__name__ = ["om","Time"];
om_Time.now = function() {
	return window.performance.now();
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
om_Tween.__name__ = ["om","Tween"];
om_Tween.add = function(tween) {
	om_Tween.list.push(tween);
};
om_Tween.remove = function(tween) {
	var i = HxOverrides.indexOf(om_Tween.list,tween,0);
	if(i != -1) om_Tween.list.splice(i,1);
};
om_Tween.getAll = function() {
	return om_Tween.list;
};
om_Tween.removeAll = function() {
	om_Tween.list = [];
};
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
	,stop: function() {
		if(!this.isPlaying) return this;
		om_Tween.remove(this);
		this.isPlaying = false;
		if(this._onStopCallback != null) this._onStopCallback();
		this.stopChainedTweens();
		return this;
	}
	,stopChainedTweens: function() {
		var _g = 0;
		var _g1 = this._chainedTweens;
		while(_g < _g1.length) {
			var t = _g1[_g];
			++_g;
			t.stop();
		}
		return this;
	}
	,delay: function(amount) {
		this._delayTime = amount;
		return this;
	}
	,repeat: function(times) {
		this._repeat = times;
		return this;
	}
	,yoyo: function(yoyo) {
		this._yoyo = yoyo;
		return this;
	}
	,easing: function(easing) {
		this._easingFunction = easing;
		return this;
	}
	,interpolation: function(interpolation) {
		this._interpolationFunction = interpolation;
		return this;
	}
	,chain: function(args) {
		this._chainedTweens = args;
		return this;
	}
	,onStart: function(callback) {
		this._onStartCallback = callback;
		return this;
	}
	,onUpdate: function(callback) {
		this._onUpdateCallback = callback;
		return this;
	}
	,onComplete: function(callback) {
		this._onCompleteCallback = callback;
		return this;
	}
	,onStop: function(callback) {
		this._onStopCallback = callback;
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
var om_easing_Back = function() { };
om_easing_Back.__name__ = ["om","easing","Back"];
om_easing_Back.In = function(k) {
	return k * k * (2.70158 * k - 1.70158);
};
om_easing_Back.Out = function(k) {
	return --k * k * (2.70158 * k + 1.70158) + 1;
};
om_easing_Back.InOut = function(k) {
	if((k *= 2) < 1) return 0.5 * (k * k * (3.5949095 * k - 2.5949095));
	return 0.5 * ((k -= 2) * k * (3.5949095 * k + 2.5949095) + 2);
};
var om_easing_Bounce = function() { };
om_easing_Bounce.__name__ = ["om","easing","Bounce"];
om_easing_Bounce.In = function(k) {
	var tmp;
	var k1 = 1 - k;
	if(k1 < 0.363636363636363646) tmp = 7.5625 * k1 * k1; else if(k1 < 0.727272727272727293) tmp = 7.5625 * (k1 -= 0.545454545454545414) * k1 + 0.75; else if(k1 < 0.909090909090909061) tmp = 7.5625 * (k1 -= 0.818181818181818232) * k1 + 0.9375; else tmp = 7.5625 * (k1 -= 0.954545454545454586) * k1 + 0.984375;
	return 1 - tmp;
};
om_easing_Bounce.Out = function(k) {
	if(k < 0.363636363636363646) return 7.5625 * k * k; else if(k < 0.727272727272727293) return 7.5625 * (k -= 0.545454545454545414) * k + 0.75; else if(k < 0.909090909090909061) return 7.5625 * (k -= 0.818181818181818232) * k + 0.9375; else return 7.5625 * (k -= 0.954545454545454586) * k + 0.984375;
};
om_easing_Bounce.InOut = function(k) {
	if(k < 0.5) {
		var tmp1;
		var k1 = 1 - k * 2;
		if(k1 < 0.363636363636363646) tmp1 = 7.5625 * k1 * k1; else if(k1 < 0.727272727272727293) tmp1 = 7.5625 * (k1 -= 0.545454545454545414) * k1 + 0.75; else if(k1 < 0.909090909090909061) tmp1 = 7.5625 * (k1 -= 0.818181818181818232) * k1 + 0.9375; else tmp1 = 7.5625 * (k1 -= 0.954545454545454586) * k1 + 0.984375;
		return (1 - tmp1) * 0.5;
	}
	var tmp;
	var k2 = k * 2 - 1;
	if(k2 < 0.363636363636363646) tmp = 7.5625 * k2 * k2; else if(k2 < 0.727272727272727293) tmp = 7.5625 * (k2 -= 0.545454545454545414) * k2 + 0.75; else if(k2 < 0.909090909090909061) tmp = 7.5625 * (k2 -= 0.818181818181818232) * k2 + 0.9375; else tmp = 7.5625 * (k2 -= 0.954545454545454586) * k2 + 0.984375;
	return tmp * 0.5 + 0.5;
};
var om_easing_Circular = function() { };
om_easing_Circular.__name__ = ["om","easing","Circular"];
om_easing_Circular.In = function(k) {
	return 1 - Math.sqrt(1 - k * k);
};
om_easing_Circular.Out = function(k) {
	return Math.sqrt(1 - --k * k);
};
om_easing_Circular.InOut = function(k) {
	if((k *= 2) < 1) return -0.5 * (Math.sqrt(1 - k * k) - 1);
	return 0.5 * (Math.sqrt(1 - (k -= 2) * k) + 1);
};
var om_easing_Cubic = function() { };
om_easing_Cubic.__name__ = ["om","easing","Cubic"];
om_easing_Cubic.In = function(k) {
	return k * k * k;
};
om_easing_Cubic.Out = function(k) {
	return --k * k * k + 1;
};
om_easing_Cubic.InOut = function(k) {
	if((k *= 2) < 1) return 0.5 * k * k * k;
	return 0.5 * ((k -= 2) * k * k + 2);
};
var om_easing_Elastic = function() { };
om_easing_Elastic.__name__ = ["om","easing","Elastic"];
om_easing_Elastic.In = function(k) {
	var s = null;
	var a = 0.1;
	if(k == 0) return 0;
	if(k == 1) return 1;
	a = 1;
	s = 0.1;
	return -(a * Math.pow(2,10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / 0.4));
};
om_easing_Elastic.Out = function(k) {
	var s = null;
	var a = 0.1;
	if(k == 0) return 0;
	if(k == 1) return 1;
	a = 1;
	s = 0.1;
	return a * Math.pow(2,-10 * k) * Math.sin((k - s) * (2 * Math.PI) / 0.4) + 1;
};
om_easing_Elastic.InOut = function(k) {
	var s;
	var a = 0.1;
	if(k == 0) return 0;
	if(k == 1) return 1;
	a = 1;
	s = 0.1;
	if((k *= 2) < 1) return -0.5 * (a * Math.pow(2,10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / 0.4));
	return a * Math.pow(2,-10 * (k -= 1)) * Math.sin((k - s) * (2 * Math.PI) / 0.4) * 0.5 + 1;
};
var om_easing_Exponential = function() { };
om_easing_Exponential.__name__ = ["om","easing","Exponential"];
om_easing_Exponential.In = function(k) {
	return k == 0?0:Math.pow(1024,k - 1);
};
om_easing_Exponential.Out = function(k) {
	return k == 1?1:1 - Math.pow(2,-10 * k);
};
om_easing_Exponential.InOut = function(k) {
	if(k == 0) return 0;
	if(k == 1) return 1;
	if((k *= 2) < 1) return 0.5 * Math.pow(1024,k - 1);
	return 0.5 * (-Math.pow(2,-10 * (k - 1)) + 2);
};
var om_easing_Linear = function() { };
om_easing_Linear.__name__ = ["om","easing","Linear"];
om_easing_Linear.None = function(k) {
	return k;
};
var om_easing_Quadratic = function() { };
om_easing_Quadratic.__name__ = ["om","easing","Quadratic"];
om_easing_Quadratic.In = function(k) {
	return k * k;
};
om_easing_Quadratic.Out = function(k) {
	return k * (2 - k);
};
om_easing_Quadratic.InOut = function(k) {
	if((k *= 2) < 1) return 0.5 * k * k;
	return -0.5 * (--k * (k - 2) - 1);
};
var om_easing_Quartic = function() { };
om_easing_Quartic.__name__ = ["om","easing","Quartic"];
om_easing_Quartic.In = function(k) {
	return k * k * k * k;
};
om_easing_Quartic.Out = function(k) {
	return 1 - --k * k * k * k;
};
om_easing_Quartic.InOut = function(k) {
	if((k *= 2) < 1) return 0.5 * k * k * k * k;
	return -0.5 * ((k -= 2) * k * k * k - 2);
};
var om_easing_Quintic = function() { };
om_easing_Quintic.__name__ = ["om","easing","Quintic"];
om_easing_Quintic.In = function(k) {
	return k * k * k * k * k;
};
om_easing_Quintic.Out = function(k) {
	return --k * k * k * k * k + 1;
};
om_easing_Quintic.InOut = function(k) {
	if((k *= 2) < 1) return 0.5 * k * k * k * k * k;
	return 0.5 * ((k -= 2) * k * k * k * k + 2);
};
var om_easing_Sinusoidal = function() { };
om_easing_Sinusoidal.__name__ = ["om","easing","Sinusoidal"];
om_easing_Sinusoidal.In = function(k) {
	return 1 - Math.cos(k * Math.PI / 2);
};
om_easing_Sinusoidal.Out = function(k) {
	return Math.sin(k * Math.PI / 2);
};
om_easing_Sinusoidal.InOut = function(k) {
	return 0.5 * (1 - Math.cos(Math.PI * k));
};
var om_tween_Interpolation = function() { };
om_tween_Interpolation.__name__ = ["om","tween","Interpolation"];
om_tween_Interpolation.linear = function(v,k) {
	var m = v.length - 1;
	var f = m * k;
	var i = Math.floor(f);
	var fn = om_tween_InterpolationUtils.linear;
	if(k < 0) return fn(v[0],v[1],f);
	if(k > 1) return fn(v[m],v[m - 1],m - f);
	return fn(v[i],v[i + 1 > m?m:i + 1],f - i);
};
om_tween_Interpolation.bezier = function(v,k) {
	var b = 0.0;
	var n = v.length - 1;
	var pw = Math.pow;
	var bn = om_tween_InterpolationUtils.bernstein;
	var i = 0;
	while(i <= n) {
		b += pw(1 - k,n - i) * pw(k,i) * v[i] * bn(n,i);
		i++;
	}
	return b;
};
om_tween_Interpolation.catmullRom = function(v,k) {
	var m = v.length - 1;
	var f = m * k;
	var i = Math.floor(f);
	var fn = om_tween_InterpolationUtils.catmullRom;
	if(v[0] == v[Math.round(m)]) {
		if(k < 0) i = Math.floor(f = m * (1 + k));
		return fn(v[(i - 1 + m) % m],v[i],v[(i + 1) % m],v[(i + 2) % m],f - i);
	} else {
		if(k < 0) return v[0] - (fn(v[0],v[0],v[1],v[1],-f) - v[0]);
		if(k > 1) return v[m] - (fn(v[m],v[m],v[m - 1],v[m - 1],f - m) - v[m]);
		return fn(v[i?i - 1:0],v[i],v[m < i + 1?m:i + 1],v[m < i + 2?m:i + 2],f - i);
	}
};
var om_tween_InterpolationUtils = function() { };
om_tween_InterpolationUtils.__name__ = ["om","tween","InterpolationUtils"];
om_tween_InterpolationUtils.linear = function(p0,p1,t) {
	return (p1 - p0) * t + p0;
};
om_tween_InterpolationUtils.bernstein = function(n,i) {
	var fc = om_tween_InterpolationUtils.factorial;
	return fc(n) / fc(i) / fc(n - i);
};
om_tween_InterpolationUtils.factorial = function(n) {
	var a = [1.0];
	var s = 1.0;
	if(a[Math.round(n)] < 0) return a[Math.round(n)];
	var i = n;
	while(i > 1) {
		s *= i;
		i--;
	}
	return a[Math.round(n)] = s;
};
om_tween_InterpolationUtils.catmullRom = function(p0,p1,p2,p3,t) {
	var v0 = (p2 - p0) * 0.5;
	var v1 = (p3 - p1) * 0.5;
	var t2 = t * t;
	var t3 = t * t2;
	return (2 * p1 - 2 * p2 + v0 + v1) * t3 + (-3 * p1 + 3 * p2 - 2 * v0 - v1) * t2 + v0 * t + p1;
};
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.__name__ = ["String"];
Array.__name__ = ["Array"];
om_Tween.list = [];
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map