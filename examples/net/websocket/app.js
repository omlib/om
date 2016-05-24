(function (console) { "use strict";
var App = function() { };
App.main = function() {
	var btn = window.document.getElementById("connect");
	btn.onclick = function() {
		var socket = new WebSocket("ws://127.0.0.1:7700");
		socket.onopen = function() {
			window.console.debug("onopen");
			console.log(socket.readyState);
			socket.send("abc");
		};
		socket.onerror = function(e) {
			window.console.error(e);
		};
		socket.onclose = function(e1) {
			window.console.info(e1);
		};
		socket.onmessage = function(e2) {
			window.console.info(e2);
			var message;
			var _this = window.document;
			message = _this.createElement("div");
			message.textContent = e2.data;
			window.document.body.appendChild(message);
		};
	};
};
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map