package om.thread;

typedef Mutex = #if cpp cpp.vm.Mutex #elseif neko neko.vm.Mutex #end;
