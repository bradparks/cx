package cx;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class StrTools 
{
	static public function tab(str:String) {
		return str + '\t';
	}

	static public function newline(str:String) {
		return str + '\n';
	}
	
	static public function repeat(repeatString:String, count:Int) {
		var result = '';
		for (i in 0...count) result += repeatString;
		return result;
	}
	
	static public function fill(str:String, toLength:Int = 32, with:String=' ', replaceNull:String='-') {
		if (str == null) str = replaceNull;
		do { str += with; } while (str.length < toLength);
		return str.substr(0, toLength);
	}	
	
	static public function splitTrim(str:String, delimiter:String=','):Array<String> {
		var a = str.split(delimiter);
		var a2 = new Array<String>();
		for (part in a) {
			var part2 = StringTools.trim(part);
			if (part.length > 0) a2.push(part);
		}
		return a2;
		/*
		var a2 = Lambda.array(Lambda.map(a, function(item) { 
			var part = StringTools.trim(item); 
			if (part.length > 0) return part;			
			} ));
		return a2;
		*/
	}	
	
	static public function replaceNull(str:String, with:String = '-'):String {
		return (str == null) ? with : str;
	}	
	
	static public function firstUpperCase(str:String):String {
		return str.substr(0, 1).toUpperCase() + str.substr(1).toLowerCase();
	}
	
	static public function afterLast(str:String, char:String, includeChar:Bool=false):String {
		var idx = str.lastIndexOf(char);
		if (!includeChar) idx += char.length;
		return str.substr(idx);
	}		
	
	static public function similarityCaseIgnore(strA:String, strB:String):Float {
		return similarity(strA.toLowerCase(), strB.toLowerCase());
	}
	
	static public function similarityCaseBalance(strA:String, strB:String):Float {
		return (similarity(strA, strB) + similarity(strA.toLowerCase(), strB.toLowerCase())) / 2;
	}
	
	static public function similarity(strA:String, strB:String):Float {
		if (strA == strB) return 1;
		function sim(strA:String, strB:String) {
			var score = _similarity(strA, strB);
			// if different length, swap and run a second pass...	
			if (strA.length != strB.length) score = (score + _similarity(strB, strA)) / 2;
			return score;
		}
		return sim(strA, strB);
	}
	
	static public function similarityAssymetric(strShorter:String, strLonger:String):Float {
		if (strShorter == strLonger) return 1;
		return  _similarity(strShorter, strShorter);
	}
	
	static public function _similarity(strA:String, strB:String) {
		var lengthA = strA.length;
		var lengthB = strB.length;
		var i = 0;
		var segmentCount = 0;
		var segmentsInfos = new Array<SimilaritySegment>();
		var segment = '';
		while (i < lengthA) {
			var char = strA.charAt(i);
			if (strB.indexOf(char) > -1) {
				segment += char;
				if (strB.indexOf(segment) > -1) {
					var segmentPosA = i - segment.length + 1;
					var segmentPosB = strB.indexOf(segment);
					var positionDiff = Math.abs(segmentPosA - segmentPosB);
					var posFactor = (lengthA - positionDiff) / lengthB;
					var lengthFactor = segment.length / lengthA;
					segmentsInfos[segmentCount] = { segment:segment, score:posFactor * lengthFactor };
				} else {
					segment = '';
					segmentCount++;
					i--;
				}
			} else {
				segment = '';
				segmentCount++;
			}
			i++;
		}
		
		var usedSegmentsCount = -2;
		var totalScore = 0.0;
		for (si in segmentsInfos) {
			if (si != null) {
				totalScore += si.score;
				usedSegmentsCount++;
			}
		}
		// every used segment more than 2 gives a tiny score minus
		totalScore = totalScore - (Math.max(usedSegmentsCount, 0) * 0.02);
		return Math.max(0, Math.min(totalScore, 1));
	}
	
}

typedef SimilaritySegment = {
	segment:String,
	score:Float
}