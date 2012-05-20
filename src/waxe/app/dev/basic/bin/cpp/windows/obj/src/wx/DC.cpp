#include <hxcpp.h>

#ifndef INCLUDED_wx_Bitmap
#include <wx/Bitmap.h>
#endif
#ifndef INCLUDED_wx_Brush
#include <wx/Brush.h>
#endif
#ifndef INCLUDED_wx_DC
#include <wx/DC.h>
#endif
#ifndef INCLUDED_wx_EventHandler
#include <wx/EventHandler.h>
#endif
#ifndef INCLUDED_wx_Font
#include <wx/Font.h>
#endif
#ifndef INCLUDED_wx_Loader
#include <wx/Loader.h>
#endif
#ifndef INCLUDED_wx_Pen
#include <wx/Pen.h>
#endif
#ifndef INCLUDED_wx_Window
#include <wx/Window.h>
#endif
namespace wx{

Void DC_obj::__construct(Dynamic handle)
{
{
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",12)
	this->wxHandle = handle;
}
;
	return null();
}

DC_obj::~DC_obj() { }

Dynamic DC_obj::__CreateEmpty() { return  new DC_obj; }
hx::ObjectPtr< DC_obj > DC_obj::__new(Dynamic handle)
{  hx::ObjectPtr< DC_obj > result = new DC_obj();
	result->__construct(handle);
	return result;}

Dynamic DC_obj::__Create(hx::DynamicArray inArgs)
{  hx::ObjectPtr< DC_obj > result = new DC_obj();
	result->__construct(inArgs[0]);
	return result;}

Void DC_obj::destroy( ){
{
		HX_SOURCE_PUSH("DC_obj::destroy")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",15)
		::wx::DC_obj::wx_object_destroy(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(DC_obj,destroy,(void))

Void DC_obj::drawLine( int x1,int y1,int x2,int y2){
{
		HX_SOURCE_PUSH("DC_obj::drawLine")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",18)
		::wx::DC_obj::wx_dc_draw_line(this->wxHandle,x1,y1,x2,y2);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC4(DC_obj,drawLine,(void))

Void DC_obj::clear( ){
{
		HX_SOURCE_PUSH("DC_obj::clear")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",22)
		::wx::DC_obj::wx_dc_clear(this->wxHandle);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC0(DC_obj,clear,(void))

::wx::Pen DC_obj::setPen( ::wx::Pen inPen){
	HX_SOURCE_PUSH("DC_obj::setPen")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",27)
	::wx::DC_obj::wx_dc_set_pen(this->wxHandle,inPen->wxGetHandle());
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",28)
	return inPen;
}


HX_DEFINE_DYNAMIC_FUNC1(DC_obj,setPen,return )

::wx::Brush DC_obj::setBrush( ::wx::Brush inBrush){
	HX_SOURCE_PUSH("DC_obj::setBrush")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",32)
	::wx::DC_obj::wx_dc_set_brush(this->wxHandle,inBrush->wxGetHandle());
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",33)
	return inBrush;
}


HX_DEFINE_DYNAMIC_FUNC1(DC_obj,setBrush,return )

::wx::Brush DC_obj::setBackground( ::wx::Brush inBrush){
	HX_SOURCE_PUSH("DC_obj::setBackground")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",37)
	::wx::DC_obj::wx_dc_set_background(this->wxHandle,inBrush->wxGetHandle());
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",38)
	return inBrush;
}


HX_DEFINE_DYNAMIC_FUNC1(DC_obj,setBackground,return )

::wx::Font DC_obj::setFont( ::wx::Font inFont){
	HX_SOURCE_PUSH("DC_obj::setFont")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",42)
	::wx::DC_obj::wx_dc_set_font(this->wxHandle,inFont->wxGetHandle());
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",43)
	return inFont;
}


HX_DEFINE_DYNAMIC_FUNC1(DC_obj,setFont,return )

Void DC_obj::drawRectangle( int x,int y,int width,int height){
{
		HX_SOURCE_PUSH("DC_obj::drawRectangle")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",46)
		::wx::DC_obj::wx_dc_draw_rectangle(this->wxHandle,x,y,width,height);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC4(DC_obj,drawRectangle,(void))

Void DC_obj::drawCircle( int x,int y,int rad){
{
		HX_SOURCE_PUSH("DC_obj::drawCircle")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",50)
		::wx::DC_obj::wx_dc_draw_circle(this->wxHandle,x,y,rad);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC3(DC_obj,drawCircle,(void))

Void DC_obj::drawEllipse( int x,int y,int width,int height){
{
		HX_SOURCE_PUSH("DC_obj::drawEllipse")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",54)
		::wx::DC_obj::wx_dc_draw_ellipse(this->wxHandle,x,y,width,height);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC4(DC_obj,drawEllipse,(void))

Void DC_obj::drawText( ::String text,int x,int y){
{
		HX_SOURCE_PUSH("DC_obj::drawText")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",58)
		::wx::DC_obj::wx_dc_draw_text(this->wxHandle,text,x,y);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC3(DC_obj,drawText,(void))

Void DC_obj::drawBitmap( ::wx::Bitmap bitmap,int x,int y,bool inTransparent){
{
		HX_SOURCE_PUSH("DC_obj::drawBitmap")
		HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",62)
		::wx::DC_obj::wx_dc_draw_bitmap(this->wxHandle,bitmap->wxHandle,x,y,inTransparent);
	}
return null();
}


HX_DEFINE_DYNAMIC_FUNC4(DC_obj,drawBitmap,(void))

::wx::DC DC_obj::createPaintDC( ::wx::Window inWindow){
	HX_SOURCE_PUSH("DC_obj::createPaintDC")
	HX_SOURCE_POS("C:\\Program Files\\Motion-Twin\\haxe\\lib\\waxe/1,0,1/wx/DC.hx",67)
	return ::wx::DC_obj::__new(::wx::DC_obj::wx_dc_create_paint(inWindow->wxHandle));
}


STATIC_HX_DEFINE_DYNAMIC_FUNC1(DC_obj,createPaintDC,return )

Dynamic DC_obj::wx_dc_create_paint;

Dynamic DC_obj::wx_dc_draw_line;

Dynamic DC_obj::wx_object_destroy;

Dynamic DC_obj::wx_dc_clear;

Dynamic DC_obj::wx_dc_set_pen;

Dynamic DC_obj::wx_dc_set_font;

Dynamic DC_obj::wx_dc_set_brush;

Dynamic DC_obj::wx_dc_set_background;

Dynamic DC_obj::wx_dc_draw_rectangle;

Dynamic DC_obj::wx_dc_draw_circle;

Dynamic DC_obj::wx_dc_draw_ellipse;

Dynamic DC_obj::wx_dc_draw_text;

Dynamic DC_obj::wx_dc_draw_bitmap;


DC_obj::DC_obj()
{
}

void DC_obj::__Mark(HX_MARK_PARAMS)
{
	HX_MARK_BEGIN_CLASS(DC);
	HX_MARK_MEMBER_NAME(pen,"pen");
	HX_MARK_MEMBER_NAME(brush,"brush");
	HX_MARK_MEMBER_NAME(background,"background");
	HX_MARK_MEMBER_NAME(font,"font");
	HX_MARK_MEMBER_NAME(wxHandle,"wxHandle");
	HX_MARK_END_CLASS();
}

Dynamic DC_obj::__Field(const ::String &inName)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"pen") ) { return pen; }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"font") ) { return font; }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"brush") ) { return brush; }
		if (HX_FIELD_EQ(inName,"clear") ) { return clear_dyn(); }
		break;
	case 6:
		if (HX_FIELD_EQ(inName,"setPen") ) { return setPen_dyn(); }
		break;
	case 7:
		if (HX_FIELD_EQ(inName,"destroy") ) { return destroy_dyn(); }
		if (HX_FIELD_EQ(inName,"setFont") ) { return setFont_dyn(); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { return wxHandle; }
		if (HX_FIELD_EQ(inName,"drawLine") ) { return drawLine_dyn(); }
		if (HX_FIELD_EQ(inName,"setBrush") ) { return setBrush_dyn(); }
		if (HX_FIELD_EQ(inName,"drawText") ) { return drawText_dyn(); }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"background") ) { return background; }
		if (HX_FIELD_EQ(inName,"drawCircle") ) { return drawCircle_dyn(); }
		if (HX_FIELD_EQ(inName,"drawBitmap") ) { return drawBitmap_dyn(); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"wx_dc_clear") ) { return wx_dc_clear; }
		if (HX_FIELD_EQ(inName,"drawEllipse") ) { return drawEllipse_dyn(); }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"createPaintDC") ) { return createPaintDC_dyn(); }
		if (HX_FIELD_EQ(inName,"wx_dc_set_pen") ) { return wx_dc_set_pen; }
		if (HX_FIELD_EQ(inName,"setBackground") ) { return setBackground_dyn(); }
		if (HX_FIELD_EQ(inName,"drawRectangle") ) { return drawRectangle_dyn(); }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"wx_dc_set_font") ) { return wx_dc_set_font; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_dc_draw_line") ) { return wx_dc_draw_line; }
		if (HX_FIELD_EQ(inName,"wx_dc_set_brush") ) { return wx_dc_set_brush; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_text") ) { return wx_dc_draw_text; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"wx_object_destroy") ) { return wx_object_destroy; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_circle") ) { return wx_dc_draw_circle; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_bitmap") ) { return wx_dc_draw_bitmap; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_dc_create_paint") ) { return wx_dc_create_paint; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_ellipse") ) { return wx_dc_draw_ellipse; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"wx_dc_set_background") ) { return wx_dc_set_background; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_rectangle") ) { return wx_dc_draw_rectangle; }
	}
	return super::__Field(inName);
}

Dynamic DC_obj::__SetField(const ::String &inName,const Dynamic &inValue)
{
	switch(inName.length) {
	case 3:
		if (HX_FIELD_EQ(inName,"pen") ) { return setPen(inValue); }
		break;
	case 4:
		if (HX_FIELD_EQ(inName,"font") ) { return setFont(inValue); }
		break;
	case 5:
		if (HX_FIELD_EQ(inName,"brush") ) { return setBrush(inValue); }
		break;
	case 8:
		if (HX_FIELD_EQ(inName,"wxHandle") ) { wxHandle=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 10:
		if (HX_FIELD_EQ(inName,"background") ) { return setBackground(inValue); }
		break;
	case 11:
		if (HX_FIELD_EQ(inName,"wx_dc_clear") ) { wx_dc_clear=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 13:
		if (HX_FIELD_EQ(inName,"wx_dc_set_pen") ) { wx_dc_set_pen=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 14:
		if (HX_FIELD_EQ(inName,"wx_dc_set_font") ) { wx_dc_set_font=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 15:
		if (HX_FIELD_EQ(inName,"wx_dc_draw_line") ) { wx_dc_draw_line=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_dc_set_brush") ) { wx_dc_set_brush=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_text") ) { wx_dc_draw_text=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 17:
		if (HX_FIELD_EQ(inName,"wx_object_destroy") ) { wx_object_destroy=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_circle") ) { wx_dc_draw_circle=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_bitmap") ) { wx_dc_draw_bitmap=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 18:
		if (HX_FIELD_EQ(inName,"wx_dc_create_paint") ) { wx_dc_create_paint=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_ellipse") ) { wx_dc_draw_ellipse=inValue.Cast< Dynamic >(); return inValue; }
		break;
	case 20:
		if (HX_FIELD_EQ(inName,"wx_dc_set_background") ) { wx_dc_set_background=inValue.Cast< Dynamic >(); return inValue; }
		if (HX_FIELD_EQ(inName,"wx_dc_draw_rectangle") ) { wx_dc_draw_rectangle=inValue.Cast< Dynamic >(); return inValue; }
	}
	return super::__SetField(inName,inValue);
}

void DC_obj::__GetFields(Array< ::String> &outFields)
{
	outFields->push(HX_CSTRING("pen"));
	outFields->push(HX_CSTRING("brush"));
	outFields->push(HX_CSTRING("background"));
	outFields->push(HX_CSTRING("font"));
	outFields->push(HX_CSTRING("wxHandle"));
	super::__GetFields(outFields);
};

static ::String sStaticFields[] = {
	HX_CSTRING("createPaintDC"),
	HX_CSTRING("wx_dc_create_paint"),
	HX_CSTRING("wx_dc_draw_line"),
	HX_CSTRING("wx_object_destroy"),
	HX_CSTRING("wx_dc_clear"),
	HX_CSTRING("wx_dc_set_pen"),
	HX_CSTRING("wx_dc_set_font"),
	HX_CSTRING("wx_dc_set_brush"),
	HX_CSTRING("wx_dc_set_background"),
	HX_CSTRING("wx_dc_draw_rectangle"),
	HX_CSTRING("wx_dc_draw_circle"),
	HX_CSTRING("wx_dc_draw_ellipse"),
	HX_CSTRING("wx_dc_draw_text"),
	HX_CSTRING("wx_dc_draw_bitmap"),
	String(null()) };

static ::String sMemberFields[] = {
	HX_CSTRING("pen"),
	HX_CSTRING("brush"),
	HX_CSTRING("background"),
	HX_CSTRING("font"),
	HX_CSTRING("wxHandle"),
	HX_CSTRING("destroy"),
	HX_CSTRING("drawLine"),
	HX_CSTRING("clear"),
	HX_CSTRING("setPen"),
	HX_CSTRING("setBrush"),
	HX_CSTRING("setBackground"),
	HX_CSTRING("setFont"),
	HX_CSTRING("drawRectangle"),
	HX_CSTRING("drawCircle"),
	HX_CSTRING("drawEllipse"),
	HX_CSTRING("drawText"),
	HX_CSTRING("drawBitmap"),
	String(null()) };

static void sMarkStatics(HX_MARK_PARAMS) {
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_create_paint,"wx_dc_create_paint");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_draw_line,"wx_dc_draw_line");
	HX_MARK_MEMBER_NAME(DC_obj::wx_object_destroy,"wx_object_destroy");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_clear,"wx_dc_clear");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_set_pen,"wx_dc_set_pen");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_set_font,"wx_dc_set_font");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_set_brush,"wx_dc_set_brush");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_set_background,"wx_dc_set_background");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_draw_rectangle,"wx_dc_draw_rectangle");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_draw_circle,"wx_dc_draw_circle");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_draw_ellipse,"wx_dc_draw_ellipse");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_draw_text,"wx_dc_draw_text");
	HX_MARK_MEMBER_NAME(DC_obj::wx_dc_draw_bitmap,"wx_dc_draw_bitmap");
};

Class DC_obj::__mClass;

void DC_obj::__register()
{
	Static(__mClass) = hx::RegisterClass(HX_CSTRING("wx.DC"), hx::TCanCast< DC_obj> ,sStaticFields,sMemberFields,
	&__CreateEmpty, &__Create,
	&super::__SGetClass(), 0, sMarkStatics);
}

void DC_obj::__boot()
{
	hx::Static(wx_dc_create_paint) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_create_paint"),(int)1);
	hx::Static(wx_dc_draw_line) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_draw_line"),(int)5);
	hx::Static(wx_object_destroy) = ::wx::Loader_obj::load(HX_CSTRING("wx_object_destroy"),(int)1);
	hx::Static(wx_dc_clear) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_clear"),(int)1);
	hx::Static(wx_dc_set_pen) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_set_pen"),(int)2);
	hx::Static(wx_dc_set_font) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_set_font"),(int)2);
	hx::Static(wx_dc_set_brush) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_set_brush"),(int)2);
	hx::Static(wx_dc_set_background) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_set_background"),(int)2);
	hx::Static(wx_dc_draw_rectangle) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_draw_rectangle"),(int)5);
	hx::Static(wx_dc_draw_circle) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_draw_circle"),(int)4);
	hx::Static(wx_dc_draw_ellipse) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_draw_ellipse"),(int)5);
	hx::Static(wx_dc_draw_text) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_draw_text"),(int)4);
	hx::Static(wx_dc_draw_bitmap) = ::wx::Loader_obj::load(HX_CSTRING("wx_dc_draw_bitmap"),(int)5);
}

} // end namespace wx
