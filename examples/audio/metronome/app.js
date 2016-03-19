(function (console) { "use strict";
var App = function() { };
App.update = function(time) {
	window.requestAnimationFrame(App.update);
	App.elementTime.textContent = "TIME " + time / 1000;
	var currentNote = App.last16thNoteDrawn;
	var currentTime = App.audio.currentTime;
	while(App.metronome.notesInQueue.length > 0 && App.metronome.notesInQueue[0].time < currentTime) {
		currentNote = App.metronome.notesInQueue[0].note;
		App.metronome.notesInQueue.splice(0,1);
	}
	var ctx = App.canvas.getContext("2d",null);
	if(App.last16thNoteDrawn != currentNote) {
		var x = Math.floor(App.canvas.width / 18);
		ctx.clearRect(0,0,App.canvas.width,App.canvas.height);
		var _g = 0;
		while(_g < 16) {
			var i = _g++;
			if(currentNote == i) {
				if(currentNote % 4 == 0) ctx.fillStyle = "#f0f0f0"; else ctx.fillStyle = "#414141";
			} else ctx.fillStyle = "#030303";
			ctx.fillRect(x * (i + 1),x,x / 2,x / 2);
		}
		App.last16thNoteDrawn = currentNote;
	}
};
App.setBPM = function(bpm) {
	App.elementBPM.textContent = "BPM " + bpm;
	App.metronome.stop();
	App.metronome.tempo = bpm;
	App.metronome.play();
};
App.main = function() {
	App.elementBPM = window.document.getElementById("bpm");
	App.elementTime = window.document.getElementById("time");
	App.elementStep = window.document.getElementById("step");
	App.canvas = window.document.getElementById("canvas");
	App.canvas.width = 400;
	App.canvas.height = 50;
	var bpm = 120;
	App.elementBPM.textContent = "BPM " + bpm;
	App.audio = new AudioContext();
	App.metronome = new om_audio_Metronome(App.audio,bpm);
	App.metronome.onTick = function(beatNumber,time) {
		App.elementStep.textContent = "STEP " + time;
		var osc = App.audio.createOscillator();
		osc.connect(App.audio.destination);
		osc.frequency.value = 0;
		if(beatNumber % 16 == 0) osc.frequency.value = 1760.0; else if(beatNumber % 4 == 0) osc.frequency.value = 880.0; else osc.frequency.value = 440.0;
		osc.start(time);
		osc.stop(time + App.metronome.noteLength);
	};
	App.metronome.play();
	window.requestAnimationFrame(App.update);
	window.addEventListener("mousedown",function(e) {
		App.setBPM(e.clientX);
	},false);
};
var om_audio_Metronome = function(context,tempo,scheduleAheadTime,noteLength,lookahead) {
	if(lookahead == null) lookahead = 25.0;
	if(noteLength == null) noteLength = 0.05;
	if(scheduleAheadTime == null) scheduleAheadTime = 0.1;
	this.noteResolution = 0;
	this.noteLength = 0.05;
	this.scheduleAheadTime = 0.1;
	var _g = this;
	this.context = context;
	this.tempo = tempo;
	this.scheduleAheadTime = scheduleAheadTime;
	this.noteLength = noteLength;
	this.lookahead = lookahead;
	this.isPlaying = false;
	this.notesInQueue = [];
	this.nextNoteTime = 0.0;
	this.worker = new Worker("metronomeworker.js");
	this.worker.onmessage = function(e) {
		if(e.data == 2) _g.scheduler(); else console.log("message: " + e.data);
	};
	this.worker.postMessage({ interval : lookahead});
};
om_audio_Metronome.prototype = {
	onTick: function(beatNumber,time) {
	}
	,play: function() {
		this.current16thNote = 0;
		this.nextNoteTime = this.context.currentTime;
		this.worker.postMessage(0);
		this.isPlaying = true;
	}
	,stop: function() {
		this.worker.postMessage(1);
		this.isPlaying = false;
	}
	,dispose: function() {
		if(this.isPlaying) this.stop();
		if(this.worker != null) this.worker.terminate();
	}
	,scheduleNote: function(beatNumber,time) {
		this.notesInQueue.push({ note : beatNumber, time : time});
		if(this.noteResolution == 1 && beatNumber % 2 == 0) return;
		if(this.noteResolution == 2 && beatNumber % 4 == 0) return;
		this.onTick(beatNumber,time);
	}
	,nextNote: function() {
		var secondsPerBeat = 60.0 / this.tempo;
		this.nextNoteTime += 0.25 * secondsPerBeat;
		if(++this.current16thNote == 16) this.current16thNote = 0;
	}
	,scheduler: function() {
		while(this.nextNoteTime < this.context.currentTime + this.scheduleAheadTime) {
			this.scheduleNote(this.current16thNote,this.nextNoteTime);
			this.nextNote();
		}
	}
};
App.last16thNoteDrawn = -1.0;
om_audio_Metronome.WORKER_MSG_START = 0;
om_audio_Metronome.WORKER_MSG_STOP = 1;
om_audio_Metronome.WORKER_MSG_TICK = 2;
App.main();
})(typeof console != "undefined" ? console : {log:function(){}});

//# sourceMappingURL=app.js.map