package smd.server.sx.controller;
import cx.TextfileDB;
import harfang.controller.AbstractController;
import haxe.Json;
import haxe.Serializer;
import smd.server.sx.Config;
import smd.server.sx.data.ScorxData;
import smd.server.sx.Site;
import smd.server.sx.State;
import smd.server.sx.result.IndexResult;
import sx.type.TListExample;
import sx.type.TLike;
import sx.type.TLikes;
import sx.util.ScorxExamples;
import sx.util.ScorxDb;
import cx.PngTools;


/**
 * ...
 * @author Jonas Nyström
 */

class MediaController extends AbstractController
{

	
	override public function handleBefore()	{
		
	}
	
	@URL("/sx/info/([a-zA-Z0-9/]+)$")
	public function sxinfo(param = '') {		
		var param = param.substr(0, -1);
		var scorxid = Std.parseInt(param);
		return "SX Info " + scorxid;
	}		
	
	@URL("/sx/pages/([a-zA-Z0-9/]+)$")
	public function sxpages(param = '') {		
		var param = param.substr(0, -1);
		var scorxid = Std.parseInt(param);
		
		var se = new ScorxExamples(Config.scorxDir);
		var filename = se.getFilename(scorxid);
		//trace(filename);
		
		var html = '<div class="pages">';
		var pages = ScorxDb.getPages(filename);
		for (page in pages) {
			html += PngTools.pngBytesToHtmlImg(page.data);			
			//trace(html);
		}		
		html += "</div>";
		html += "<style>";
		html += ".pages  img {border: 1px solid #dddddd; margin-bottom:4px; margin-right:4px; height:600px; }";
		html += "</style>";
		
		
		return html;
	}			
	
	@URL("/sx/list")
	public function sxlist() {			
		var domainkategori = "#" + State.domaintag;
		var ids = ScorxData.getScorxtillgangligheterIds(domainkategori);
		var listexamples = ScorxData.getListexamples(ids);
		
		/*
		var likes = new TextfileDB(Config.likesFile, '|');		
		for (idString in likes.keys()) {
			var id = Std.parseInt(idString);
			listexamples.get(id).likes = Std.parseInt(likes.get(idString));
		}
		*/
		
		
		//var scorxitems = new Array<TListExample>();
		//var scorxitems = new sx.type.TListExamples();
		
		//for (id in listexamples.keys()) {
		//	scorxitems.push(listexamples.get(id));
		//}
		
		/*
		var data = { scorxitems:scorxitems };
		return new IndexResult(Config.scorxlistPage, data);
		*/
		
		//return Json.stringify(scorxitems);
		return Serializer.run(listexamples);
		//return Json.stringify(listexamples);
		//return "SX List";
	}	
	
	@URL("/sx/likes")
	public function sxlikes() {		
		var likes = new TextfileDB(Config.likesFile, '|');	
		var aLikes = new TLikes();
		for (id in likes.keys()) {			
			var like:TLike = { id:Std.parseInt(id), likes:Std.parseInt(likes.get(id)) } ;
			aLikes.push(like);
		}
		return Serializer.run(aLikes);
	}
	
	@URL("/sx/addlike/([0-9/]+)$")
	public function addlike(param:String = '') {		
		var id = Std.parseInt(param.substr(0, -1));
		var idString = Std.string(id);
		var likes = new TextfileDB(Config.likesFile, '|');	
		var likesCount:Int = Std.parseInt(likes.get(idString));
		if (likesCount == null) likesCount = 0;
		likesCount += 1;
		likes.set(idString, Std.string(likesCount));
		return this.sxlikes();
	}	
	
	
	
	
	@URL("/sx/")
	public function sx() {			
		return "SX";
	}	
	
	
}