package om.sys;

#if (macro||nodejs||sys)

class Env {

    public static inline function get( variable : String ) : String {
        return
            #if (macro||sys)
            Sys.getEnv( variable );
            #elseif nodejs
            js.Node.process.env[ variable ];
            #end
    }

}

#end
