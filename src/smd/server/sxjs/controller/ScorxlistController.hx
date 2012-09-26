package smd.server.sxjs.controller;
import cx.ArrayTools;
import cx.TimerTools;
import dtx.Tools;
import haxe.Http;
import haxe.Json;
import haxe.Unserializer;
import js.Lib;
import smd.server.sxjs.MainController;
import smd.server.sxjs.widget.scorx.Commentsitem;
import sx.type.TComments;
import sx.type.TCommentsCount;
import sx.type.TLikes;

import sx.type.TListExample;
import sx.type.TListExamples;
import smd.server.sxjs.widget.scorx.Scorxitem;
import sx.type.TOriginatorshorts;

/**
 * ...
 * @author Jonas Nyström
 */
using Detox;
using StringTools;
class ScorxlistController extends Controller
{		

	
	private var ulScorxlist:DOMCollection;
	private var listexamples:TListExamples;

	private var inputSearchTitle:DOMCollection;
	private var inputSearchBes:DOMCollection;
	private var inputSearchOrig:DOMCollection;
	private var inputSearchFree:DOMCollection;
	
	private var searchTitle:String = '';
	private var searchBes:String = '';
	private var searchOrig:String = '';
	private var searchFree:String = '';
	
	
	
	
	public function new(main:MainController) {
		//trace('ScorxlistController');
		//this.main = main;
		super(main);
		
		
		
		this.ulScorxlist = this.findElement('#scorxlist');

		this.inputSearchTitle = this.findElement('#searchTitle');
		this.inputSearchTitle.keydown(onSearchTitle);		
		
		this.inputSearchBes = this.findElement('#searchBes');
		this.inputSearchBes.keydown(onSearchBes);		
		
		this.inputSearchOrig = this.findElement('#searchOrig');
		this.inputSearchOrig.keydown(onSearchOrig);		
		
		this.inputSearchFree = this.findElement('#searchFree');
		this.inputSearchFree.keydown(onSearchFree);		
		
		
		var data = Http.requestUrl('/sx/list');
		this.listexamples = Unserializer.run(data);	
		this.updateScorxitems();
				
		this.createLikesList();		
		
		this.createLatestCommentsList();
		
		this.createCommentsCounts();
	}
	
	

	
	private function removeScorxitems() {
		var liScorxitems = this.ulScorxlist.find('#scorxitem');
		this.ulScorxlist.removeChildren(null, liScorxitems);
	}
	
	private function addScorxitems(listexamples:TListExamples) {
		var aListexamples:Array<TListExample> = ArrayTools.fromIterables(listexamples);		
		aListexamples.sort(function (a, b) {
			return Reflect.compare(a.title, b.title);
		});
		var l:TListExample;
		

		
		for (listexample in aListexamples) {
			var scorxitem = new Scorxitem(this.main, listexample);
			this.ulScorxlist.append(scorxitem);			
		}
	}
	
	private function filterListexamples(listexamples:TListExamples, searchTitle:String='', searchBes='', searchOrig=''):TListExamples {
		var result = new TListExamples();		
		
		if (searchTitle != '') listexamples = filterTitle(listexamples, searchTitle);		
		if (searchBes != '') listexamples = filterBes(listexamples, searchBes);
		if (searchOrig != '') listexamples = filterOrig(listexamples, searchOrig);
		if (searchFree != '') listexamples = filterFree(listexamples, searchFree);
		
		return listexamples;
	}
	
	private function filterTitle(listexamples:TListExamples, searchTitle:String = '') {
		var result = new TListExamples();		
		if (searchTitle == '') return listexamples;
		
		searchTitle = searchTitle.toLowerCase();		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			var indexOf = listexample.title.toLowerCase().indexOf(searchTitle);
			if (indexOf >= 0) {
				result.set(id, listexample);
			}				
		}
		return result;		
	}
	
	private function filterBes(listexamples:TListExamples, searchBes:String = '') {
		var result = new TListExamples();		
		if (searchBes == '') return listexamples;
		
		searchBes = searchBes.toLowerCase();		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			if (listexample.bes != null) {
				var indexOf = listexample.bes.toLowerCase().indexOf(searchBes);
				if (indexOf >= 0) {
					result.set(id, listexample);
				}				
			}
		}
		return result;		
	}	
	
	private function filterOrig(listexamples:TListExamples, searchOrig:String = '') {
		var result = new TListExamples();		
		if (searchOrig == '') return listexamples;
		
		searchOrig = searchOrig.toLowerCase();		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);
			if (listexample.originatorshorts != null) {
				var indexOf = listexample.originatorshorts.join(' ').toLowerCase().indexOf(searchOrig);
				if (indexOf >= 0) {
					result.set(id, listexample);
				}				
			}
		}
		return result;		
	}		
	
	
	private function filterFree(listexamples:TListExamples, searchFree:String = '') {
		var result = new TListExamples();		
		if (searchFree == '') return listexamples;
		
		searchFree = searchFree.toLowerCase();		
		
		
		for (id in listexamples.keys()) {				
			var listexample = listexamples.get(id);

			var alternativesString = '';
			for (alternative in listexample.categories) {
				if (alternative.categoryId == 'bes') continue;
				if (alternative.categoryId == 'ack') continue;
				alternativesString += alternative.value + ', ';
			}
			
			var indexOf = alternativesString.toLowerCase().indexOf(searchFree);
			if (indexOf >= 0) {
				result.set(id, listexample);
			}				
		}
		return result;		
	}		
	
	
	private function onSearchTitle (e) {
		TimerTools.timeout(function () { 
			this.searchTitle = this.inputSearchTitle.val();
			updateScorxitems();
		} );
	}	
	
	private function onSearchBes (e) {
		TimerTools.timeout(function () { 
			this.searchBes = this.inputSearchBes.val();
			updateScorxitems();
		} );
	}	
	
	private function onSearchOrig (e) {
		TimerTools.timeout(function () { 
			this.searchOrig = this.inputSearchOrig.val();
			updateScorxitems();
		} );
	}

	private function onSearchFree (e) {
		TimerTools.timeout(function () { 
			this.searchFree = this.inputSearchFree.val();
			updateScorxitems();
		} );
	}
	
	
	
	private function updateScorxitems() {
		var listexamples = this.filterListexamples(this.listexamples, this.searchTitle, this.searchBes, this.searchOrig);
		removeScorxitems();
		addScorxitems(listexamples);
	}	
	
	 //------------------------------------------------------------------------------------------------------------------------
	 
	private function createLikesList() {
		var data = Http.requestUrl('/sx/likes');
		var likes:TLikes = Unserializer.run(data);
		this.updateLikesList(likes);
	}
	
	private function updateLikesList(likes:TLikes) {
		
		for (like in likes) {
			var idString = 'id-' + like.id;
			var likesClass = 'badge-light';
			var likesText = 'Gilla';
			if (like.likes > 0) {
				likesClass = 'somelikes';
				likesText = 'Gilla ' + like.likes;
				if (like.likes > 10) {
					likesClass = 'manylikes';
					likesText = 'Gilla ' + like.likes;
				}
			}
			//Tools.find('#likespan.' + idString).removeClass('nolikes');
			Tools.find('#likespan.' + idString).addClass(likesClass);
			Tools.find('#liketext.' + idString).setText(likesText);			
			
		}
		
		likes.sort(function(a, b) { return Reflect.compare(b.likes, a.likes); } );
		var fiveLikes = likes.slice(0, 5);		
		
		
		if (! "#gillalistan".exists()) {
			Lib.alert (' Ingen gillalista i menyn!');
			return;
		}
		
		var gillalistan = "#gillalistan".find();
		gillalistan.removeChildren(null, "li".find());
		
		var liHeader = '<li class="nav-header">Gillalistan</li>'.parse();
		gillalistan.append(liHeader);
		
		for (like in fiveLikes) {			
			if (! this.listexamples.exists(like.id)) continue;
			
			var likesText = like.likes + ' - ' + this.listexamples.get(like.id).title.substr(0, 16) + '...';
			var likesClass = 'badge-light';
			if (like.likes > 0) {
				likesClass = 'somelikes';
				if (like.likes > 10) {
					likesClass = 'manylikes';
				}
			}						
			
			
			var likeItem = '<li><a id="like" class="clip-link"   href="#" ><span id="likespan" class="badge " "><i class="icon icon-thumbs-up"></i> <span  id="liketext">Gilla</span></span></a></li>'.parse();
			likeItem.find('#liketext').setText(likesText);
			likeItem.find('#likespan').addClass(likesClass);
			likeItem.click(function(e) {
				main.testfunction(like.id);
			});
			gillalistan.append(likeItem);
		}	
	}
	
	public function addLike(id:Int) {
		var data = Http.requestUrl('/sx/addlike/' + id);
		var likes:TLikes = Unserializer.run(data);
		this.updateLikesList(likes);
	}
	
	//-------------------------------------------------------------------------------------
	
	public function scrollToId(id:Int, title:String = '' ) {
		var title = ("#title.id-" + id).find();
						
	}
	
	
	
	
	public function getComments(id:Int) {
		var data = Http.requestUrl('/sx/getcomments/' + id);
		var comments:TComments;
		if (data != '') {
			comments = Unserializer.run(data);
		} else {
			comments = new TComments();
		}
		
		this.updateCommentsList(id, comments);
	}
	
	private var addCommentId:Int;
	public function addComment(id:Int, text:String) {
		//Lib.alert('addComment');
		
		this.addCommentId = id;
		
		var http = new Http('/sx/addcomment/' + id);
		http.setParameter('commenttext', text);
		http.request(false);
		http.onData = onAddedComment;
	}
	
	private function onAddedComment(data:String) {
		//Lib.alert('onAddedComment');
		
		var comments:TComments;
		if (data != '') {
			comments = Unserializer.run(data);
		} else {
			comments = new TComments();
		}
		
		this.updateCommentsList(this.addCommentId, comments);
		
	}
	
	
	private function updateCommentsList(id:Int, comments:TComments) {
		var wrappers = Tools.find('#comments-wrapper');
		wrappers.setText('');
		
		// show...		
		var idString = 'id-' + id;
		var wrapper = ("#comments-wrapper." + idString).find();
		var commentsitem:Commentsitem = new Commentsitem(this, id, comments);
		wrapper.append(commentsitem);
		
		this.createLatestCommentsList();
		this.createCommentsCounts();
	}

	//---------------------------------------------------------------------------------------------------------
	
	private function createLatestCommentsList() {
		var data = Http.requestUrl('/sx/getcommentsdate');
		var latestComments:TComments = Unserializer.run(data);
		this.updateLatestList(latestComments);
		
		
	}
	
	private function updateLatestList(latestComments:TComments) {
		if (! "#kommentarlistan".exists()) {
			trace (' Ingen kommentarlista i menyn!');
			return;
		}
		
		var listan = "#kommentarlistan".find();
		listan.removeChildren(null, "li".find());
		
		var liHeader = '<li class="nav-header">Senaste kommentarer</li>'.parse();
		listan.append(liHeader);		
		
		for (comment in latestComments) {
			
			var item = '<li><a id="latest" class="clip-link"   href="#" ><span id="latestspan" class="badge badge-blue" "><i class="icon icon-pencil"></i> <span  id="latesttext">Latest</span></span></a></li>'.parse();
			
			var text = comment.text.substr(0, 24);
			if (! text.endsWith('...')) text += '...';
			
			item.find('#latesttext').setText(text);
			//likeItem.find('#latestspan').addClass(likesClass);
			item.click(function(e) {
				main.showComments(comment.id, comment);
			});
			listan.append(item);
			
			
			
			
		}
	}

	//--------------------------------------------------------------------------------------------------------
	
	private function createCommentsCounts() {
		var data = Http.requestUrl('/sx/getcommentscount');
		var commentsCount:TCommentsCount = Unserializer.run(data);		
		this.updateCommentsCounts(commentsCount);
	}
	
	private function updateCommentsCounts(commentsCount:TCommentsCount) {
		
		for (id in commentsCount.keys()) {
			var idString = 'id-' + id;			
			var count = commentsCount.get(id);
			
			var btnText = ("#commentbtntext." + idString).find();
			btnText.setText(count + ' Kommentarer');
			
			var span = ("#commentspan." + idString).find();
			span.addClass('badge-blue');
		}
		
	}
	
	
	
	
}



 
 