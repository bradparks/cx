class ApplicationMain
{

	#if waxe
	static public var frame : wx.Frame;
	static public var autoShowFrame : Bool = true;
	#if nme
	static public var nmeStage : wx.NMEStage;
	#end
	#end
	
	public static function main()
	{
		#if nme
		nme.Lib.setPackage("waxe", "NmmlEdit", "com.waxe.NmmlEdit", "1.0");
		
		#end
		
		#if waxe
		wx.App.boot(function()
		{
			
			frame = wx.Dialog.create(null, null, "NmmlEdit", null, { width: 800, height: 600 });
			
			#if nme
			var stage = wx.NMEStage.create(frame, null, null, { width: 800, height: 600 });
			#end
			
			NmmlEdit.main();
			
			if (autoShowFrame)
			{
				wx.App.setTopWindow(frame);
				frame.shown = true;
			}
		});
		#else
		
		nme.Lib.create(function()
			{ 
				if (800 == 0 && 600 == 0)
				{
					nme.Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
					nme.Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
				}
				
				NmmlEdit.main(); 
			},
			800, 600, 
			24, 
			0xffffff,
			(true ? nme.Lib.HARDWARE : 0) |
			(true ? nme.Lib.RESIZABLE : 0) |
			(false ? nme.Lib.BORDERLESS : 0) |
			(false ? nme.Lib.VSYNC : 0) |
			(false ? nme.Lib.FULLSCREEN : 0) |
			(1 == 4 ? nme.Lib.HW_AA_HIRES : 0) |
			(1 == 2 ? nme.Lib.HW_AA : 0),
			"NmmlEdit"
			
		);
		#end
		
	}
	
	
	public static function getAsset(inName:String):Dynamic
	{
		#if nme
		
		return null;
		
		#elseif cpp			// <---- Add this line...
			return null;	// <---- ...and this one!
		#end
	}
	
	
}