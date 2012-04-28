package ka.admin;

import cx.CliBase;
import cx.ExcelTools;
import cx.FileTools;
import cx.GoogleTools;
import cx.HtmlTools;
import cx.Tools;
import cx.ValidationTools;
import haxe.Serializer;
import haxe.Unserializer;
import ka.tools.AdminGdata;
import neko.FileSystem;
import neko.io.File;
import neko.Lib;
import ka.tools.PersonerExport;
import ka.types.Person;
import ka.types.Personer;
import ka.types.Studietermin;
import ka.types.Studieterminer;
import ka.types.StudieterminExt;
import ka.types.StudieterminerExt;
import ka.types.Admingrupp;
import ka.types.Admingrupper;
import ka.types.Kor;
import ka.types.Korer;

/**
 * ...
 * @author Jonas Nyström
 */

class Main {	
	static function main() {
		new CliBase(AdminCli, AdminCli.cmds, ' Körakademins Administrationsverktg "KALLE" - version ');
	}		
}

import cx.GoogleTools;

using StringTools;
using ka.tools.PersonFilter;

class AdminCli extends CliBase {	
	static var email = 'jonasnys';
	static var passwd = '%gloria!';
	static var sheetPersoner = '0Ar0dMoySp13UdFNOdXNjenRJd3pyLW9GWlFJTXdrX0E';
	static var sheetData = '0Ar0dMoySp13UdDZuelAyRmFSektpOTZNeWhFeHVkbGc';
	static var pageDataStudieterminer = 0;
	static var pageDataAdmingrupper = 1;
	static var pageDataKorer = 2;
	
	static public var cmds = [
				'hämta personer', 
				'hämta data',
				['filtrera', 'filter körer', 'filter admingrupper', 'filter studieterminer'],
				['skärmlista', 'personer urval| lista', 'personer alla| lista', 'körer urval| lista', 'körer alla| lista'],
				['html', 'personer urval| html', 'personer alla| html'],
				['excel', 'personer urval| excel', 'personer alla| excel'],
				['epost', 'personer urval| email', 'personer alla| email'],
				['övrigt', 'exportera autentiseringsfil'],
				'sortera',
			];	
	
	
	
	static public var fieldsPerson:Person;
	static public var dataPersoner:Personer;
	static public var dataStudieterminer:Studieterminer;
	static public var dataStudieterminerExt:StudieterminerExt;
	static public var dataAdmingrupper:Admingrupper;
	static public var dataKorer:Korer;
	
	static public var resultPersoner:Personer;

	static public var filterKorer:Korer;
	static public var filterAdmingrupper:Admingrupper;
	static public var filterStudieterminer:Studieterminer;
		
	static private var filenameDataPersoner:String = 'temp/personer.data';
	static private var filenameFieldsPersoner:String = 'temp/personer.fields';
	static private var filenameHtmlPersoner:String = 'temp/personer.html';
	static private var filenameEmailsPersoner:String = 'temp/emails.txt';	
	static private var filenameStudieterminerExt = 'temp/studieterminer-ext.data';
	static private var filenameKorer = 'temp/korer.data';
	static private var filenameAdmingrupper = 'temp/admingrupper.data';
	
	static public function init() {
		filterKorer = new Korer();
		if (!FileSystem.exists('temp')) {
			FileSystem.createDirectory('temp');
		}
		//--------------------------------------------------------		
		if (FileSystem.exists(filenameDataPersoner)) {
			dataPersoner = Unserializer.run(File.getContent(filenameDataPersoner));
			fieldsPerson = Unserializer.run(File.getContent(filenameFieldsPersoner));
		} else {
			__hamta_personer();
		}
		
		if (FileSystem.exists(filenameStudieterminerExt)) {
			dataStudieterminerExt = Unserializer.run(File.getContent(filenameStudieterminerExt));
		} else {
			fetchStuditerminer();
		}
		dataStudieterminer = new Studieterminer();
		for (dse in dataStudieterminerExt) {
			dataStudieterminer.push(dse.namn);
		}
		filterStudieterminer = dataStudieterminer.copy();
		filterStudieterminer = setStudieterminerFiletToDate(Date.now());		

		if (FileSystem.exists(filenameAdmingrupper)) {
			dataAdmingrupper = Unserializer.run(File.getContent(filenameAdmingrupper));
		} else {
			fetchAdmingrupper();
		}
		filterAdmingrupper = new Admingrupper();

		if (FileSystem.exists(filenameKorer)) {
			dataKorer = Unserializer.run(File.getContent((filenameKorer)));
		} else {
			fetchKorer();
		}
		filterKorer = new Korer();
	}		

	static public function beforePrintAndWait() {		
		resultPersoner = applyFilters();
		Lib.println('');
		Lib.println(CliBase.DIVIDER2);
		
		// Filter
		if (filterStudieterminer.length > 0) Lib.println(CliBase.decode('Filter studieterminer: ') + filterStudieterminer);
		if (filterKorer.length > 0) Lib.println(CliBase.decode('Filter körer: ') + filterKorer);		
		if (filterAdmingrupper.length > 0) Lib.println(CliBase.decode('Filter admingrupper') + filterAdmingrupper);
		
		
		// Antal
		Lib.println(CliBase.decode('Antal personer : ' + resultPersoner.length + '/' + dataPersoner.length));

		//if (filterKorer.length > 0) Lib.println(CliBase.decode('filter körer: ') + filterKorer);
		//Lib.println(CliBase.DIVIDER2);
	}	
	
	
	static public function __hamta_personer() {
		Lib.println(CliBase.decode('Hämtar personer...'));
		dataPersoner = AdminGdata.getPersoner();
		fieldsPerson = AdminGdata.getPersonerFields();
		FileTools.putContent(filenameDataPersoner, Serializer.run(dataPersoner));
		FileTools.putContent(filenameFieldsPersoner, Serializer.run(fieldsPerson));
	}
		

	static public function __hamta_data() {
		fetchStuditerminer();
		fetchAdmingrupper();
		fetchKorer();
	}
	
	//--------------------------------------------------------------
	
	static public function fetchStuditerminer() {
		Lib.println(CliBase.decode('Hämtar studieterminer...'));
		dataStudieterminerExt = AdminGdata.getStudieterminerExt();
		dataStudieterminer = AdminGdata.getStudieterminer();
		FileTools.putContent(filenameStudieterminerExt, Serializer.run(dataStudieterminerExt));	
	}
	
	static public function fetchAdmingrupper() {
		Lib.println(CliBase.decode('Hämtar administrativa grupper...'));
		dataAdmingrupper = AdminGdata.getAdmingrupper();
		FileTools.putContent(filenameAdmingrupper, Serializer.run(dataAdmingrupper));		
	}	
	
	static public function fetchKorer() {
		Lib.println(CliBase.decode('Hämtar körer...'));
		dataKorer = AdminGdata.getKorer();
		FileTools.putContent(filenameKorer, Serializer.run(dataKorer));		
	}	
	
	static public function setStudieterminerFiletToDate(date:Date) {		
		var filterStudieterminer = new Studieterminer();
		for (se in dataStudieterminerExt) {
			if (se.start != null) {				
				if (Tools.inRange(se.start.getTime(), date.getTime(), se.slut.getTime())) {
					filterStudieterminer.push(se.namn);	
				}			
			}
		}
		return filterStudieterminer;
	}
	
	static public function __filter_korer() {		
		
		/*
		var aktuellaKorer = Lambda.filter(dataKorer, function(item) { 			
			return Tools.arraysOverlap(item.studieterminer, filterStudieterminer);				
		} );
		*/

		var items = Lambda.map(dataKorer, function(item) { return item.namn; } );
		var itemNr = CliBase.subcommandPrintAndWait(items, 'Kör nr', true, true);
		if (itemNr == -1) return;		
		if (itemNr == -2) { filterKorer = dataKorer;	return;}
		if (itemNr == -3) { filterKorer = new Korer();	return; }
		
		var kor = dataKorer[itemNr];
		
		if (Lambda.indexOf(filterKorer, kor) >= 0) {
			trace('Koren finns redan');
			return;
		} 
		filterKorer.push(kor);
	}
	
	static public function __filter_studieterminer() {
		var items = Lambda.map(dataStudieterminer, function(item) { return item; } );		
		var itemNr = CliBase.subcommandPrintAndWait(items, 'Studietermin nr');
		
		var studietermin:Studietermin = dataStudieterminer[itemNr];
		
		filterStudieterminer = new Studieterminer();
		filterStudieterminer.push(studietermin);
		Lib.println('');
		Lib.println(CliBase.decode('Nytt filter för studietermin: ') + filterStudieterminer);		
	}
	
	static public function __filter_admingrupper() {		
		
		var items = Lambda.map(dataAdmingrupper, function(item) { return item.gruppnamn; } );
		var itemNr = CliBase.subcommandPrintAndWait(items, 'Admingrupp nr', true, true);
		if (itemNr == -1) return;		
		
		if (itemNr == -2) { filterAdmingrupper = dataAdmingrupper;	return;}
		if (itemNr == -3) { filterAdmingrupper = new Admingrupper();	return; }

		if (Lambda.indexOf(filterAdmingrupper, dataAdmingrupper[itemNr]) >= 0) {
			trace('Admingruppen finns redan');
			return;
		} 		
		
		filterAdmingrupper.push(dataAdmingrupper[itemNr]);
		
		
		
		/*
		var kor = dataAdmingrupper[itemNr];
		if (Lambda.indexOf(filterKorer, kor) >= 0) {
			trace('Koren finns redan');
		}else filterAdmingrupper.push(kor);
		*/
		
		trace(filterAdmingrupper);
	}	
	
	//----------------------------------------------------------------------------------------------------------------
	//----------------------------------------------------------------------------------------------------------------
	
	static public function applyFilters() {
		var tempPersoner:Personer = dataPersoner.copy();
		if (filterStudieterminer != null) if (filterStudieterminer.length > 0) tempPersoner = tempPersoner.filterStudieterminer(filterStudieterminer);
		if (filterKorer != null) if (filterKorer.length > 0) tempPersoner = tempPersoner.filterKorer(filterKorer);
		if (filterAdmingrupper != null) if (filterAdmingrupper.length > 0) tempPersoner = tempPersoner.filterAdmingrupper(filterAdmingrupper);
		return tempPersoner;
	}
	
	//----------------------------------------------------------------------------------------------------------------
	//----------------------------------------------------------------------------------------------------------------
	
	static public function __personer_alla_lista() {
		_personer(dataPersoner, 'Alla personer:');
	}	
	
	static public function __personer_urval_lista() {
		_personer(resultPersoner, 'Urval personer:');
	}

	static public function _personer(personer:Personer, label:String) {
		Lib.println('');
		Lib.println(CliBase.decode(label) + ' ' + personer.length + ' st');
		Lib.println(CliBase.DIVIDER1 + CliBase.DIVIDER1);
		var str = PersonerExport.toStringlist(personer, null);
		Lib.println(str);
		Lib.println(CliBase.DIVIDER1 + CliBase.DIVIDER1);
		Lib.println('');
	}
	
	
	static public function __korer_alla_lista() {
		Lib.println('');
		Lib.println(CliBase.decode('Alla körer:'));
		for (kor in dataKorer) {
			Lib.println(' - ' + CliBase.decode(kor.namn) + ' ' + kor.studieterminer);
		}
		Lib.println('');
	}
	
	static public function __korer_urval_lista() {
		var tempKorer = new  Korer();
		for (kor in dataKorer) {
			for (termin in filterStudieterminer) {
				if (Lambda.has(kor.studieterminer, termin)) tempKorer.push(kor);			
			}
		}
		//trace(tempKorer);
		Lib.println('');
		Lib.println(CliBase.decode('Körer:'));
		for (kor in tempKorer) {
			Lib.println(' - ' + CliBase.decode(kor.namn) + ' ' + kor.studieterminer);
		}
		Lib.println('');
	}	
	
	
	//--------------------------------------------------------
	// html
	
	static public function __personer_alla_html() {
		_html(dataPersoner);
	}	
	
	static public function __personer_urval_html() {
		_html(resultPersoner);
	}	
	
	static public function _html(personer:Personer) {
		/*
		var html = HtmlTools.getMeta() + getPersonerHtml(personer);
		FileTools.putContentExecute(filenameHtmlPersoner, html);				
		*/
		PersonerExport.toHtml(filenameHtmlPersoner, personer, null);
		
	}

	//--------------------------------------------------------
	// email
	
	static public function __personer_alla_email() {
		_email(dataPersoner);
	}

	static public function __personer_urval_email() {
		_email(resultPersoner);
	}		

	static public function _email(personer:Personer) {
		PersonerExport.toEmailList(filenameEmailsPersoner, personer);
	}		
	
	//--------------------------------------------------------
	// excel
	
	static public function __personer_alla_excel() {		
		var filename = 'export/alla-personer.xls';
		_excel(dataPersoner, filename);
	}	
	
	static public function __personer_urval_excel() {		
		var filename = 'export/urval-personer.xls';
		_excel(resultPersoner, filename);
	}		

	static public function _excel(personer:Personer, filename:String) {		
		//var filename = 'export/urval-personer.xls';
		Lib.println('');
		Lib.println(' Exporterar personer till ' + filename + '...');		
		PersonerExport.toExcel(filename, personer);
		Lib.println(' Export klar!');		
		Lib.println('');		
	}		
	
	//--------------------------------------------------------
	// autentisering	
	
	static private function __exportera_autentiseringsfil() {
		PersonerExport.toAuthfile('data/autentisering.dat', resultPersoner);
	}
	
}

