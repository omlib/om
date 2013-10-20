package om.thread;

typedef Thread = #if cpp cpp.vm.Thread #elseif neko neko.vm.Thread #end;
