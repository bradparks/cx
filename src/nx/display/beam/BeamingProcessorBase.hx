package nx.display.beam;

import nx.core.display.DNote;
import nx.core.display.DVoice;
import nx.enums.ENoteType;
import nx.enums.ENoteValue;
import nx.enums.EDirectionUAD;
import nx.enums.EDirectionUD;
import nme.ObjectHash;
/**
 * ...
 * @author Jonas Nyström
 */

class BeamingProcessorBase {
	public var valuePattern:Array<ENoteValue>;
	public var dVoice:DVoice; 
	public var forceDirection:EDirectionUAD;
	
	public function beam(dVoice:DVoice, valuePattern:Array<ENoteValue>, ?forceDirection:EDirectionUAD=null) {
		this.valuePattern = valuePattern;
		this.dVoice = dVoice;
		this.forceDirection = forceDirection;
		
		
		this.clearBeamlist()
		.adjustPatternLength()
		
		.preparePatternCalculation()
		.createBeamGroups2()
		
		.findBeamableNotes()
		.filterSingleBeamableNotes()
		.createBeamGroups()
		.calcLevelWeight()
		.setGroupDirection()
		.setDisplayNoteDirections()
		
		.traceBeamGroups()
		;
	}	
	

	

	

	
	private function clearBeamlist():BeamingProcessorBase { 
		//trace('clearBeamlist');
		//this.dVoice.setBeamGroups([]);
		this.dVoice.beamGroupsClear();
		return this;
	}	
	
	private function adjustPatternLength():BeamingProcessorBase { //(dVoice:DisplayVoice) {
		//trace('adjustPatternLength');
		var vpValue:Int = 0;
		for (value in valuePattern) vpValue += value.value;
		
		while (vpValue <= dVoice.value) {
			this.valuePattern = Lambda.array(Lambda.concat(this.valuePattern, this.valuePattern));
			vpValue = 0;
			for (value in valuePattern) vpValue += value.value;
			//trace([vpValue, dVoice.value]);
		}
		return this;
	}	
	
	private function findBeamableNotes():BeamingProcessorBase {
		//trace('find beamable');
		
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
		for (dNote in dVoice.dnotes) {
			
			while (!(dVoice.dnotePositionEnd.get(dNote) <= vEnd.get(v))) {
				//trace([dNote.positionEnd, vEnd.get(v)]);
				v++;
			}
			
			//trace([dNote.notevalue, dNote.type]);		
			
			if ((dVoice.dnotePositionEnd.get(dNote) >= vPos.get(v)) && (dNote.notevalue.beamingLevel > 0) && (dNote.notetype == ENoteType.Normal ) ) {
				dNote.beamTemp = v;
			} else {
				dNote.beamTemp = -1;
			}
		}			
		return this;
	}	
	
	private function filterSingleBeamableNotes():BeamingProcessorBase {
		var c = new IntHash<Int>();
		for (dNote in dVoice.dnotes) {
			if (dNote.beamTemp < 0) continue;
			if (!c.exists(dNote.beamTemp)) c.set(dNote.beamTemp, 0);
			c.set(dNote.beamTemp, c.get(dNote.beamTemp) + 1);
						
		}
		//trace(c);
		for (dNote in dVoice.dnotes) {
			if (dNote.beamTemp < 0) continue;
			if (c.get(dNote.beamTemp) < 2) dNote.beamTemp = -2;
		}
		return this;
	}	
	
	private var bgm:BeamGroupMulti;
	
	private function createBeamGroups():BeamingProcessorBase {
		var dbm = new IntHash<Array<Int>>();
		var i = 0;
		for (i in 0...dVoice.dnotes.length) {
			var dNote = dVoice.dnote(i);
			if (dNote.beamTemp < 0) {
				continue;
			}
			
			if (!(dbm.exists(dNote.beamTemp))) dbm.set(dNote.beamTemp, []);
			var a = dbm.get(dNote.beamTemp);
			a.push(i);
		}		
		//trace(dbm);
		
		for (i in 0...dVoice.dnotes.length) {
			var dNote = dVoice.dnote(i);

			if (dbm.exists(dNote.beamTemp)) {

				var a = dbm.get(dNote.beamTemp);

				// first group dNote
				if (i == a[0]) {
					this.bgm = new BeamGroupMulti();
					this.bgm.firstType = dNote.notetype;
					this.bgm.firstNotevalue = dNote.notevalue;
				}
				
				if (this.bgm != null) {
					this.bgm.dNotes.push(dNote);
					dNote.beamGroup = this.bgm;
				}
				
				// last group dNote
				if (i == a[a.length -1]) {
					//dVoice.getBeamGroups().push(this.bgm);
					dVoice.beamGroupsAdd(this.bgm);
				}
				
			} else {
				var bgs:BeamGroupSingle = new BeamGroupSingle();
				bgs.dNote = dNote;				
				
				bgs.firstType = dNote.notetype;
				bgs.firstNotevalue = dNote.notevalue;
				
				//dVoice.getBeamGroups().push(bgs);
				dVoice.beamGroupsAdd(bgs);
			}
		}
		return this;
	}	
	
	private function calcLevelWeight():BeamingProcessorBase { 
		for (bg in dVoice.beamGroups) {
			if (Std.is(bg, BeamGroupSingle)) {
				bg.setLevelTop(bg.getFirstNote().levelTop);
				bg.setLevelBottom(bg.getFirstNote().levelBottom);
			} else {
				for (dNote in bg.getNotes()) {
					if (dNote == bg.getFirstNote()) {
						bg.setLevelTop(dNote.levelTop);
						bg.setLevelBottom(dNote.levelBottom);
					} else {
						bg.setLevelTop(Std.int(Math.min(bg.getLevelTop(), dNote.levelTop)));
						bg.setLevelBottom(Std.int(Math.max(bg.getLevelBottom(), dNote.levelBottom)));
					}
				}
			}
		}

		return this;
	}

	private function setGroupDirection():BeamingProcessorBase { 
		//trace('voice direction: ' + dVoice.voice.direction);
		//trace('force direction: ' + this.forceDirection);
		var useDirection:EDirectionUAD = (this.forceDirection != null) ? this.forceDirection : this.dVoice.direction;
		if (useDirection == null) useDirection = EDirectionUAD.Auto;
		//trace('use direction:  ' + useDirection);		
		for (bg in dVoice.beamGroups) {
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
	
	private function setDisplayNoteDirections():BeamingProcessorBase {
		for (bg in dVoice.beamGroups) {
			if (Std.is(bg, BeamGroupSingle)) {
				var dNote = bg.getFirstNote();
				//dNote.setDirection(bg.getDirection());
				dNote.direction = bg.getDirection();
			} else {
				for (dNote in bg.getNotes()) {
					//dNote.setDirection(bg.getDirection());
					dNote.direction = bg.getDirection();
				}
			}
		}		
		return this;
	}

	
	/*

	private var bgm:BeamGroupMulti;
	
	private function createBeamGroups():BeamingProcessorBase {

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
					dVoice.getBeamGroups().push(this.bgm);
					
				}
				
			} else {
				var bgs:BeamGroupSingle = new BeamGroupSingle();
				bgs.dNote = dNote;				
				dVoice.getBeamGroups().push(bgs);
			}
		}
		return this;
	}
	*/
	

	

	
	private var patternValuePos:Array<Int>;
	private var patternValueEnd: Array<Int>;
	
	
	
	private function preparePatternCalculation() {
		
		trace('preparePatternCalculation');
		
		patternValuePos = [];
		patternValueEnd = [];		
		
		var vPos = 0;
		var i = 0;
		for (v in valuePattern) {			
			var vValue = v.value;
			var vEnd = vPos + vValue;
			patternValuePos.push(vPos);
			patternValueEnd.push(vEnd);			
			vPos = vEnd;
			i++;
		}
		
		trace(patternValuePos);
		trace(patternValueEnd);
		return this;
	}	
	
	private function createBeamGroups2() {
		trace('');	
		trace('CREATE BEAM GROUPS 2');
		
		var dnoteGroupIdx = new ObjectHash<DNote, Int>();
		
		for (dnote in dVoice.dnotes) {
			var dnotePos = dVoice.dnotePosition.get(dnote);
			var dnoteEnd = dVoice.dnotePositionEnd.get(dnote);
			
			if (dnote.notetype != ENoteType.Normal) {
				groupIdx = -2;
			} else if (dnote.notevalue.beamingLevel < 1) {
				groupIdx = -1;
			} else {
				var groupIdx = _findBeamGroupIndex(dnotePos, dnoteEnd);				
			}			
			dnoteGroupIdx.set(dnote, groupIdx);			
		}
		
		var prevDnote:DNote = null;
		var groupIdx = 0;
		
		var currType = 'single';
		
		for (dnote in dVoice.dnotes) {
			if (prevDnote == null) continue;			
			var prevGroupIdx = dnoteGroupIdx.get(prevDnote);
			var currGroupIdx = dnoteGroupIdx.get(dnote);

			
			if (prevGroupIdx != currGroupIdx) {
				trace('Add current to ' + currType);				
			} else {
				currType = 'Multi';
				trace('Add current to ' + currType);
			}
			
			
			
			
			
			prevDnote = dnote;
		}
		
		
		
		
		
		return this;
	}	
	
	
	private function _findBeamGroupIndex(pos:Int, endPos:Int, countFrom:Int=0) {
		for (idx in countFrom...patternValuePos.length) {			
			if (pos >= patternValuePos[idx] && endPos <= patternValueEnd[idx]) {
				return idx;
			}
		}
		return -1;			
	}

	private function traceBeamGroups() {
		
		for (beamGroup in this.dVoice.beamGroups) {
				
				
		}
		
	}	
	
	
	

}