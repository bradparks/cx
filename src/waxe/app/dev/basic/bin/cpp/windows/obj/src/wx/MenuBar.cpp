#include <hxcpp.h>

#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Menu
#include <wx/Menu.h>
#endif
#ifndef INCLUDED_wx_MenuBar
#include <wx/MenuBar.h>
#endif
namespace wx{

Void MenuBar_obj::__construct()
{
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/MenuBar.hx",6)
	super::__construct(::wx::MenuBar_obj::wx_menu_bar_create());
}
;
	return null();
}

MenuBar_obj::~MenuBar_obj() { }

Dynamic MenuBar_obj::__CreateEmpty() { return  new MenuBar_obj; }
hx::ObjectPtr< MenuBar_obj > MenuBar_obj::__new()
{  hx::ObjectPtr< MenuBar_obj > result = new MenuBar_obj();
	result->__construct();
	return result;}

Dynamic MenuBar_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< MenuBar_obj > result = new MenuBar_obj();
	result->__construct();
	return result;}

Void MenuBar_obj::HandleEvent( Dynamic event){
{
		HX_SOURCE_PUSH("MenuBar_obj::HandleEvent")
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(MenuBar_obj,HandleEvent,(void))

Void MenuBar_obj::append( ::wx::Menu inMenu,::String inTitle){
{
		HX_SOURCE_PUSH("MenuBar_obj::append")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/MenuBar.hx",14)
		::wx::MenuBar_obj::wx_menu_bar_append(this->wxHandle,inMenu->wxHandle,inTitle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(MenuBar_obj,append,(void))

Dynamic MenuBar_obj::wx_menu_bar_create;

Dynamic MenuBar_obj::wx_menu_bar_append;


MenuBar_obj::MenuBar_obj()
{
}

void MenuBar_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(MenuBar);
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

Dynamic MenuBar_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"append") ) { return append_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"HandleEvent") ) { return HandleEvent_dyn(); }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_menu_bar_create") ) { return wx_menu_bar_create; }
		if (HX_FIELD_EQ(inName,"wx_menu_bar_append") ) { return wx_menu_bar_append; }
	}
	return super::__Field(inName);
}

Dynamic MenuBar_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 18:
		if (HX_FIELD_EQ(inName,"wx_menu_bar_create") ) { wx_menu_bar_create=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_menu_bar_append") ) { wx_menu_bar_append=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void MenuBar_obj::__GetFields(Array< ::String> &outFields)
{
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("wx_menu_bar_create"),
	HX_CSTRING("wx_menu_bar_append"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("HandleEvent"),
	HX_CSTRING("append"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(MenuBar_obj::wx_menu_bar_create,"wx_menu_bar_create");
	HX_MARK_MEMBER_NAME(MenuBar_obj::wx_menu_bar_append,"wx_menu_bar_append");
};

Class MenuBar_obj::__mClass;

void MenuBar_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.MenuBar"), hx::TCanCast< MenuBar_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void MenuBar_obj::__boot()
{
	hx::Static(wx_menu_bar_create) = ::wx::Loader_obj::load(HX_CSTRING("wx_menu_bar_create"),(int)0);
	hx::Static(wx_menu_bar_append) = ::wx::Loader_obj::load(HX_CSTRING("wx_menu_bar_append"),(int)3);
}

} // end namespace wx
