package smd.server.sx.controller;
import cx.FileTools;
import cx.SqliteTools;
import cx.WebTools;
import harfang.controller.AbstractController;
import harfang.exceptions.Exception;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.Config;
import smd.server.sx.data.DocumentData;
import smd.server.sx.data.DocumentData.TDocument;
import smd.server.sx.data.PageData;
import smd.server.sx.result.IndexResult;
import smd.server.sx.State;

/**
 * ...
 * @author Jonas Nyström
 */
using StringTools;
class IndexController extends AbstractController
{
	//static private var domainIndexPage:String = WebTools.getDomainInfo().domain + '.html';
	
	@URL("^/$")
	public function index() { 			
		return new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir);
	}
	
	
	@URL("/info/([a-zA-Z]+)", "g")
	public function info(param : String = 'default') {			
		return new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir);
	}
	
	@URL("/dok/([a-zA-Z]+)", "g")
	public function dok(param : String = 'default') {			
		
		var tag = 'site' + WebTools.getUri().replace('/', '_');
		var doc:TDocument = DocumentData.getDocument(tag);
				
		//var data:Dynamic = { };		
		var data = PageData.getData();
		
		data.content = {tag:'content', text:doc.text};
		data.title = { tag:'title', text:'title' };
		data.layout = { tag:'document', text:'document' };
		return new IndexResult(State.indexPage, data, Config.templatesDir);
	}
	
}

typedef TPageData = {
	?title:TPageTextElement, 
	?korakademin:TPageTextElement, 
	?sensus30:TPageTextElement, 
	?projektinloggning:TPageTextElement,
	?content:TPageTextElement, 
}

typedef TPageTextElement = {
	tag:String,
	text:String,
}

