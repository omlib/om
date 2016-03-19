(function (console) { "use strict";
var App = function() { };
App.selectNoise = function(type) {
	if(App.noise != null) App.noise.disconnect();
	switch(type) {
	case "white":
		App.noise = om_audio_NoiseGenerator.generateWhiteNoise(App.audio);
		break;
	case "pink":
		App.noise = om_audio_NoiseGenerator.generatePinkNoise(App.audio);
		break;
	case "brown":
		App.noise = om_audio_NoiseGenerator.generateBrownNoise(App.audio);
		break;
	default:
		App.noise = null;
	}
	App.noise.connect(App.audio.destination);
};
App.main = function() {
	window.onload = function() {
		App.audio = new AudioContext();
		var noise;
		var _g = new haxe_ds_StringMap();
		var value = om_audio_NoiseGenerator.generateWhiteNoise(App.audio);
		if(__map_reserved.white != null) _g.setReserved("white",value); else _g.h["white"] = value;
		var value1 = om_audio_NoiseGenerator.generatePinkNoise(App.audio);
		if(__map_reserved.pink != null) _g.setReserved("pink",value1); else _g.h["pink"] = value1;
		var value2 = om_audio_NoiseGenerator.generateBrownNoise(App.audio);
		if(__map_reserved.brown != null) _g.setReserved("brown",value2); else _g.h["brown"] = value2;
		noise = _g;
		var $it0 = noise.keys();
		while( $it0.hasNext() ) {
			var type = $it0.next();
			var type1 = [type];
			var e = [window.document.getElementById(type1[0])];
			e[0].style.textDecoration = "line-through";
			e[0].onclick = (function(e,type1) {
				return function() {
					if(e[0].style.textDecoration == "none") {
						e[0].style.textDecoration = "line-through";
						(__map_reserved[type1[0]] != null?noise.getReserved(type1[0]):noise.h[type1[0]]).disconnect();
					} else {
						e[0].style.textDecoration = "none";
						(__map_reserved[type1[0]] != null?noise.getReserved(type1[0]):noise.h[type1[0]]).connect(App.audio.destination);
					}
				};
			})(e,type1);
		}
	};
};
var HxOverrides = function() { };
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var haxe_IMap = function() { };
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
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
};
var om_audio_NoiseGenerator = function() { };
om_audio_NoiseGenerator.generateWhiteNoise = function(ctx,bufferSize) {
	if(bufferSize == null) bufferSize = 4096;
	var node = ctx.createScriptProcessor(bufferSize,1,1);
	node.onaudioprocess = function(e) {
		var output = e.outputBuffer.getChannelData(0);
		var _g = 0;
		while(_g < bufferSize) {
			var i = _g++;
			output[i] = Math.random() * 2 - 1;
		}
	};
	return node;
};
om_audio_NoiseGenerator.generatePinkNoise = function(ctx,bufferSize) {
	if(bufferSize == null) bufferSize = 4096;
	var b0;
	var b1;
	var b2;
	var b3;
	var b4;
	var b5;
	var b6;
	b0 = b1 = b2 = b3 = b4 = b5 = b6 = 0.0;
	var node = ctx.createScriptProcessor(bufferSize,1,1);
	node.onaudioprocess = function(e) {
		var output = e.outputBuffer.getChannelData(0);
		var _g = 0;
		while(_g < bufferSize) {
			var i = _g++;
			var white = Math.random() * 2 - 1;
			b0 = 0.99886 * b0 + white * 0.0555179;
			b1 = 0.99332 * b1 + white * 0.0750759;
			b2 = 0.96900 * b2 + white * 0.1538520;
			b3 = 0.86650 * b3 + white * 0.3104856;
			b4 = 0.55000 * b4 + white * 0.5329522;
			b5 = -0.7616 * b5 - white * 0.0168980;
			output[i] = b0 + b1 + b2 + b3 + b4 + b5 + b6 + white * 0.5362;
			output[i] *= 0.11;
			b6 = white * 0.115926;
		}
	};
	return node;
};
om_audio_NoiseGenerator.generateBrownNoise = function(ctx,bufferSize) {
	if(bufferSize == null) bufferSize = 4096;
	var lastOut = 0.0;
	var node = ctx.createScriptProcessor(bufferSize,1,1);
	node.onaudioprocess = function(e) {
		var output = e.outputBuffer.getChannelData(0);
		var _g = 0;
		while(_g < bufferSize) {
			var i = _g++;
			var white = Math.random() * 2 - 1;
			output[i] = (lastOut + 0.02 * white) / 1.02;
			lastOut = output[i];
			output[i] *= 3.5;
		}
	};
	return node;
};
var __map_reserved = {}
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map