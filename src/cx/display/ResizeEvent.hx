package cx.display;
import flash.events.Event;
import flash.geom.Rectangle;

/**
 * ...
 * @author Jonas Nyström
 */

class ResizeSpriteEvent extends Event
{
	static public var RESIZE = 'resize';
	
	public  var rect:Rectangle;
	
	public function new(type:String, rect:Rectangle) 
	{
		this.rect = rect;
		super(type);
	}	
}