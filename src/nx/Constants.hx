package nx;


/**
 * ...
 * @author Jonas Nyström
 */

class Constants {

	static public inline var BASE_NOTE_VALUE:Int = 3024;	
	static public inline var HEAD_MAX_LEVEL:Int = 12;
	
	static public inline var HEAD_WIDTH:Int = 4;
	static public inline var HEAD_HALFWIDTH:Int = 2;
	static public inline var HEAD_QUARTERWIDTH:Int = 1;
	static public inline var HEAD_16thWIDTH:Float = 0.5;
	static public inline var HEAD_HALFHEIGHT:Int = 1;
	static public inline var HEAD_HEIGHT:Int = 2;
	static public inline var HEAD_DOTRADIUS:Float = 0.5;
	
	static public inline var HEAD_LEGER_LEFT:Float = 1;
	static public inline var HEAD_LEGER_RIGHT:Float = 1.9;
	static public inline var HEAD_LEGER_RIGHT_WHOLE:Float = 1.8;
	
	static public inline var BEAM_HEIGHT:Float = 0.8;
	static public inline var BEAM_SUBDISTANCE:Float = HEAD_HEIGHT * 0.8;
	static public inline var BEAM_SUBWIDTH:Float = HEAD_WIDTH * 0.8;
	
	static public inline var STAVE_LENGTH:Float = 6.8;
	static public inline var STAVE_OFFSET:Float = 1.4;
	static public inline var STAVE_WIDTH:Float = 0.2;
	static public inline var STAVE_HEADADJUST:Float = 0.4;
	static public inline var STAVE_FLAGCORRECTION:Float = HEAD_HALFWIDTH + HEAD_QUARTERWIDTH;
	
	static public inline var ASPACING_NORMAL:Float = HEAD_HALFWIDTH * 5;	
	static public inline var LOOP_COUNT_MAX:Int = 3000;
	
	static public inline var TIE_WIDTH:Float = 4.0;
	static public inline var TIE_WIDTH_LASTHANGING:Float = 8.0;
	static public inline var TIE_HEIGHT:Float = 1.5;
	static public inline var TIE_THICKNESS:Float = 0.5;
	static public inline var TIE_SINGLE_YMOVE:Float = 1.5;
	static public inline var TIE_MULTI_YMOVE:Float = 0.7;	
	static public inline var TIE_SINGLE_XCOMP:Float = 1;	
	static public inline var TIE_SHORT:Float = 5;	
	static public inline var TIE_SHORT_HEIGHT:Float = 1.0;	
	static public inline var TIE_DELTA:Int = 7;
	
	static public inline var SIGNS_HEADS_DISTANCE:Float = 0.3 * Constants.HEAD_QUARTERWIDTH;
	
	static public inline var COMPLEX_COLLISION_SECOND_XSHIFT:Float = 3 * Constants.HEAD_QUARTERWIDTH;
	
	static public inline var CLEF_WIDTH:Float = 11;
	static public inline var KEYSIGN_WIDTH:Float = 2;
	static public inline var TIME_WIDTH:Float = 6;
	static public inline var ATTRIBUTE_NULL_WIDTH:Float = 0;
	
	static public inline var BARLINE_NORMAL_WIDTH:Float = 1.0;
	static public inline var BARLINE_DOUBLE_WIDTH:Float = 2.2;
	static public inline var BARLINE_THICKNESS:Float = .4;
	
	static public inline var BAR_MARGIN_LEFT:Float = 3.2;
	static public inline var BAR_MARGIN_RIGHT:Float = 1;
	static public inline var SIGN_WIDTH:Float = 3.2;
	
	static public inline var TEXT_XADJUST:Float = 0.8;
	static public inline var TEXT_YADJUST:Float = 2.8;
	
	static public inline var PART_MIN_DISTANCE:Float = 0;
	static public inline var ACKOLADE_CLEF_MARGIN:Float = 1;
	
	static public inline var TPL_RECT_X:Float = 6;
	static public inline var TPL_RECT_Y:Float = 8;
	static public inline var TPL_X:Float = -4;
	static public inline var TPL_Y:Float = 2;
	static public inline var TPLCHAIN_Y_SHIFT:Float = 4;
	static public inline var TPL_CIRCLE_RADIUS:Float = 5;
	static public inline var TPL_CIRCLE_THICKNESS:Float = 0.6;
	static public inline var TPL_CIRCLE_X:Float = 5.9;
	static public inline var TPL_CIRCLE_Y:Float = 7.6;
	
}