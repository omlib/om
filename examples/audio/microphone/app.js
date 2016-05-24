(function (console) { "use strict";
var App = function() { };
App.update = function(time) {
	window.requestAnimationFrame(App.update);
	App.analyser.getByteFrequencyData(App.frequencyData);
	App.analyser.getByteTimeDomainData(App.timeDomainData);
	var w = window.innerWidth;
	var h = window.innerHeight;
	var sliceWidth = w * 1.0 / App.bufferLength;
	App.spectrum.clearRect(0,0,w,h);
	App.spectrum.fillStyle = "#fff";
	var _g1 = 0;
	var _g = App.frequencyData.length;
	while(_g1 < _g) {
		var i = _g1++;
		App.spectrum.fillRect(i,0,1,App.frequencyData[i] / 256 * h);
	}
};
App.handleUserMedia = function(stream) {
	App.audio = new AudioContext();
	App.analyser = App.audio.createAnalyser();
	App.analyser.fftSize = 2048;
	App.bufferLength = App.analyser.frequencyBinCount;
	App.frequencyData = new Uint8Array(App.bufferLength);
	App.timeDomainData = new Uint8Array(App.bufferLength);
	var mic = App.audio.createMediaStreamSource(stream);
	mic.connect(App.analyser);
	App.analyser.connect(App.audio.destination);
	window.requestAnimationFrame(App.update);
};
App.main = function() {
	window.navigator.getUserMedia = window.navigator.getUserMedia || window.navigator.webkitGetUserMedia || window.navigator.mozGetUserMedia;
	window.onload = function() {
		var _this = window.document;
		App.canvas = _this.createElement("canvas");
		App.canvas.style.backgroundColor = "#000";
		App.canvas.width = window.innerWidth;
		App.canvas.height = window.innerHeight;
		window.document.body.appendChild(App.canvas);
		App.spectrum = App.canvas.getContext("2d",null);
		var startButton = window.document.getElementById("start");
		startButton.onmousedown = function(e) {
			startButton.remove();
			window.navigator.getUserMedia({ audio : true},App.handleUserMedia,function(e1) {
				console.error(e1);
			});
		};
	};
};
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map