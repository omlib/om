package om.input;

import js.Browser.document;
import js.html.Element;
import js.html.FileList;

class FileDropArea {

	public dynamic function onInput( files : FileList ) {}

	public var target(default,null) : Element;
	public var active(default,null) = false;

	public function new( ?target : Element ) {
		if( target == null ) target = document.body;
		this.target = target;
	}

	public function start() : FileDropArea {
		active = true;
		target.addEventListener( 'dragover', onDragOver, false );
		target.addEventListener( 'dragenter', onDragEnter, false );
		target.addEventListener( 'drop', onDrop, false );
		return this;
	}

	public function stop() : FileDropArea {
		active = false;
		target.removeEventListener( 'dragover', onDragOver );
		target.removeEventListener( 'dragenter', onDragEnter );
		target.removeEventListener( 'drop', onDrop );
		return this;
	}

	function onDragOver(e) {
		e.stopPropagation();
		e.preventDefault();
		return false;
	}

	function onDragEnter(e) {
		e.stopPropagation();
		e.preventDefault();
		return false;
	}

	function onDrop(e) {
		e.stopPropagation();
    	e.preventDefault();
		//e.dataTransfer.dropEffect = 'copy';
		//$type(e.dataTransfer);
		var files = e.dataTransfer.files;
		onInput( files );
	}

}
