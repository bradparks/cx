package cx;

/**
 * ...
 * @author Jonas Nyström
 */

class EnvTools 
{
	
	#if neko 
		static public function getComputername():String return neko.Sys.getEnv('COMPUTERNAME')
	#else if cpp
		static public function getComputername():String return cpp.Sys.getEnv('COMPUTERNAME')
	#end
	
}