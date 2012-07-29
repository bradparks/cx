package nx.core.element;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;
import nx.enums.ESign;

/**
 * ...
 * @author Jonas Nyström
 */

class Voice 
{
	public function new(notes:Iterable<Note>=null, direction:EDirectionUAD=null)  {
		this.notes = (notes != null) ? Lambda.array(notes) : [new Note()];
		this.direction = direction;
	}

	public var notes(default, null):Array<Note>;
	public var direction(default, null):EDirectionUAD;
	
	static public function _test0() {
		return new Voice([
				new Note([new Head(3)], ENoteValue.Nv2),
				new Note([new Head(0)], ENoteValue.Nv2),
			]);
	}

	static public function _test0Down() {
		return new Voice([
				new Note([new Head(3)], ENoteValue.Nv2),
				new Note([new Head(0)], ENoteValue.Nv2),
			], EDirectionUAD.Down);
	}	
	
	static public function _test0Up() {
		return new Voice([
				new Note([new Head(3)], ENoteValue.Nv2),
				new Note([new Head(0)], ENoteValue.Nv2),
			], EDirectionUAD.Up);
	}		
	
	
	static public function _test1() {
		return new Voice([
				new Note([new Head(-2)], ENoteValue.Nv2dot),
				new Note([new Head(-3)], ENoteValue.Nv4),
			]);
	}
	
	static public function _test2() {
		return new Voice([
				new Note([new Head(0)]),
				new Note([new Head(2)]),
				new Note([new Head(-1)]),
				new Note([new Head(-0)]),
			]);
	}
	
	static public function _test2Down() {
		return new Voice([
				new Note([new Head(3)]),
				new Note([new Head(4)]),
				new Note([new Head(2)]),
				new Note([new Head(2)]),
			], EDirectionUAD.Down);
	}		
	
	static public function _test2Up() {
		return new Voice([
				new Note([new Head(0)]),
				new Note([new Head(2)]),
				new Note([new Head(-1)]),
				new Note([new Head(0, ESign.Flat)]),
			], EDirectionUAD.Up);
	}	
	
	
	static public function _test3() {
		return new Voice([
				new Note([new Head(0)], ENoteValue.Nv4dot),
				new Note([new Head(2)], ENoteValue.Nv16),
				new Note([new Head(-1, ESign.Sharp)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv8),
				new Note([new Head(-3, ESign.Flat)], ENoteValue.Nv16),
				new Note([new Head(-1)], ENoteValue.Nv16),
				new Note([new Head(0)], ENoteValue.Nv4),
			]);
	}
	
	static public function _test3Up() {
		return new Voice([
				new Note([new Head(1)], ENoteValue.Nv4dot),
				new Note([new Head(-2)], ENoteValue.Nv16),
				new Note([new Head(-2, ESign.Sharp)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv8),
				new Note([new Head(-2, ESign.Flat)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv16),
				new Note([new Head(-2)], ENoteValue.Nv4),
			], EDirectionUAD.Up);
	}	

		
			
}


