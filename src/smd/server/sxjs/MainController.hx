package smd.server.sxjs;

import cx.ArrayTools;
import cx.TimerTools;
import dtx.Tools;
import haxe.Http;
import haxe.Timer;
import haxe.TimerQueue;
import haxe.Unserializer;
import js.Dom;
import js.Lib;
import smd.server.sxjs.controller.AlertController;
import smd.server.sxjs.controller.ScorxlistController;
import smd.server.sxjs.controller.ScorxplayerController;
import smd.server.sxjs.widget.alert.Alert;
import smd.server.sxjs.widget.scorx.Scorxitem;
import sx.type.TListExamples;

using Detox;
class MainController
{
	private var ulScorxlist:DOMCollection;
	private var inputSearch:DOMCollection;
	private var searchTitle:String = '';
	private var listexamples:TListExamples;
	
	static function main() 
	{
		var main = new MainController();
		Tools.window.onload = main.run;
	}

	public function new() {}
	
	
	private var scorxplayerController:ScorxplayerController;
	
	private function run(e)
	{
		if ("#scorxlist".find() != null) new ScorxlistController(this);
		if ("#scorxplayer".find() != null) this.scorxplayerController = new ScorxplayerController(this);		
	}
	
	public function testfunction(id:Int) {
		trace(id);
		if (this.scorxplayerController != null) {
			this.scorxplayerController.loadPlayer(id);
		} else {
			Lib.alert('No ScorxplayerController');
		}
	}
	

}