#include <hxcpp.h>

#ifndef INCLUDED_IntHash
#include <IntHash.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_EventID
#include <wx/EventID.h>
#endif
#ifndef INCLUDED_wx_Frame
#include <wx/Frame.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_MenuBar
#include <wx/MenuBar.h>
#endif
#ifndef INCLUDED_wx_TopLevelWindow
#include <wx/TopLevelWindow.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void Frame_obj::__construct(Dynamic inHandle)
{
HX_STACK_PUSH("Frame::new","wx/Frame.hx",19);
{
	HX_STACK_LINE(20)
	super::__construct(inHandle);
	HX_STACK_LINE(21)
	this->setHandler(::wx::EventID_obj::COMMAND_MENU_SELECTED_dyn(),this->onMenu_dyn());
	HX_STACK_LINE(22)
	this->menuMap = ::IntHash_obj::__new();
}
;
	return null();
}

Frame_obj::~Frame_obj() { }

Dynamic Frame_obj::__CreateEmpty() { return  new Frame_obj; }
hx::ObjectPtr< Frame_obj > Frame_obj::__new(Dynamic inHandle)
{  hx::ObjectPtr< Frame_obj > result = new Frame_obj();
	result->__construct(inHandle);
	return result;}

Dynamic Frame_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< Frame_obj > result = new Frame_obj();
	result->__construct(inArgs[0]);
	return result;}

Void Frame_obj::onMenu( Dynamic event){
{
		HX_STACK_PUSH("Frame::onMenu","wx/Frame.hx",37);
		HX_STACK_THIS(this);
		HX_STACK_ARG(event,"event");
		HX_STACK_LINE(38)
		int id = event->__Field(HX_CSTRING("id"),true);		HX_STACK_VAR(id,"id");
		HX_STACK_LINE(39)
		if ((this->menuMap->exists(id))){
			HX_STACK_LINE(40)
			this->menuMap->get(id)(event).Cast< Void >();
		}
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC1(Frame_obj,onMenu,(void))

Void Frame_obj::handle( int id,Dynamic handler){
{
		HX_STACK_PUSH("Frame::handle","wx/Frame.hx",32);
		HX_STACK_THIS(this);
		HX_STACK_ARG(id,"id");
		HX_STACK_ARG(handler,"handler");
		HX_STACK_LINE(32)
		this->menuMap->set(id,handler);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC2(Frame_obj,handle,(void))

::wx::MenuBar Frame_obj::wxSetMenuBar( ::wx::MenuBar inBar){
	HX_STACK_PUSH("Frame::wxSetMenuBar","wx/Frame.hx",26);
	HX_STACK_THIS(this);
	HX_STACK_ARG(inBar,"inBar");
	HX_STACK_LINE(27)
	::wx::Frame_obj::wx_frame_set_menu_bar(this->wxHandle,inBar->wxHandle);
	HX_STACK_LINE(28)
	return inBar;
}


HX_DEFINE_DYNAMIC_FUNC1(Frame_obj,wxSetMenuBar,return )

::wx::Frame Frame_obj::create( ::wx::Window inParent,Dynamic inID,::String __o_inTitle,Dynamic inPosition,Dynamic inSize,Dynamic inStyle){
::String inTitle = __o_inTitle.Default(HX_CSTRING(""));
	HX_STACK_PUSH("Frame::create","wx/Frame.hx",11);
	HX_STACK_ARG(inParent,"inParent");
	HX_STACK_ARG(inID,"inID");
	HX_STACK_ARG(inTitle,"inTitle");
	HX_STACK_ARG(inPosition,"inPosition");
	HX_STACK_ARG(inSize,"inSize");
	HX_STACK_ARG(inStyle,"inStyle");
{
		HX_STACK_LINE(12)
		Dynamic handle = ::wx::Frame_obj::wx_frame_create(Dynamic( Array_obj<Dynamic>::__new().Add((  (((inParent == null()))) ? Dynamic(null()) : Dynamic(inParent->wxHandle) )).Add(inID).Add(inTitle).Add(inPosition).Add(inSize).Add(inStyle)));		HX_STACK_VAR(handle,"handle");
		HX_STACK_LINE(14)
		return ::wx::Frame_obj::__new(handle);
	}
}


STATIC_HX_DEFINE_DYNAMIC_FUNC6(Frame_obj,create,return )

Dynamic Frame_obj::wx_frame_create;

Dynamic Frame_obj::wx_frame_set_menu_bar;


Frame_obj::Frame_obj()
{
}

void Frame_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(Frame);
	HX_MARK_MEMBER_NAME(menuMap,"menuMap");
	HX_MARK_MEMBER_NAME(menuBar,"menuBar");
	super::__Mark(HX_MARK_ARG);
	HX_MARK_END_CLASS();
}

void Frame_obj::__Visit(HX_VISIT_PARAMS)
{
	HX_VISIT_MEMBER_NAME(menuMap,"menuMap");
	HX_VISIT_MEMBER_NAME(menuBar,"menuBar");
	super::__Visit(HX_VISIT_ARG);
}

Dynamic Frame_obj::__Field(const ::String &inName,bool inCallProp)
{
	switch(inName.length) {
	case 6:
		if (HX_FIELD_EQ(inName,"create") ) { return create_dyn(); }
		if (HX_FIELD_EQ(inName,"onMenu") ) { return onMenu_dyn(); }
		if (HX_FIELD_EQ(inName,"handle") ) { return handle_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"menuMap") ) { return menuMap; }
		if (HX_FIELD_EQ(inName,"menuBar") ) { return menuBar; }
		break;
	case 12:
		if (HX_FIELD_EQ(inName,"wxSetMenuBar") ) { return wxSetMenuBar_dyn(); }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_frame_create") ) { return wx_frame_create; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"wx_frame_set_menu_bar") ) { return wx_frame_set_menu_bar; }
	}
	return super::__Field(inName,inCallProp);
}

Dynamic Frame_obj::__SetField(const ::String &inName,const Dynamic &inValue,bool inCallProp)
{
	switch(inName.length) {
	case 7:
		if (HX_FIELD_EQ(inName,"menuMap") ) { menuMap=inValue.Cast< ::IntHash >(); return inValue; }
		if (HX_FIELD_EQ(inName,"menuBar") ) { if (inCallProp) return wxSetMenuBar(inValue);menuBar=inValue.Cast< ::wx::MenuBar >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_frame_create") ) { wx_frame_create=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 21:
		if (HX_FIELD_EQ(inName,"wx_frame_set_menu_bar") ) { wx_frame_set_menu_bar=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue,inCallProp);
}

void Frame_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("menuMap"));
	outFields->push(HX_CSTRING("menuBar"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("create"),
	HX_CSTRING("wx_frame_create"),
	HX_CSTRING("wx_frame_set_menu_bar"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("onMenu"),
	HX_CSTRING("handle"),
	HX_CSTRING("wxSetMenuBar"),
	HX_CSTRING("menuMap"),
	HX_CSTRING("menuBar"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(Frame_obj::__mClass,"__mClass");
	HX_MARK_MEMBER_NAME(Frame_obj::wx_frame_create,"wx_frame_create");
	HX_MARK_MEMBER_NAME(Frame_obj::wx_frame_set_menu_bar,"wx_frame_set_menu_bar");
};

static void sVisitStatics(HX_VISIT_PARAMS) {
	HX_VISIT_MEMBER_NAME(Frame_obj::__mClass,"__mClass");
	HX_VISIT_MEMBER_NAME(Frame_obj::wx_frame_create,"wx_frame_create");
	HX_VISIT_MEMBER_NAME(Frame_obj::wx_frame_set_menu_bar,"wx_frame_set_menu_bar");
};

Class Frame_obj::__mClass;

void Frame_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.Frame"), hx::TCanCast< Frame_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics, sVisitStatics);
}

void Frame_obj::__boot()
{
	wx_frame_create= ::wx::Loader_obj::load(HX_CSTRING("wx_frame_create"),(int)1);
	wx_frame_set_menu_bar= ::wx::Loader_obj::load(HX_CSTRING("wx_frame_set_menu_bar"),(int)2);
}

} // end namespace wx
