package smd.server.proto;

/**
 * ...
 * @author Jonas Nyström
 */

typedef User = {
	id:String,
	category:UserCategory,
	firstname:String,
	lastname:String,
	user:String,
	pass:String,
}

enum UserCategory {
	Anonym;
	Deltagare;
	Admin;
}