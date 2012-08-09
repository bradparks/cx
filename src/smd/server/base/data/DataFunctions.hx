package smd.server.base.data;
import cx.ReflectTools;
import cx.Tools;
import haxe.Firebug;
import neko.Web;
import smd.server.sx.Config;

/**
 * ...
 * @author Jonas Nyström
 */

class DataFunctions 
{
	static public var params:Hash<String>;
	
	public function new() {

		params = Web.getParams();
		if (!params.keys().hasNext()) return;
		
		var keys = Web.getParams().keys();
		var classMethods = ReflectTools.getMethods(this);		
		for (key in keys) {
			var value = params.get(key);
			if (value != Config.secretKey) {
				//trace('wrong key!');
				return;
			}
			
			var funcname = "__" + key;
			//trace(funcname);
			
			if (Lambda.has(classMethods, funcname)) {
				ReflectTools.callMethod(this, funcname, []);
			}			
		}
	}
}