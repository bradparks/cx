package nx.output;
import cx.NmeTools;
import haxe.unit.TestCase;
import nme.display.Sprite;
import nme.Lib;
import nx.core._TO;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.SpriteTools;
class _TestRender extends TestCase
{
	private var render:Render;
	private var scaling:TScaling;
	private var target:Sprite;
	
	override public function setup() {
		this.target = new Sprite();
		this.render = new Render(this.target, Scaling.getBig());
		render.lines(0, 100, 800);
		render.clef(20, 100);
	}


	
	/*
	 * *********************************************************
	 * 
	 * *********************************************************
	 *
	*/	
	
	public function testDNoteOutput() {
		assertTrue(true);
		render.dnote(0, 0, _TO.dNoteSimple0);		
		_output();
	}
	
	private function _output() {
		Lib.current.addChild(this.target);				
	}

	
}