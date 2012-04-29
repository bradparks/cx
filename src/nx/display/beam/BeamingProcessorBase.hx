package nx.display.beam;

import nx.enums.ENoteValue;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
/**
 * ...
 * @author Jonas Nyström
 */

class BeamingProcessorBase {
	public var valuePattern:Array<ENoteValue>;
	public var dVoice:DisplayVoice; 
	public var forceDirection:EDirectionUAD;
	public function beam(dVoice:DisplayVoice, valuePattern:Array<ENoteValue>, ?forceDirection:EDirectionUAD=null) {
		this.valuePattern = valuePattern;
		this.dVoice = dVoice;
		this.forceDirection = forceDirection;
		
		this.clearBeamlist()
		.adjustPatternLength()
		.findBeamableNotes()
		.filterSingleBeamableNotes()
		.createBeamGroups()
		.calcLevelWeight()
		.setGroupDirection()
		.setDisplayNoteDirections()
		;
	}	
	
	private function setDisplayNoteDirections():BeamingProcessorBase {
		for (bg in dVoice.getBeamlist()) {
			if (Std.is(bg, BeamGroupSingle)) {
				var dNote = bg.getFirstNote();
				dNote.setDirection(bg.getDirection());
			} else {
				for (dNote in bg.getNotes()) {
					dNote.setDirection(bg.getDirection());
				}
			}
		}		
		return this;
	}
	
	private function setGroupDirection():BeamingProcessorBase { 
		//trace('voice direction: ' + dVoice.voice.direction);
		//trace('force direction: ' + this.forceDirection);
		var useDirection:EDirectionUAD = (this.forceDirection != null) ? this.forceDirection : this.dVoice.getDirection();
		//trace('use direction:  ' + useDirection);		
		for (bg in dVoice.getBeamlist()) {
			if (useDirection == EDirectionUAD.Auto) {
				var levelWeight = bg.getLevelTop() + bg.getLevelBottom();
				var levelWeightDirection:EDirectionUD = (levelWeight > 0) ? EDirectionUD.Up : EDirectionUD.Down;
				bg.setDirection(levelWeightDirection);
			} else {
				bg.setDirection(this.directionTranslate(useDirection));
			}
		}
		
		
		return this;
	}
	
	private function directionTranslate(dirUAD:EDirectionUAD):EDirectionUD {
		if (dirUAD == EDirectionUAD.Up) return EDirectionUD.Up;
		return EDirectionUD.Down;
	}
	
	private function calcLevelWeight():BeamingProcessorBase { 
		
		for (bg in dVoice.getBeamlist()) {
			if (Std.is(bg, BeamGroupSingle)) {
				bg.setLevelTop(bg.getFirstNote().getLevelTop());
				bg.setLevelBottom(bg.getFirstNote().getLevelBottom());
			} else {
				for (dNote in bg.getNotes()) {
					if (dNote == bg.getFirstNote()) {
						bg.setLevelTop(dNote.getLevelTop());
						bg.setLevelBottom(dNote.getLevelBottom());
					} else {
						bg.setLevelTop(Std.int(Math.min(bg.getLevelTop(), dNote.getLevelTop())));
						bg.setLevelBottom(Std.int(Math.max(bg.getLevelBottom(), dNote.getLevelBottom())));
					}
				}
			}
		}

		return this;
	}
	private function clearBeamlist():BeamingProcessorBase { 
		this.dVoice.setBeamlist([]);
		return this;
	}
	private function adjustPatternLength():BeamingProcessorBase { //(dVoice:DisplayVoice) {
		var vpValue:Int = 0;
		for (value in valuePattern) vpValue += value.value;
		
		while (vpValue <= dVoice.getValue()) {
			this.valuePattern = Lambda.array(Lambda.concat(this.valuePattern, this.valuePattern));
			vpValue = 0;
			for (value in valuePattern) vpValue += value.value;
			//trace([vpValue, dVoice.value]);
		}
		return this;
	}
	
	private function findBeamableNotes():BeamingProcessorBase {
		var vP = 0;
		var vPos = new IntHash<Int>();
		var vEnd = new IntHash<Int>();
		var i = 0;
		for (v in valuePattern) {			
			var vV = v.value;
			var vE = vP + vV;
			vPos.set(i, vP);
			vEnd.set(i, vE);			
			vP = vE;
			i++;
		}
		//trace(vPos);
		//trace(vEnd);
		//---------------------------------------------------------------		
		var v = 0;
		for (dNote in dVoice.getDisplayNotes()) {
			while (!(dVoice.getDisplayNotePostionEnd(dNote) <= vEnd.get(v))) {
				//trace([dNote.positionEnd, vEnd.get(v)]);
				v++;
			}
			
			
			if ((dVoice.getDisplayNotePosition(dNote) >= vPos.get(v)) && (dNote.getNote().value.beamingLevel > 0)) {
				dNote.beamTemp = v;
			} else {
				dNote.beamTemp = -1;
			}
		}			
		return this;
	}
	
	private function filterSingleBeamableNotes():BeamingProcessorBase {
		var c = new IntHash<Int>();
		for (dNote in dVoice.getDisplayNotes()) {
			if (dNote.beamTemp < 0) continue;
			if (!c.exists(dNote.beamTemp)) c.set(dNote.beamTemp, 0);
			c.set(dNote.beamTemp, c.get(dNote.beamTemp) + 1);
						
		}
		//trace(c);
		for (dNote in dVoice.getDisplayNotes()) {
			if (dNote.beamTemp < 0) continue;
			if (c.get(dNote.beamTemp) < 2) dNote.beamTemp = -2;
		}
		return this;
	}

	private var bgm:BeamGroupMulti;
	
	private function createBeamGroups():BeamingProcessorBase {
		/*
		for (dNote in dVoice.children) {
			trace([dNote.beamTemp, dNote.value, dNote.position, dNote.positionEnd]);
		}
		*/
		var dbm = new IntHash<Array<Int>>();
		var i = 0;
		for (i in 0...dVoice.getDisplayNotes().length) {
			var dNote = dVoice.getDisplayNote(i);
			if (dNote.beamTemp < 0) {
				continue;
			}
			
			if (!(dbm.exists(dNote.beamTemp))) dbm.set(dNote.beamTemp, []);
			var a = dbm.get(dNote.beamTemp);
			a.push(i);
		}		
		//trace(dbm);
		
		for (i in 0...dVoice.getDisplayNotes().length) {
			var dNote = dVoice.getDisplayNote(i);

			if (dbm.exists(dNote.beamTemp)) {

				var a = dbm.get(dNote.beamTemp);

				// first group dNote
				if (i == a[0]) {
					this.bgm = new BeamGroupMulti();
				}
				
				if (this.bgm != null) {
					this.bgm.dNotes.push(dNote);
					dNote.beamGroup = this.bgm;
				}
				
				// last group dNote
				if (i == a[a.length -1]) {
					dVoice.getBeamlist().push(this.bgm);
					
				}
				
			} else {
				var bgs:BeamGroupSingle = new BeamGroupSingle();
				bgs.dNote = dNote;				
				dVoice.getBeamlist().push(bgs);
			}
		}
		return this;
	}
	

}