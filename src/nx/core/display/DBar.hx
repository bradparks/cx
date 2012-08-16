package nx.core.display;
import cx.ArrayTools;
import nme.geom.Rectangle;
import nx.Constants;
import nx.core.element.Bar;
import nme.ObjectHash;
import nx.enums.EAllotment;
import nx.enums.EBarline;
import nx.enums.EPartType;
import nx.enums.EPartType.EPartTypeDistances;
import nx.enums.utils.EAllotmentCalculator;

/**
 * ...
 * @author Jonas Nyström
 */
using cx.ArrayTools;
using nx.enums.utils.EAllotmentCalculator;

class DBar 
{
	public var dparts							(default, null)	:	Array<DPart>;
	public var bar								(default, null)	:	Bar;
	public var positions						(default, null)	:	Array<Int>;
	public var positionDistance			(default, null)	:	IntHash<Float>;
	public var postionDistpos				(default, null)	:	IntHash<Float>;
	
	public var columns						(default, null)	:	Array<Column>;
	public var dnoteColumn				(default, null)		:ObjectHash<DNote, Column>;
	public var dnoteComplexXadjust	(default, null)		:ObjectHash<DNote, Float>;
	public var dnoteComplex				(default, null)		:ObjectHash<DNote, Complex>;

	/*
	 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
	 * 	
	public var dnoteguidColumnidx		(default, null)		:Hash<Int>;
	public var dnoteguidComplexidx		(default, null)		:Hash<Int>;
	public var dnoteguidComplexXadjust	(default, null)		:Hash<Float>;
	*/
	
	public var columnsRectMinframe	(default, null) :	Rectangle;	
	public var columnsRectCramped		(default, null) :	Rectangle;	
	public var columnsRectAlloted		(default, null) :	Rectangle;	
	public var columnsRectStretched	(default, null) :	Rectangle;	
	
	public var allotment						(default, null)	: 	EAllotment;	
	
	
	public function new(bar:Bar=null, allotment:EAllotment=null) {				
		this.bar = (bar != null) ? bar : new Bar();				
		this.allotment = (allotment != null) ? allotment : EAllotment.Logaritmic;
		this._value = 0;
		
		this.dparts = [];
		for (part in this.bar.parts) {
			this.dparts.push(new DPart(part));
		}				
		this._calcPositions();		
		this._calcColumns();
		this._calcColumnValues();
		this._calcColumValueWeight();
		this._calcDnotesColumnsAndComplexes();
		this._calcDnotesComplexXadjust();
		this._calcColumnsDistancesX();
		this._calcColumnsPositionsX();		
		this._calcColumnsSpacing();
		this._calcColumnsRects();		
	}
	

	

	/************************************************************************
	 * Private methods
	 * 
	 ************************************************************************/
	
	private function _calcPositions() {
		this.positions = [];
		for (dpart in this.dparts) {
			this.positions  = this.positions.concat(dpart.positions);			
		}	
		this.positions = ArrayTools.unique(this.positions);
		this.positions.sort(function(a, b) { return Reflect.compare(a, b); } );
	}
	
	private function _calcColumns() {		
		this.columns = [];	
		
		
		for (pos in this.positions) {			
			var column:Column = { position:pos, value:12345, complexes:[], distanceX:0.0, positionX:0.0, widthX:0.0 };
			for (dpart in this.dparts) {
				var dplex = dpart.positionComplex.get(pos);	
				column.complexes.push(dplex);
			}			
			this.columns.push(column);			
		}
	}	

	private function _calcColumnValues() {
		var prevColumn:Column = null;
		for (column in this.columns) {			
			if (column == this.columns.first()) {
				prevColumn = column;				
				continue;
			}			
			var prevValue = column.position - prevColumn.position;
			prevColumn.value = prevValue;
			prevColumn = column;
		}
		var lastColumn = prevColumn;
		lastColumn.value = this.value - lastColumn.position;
		
	}
	
	private function _calcColumValueWeight() {
		var barvalue = this.value;
		for (column in this.columns) {
			column.valueWeight = column.value / barvalue;
		}
	}
	
	private function _calcDnotesColumnsAndComplexes() {
		this.dnoteColumn 				= new ObjectHash<DNote, Column>();
		this.dnoteComplex 				= new ObjectHash <DNote, Complex>();

		/*
		 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
		 * 
		this.dnoteguidColumnidx 		= new Hash<Int>();
		this.dnoteguidComplexidx 	= new Hash<Int>();
		*/
		
		for (column in this.columns) {
			for (complex in column.complexes) {
				if (complex == null) continue;
				for (dnote in complex.dnotes) {
					this.dnoteColumn.set(dnote, column);
					this.dnoteComplex.set(dnote, complex);
			
					/*
					 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
					 * 
					var columnIdx = this.columns.index(column);
					this.dnoteguidColumnidx.set(dnote.guid, columnIdx);
					
					var complexIdx = column.complexes.index(complex);
					this.dnoteguidComplexidx.set(dnote.guid, complexIdx);
					*/
					
				}
			}
		}
	}	
	
	
	
	private function _calcDnotesComplexXadjust() {
		this.dnoteComplexXadjust = new ObjectHash<DNote, Float>();

		/*
		 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
		 * 		
		this.dnoteguidComplexXadjust = new Hash<Float>();
		*/
		
		for (column in this.columns) {
			for (complex in column.complexes) {
				if (complex == null) continue;
				var idx = 0;
				for (dnote in complex.dnotes) {
					var adjustX = complex.dnoteXshift(idx);
					this.dnoteComplexXadjust.set(dnote, adjustX);
					
					/*
					 * 2.09 dpp ObjectHash bug workaround - seems to work in 2.10
					 * 					
					var complexIdx = column.complexes.index(complex);
					this.dnoteguidComplexXadjust.set(dnote.guid, adjustX);
					*/
					
					idx++;
				}
			}
		}
		
	}
	
	private function _calcColumnsDistancesX() {
		var testPB:TPosComplex = { position:0, rectsAll:[], rectsHeadW:[] };
		var firstpb = this.columns[0];		
		for (complex in firstpb.complexes) {
			var dplexRectsAll = complex.rectsAll;
			testPB.rectsAll.push(complex.getRectsAllCopy());
			testPB.rectsHeadW.push(complex.rectHeads.width);
		}
		
		var prevColumn:Column = null;
		for (column in this.columns) {
			

			if (column == this.columns.first()) {
				prevColumn = column;
				continue;
			}
			
			//-----------------------------------------------------------------------			
			//trace('*** pb ' + i + ' ***');			
			//-----------------------------------------------------------------------

			var maxDistanceX = 0.0;
			for (j in 0...column.complexes.length) {

				var dplex = column.complexes[j];
				var testRectsAll = testPB.rectsAll[j];
				var testRectHeadW = testPB.rectsHeadW[j];

				if (dplex != null) {
					var dplexRectsAll = dplex.rectsAll;
					var distanceX = Complex.dplexDistanceX(testRectsAll, testRectHeadW, dplexRectsAll);
					maxDistanceX = Math.max(maxDistanceX, distanceX);
				} else {
					
				}				
			}
			
			//-----------------------------------------------------------------------

			//trace('Max distanceX:' + maxDistanceX);
			prevColumn.widthX = maxDistanceX;
			column.distanceX = maxDistanceX;
		
			//-----------------------------------------------------------------------

			for (j in 0...column.complexes.length) {

				var dplex = column.complexes[j];
				var testRectsAll = testPB.rectsAll[j];
				var testRectHeadW = testPB.rectsHeadW[j];
				
				if (dplex != null) {
					testPB.rectsAll[j] = dplex.getRectsAllCopy();
					testPB.rectsHeadW[j] = dplex.rectHeads.width;
				} else {				
					for (rect in testPB.rectsAll[j]) {
						rect.offset( -maxDistanceX, 0);
					}
					testPB.rectsHeadW[j] += -maxDistanceX;					
				}	
				
			}
			prevColumn = column;
		}
	}
	
	private function _calcColumnsPositionsX() {
		var positionX = 0.0;
		for (column in this.columns) {
			positionX += column.distanceX;
			column.positionX = positionX;			
		}
	}	
	
	private function _calcColumnsSpacing() {
		//trace('*****************************');
		
		//allotment = EAllotment.Logaritmic;

		for (column in this.columns) {
			column.aWidthX = this.allotment.aWidthX(column.widthX, column.value);
			column.aSuperX = this.allotment.aSuperX(column.widthX, column.value);
		}
		
		
		
		/*
		//-----------------------------------------------------------------------------------------------------
		// Test equal distance		
		for (column in this.columns) {
			column.aWidthX = Math.max(column.widthX, Constants.ASPACING_NORMAL);
			column.aSuperX = Math.max(column.widthX - Constants.ASPACING_NORMAL, 0);
		}
		
		//-----------------------------------------------------------------------------------------------------
		// Test linear distance
		for (column in this.columns) {
			var columnWidthX = (column.value / Constants.BASE_NOTE_VALUE) * Constants.ASPACING_NORMAL;
			column.aWidthX = Math.max(column.widthX, columnWidthX);
			column.aSuperX = Math.max(column.widthX - columnWidthX, 0);			
		}
		
		//-----------------------------------------------------------------------------------------------------
		// Test logaritmic distance
		for (column in this.columns) {
			var delta:Float = 0.5;
			var columnWidthX = (delta +(column.value / Constants.BASE_NOTE_VALUE) / 2) * Constants.ASPACING_NORMAL;
			column.aWidthX = Math.max(column.widthX, columnWidthX);
			column.aSuperX = Math.max(column.widthX - columnWidthX, 0);			
		}		
		*/
		
		
		var posX = 0.0;
		for (column in this.columns) {
			//column.sWidthX = column.aWidthX;

			column.sPositionX = column.aPositionX = posX;			
			posX += column.aWidthX;
		}		
		
		/*
		for (column in this.columns) {
			trace([column.widthX, column.positionX, Constants.ASPACING_NORMAL, column.aSuperX, column.aWidthX, column.aPositionX]);						
		}
		*/
		
	}
	
	private var firstMinX:Float;
	private var lastWidthIncludeValue:Float;
	
	private function _calcColumnsRects() {
		
		var firstColumn = this.columns.first();
		this.firstMinX = 0.0;
		for (complex in firstColumn.complexes) {
			firstMinX = Math.min(firstMinX, complex.rectFull.x);
		}		
		
		var lastColumn = this.columns.last();		
		var lastMaxW = 0.0;
		for (complex in lastColumn.complexes) {
			if (complex != null) {
				lastMaxW = Math.max(lastMaxW, complex.rectFull.x + complex.rectFull.width);				
			}
		}	
		this.lastWidthIncludeValue = Math.max(lastMaxW, lastColumn.aWidthX);				
		
		//-----------------------------------------------------------------------------------------------------
		
		var columnsWidthCramped = lastColumn.positionX;
		
		this.columnsRectMinframe = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthCramped + lastMaxW, 0);		
		this.columnsRectCramped = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthCramped + lastWidthIncludeValue, 0);		
		
		var columnsWidthAlloted = this.columns.last().aPositionX;
		this.columnsRectAlloted = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthAlloted + lastWidthIncludeValue, 0);
		
		var columnsWidthStretched = this.columns.last().sPositionX;
		this.columnsRectStretched = new Rectangle(firstMinX, 0, -firstMinX + columnsWidthStretched + lastWidthIncludeValue, 0);
		
		/*
		trace(this.columnsRectAlloted);
		trace(this.columnsRectStretched);		
		*/
		
	}		

	public function stretchContentTo(stetchedContentWidth:Float=0.0):DBar {		
		
		if (this.allotment == EAllotment.Cramped) return this;
		
		var currentContentWidth = this.columnsRectAlloted.width;
		var stretchAmount:Float = stetchedContentWidth - currentContentWidth;
		
		//trace([currentContentWidth, stetchedContentWidth, stretchAmount]);
		
		if (stetchedContentWidth <= currentContentWidth) return this;

		//-----------------------------------------------------------------------------------------------------
		
		for (column in this.columns) {
			column.sPositionX = column.aPositionX;
			column.sWidthX = column.aWidthX;
		}
		
		//-----------------------------------------------------------------------------------------------------
		
		var currentNormalValueWidth = new IntHash<Float>();
		var newNormalValueWidth = new IntHash<Float>();
		
		for (column in this.columns) {
			var valueWidth = this.allotment.aWidthX(0, column.value);			
			//trace(this.allotment.aWidthX(0, column.value));
			if (!currentNormalValueWidth.exists(column.value)) {
				currentNormalValueWidth.set(column.value, valueWidth);
				newNormalValueWidth.set(column.value, valueWidth);
			}
		}
		
		var currentValues = ArrayTools.fromIterator(currentNormalValueWidth.keys());
		var pott = stretchAmount;				
		var loopCount = 0;
		
		do {		
			// set new width values:
			
			for (value in currentValues) {
				var change = 0.5 * this.allotment.valueFactor(value);	
				newNormalValueWidth.set(value, newNormalValueWidth.get(value) + change);				
			}
			
			for (column in this.columns) {								
				var change = 0.5 * (column.value / Constants.BASE_NOTE_VALUE);			
				var checkWidth = newNormalValueWidth.get(column.value);
				
				if (column.sWidthX < checkWidth) {
					column.sWidthX += change;
					pott -= change;
				} else {
					// utvidga ej!
				}
				
				loopCount++;				
				if (loopCount > Constants.LOOP_COUNT_MAX) {
					throw "Loop check overload";
					pott = 0;								
				}
				
				if (pott <= 0) break;				
			}
			
		} while (pott > 0);
		
		//trace(loopCount);

		//-----------------------------------------------------------------------------------------------------
		// Finally set rectangle

		var pos = 0.0;
		for (column in this.columns) {
			column.sPositionX = pos;
			pos += column.sWidthX;
		}

		this.columnsRectStretched.width = stetchedContentWidth;
		return this;
	}
	
	
	
	//------------------------------------------------------------------------------------------------------
	
	private var _value:Int;
	public var value(get_value, null):Int;
	private function get_value():Int 
	{
		if (this._value != 0) return this._value;
		this._value = 0;
		for (dpart in this.dparts) {
			this._value = Std.int(Math.max(this._value, dpart.value));
		}
		return this._value;
	}		
	
	//-----------------------------------------------------------------------------------------------------
	

	//-----------------------------------------------------------------------------------------------------
	
	/// INDENT LEFT
	
	
	
	/// PART LABELS
	private var _rectLabels:Rectangle;
	public var rectLabels(get_rectLabels, null):Rectangle;
	private function get_rectLabels():Rectangle {
		if (this._rectLabels != null) return this._rectLabels;
		this._rectLabels = new Rectangle(0, -1, 2, 2);
		return this._rectLabels;
	}
	
	/// ACKOLADE
	private var _rectAckolade:Rectangle;
	public var rectAckolade(get_rectAckolade, null):Rectangle;
	private function get_rectAckolade():Rectangle 
	{
		if (this._rectAckolade != null) return this._rectAckolade;
		this._rectAckolade = new Rectangle(0, -3, 4, 6);
		this._rectAckolade.offset(this.rectLabels.x + this.rectLabels.width, 0);
		return this._rectAckolade;
	}
	
	/// ACKOLADEMargin
	private var _rectAckolademargin:Rectangle;
	public var rectAckolademargin(get_rectAckolademargin, null):Rectangle;
	private function get_rectAckolademargin():Rectangle 
	{
		if (this._rectAckolademargin != null) return this._rectAckolademargin;
		this._rectAckolademargin = new Rectangle(0, -4, Constants.ACKOLADE_CLEF_MARGIN, 8);
		this._rectAckolademargin.offset(this.rectAckolade.x + this.rectAckolade.width, 0);
		return this._rectAckolademargin;
	}	
	
	
	private var _rectClef:Rectangle;
	public var rectClef(get_rectClef, null):Rectangle;
	private function get_rectClef():Rectangle 
	{
		if (this._rectClef != null) return this._rectClef;
		this._rectClef = new Rectangle(0, -2, 0, 2);
		for (dpart in this.dparts) {
			this._rectClef = this._rectClef.union(dpart.rectClef);			
		}		
		this._rectClef.offset(this.rectAckolademargin.x + this.rectAckolademargin.width, 0); /// CHANGE WHEN ACKOLADE!
		return this._rectClef;
	}
	
	private var _rectKey:Rectangle;
	public var rectKey(get_rectKey, null):Rectangle;
	private function get_rectKey():Rectangle {
		if (this._rectKey != null) return this._rectKey;
		this._rectKey = new Rectangle(0, 0, 0, 0);
		for (dpart in this.dparts) {
			this._rectKey = this._rectKey.union(dpart.rectKey);						
		}
		
		this._rectKey.offset(this.rectClef.x + this.rectClef.width, 0);
		return this._rectKey;
	}	
	
	private var _rectTime:Rectangle;
	public var rectTime(get_rectTime, null):Rectangle;
	private function get_rectTime():Rectangle 
	{
		var rect:Rectangle = null;
		if (this.bar.time == null) {
			rect = new Rectangle(0, -2, Constants.ATTRIBUTE_NULL_WIDTH, 4);
		} else {
			rect = new Rectangle(0, -2, Constants.TIME_WIDTH, 4);
		}		
		this._rectTime = rect;
		
		this._rectTime.offset(this.rectKey.x + this.rectKey.width, 0);
		return _rectTime;
	}
	
	/// LEFT BARLINE

	private var _rectMarginLeft:Rectangle;
	public var rectMarginLeft(get_rectMarginLeft, null):Rectangle;
	private function get_rectMarginLeft():Rectangle 
	{
		if (this._rectMarginLeft != null) return this._rectMarginLeft;		
		this._rectMarginLeft = new Rectangle(0, -2, Constants.BAR_MARGIN_LEFT, 4);
		this._rectMarginLeft.offset(this.rectTime.x + this.rectTime.width, 0); /// CHANGE TO LEFT BARLINE
		return this._rectMarginLeft;
	}
	
	//--------------------------------------------------------------------------------------
	
	private var _rectMarginRight:Rectangle;
	public var rectMarginRight(get_rectMarginRight, null):Rectangle;
	private function get_rectMarginRight():Rectangle 
	{
		
		if (this._rectMarginRight != null) return this._rectMarginRight;		
		this._rectMarginRight = new Rectangle(0, -3, Constants.BAR_MARGIN_RIGHT, 6);
		
		return this._rectMarginRight;		
		
	}
	
	
	private var _rectBarline:Rectangle;
	public var rectBarline(get_rectBarline, null):Rectangle;
	private function get_rectBarline():Rectangle 
	{
		if (this._rectBarline != null) return this._rectBarline;
		var barlineWidth:Float = Constants.ATTRIBUTE_NULL_WIDTH;
		
		if (this.bar.barline == null) {
			this._rectBarline = new Rectangle(0, -2, Constants.BARLINE_NORMAL_WIDTH, 4);
		} else {
			switch (this.bar.barline) {
				case EBarline.Normal: barlineWidth = Constants.BARLINE_NORMAL_WIDTH;
				case EBarline.Double: barlineWidth = Constants.BARLINE_DOUBLE_WIDTH;			
				default: 
					barlineWidth = Constants.BARLINE_DOUBLE_WIDTH;
			}
			this._rectBarline = new Rectangle(0, -2, barlineWidth, 4);
		}
		this._rectBarline.offset(this.rectMarginRight.x + this.rectMarginRight.width, 0);
		
		return this._rectBarline;
	}
	
	/// CAUTIONARIES...
	
	/// RIGHT INDENT
	
		
	//--------------------------------------------------------------------------------------
	
	private var _attributesRectLeft:Rectangle;
	private function get_attributesRectLeft():Rectangle 
	{
		if (this._attributesRectLeft != null) return this._attributesRectLeft;

		var rect = new Rectangle(0, 0, 0, 0)
		
			// left indent
			// part labels
			// ackolade
			.union(this.rectLabels)
			.union(this.rectAckolade)
			.union(this.rectAckolademargin)
			.union(this.rectClef)
			.union(this.rectKey)
			.union(this.rectTime)
			// Right barline
			.union(this.rectMarginLeft)			
			;
		/*
		rect = rect.union(this.rectLabels);	
		rect = rect.union(this.rectAckolade);	
		rect = rect.union(this.rectClef);	
		rect = rect.union(this.rectKey);	
		rect = rect.union(this.rectTime);	
		rect = rect.union(this.rectMarginLeft);	
		*/	
		
		this._attributesRectLeft = rect;
		return this._attributesRectLeft;
	}
	public var attributesRectLeft(get_attributesRectLeft, null):Rectangle;	

	
	private var _attributesRectRight:Rectangle;
	private function get_attributesRectRight():Rectangle 
	{
		if (this._attributesRectRight != null) return this._attributesRectRight;
	
		var rect = new Rectangle(0, 0, 0, 0)
			.union(this.rectMarginRight)
			.union(this.rectBarline)
			// cautionaries...
			// right indent...
			;
			
		this._attributesRectRight = rect;
		return this._attributesRectRight;
	}
	public var attributesRectRight(get_attributesRectRight, null):Rectangle;	

	
	//---------------------------------------------------------------------------------------------------------

	public function getTotalWidthCramped() {
		var ret:TBarMeasurement = {
			attribLeftWidth: 		this.attributesRectLeft.width,
			columnsWidth: 		this.columnsRectCramped.width,
			attribRightWidth:	this.attributesRectRight.width, 
			totalWidth:			this.attributesRectLeft.width + this.columnsRectCramped.width + this.attributesRectRight.width,
			//columnsX:				this.attributesRectLeft.width + -this.columnsRectCramped.x,
			//attribRightX:			this.attributesRectLeft.width + this.columnsRectCramped.width,			
		}
		return ret;		
	}
	
	
	public function getTotalWidthAlloted() {
		var ret:TBarMeasurement = {
			attribLeftWidth: 		this.attributesRectLeft.width,
			columnsWidth: 		this.columnsRectCramped.width,
			attribRightWidth:	this.attributesRectRight.width, 
			totalWidth:			this.attributesRectLeft.width + this.columnsRectAlloted.width + this.attributesRectRight.width,
			//columnsX:				this.attributesRectLeft.width + -this.columnsRectAlloted.x,
			//attribRightX:			this.attributesRectLeft.width + this.columnsRectAlloted.width,			
		}
		return ret;		
	}	

	
	//-----------------------------------------------------------------------------------------------------
	
	private var _dpartTop:ObjectHash<DPart, Float>;
	public var dpartTop(get_dpartTop, null):ObjectHash<DPart, Float>;
	


	private function get_dpartTop():ObjectHash<DPart, Float> {

		if (this._dpartTop != null) return this._dpartTop;
		this._dpartTop = new ObjectHash<DPart, Float>();
		
		var distance = 0.0;
		var prevDpart:DPart = null;
		for (dpart in this.dparts) {						
			if (dpart == this.dparts.first()) {
				distance += -(dpart.rectDPartHeight.y);
			} else {
				var increase = (prevDpart.rectDPartHeight.height + prevDpart.rectDPartHeight.y) + -dpart.rectDPartHeight.y + Constants.PART_MIN_DISTANCE;								
				var minDistance = EPartTypeDistances.getMinDistance(dpart.part.type);
				//trace([increase, minDistance]);
				distance += Math.max(minDistance, increase);
			}
			this._dpartTop.set(dpart, distance);			
			prevDpart = dpart;
		}
		return this._dpartTop;
	}
	

	
	
	
}


typedef TBarMeasurement = {
	attribLeftWidth: 		Float,
	columnsWidth: 		Float,
	attribRightWidth:	Float, 
	totalWidth:			Float,
	//columnsX:				Float,
	//attribRightX:			Float,
}



typedef TPosComplex = {
	position: Int,
	rectsAll: Array<Array<Rectangle>>,	
	rectsHeadW:Array<Float>,
}