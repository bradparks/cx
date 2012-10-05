package smd.server.sx;


import cx.ConfigTools;
import harfang.configuration.AbstractServerConfiguration;
import harfang.exception.Exception;
import harfang.exception.HTTPException;
import haxe.Firebug;
import haxe.Log;
import neko.Lib;
import neko.Web;
import smd.server.base.result.TemplateResult;
import smd.server.sx.Config;
import smd.server.sx.data.Functions;
import smd.server.sx.data.PageData;
import smd.server.sx.result.IndexResult;
import smd.server.sx.user.User;

import harfang.url.URLDispatcher;

class UserConfiguration extends AbstractServerConfiguration {

    public function new() {
        super();
		
		Log.trace = Firebug.trace;
		
		ConfigTools.loadConfig(Config, Config.configFile);
		new Functions();		
		//User.updateUserdata();
		User.getCurrentUser();
		User.checkRedirect();	
		State.getAlerts();
    }
	
	
    public override function init() {
        super.init();
        this.addModule(new Site());
    }	
		
	override public function onHTTPError(error : HTTPException) : Void {
		Lib.println(error.getMessage());
		/*
		State.messages.errors.push(error.getErrorCode() + ': ' + error.getMessage());
		//error.uri = Web.getURI();
		var output = new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		*/
	}
	
	override public function onError(exception : Exception) : Void {		
		Lib.println(exception.getMessage());
		/*
		State.messages.errors.push(exception.getMessage());
		//exception.uri = Web.getURI();
		var output = new IndexResult(State.indexPage, PageData.getData(), Config.templatesDir).execute();
		Lib.print(output);
		*/
	}
	
}