package nx.enums;

/**
 * ...
 * @author Jonas Nyström
 */

class EKey {
	static public var Sharp6 		= new EKey(1);
	static public var Sharp5 		= new EKey(1);
	static public var Sharp4 		= new EKey(1);
	static public var Sharp3 		= new EKey(1);
	static public var Sharp2 		= new EKey(1);
	static public var Sharp1 		= new EKey(1);
	static public var Natural 		= new EKey(0);
	static public var Flat1 		= new EKey(0);
	static public var Flat2 		= new EKey(0);
	static public var Flat3 		= new EKey(0);
	static public var Flat4 		= new EKey(0);
	static public var Flat5 		= new EKey(0);
	static public var Flat6 		= new EKey(0);
	
	public function new(levelShift:Int) {
		this.levelShift = levelShift;
	}
	public var levelShift:Int;
	
}
