package om;

import js.Browser.window;

class Console {

    public static inline function print( obj : Dynamic ) { #if (!no_console&&!doc_gen) log( obj ); #end }

    public static inline function log( obj : Dynamic ) { #if (!no_console&&!doc_gen) window.console.log( obj ); #end }
	public static inline function info( obj : Dynamic ) { #if (!no_console&&!doc_gen) window.console.info( obj ); #end }
	public static inline function debug( obj : Dynamic ) { #if (!no_console&&!doc_gen) window.console.debug( obj ); #end }
	public static inline function warn( obj : Dynamic ) { #if (!no_console&&!doc_gen) window.console.warn( obj ); #end }
	public static inline function error( obj : Dynamic ) { #if (!no_console&&!doc_gen) window.console.error( obj ); #end }

	public static inline function assert( expression : Dynamic, obj : Dynamic ) { #if (!no_console&&!doc_gen)  window.console.assert( expression, obj ); #end }

	public static inline function count( label : String ) { #if (!no_console&&!doc_gen)  window.console.count( label ); #end }

	public static inline function dir( obj : Dynamic ) { #if (!no_console&&!doc_gen)  window.console.dir( obj ); #end }
	public static inline function dirxml( obj : Dynamic ) { #if (!no_console&&!doc_gen)  untyped window.console.dirxml( obj ); #end }

	public static inline function group( obj : Dynamic ) { #if (!no_console&&!doc_gen)  window.console.group( obj ); #end }
	public static inline function groupCollapsed( obj : Dynamic ) { #if (!no_console&&!doc_gen)  window.console.groupCollapsed( obj ); #end }
	public static inline function groupEnd() { #if (!no_console&&!doc_gen)  window.console.groupEnd(); #end }

	public static inline function profile( label : String ) { #if (!no_console&&!doc_gen)  window.console.profile( label ); #end }
	public static inline function profileEnd() { #if (!no_console&&!doc_gen)  window.console.profileEnd(); #end }

	public static inline function time( label : String ) { #if (!no_console&&!doc_gen)  window.console.time( label ); #end }
	public static inline function timeEnd( label : String ) { #if (!no_console&&!doc_gen)  window.console.timeEnd( label ); #end }

	public static inline function timeline( label : String ) { #if (!no_console&&!doc_gen)  untyped window.console.timeline( label ); #end }
	public static inline function timelineEnd( label : String ) { #if (!no_console&&!doc_gen)  untyped window.console.timelineEnd( label ); #end }
	public static inline function timeStamp( label : String ) { #if (!no_console&&!doc_gen)  untyped window.console.timeStamp( label ); #end }

	public static inline function trace( obj : Dynamic ) { #if (!no_console&&!doc_gen) untyped console.trace( obj ); #end }

	public static inline function clear() { #if (!no_console&&!doc_gen)  untyped window.console.clear(); #end }

}
