package nx.test;
import cx.NmeTools;
import haxe.Stack;
import nme.geom.Rectangle;
import nx.display.DisplayNote;
import nx.display.utils.DisplayNoteUtils;
import nx.element.Note;
import nx.element.Head;
import nx.element.post.PostTie;
import nx.element.pre.PreApoggiatura;
import nx.element.pre.PreArpeggio;
import nx.element.pre.PreClef;
import nx.element.pre.PreTie;
import nx.enums.EClef;
import nx.test.base.TestBasePng;
import nx.enums.ESign;
import nx.enums.EDirectionUD;
import nx.enums.ENoteValue;
import nx.output.Scaling;
import nx.output.Render;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.NmeTools;
class TestRenderDisplayNote extends TestBasePng
{
	override function setup() {
		super.setup();		
		var y = 100;		
		var scaling = Scaling.getBig();
		var render = new Render(this.sprite, scaling);		
		render.clef(10, y);
		render.lines(10, y, 980);		
	}
	
	public function test0() {
		var y = 100;
		var scaling = Scaling.getBig();		
		var render = new Render(this.sprite, scaling);

		var dn = new DisplayNote(Note.getNew([Head.getNew( -2, ESign.Flat), Head.getNew(-1, ESign.None), Head.getNew(0, ESign.None), Head.getNew(1, ESign.Sharp), Head.getNew( 5, ESign.Natural)], ENoteValue.Nv4));		
		
		var x = 150;
		render.note(x, y, dn);	
		render.noteRects(x, y, dn);
		
		dn.setDirection(EDirectionUD.Down);		
		var x = 300;
		render.note(x, y, dn);	
		render.noteRects(x, y, dn);
		
		var y = 200;
		var render = new Render(this.sprite, Scaling.getNormal());		
		render.clef(10, y);
		render.lines(10, y, 900);
		render.note(x, y, dn);	

		var y = 300;
		var render = new Render(this.sprite, Scaling.getSmall());		
		render.clef(10, y);
		render.lines(10, y, 900);
		render.note(x, y, dn);			

		//this.spriteSave('test0.png');
		assertTrue(true);
	}
	
	public function test1() {
		assertTrue(true);
		var y = 100;		
		var render = new Render(this.sprite, Scaling.getBig());

		var x = 500;
		var dnOver = new DisplayNote(Note.getNew([Head.getNew(2)]), EDirectionUD.Up);
		//render.note(x, y, dnOver);	
		render.noteRects(x, y, dnOver);
		
		var x = 600;
		var dnUnder = new DisplayNote(Note.getNew([Head.getNew(2)]), EDirectionUD.Down);
		//render.note(x, y, dnUnder);	
		render.noteRects(x, y, dnUnder);
		//DisplayNoteUtils.overlapHeads(dnOver, dnUnder);
		//this.spriteSave('test1.png');
	}
	
	
	public function test2() {		
		/*
		var ra1 = [new Rectangle(0, 0, 10, 10), new Rectangle(20, 0, 10, 10)];
		var ra2 = [new Rectangle(0, 50, 5, 5), new Rectangle (20, 50, 5, 50)];
		this.sprite.graphics.lineStyle(1, 0xFF0000);
		for (r in ra1) {
			this.sprite.graphics.drawRect(r.x, r.y, r.width, r.height);
		}
		this.sprite.graphics.lineStyle(1, 0x00FF00);
		for (r in ra2) {
			this.sprite.graphics.drawRect(r.x, r.y, r.width, r.height);
		}
		this.sprite.graphics.lineStyle(1, 0x0000FF);
		var r = NmeTools.rectangleArraysIntersection(ra1, ra2);
		if (r != null) this.sprite.graphics.drawRect(r.x, r.y, r.width, r.height);
		
		this.spriteSave('test2.png', 100, 100);
		assertTrue(true);
		*/
		var render = new Render(this.sprite, Scaling.getBig());
		var x = 100;
		var y = 100;
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0)]));
		render.note(100, y, dn);
		render.noteRects(100, y, dn);
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)]));
		render.note(200, y, dn);
		render.noteRects(200, y, dn);
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)], ENoteValue.Nv4dot));
		render.note(300, y, dn);
		render.noteRects(300, y, dn);

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4dot));
		render.note(400, y, dn);
		render.noteRects(400, y, dn);		

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4dot), EDirectionUD.Up);
		render.note(500, y, dn);
		render.noteRects(500, y, dn);			

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4ddot), EDirectionUD.Up);
		render.note(600, y, dn);
		render.noteRects(600, y, dn);			
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var dn = new DisplayNote(Note.getNew([h]));
		render.note(700, y, dn);
		render.noteRects(700, y, dn);		
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew(2);
		h2.setTieFrom(new PostTie());		
		var dn = new DisplayNote(Note.getNew([h, h2], ENoteValue.Nv4dot));
		render.note(800, y, dn);
		render.noteRects(800, y, dn);		
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew(-2);
		h2.setTieFrom(new PostTie());		
		var dn = new DisplayNote(Note.getNew([h, h2], ENoteValue.Nv4dot));
		render.note(900, y, dn);
		render.noteRects(900, y, dn);			
		
		
		var y = 300;		
		render.clef(10, y);
		render.lines(10, y, 980);			
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0)]));
		render.note(100, y, dn);
		render.noteRects(100, y, dn);
		
		
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat)]));
		render.note(200, y, dn);
		render.noteRects(200, y, dn);
		
		var h = Head.getNew(0); // 
		h.setApoggiatura(new PreApoggiatura());		
		var dn = new DisplayNote(Note.getNew([h]));
		dn.getAppogiaturaDisplayRect();
		render.note(300, y, dn);
		render.noteRects(300, y, dn);

		var h = Head.getNew(0, ESign.Sharp); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3, ESign.Natural); h2.setApoggiatura(new PreApoggiatura());
		var h3 = Head.getNew(-4); h3.setApoggiatura(new PreApoggiatura());				
		var dn = new DisplayNote(Note.getNew([h, h2, h3, Head.getNew(1)]));
		render.note(400, y, dn);
		render.noteRects(400, y, dn);		
		
		var h = Head.getNew(0); 
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew(-4); h3.setApoggiatura(new PreApoggiatura());
		var dn = new DisplayNote(Note.getNew([h, h2, h3, Head.getNew(2, ESign.Flat)]));
		render.note(500, y, dn);
		render.noteRects(500, y, dn);		

		var h = Head.getNew(0); 
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, h2, h3, Head.getNew(2, ESign.Flat)]);
		n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(650, y, dn);
		render.noteRects(650, y, dn);			
		
		var h = Head.getNew(0); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, h2, h3, Head.getNew(2)]);
		n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(750, y, dn);
		render.noteRects(750, y, dn);			
		
		var h = Head.getNew(0); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3); 
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, h2, h3, Head.getNew(2, ESign.Flat)]);
		n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(900, y, dn);
		render.noteRects(900, y, dn);				
		
		var y = 500;		
		render.clef(10, y);
		render.lines(10, y, 980);			
		
		var h = Head.getNew(0, ESign.Flat);
		h.setTieTo(new PreTie());
		h.setApoggiatura(new PreApoggiatura());
		var n = Note.getNew([h, Head.getNew(3)]);
		n.setClef(new PreClef(EClef.ClefC, -3));
		n.setArpeggio(new PreArpeggio());
		var dn = new DisplayNote(n);
		render.note(300, y, dn);
		render.noteRects(300, y, dn);	

		/*
		var h = Head.getNew(0); h.setApoggiatura(new PreApoggiatura());
		var h2 = Head.getNew(-3); h2.setApoggiatura(new PreApoggiatura());
		var h3 = Head.getNew( -4); h3.setApoggiatura(new PreApoggiatura());				
		var n = Note.getNew([h, h2, h3, Head.getNew(1)]);
		//n.setArpeggio(new PreArpeggio(0, 0));
		var dn = new DisplayNote(n);
		render.note(500, y, dn);
		render.noteRects(500, y, dn);			
		*/
		
		
		/*
		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4dot));
		render.note(400, y, dn);
		render.noteRects(400, y, dn);		

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4dot), EDirectionUD.Up);
		render.note(500, y, dn);
		render.noteRects(500, y, dn);			

		var dn = new DisplayNote(Note.getNew([Head.getNew(0, ESign.Flat), Head.getNew(-1)], ENoteValue.Nv4ddot), EDirectionUD.Up);
		render.note(600, y, dn);
		render.noteRects(600, y, dn);			
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var dn = new DisplayNote(Note.getNew([h]));
		render.note(700, y, dn);
		render.noteRects(700, y, dn);		
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew(2);
		h2.setTieFrom(new PostTie());		
		var dn = new DisplayNote(Note.getNew([h, h2], ENoteValue.Nv4dot));
		render.note(800, y, dn);
		render.noteRects(800, y, dn);		
		
		var h = Head.getNew(0); // 
		h.setTieFrom(new PostTie());
		var h2 = Head.getNew(-2);
		h2.setTieFrom(new PostTie());		
		var dn = new DisplayNote(Note.getNew([h, h2], ENoteValue.Nv4dot));
		render.note(900, y, dn);
		render.noteRects(900, y, dn);					
		*/
		
		
		
		
		this.spriteSave('test2.png');
		assertTrue(true);
		
	}
	

}