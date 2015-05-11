package om.macro;

#if macro

import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;

/**
    Syntax-tolerant, position-aware json parser.

    http://nadako.tumblr.com/post/77106860013/using-haxe-macros-as-syntax-tolerant
    https://gist.github.com/nadako/9081608

    Usage:
        var e = Hxon.parseFile( 'file.hxon' );
        Hxon.validateExpr(e);
        trace( Hxon.extractValue(e) );

*/
class Hxon {

    static inline var QUOTED_FIELD_PREFIX = "@$__hx__";

    public static function parseFile<T>( path : String ) : T {
        var src = sys.io.File.getContent( path );
        var pos = Context.makePosition( { min:0, max:0, file:path } );
        var e = Context.parseInlineString( src, Context.currentPos() );
        validateExpr( e );
        return Hxon.extractValue( e );
    }

    public static function parseString<T>( src : String ) : T {
        var e = Context.parseInlineString( src, Context.currentPos() );
        validateExpr( e );
        return Hxon.extractValue( e );
    }

    public static function validateExpr( e : Expr ) {
        switch e.expr {
        case EConst( CInt(_) | CFloat(_) | CString(_) | CIdent("true"|"false"|"null") ): // constants
        case EBlock([]): // empty object
        case EObjectDecl(fields): for( f in fields ) validateExpr(f.expr);
        case EArrayDecl(exprs): for( e in exprs ) validateExpr(e);
        default:
            throw new Error( "Invalid JSON expression: " + e.toString(), e.pos );
        }
        return null;
    }

    public static function extractValue( e : Expr ) : Dynamic {
        switch e.expr {
        case EConst(c):
            switch c {
            case CInt(s):
                var i = Std.parseInt(s);
                return (i != null) ? i : Std.parseFloat(s); // If the number exceeds standard int return as float
            case CFloat(s):
                return Std.parseFloat(s);
            case CString(s):
                return s;
            case CIdent("null"):
                return null;
            case CIdent("true"):
                return true;
            case CIdent("false"):
                return false;
            default:
            }
        case EBlock([]):
            return {};
        case EObjectDecl(fields):
            var obj = {};
            for( field in fields )
                Reflect.setField( obj, unquoteField( field.field ), extractValue( field.expr ) );
            return obj;
        case EArrayDecl(exprs):
            return [for(e in exprs) extractValue(e)];
        default:
        }
        throw new Error( "Invalid JSON expression: " + e.toString(), e.pos );
    }

    static function unquoteField( name : String ) : String {
        return (name.indexOf( QUOTED_FIELD_PREFIX ) == 0) ? name.substr( QUOTED_FIELD_PREFIX.length ) : name;
    }

}

#end
