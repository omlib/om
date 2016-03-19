(function (console) { "use strict";
var App = function() { };
App.update = function(time) {
	window.requestAnimationFrame(App.update);
	App.parallax.update();
};
App.handleWindowResize = function(e) {
};
App.handleMouseMove = function(e) {
	App.parallax.offsetX = e.clientX / window.innerWidth;
	App.parallax.offsetY = e.clientY / window.innerHeight;
};
App.handleClick = function(e) {
	if(++App.exampleIndex == App.numExamples) App.exampleIndex = 0;
	App.loadExample(App.exampleIndex);
};
App.loadExample = function(i) {
	if(App.parallax != null) {
		App.parallax.clear();
		App.parallax.element.style.display = "none";
	}
	var element = window.document.getElementById("example-" + i);
	element.style.display = "block";
	App.parallax = om_Parallax.fromElement(element);
};
App.main = function() {
	window.onload = function() {
		App.numExamples = window.document.querySelectorAll(".parallax").length;
		App.loadExample(App.exampleIndex = 0);
		window.requestAnimationFrame(App.update);
		window.addEventListener("resize",App.handleWindowResize,false);
		window.addEventListener("mousemove",App.handleMouseMove,false);
		window.addEventListener("touchmove",App.handleMouseMove,false);
		window.addEventListener("click",App.handleClick,false);
	};
};
var Std = function() { };
Std["int"] = function(x) {
	return x | 0;
};
Std.parseFloat = function(x) {
	return parseFloat(x);
};
var om_Parallax = function(element,layers) {
	this.lockY = false;
	this.lockX = false;
	this.invertY = false;
	this.invertX = false;
	this.element = element;
	this.layers = layers;
	this.offsetX = this.offsetY = 0;
};
om_Parallax.fromElement = function(element) {
	var layers = [];
	var _g = 0;
	var _g1 = element.children;
	while(_g < _g1.length) {
		var child = _g1[_g];
		++_g;
		var layer = new om_ParallaxLayer(child);
		var lock1 = om_Parallax.getAttrLock(child);
		layer.lockX = lock1.x;
		layer.lockY = lock1.y;
		if(child.hasAttribute("data-depth")) layer.depth = Std.parseFloat(child.getAttribute("data-depth"));
		layers.push(layer);
	}
	var parallax = new om_Parallax(element,layers);
	var lock = om_Parallax.getAttrLock(element);
	parallax.lockX = lock.x;
	parallax.lockY = lock.y;
	return parallax;
};
om_Parallax.getAttrLock = function(element) {
	var lock = { x : false, y : false};
	if(element.hasAttribute("data-lock")) {
		var attr = element.getAttribute("data-lock");
		var _g = 0;
		var _g1 = attr.split("");
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			switch(c) {
			case "x":
				lock.x = true;
				break;
			case "y":
				lock.y = true;
				break;
			}
		}
	}
	return lock;
};
om_Parallax.prototype = {
	get_numLayers: function() {
		return this.layers.length;
	}
	,update: function() {
		var _g = 0;
		var _g1 = this.layers;
		while(_g < _g1.length) {
			var layer = _g1[_g];
			++_g;
			if(layer.locked) continue;
			var x;
			if(this.lockX) x = 0; else if(layer.lockX) x = 0; else x = this.offsetX;
			var y;
			if(this.lockY) y = 0; else if(layer.lockY) y = 0; else y = this.offsetY;
			if(this.invertX) x = 1 - x;
			if(this.invertY) y = 1 - y;
			layer.setOffset(x,y);
		}
	}
	,addLayer: function(layer) {
		this.layers.push(layer);
		this.element.appendChild(layer.element);
	}
	,clear: function(removeElements) {
		if(removeElements == null) removeElements = false;
		if(removeElements) {
			var _g = 0;
			var _g1 = this.layers;
			while(_g < _g1.length) {
				var layer = _g1[_g];
				++_g;
				layer.element.remove();
			}
		}
		this.layers = [];
	}
};
var om_ParallaxLayer = function(element,depth,locked) {
	if(locked == null) locked = false;
	if(depth == null) depth = 1.0;
	this.element = element;
	this.depth = depth;
	this.locked = locked;
	this.lockX = this.lockY = false;
	element.classList.add("layer");
};
om_ParallaxLayer.prototype = {
	get_width: function() {
		return Std["int"](this.element.getBoundingClientRect().width);
	}
	,get_height: function() {
		return Std["int"](this.element.getBoundingClientRect().height);
	}
	,setOffset: function(x,y) {
		var rect = this.element.parentElement.getBoundingClientRect();
		var parentWidth = rect.width;
		var parentHeight = rect.height;
		var px = -(x * (Std["int"](this.element.getBoundingClientRect().width) - parentWidth)) * this.depth;
		var py = -(y * (Std["int"](this.element.getBoundingClientRect().height) - parentHeight)) * this.depth;
		this.setPosition(px,py);
	}
	,setPosition: function(x,y) {
		this.element.style.transform = "translate(" + x + "px," + y + "px)";
	}
};
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map