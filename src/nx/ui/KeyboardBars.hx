package nx.ui;
import nme.display.Stage;
import nme.events.KeyboardEvent;
import nme.events.TimerEvent;
import nme.utils.Timer;
import nx.display.DBar;
import nx.element.Bar;
import nx.element.Bars;
import nx.element.Head;
import nx.element.Note;
import nx.element.Part;
import nx.element.Voice;
import nx.enums.EDirectionUAD;
import nx.enums.ENoteValue;
import nx.enums.ESign;
import nx.enums.ETie;
import nx.enums.EVoiceType;

/**
 * ...
 * @author Jonas Nyström
 */
using nx.element.util.BarUtil;
using nx.element.util.NoteUtil;
using cx.ArrayTools;

class KeyboardBars 
{
	
	private var barNr:Int = 0;
	private var partNr:Int = 0;
	private var voiceNr:Int = 0;
	private var noteNr:Int = 0;
	private var headNr:Int = 0;
	
	private var bars:Bars;
	private var bar:Bar;
	private var part:Part;
	private var voice:Voice;
	private var note:Note;
	private var head:Head;
	
	private function setBarNr(newBarNr:Int) {
		newBarNr = Std.int(Math.max(0, Math.min(bars.bars.length-1, newBarNr)));
		trace(newBarNr);
		//if (newBarNr == barNr) return barNr;
		bar = bars.bars[newBarNr];
		partNr = Std.int(Math.min(bar.parts.length, partNr));
		part = bar.parts[partNr];
		
		voiceNr = Std.int(Math.min(part.voices.length, voiceNr));
		voice = part.voices[voiceNr];
		
		noteNr = 0; // Std.int(Math.min(voice.notes.length, noteNr));
		note = voice.notes[0];					
		return newBarNr;			
	}
	
	private function setBar(_barNr:Int = 0, _partNr:Int = 0, _voiceNr:Int = 0, _noteNr:Int = 0) {
		barNr = Std.int(Math.max(0, Math.min(bars.bars.length-1, _barNr)));
		bar = bars.bars[barNr];
		
		partNr = Std.int(Math.min(bar.parts.length-1, _partNr));
		part = bar.parts[partNr];
		
		voiceNr = Std.int(Math.min(part.voices.length-1, _voiceNr));
		voice = part.voices[voiceNr];
		
		noteNr = Std.int(Math.min(voice.notes.length-1, _noteNr));
		note = voice.notes[noteNr];							
	}
	
	
	private function setNoteNr(newNoteNr:Int) {
		if (newNoteNr < 0) {
			if (barNr > 0) {
				trace ('BACK');
				//barNr = setBarNr(barNr - 1);
				//newNoteNr = voice.notes.length - 1;															
				setBar(barNr - 1, partNr, voiceNr, 1000);
			} else {
				trace('CANT BACK');
				//return 0;
			}
		} else if (newNoteNr > voice.notes.length - 1) {
			if (barNr < bars.bars.length) {				
				trace('FORW');
				//barNr = setBarNr(barNr + 1);
				//newNoteNr = noteNr;
				setBar(barNr + 1, partNr, voiceNr, 0);
				
			} else {
				trace('CANT FORW');
				//return voice.notes.length - 1;
			}
		} else {
			//noteNr = newNoteNr;
			setBar(barNr, partNr, voiceNr, newNoteNr);
		}
	}	
	
	private function key(keyCode:Int):Bool {
		var render:Bool = false;
		switch(keyCode) {
				
			// Home
			case 36: {
				setBar(barNr - 1, partNr, voiceNr, 0);
			}
			
			// End
			case 35: {
				setBar(barNr + 1, partNr, voiceNr, 0);
			}
			
			// Right, Ö
			case 39, 186: {
				setNoteNr(noteNr + 1);
			}
			
			// Left, K:
			case 37, 107: {
				setNoteNr(noteNr - 1);
			}
			
			// PageUp
			case 33: {
				setBar(barNr, partNr - 1, voiceNr, noteNr);
			}
			
			// PageDown
			case 34: {
				setBar(barNr, partNr + 1, voiceNr, noteNr);
			}
			
			// V
			case 118: {
				if (part.voices.length > 1) {
					var v = (voiceNr == 0) ? 1 : 0;
					setBar(barNr, partNr, v, noteNr);						
				}
			}
			
			// Up, O
			case 38, 111: {
				note.setLevel( -1);					
				bar = bar.clone();
				render = true;
			}
			
			// Down, L
			case 40, 108: {
				note.setLevel(1);					
				bar = bar.clone();
				render = true;
			}
			
			// Insert
			case 45: {
				if (voice.type == EVoiceType.Barpause) {
					voice.type = EVoiceType.Normal;
					setBar(barNr, partNr, voiceNr, noteNr);
				} else {				
					var newNote = note.clone(); // new Note(note.notevalue);
					voice.notes.insert(voice.notes.index(note) + 1, newNote);				
					setBar(barNr, partNr, voiceNr, noteNr + 1);
				}
				bar = bar.clone();
				render = true;				
			}
			
			// Delete
			case 46: {
				if (voice.notes.length > 1) {
					voice.notes.splice(voice.notes.index(note), 1);
					setBar(barNr, partNr, voiceNr, noteNr);
					bar = bar.clone();		
					render = true;
				} else {
					trace('cant remove!');
					voice.type = EVoiceType.Barpause;
					bar = bar.clone();		
					render = true;					
				}
				
			}
			
			
			case 98, 50: {
				note.setValue(ENoteValue.Nv16);
				bar = bar.clone();
				render = true;
			}			

			case 99, 51: {
				note.setValue(ENoteValue.Nv8);
				bar = bar.clone();
				render = true;
			}			
			
			// Num 4, 4
			case 100, 52: {
				note.setValue(ENoteValue.Nv4);
				bar = bar.clone();
				render = true;
			}
			
			case 101, 53: {
				note.setValue(ENoteValue.Nv2);
				bar = bar.clone();
				render = true;
			}
			
			case 102, 54: {
				note.setValue(ENoteValue.Nv1);
				bar = bar.clone();
				render = true;
			}			
			
			// num 7
			case 103: {				
				var sign = (note.heads[0].sign == ESign.None) ? ESign.Natural : ESign.None;
				note.setSign(sign);
				bar = bar.clone();
				render = true;				
			}
			
			// num 8
			case 104: {				
				var sign = (note.heads[0].sign == ESign.None) ? ESign.Flat : ESign.None;
				note.setSign(sign);
				bar = bar.clone();
				render = true;				
			}
			
			// num 9
			case 105: {				
				var sign = (note.heads[0].sign == ESign.None) ? ESign.Sharp : ESign.None;
				note.setSign(sign);
				bar = bar.clone();
				render = true;				
			}
			
			// -
			case 191: {
				var tie = (note.heads[0].tie != null) ? null : ETie.Tie(EDirectionUAD.Auto);
				note.setTie(tie);
				bar = bar.clone();
				render = true;				
			}
			
			// X
			case 120: {
				var newBar = bar.clone();
				bars.bars.push(newBar);
				render = true;
			}
			
			
			// Esc
			case 27: renderCallback();
		default:
			trace(keyCode);
				
		}
		return render;		
	}
	
	
	private function onKeyDown(e:KeyboardEvent) {
		
		var render = false;
		
		if (!e.ctrlKey && !e.altKey && !e.shiftKey) render = key(e.keyCode);
		
		trace([e.keyCode, barNr, partNr, voiceNr, noteNr, headNr]);
		
		if (render) {
			timer.stop();
			timer.start();			
		}
		
	}
	
	private var timer:Timer;
	private var renderCallback:Void->Void;
	
	public function new(stage:Stage, bars:Bars, renderCallback:Void->Void=null) {
		this.bars = bars;
		this.renderCallback = renderCallback;
		timer = new Timer(300);
		timer.addEventListener(TimerEvent.TIMER, onKeyTimer);
		
		setBarNr(0);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onKeyTimer(e:TimerEvent):Void {
		trace('TIMER');
		timer.stop();
		this.renderCallback();
	}
	
}