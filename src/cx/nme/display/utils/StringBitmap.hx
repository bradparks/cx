package cx.nme.display.utils;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormat;


/**
 * ...
 * @author Jonas Nyström
 */

class StringBitmap 
{
	private var t:TextField;
	private var tf:TextFormat;
	private var cache:Hash<Bitmap>;

	public function new(font:String='Arial', size:Float=14.0, color:Int=0xFF0000, bold:Bool=false, italic:Bool=false)  {		
		this.t = new TextField();		
		this.t.width = 200;
		this.t.height = 30;
		this.t.defaultTextFormat = new TextFormat(font, size, color, bold, italic);
		this.t.autoSize = TextFieldAutoSize.LEFT;
		this.cache = new Hash<Bitmap>();
	}
	
	public function getStringBitmap(string:String, x=0.0, y=0.0, maxLength=5):Bitmap {
		string = string.substr(0, maxLength);
		if (this.cache.exists(string)) {			
			var bm = new Bitmap(this.cache.get(string).bitmapData);			
			bm.x = x;
			bm.y = y;
			return bm;
		}
		
		this.t.text = string;

		#if neko
			var color = { rgb:0xFFFFFF, a:0 };
		#else
			var color = 0xFFFFFF;
		#end
		
		var bmd = new BitmapData(Std.int(t.textWidth + 1), Std.int(t.textHeight + 1), true, color);
		bmd.draw(t);
		var bm = new Bitmap(bmd);				
		this.cache.set(string, bm);
		bm.x = x;
		bm.y = y;
		return bm;
	}	
	
}