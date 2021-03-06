package cx;


/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class ValidationTools {
	
	static public function isValidEmail( email : String ) : Bool {
		if (email == null) return false;
		var emailExpression : EReg = ~/^[\w-\.]{2,}@[ÅÄÖåäö\w-\.]{2,}\.[a-z]{2,6}$/i;
		return emailExpression.match( email );
	}	
	
	static public function isValidPersonnrLong( personnr: String ) : Bool {
		if (personnr == null) return false;
		if (personnr.charAt(8) != '-') return false;
		var segments = personnr.split('-');
		if (segments[0].length != 8) return false;
		if (segments[1].length != 4) return false;
		if (Std.parseInt(segments[0]) == null) return false;
		if (Std.parseInt(segments[1]) == null) return false;
		return true;
	}
	
	static public function isValidFornamn(namn:String):Bool {
		
		if (! RegexTools.hasSwedishNameChars(namn)) return false;		
		if (RegexTools.hasNumber(namn)) return false;
		if (namn == null) return false;
		if (namn.trim() == '') return false;
		if (namn.startsWith(' ')) return false;
		if (namn.endsWith(' ')) return false;
		if (namn.length < 2) return false;
		if (namn.length > 24) return false;
		
		if (namn.charAt(0).toUpperCase() != namn.charAt(0)) return false;		
		
		return true;
	}
	
	static public function isValidEfternamn(namn:String):Bool {
		var bprefs = ['de la ', 'von ', 'af ', 'de '];
		
		for (bpref in bprefs) {
			if (namn.toLowerCase().startsWith(bpref.toLowerCase())) {
				// remove blue prefix
				namn = namn.substr(bpref.length);
			}		
		}
		
		if (! RegexTools.hasSwedishNameChars(namn)) return false;
		if (RegexTools.hasNumber(namn)) return false;
		if (namn == null) return false;
		if (namn.trim() == '') return false;
		if (namn.startsWith(' ')) return false;
		if (namn.endsWith(' ')) return false;
		if (namn.length < 2) return false;
		if (namn.length > 32) return false;
		
		if (namn.charAt(0).toUpperCase() != namn.charAt(0)) return false;
		
		if (namn.split(' ').length > 2) return false;
		if (namn.split('-').length > 2) return false;		
		
		var segs = namn.split(' ');
		for (seg in segs) {
			if (seg.charAt(0).toUpperCase() != seg.charAt(0)) return false;
		}
		
		var segs = namn.split('-');
		for (seg in segs) {
			if (seg.charAt(0).toUpperCase() != seg.charAt(0)) return false;
		}		
		
		
		return true;
	}
	
	
	
}