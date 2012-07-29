package nx.core.display;
import cx.ArrayTools;
import cx.NmeTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.type.TSigns;
import nx.core.util.GeomUtils;
import nx.core.util.SignsUtil;
import nx.enums.EDirectionUAD;

/**
 * ...
 * @author Jonas Nyström
 */

class DPlex
{
	/**************************************************************************
	 * Private vars
	 * 
	 **************************************************************************/	
	
	static private var COLLISION_XSHIFT_SECOND:Float = 3 * Constants.HEAD_QUARTERWIDTH;
	static private var SIGNS_HEADS_DISTANCE:Float = 0.3 * Constants.HEAD_QUARTERWIDTH;
	
	
	private var _dnotesXshift:Array<Float>;
	
	public function new(dnotes:Iterable<DNote>)  {
		this.dnotes 			= Lambda.array(dnotes);
		this._dnotesXshift 	= [];
		this.signs 				= [];
		
		for (dnote in this.dnotes) {
			this._dnotesXshift.push(0);
		}

		this.signs = this._calculateSigns();		
		this._avoidCollisions();
	}
	
	/**************************************************************************
	 * Public vars 
	 * 
	 **************************************************************************/	
	
	public var signs(default, null):TSigns;
	public var dnotes(default, null):Array<DNote>;		
	
	public function dnote(idx:Int) : DNote {
		return this.dnotes[idx];
	}
	
	public function dnoteXshift(idx:Int): Float {
		return this._dnotesXshift[idx];
	}
	
	/**************************************************************************
	 * Private functions
	 * 
	 **************************************************************************/	

	private function _calculateSigns():TSigns {
		var sgs:TSigns = [];
		for (dnote in this.dnotes) {
			for (dhead in dnote.dheads) {
				sgs.push({sign:dhead.head.sign, level:dhead.head.level, position:0});
			}
		}	
		return SignsUtil.adjustPositions(sgs);
	}
	
	private function _avoidCollisions() {
		
		if (this.dnotes.length > 1) {
			var diff = this.dnote(1).levelTop -  this.dnote(0).levelBottom;
			
			var checkRect = (this.dnote(0).notevalue.dotLevel > 0) ? this.dnote(0).rectDots : this.dnote(0).rectHeads;
			
			if (diff == 1) {
				//trace('second clash');		
				if (this.dnote(0).notevalue.dotLevel > 0) {
					var isect = NmeTools.intersection2(checkRect, this.dnote(1).rectHeads);
					this._setDnoteX(1, isect.width);
				} else {
					this._setDnoteX(1, COLLISION_XSHIFT_SECOND);					
				}
			} else if (diff < 1) {
				//trace('overlap');	
				//var isect = NmeTools.intersection2(this.dnote(0).rectHeads, this.dnote(1).rectHeads);
				var isect = NmeTools.intersection2(checkRect, this.dnote(1).rectHeads);
				this._setDnoteX(1, isect.width);
			} else {
				//trace('no overlap');
			}
		}				
	}	
	
	private function _setDnoteX(idx:Int, x:Float) 	{
		this._dnotesXshift[idx] = x;
	}	
	
	/**************************************************************************
	 * Public getters and setters
	 * 
	 **************************************************************************/	
	
	private var _rectHeads:Rectangle;
	public var rectHeads(get_rectHeads, null):Rectangle;
	private function get_rectHeads():Rectangle {
		if (this._rectHeads != null) return this._rectHeads;
		var idx = 0;
		for (dnote in this.dnotes) {
			var r = dnote.rectHeads;
			r.offset(this.dnoteXshift(idx), 0);
			if (this._rectHeads == null) {
				this._rectHeads = r;
			} else {
				this._rectHeads = this._rectHeads.union(r);
			}
			idx++;
		}
		return this._rectHeads;
	}	
	
	
	private var _rectSigns:Rectangle;
	private function get_rectSigns():Rectangle {
		if (this._rectSigns != null) return this._rectSigns;		
		this._rectSigns = SignsUtil.getDisplayRectSigns(signs);		
		if (this._rectSigns == null) return null;
		var shiftRect = GeomUtils.overlapX(this._rectSigns, this.rectHeads);
		this._rectSigns.offset(-shiftRect.width - SIGNS_HEADS_DISTANCE, 0);
		
		return this._rectSigns;
	}
	public var rectSigns(get_rectSigns, null):Rectangle;

	
	private var _rectsAll:Array<Rectangle>;
	public var rectsAll(get_rectsAll, null):Array<Rectangle>;
	private function get_rectsAll():Array<Rectangle> {
		if (this._rectsAll != null) return this._rectsAll;
		this._rectsAll = [];
		if (this.rectHeads != null) this._rectsAll.push(this.rectHeads);
		if (this.rectSigns != null) this._rectsAll.push(this.rectSigns);
		for (dnote in this.dnotes) {
			if (dnote.rectStave != null) this._rectsAll.push(dnote.rectStave);			
			if (dnote.rectDots != null) this._rectsAll.push(dnote.rectDots);
		}
		return this._rectsAll;
	}
	
	/**************************************************************************
	 * Public methods
	 * 
	 **************************************************************************/		
	
	public function distanceX(next:DPlex):Float {	
		var thisRects = this.rectsAll;
		var nextRects = next.rectsAll;
		var plexDistanceX = GeomUtils.arrayOverlapX(thisRects, nextRects);
		//return plexDistanceX;
		
		var distanceX = Math.max(plexDistanceX + Constants.HEAD_QUARTERWIDTH, Constants.HEAD_WIDTH + Constants.HEAD_QUARTERWIDTH);
		return distanceX;
		
		//return 0.0;
	}
	
}