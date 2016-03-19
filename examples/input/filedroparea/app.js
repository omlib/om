(function (console) { "use strict";
var App = function() { };
App.__name__ = true;
App.main = function() {
	window.onload = function() {
		var element = window.document.getElementById("file-drop-area");
		var fileDropArea = new om_input_FileDropArea(element);
		fileDropArea.onEvent = function(e) {
			var _g = e.type;
			switch(_g) {
			case "dragenter":
				element.style.background = "#f0f0f0";
				break;
			case "dragleave":
				element.style.background = "#616161";
				break;
			case "drop":
				var files = e.dataTransfer.files;
				var info = window.document.getElementById("info");
				var _g2 = 0;
				var _g1 = files.length;
				while(_g2 < _g1) {
					var i = _g2++;
					var f = files[i];
					var e1;
					var _this = window.document;
					e1 = _this.createElement("div");
					e1.textContent = f.name + " - " + Std.string(f.lastModifiedDate);
					info.appendChild(e1);
				}
				element.style.background = "#73C990";
				haxe_Timer.delay(function() {
					element.style.background = "#616161";
				},600);
				break;
			}
		};
		fileDropArea.activate();
	};
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.dateStr = function(date) {
	var m = date.getMonth() + 1;
	var d = date.getDate();
	var h = date.getHours();
	var mi = date.getMinutes();
	var s = date.getSeconds();
	return date.getFullYear() + "-" + (m < 10?"0" + m:"" + m) + "-" + (d < 10?"0" + d:"" + d) + " " + (h < 10?"0" + h:"" + h) + ":" + (mi < 10?"0" + mi:"" + mi) + ":" + (s < 10?"0" + s:"" + s);
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
haxe_Timer.__name__ = true;
haxe_Timer.delay = function(f,time_ms) {
	var t = new haxe_Timer(time_ms);
	t.run = function() {
		t.stop();
		f();
	};
	return t;
};
haxe_Timer.prototype = {
	stop: function() {
		if(this.id == null) return;
		clearInterval(this.id);
		this.id = null;
	}
	,run: function() {
	}
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
var om_Disposable = function() { };
om_Disposable.__name__ = true;
var om_input_FileDropArea = function(target) {
	this.active = false;
	this.target = target;
};
om_input_FileDropArea.__name__ = true;
om_input_FileDropArea.__interfaces__ = [om_Disposable];
om_input_FileDropArea.prototype = {
	onEvent: function(e) {
	}
	,activate: function() {
		if(this.active) return;
		this.target.addEventListener("drag",$bind(this,this.handleDrag),false);
		this.target.addEventListener("dragstart",$bind(this,this.handleDragStart),false);
		this.target.addEventListener("dragend",$bind(this,this.handleDragEnd),false);
		this.target.addEventListener("dragover",$bind(this,this.handleDragOver),false);
		this.target.addEventListener("dragenter",$bind(this,this.handleDragEnter),false);
		this.target.addEventListener("dragleave",$bind(this,this.handleDragLeave),false);
		this.target.addEventListener("drop",$bind(this,this.handleDrop),false);
		this.active = true;
	}
	,handleDrag: function(e) {
		this.onEvent(e);
	}
	,handleDragStart: function(e) {
		this.onEvent(e);
	}
	,handleDragEnd: function(e) {
		this.onEvent(e);
	}
	,handleDragLeave: function(e) {
		this.onEvent(e);
	}
	,handleDragOver: function(e) {
		e.stopPropagation();
		e.preventDefault();
		this.onEvent(e);
		return false;
	}
	,handleDragEnter: function(e) {
		e.stopPropagation();
		e.preventDefault();
		this.onEvent(e);
		return false;
	}
	,handleDrop: function(e) {
		e.stopPropagation();
		e.preventDefault();
		this.onEvent(e);
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
Date.__name__ = ["Date"];
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map