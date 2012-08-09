package smd.server.sx.data;
import cx.FileTools;
import cx.SqliteTools;
import harfang.exceptions.Exception;
import harfang.exceptions.HTTPException;
import neko.Web;
import smd.server.sx.Config;
import smd.server.sx.State;

import cx.GoogleTools;
import cx.GoogleTools.Documents;
import ka.app.KalleConfig;


/**
 * ...
 * @author Jonas Nyström
 */

class DocumentData 
{

	static public function getDocument(tag:String, sqlitefile:String = 'data/documents.sqlite'):TDocument {
		
		var file = Web.getCwd() + Config.filesDir + sqlitefile;
		
		var updatedoc = (Web.getParams().get('updatedoc') == Config.secretKey);
		if (updatedoc) {
			var sql = 'DELETE from documents where tag="' + tag + '"';
			var ret = SqliteTools.execute(file, sql);			
		}
		
		var sql = "select rowid, * from documents where (tag = '" + tag + "')";
		var results = SqliteTools.execute(file, sql);
		try {
			var result = results.first();
			
			var doc:TDocument = {
				tag:tag,
				title:result.title,
				text:result.text,
			}
			return doc;
			
		} catch (e:Dynamic) {
			
			//trace('hämta från google');
			var doc = DocumentData.getGoogleDoc(tag);			
			if (doc == null) {
				State.messages.errors.push("Can't get content for document " + tag);
				throw new Exception("Can't get content for document " + tag);
				return null;
			}
			
			saveGoogleDocToSqlite(doc, file);
			State.messages.success.push("Document saved locally! " + tag);
			
			return doc;
			
		}
		return null;
	}
	
	
	static public function saveGoogleDocToSqlite(doc:TDocument, sqlitefile:String) {
				
		var insertObject = {
			tag: doc.tag,
			title: doc.title,
			text: StringTools.urlDecode(doc.text),
		}
		var sql = SqliteTools.getInsertStatement(insertObject, 'documents');
		var insertId = SqliteTools.insert(sqlitefile, sql);		
		
	}

	static public function getGoogleDoc(tag:String):TDocument {
		
		var entry:DocumentEntry = null;
		var content:String = null;
		var doc:TDocument = {
			tag:'',
			title:'',
			text:'',
		}
		
		try {
			
			var uri = Web.getURI();
			
			var d = new cx.GoogleTools.Documents(Config.guser, Config.gpass);
			var entries = d.getDocumentEntries();
			
			
			entry = d.getEntryForTitle(tag);
			if (entry == null) {
				State.messages.errors.push("Can't find document entry " + tag);
				return null;
			}
			
			content = d.getDocumentDownloadString(entry.id, 'html');
			/*
			var fn = Web.getCwd() + tag + '.html';
			trace(fn);
			FileTools.putContent(fn, content);
			*/
			
			content = d.getCleanHtml(content);		
			
			doc.tag = tag;
			doc.title = tag;
			doc.text = content;
		} catch (e:Dynamic) {
			State.messages.errors.push('Can not load remote document!');
			return null;
		}	
		
		return doc;
	}
	
	
}

typedef TDocument = {
	tag:String,
	title:String,
	text:String,
	?createdby:String,
	?updatedby:String,
	?createdate:String,
	?updateddate:String,	
}

