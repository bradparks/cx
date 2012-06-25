#ifndef INCLUDED_neash_display_DisplayObject
#define INCLUDED_neash_display_DisplayObject

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include <neash/events/EventDispatcher.h>
#include <neash/display/IBitmapDrawable.h>
HX_DECLARE_CLASS2(neash,display,BlendMode)
HX_DECLARE_CLASS2(neash,display,DisplayObject)
HX_DECLARE_CLASS2(neash,display,DisplayObjectContainer)
HX_DECLARE_CLASS2(neash,display,Graphics)
HX_DECLARE_CLASS2(neash,display,IBitmapDrawable)
HX_DECLARE_CLASS2(neash,display,InteractiveObject)
HX_DECLARE_CLASS2(neash,display,Stage)
HX_DECLARE_CLASS2(neash,events,Event)
HX_DECLARE_CLASS2(neash,events,EventDispatcher)
HX_DECLARE_CLASS2(neash,events,IEventDispatcher)
HX_DECLARE_CLASS2(neash,geom,ColorTransform)
HX_DECLARE_CLASS2(neash,geom,Matrix)
HX_DECLARE_CLASS2(neash,geom,Point)
HX_DECLARE_CLASS2(neash,geom,Rectangle)
HX_DECLARE_CLASS2(neash,geom,Transform)
namespace neash{
namespace display{


class DisplayObject_obj : public ::neash::events::EventDispatcher_obj{
	public:
		typedef ::neash::events::EventDispatcher_obj super;
		typedef DisplayObject_obj OBJ_;
		DisplayObject_obj();
		Void __construct(Dynamic inHandle,::String inType);

	public:
		static hx::ObjectPtr< DisplayObject_obj > __new(Dynamic inHandle,::String inType);
		static Dynamic __CreateEmpty();
		static Dynamic __Create(hx::DynamicArray inArgs);
		~DisplayObject_obj();

		HX_DO_RTTI;
		static void __boot();
		static void __register();
		void __Mark(HX_MARK_PARAMS);
		inline operator ::neash::display::IBitmapDrawable_obj *()
			{ return new ::neash::display::IBitmapDrawable_delegate_< DisplayObject_obj >(this); }
		hx::Object *__ToInterface(const type_info &inType);
		::String __ToString() const { return HX_CSTRING("DisplayObject"); }

		double alpha; /* REM */ 
		::neash::display::BlendMode blendMode; /* REM */ 
		bool cacheAsBitmap; /* REM */ 
		Dynamic filters; /* REM */ 
		::neash::display::Graphics graphics; /* REM */ 
		double height; /* REM */ 
		::neash::display::DisplayObject mask; /* REM */ 
		double mouseX; /* REM */ 
		double mouseY; /* REM */ 
		::String name; /* REM */ 
		Dynamic nmeHandle; /* REM */ 
		Dynamic opaqueBackground; /* REM */ 
		::neash::display::DisplayObjectContainer parent; /* REM */ 
		double rotation; /* REM */ 
		::neash::geom::Rectangle scale9Grid; /* REM */ 
		double scaleX; /* REM */ 
		double scaleY; /* REM */ 
		::neash::geom::Rectangle scrollRect; /* REM */ 
		::neash::display::Stage stage; /* REM */ 
		::neash::geom::Transform transform; /* REM */ 
		bool visible; /* REM */ 
		double width; /* REM */ 
		double x; /* REM */ 
		double y; /* REM */ 
		Dynamic nmeFilters; /* REM */ 
		::neash::display::Graphics nmeGraphicsCache; /* REM */ 
		int nmeID; /* REM */ 
		::neash::display::DisplayObjectContainer nmeParent; /* REM */ 
		::neash::geom::Rectangle nmeScale9Grid; /* REM */ 
		::neash::geom::Rectangle nmeScrollRect; /* REM */ 
		virtual bool dispatchEvent( ::neash::events::Event event);

		virtual ::neash::geom::Point globalToLocal( ::neash::geom::Point inGlobal);
		Dynamic globalToLocal_dyn();

		virtual bool hitTestPoint( double x,double y,hx::Null< bool >  shapeFlag);
		Dynamic hitTestPoint_dyn();

		virtual ::neash::geom::Point localToGlobal( ::neash::geom::Point inLocal);
		Dynamic localToGlobal_dyn();

		virtual ::neash::display::InteractiveObject nmeAsInteractiveObject( );
		Dynamic nmeAsInteractiveObject_dyn();

		virtual Void nmeBroadcast( ::neash::events::Event inEvt);
		Dynamic nmeBroadcast_dyn();

		virtual bool nmeDispatchEvent( ::neash::events::Event inEvt);
		Dynamic nmeDispatchEvent_dyn();

		virtual Void nmeDrawToSurface( Dynamic inSurface,::neash::geom::Matrix matrix,::neash::geom::ColorTransform colorTransform,::String blendMode,::neash::geom::Rectangle clipRect,bool smoothing);
		Dynamic nmeDrawToSurface_dyn();

		virtual ::neash::display::DisplayObject nmeFindByID( int inID);
		Dynamic nmeFindByID_dyn();

		virtual Void nmeFireEvent( ::neash::events::Event inEvt);
		Dynamic nmeFireEvent_dyn();

		virtual ::neash::geom::ColorTransform nmeGetColorTransform( );
		Dynamic nmeGetColorTransform_dyn();

		virtual ::neash::geom::ColorTransform nmeGetConcatenatedColorTransform( );
		Dynamic nmeGetConcatenatedColorTransform_dyn();

		virtual ::neash::geom::Matrix nmeGetConcatenatedMatrix( );
		Dynamic nmeGetConcatenatedMatrix_dyn();

		virtual Void nmeGetInteractiveObjectStack( Array< ::neash::display::InteractiveObject > outStack);
		Dynamic nmeGetInteractiveObjectStack_dyn();

		virtual ::neash::geom::Matrix nmeGetMatrix( );
		Dynamic nmeGetMatrix_dyn();

		virtual Void nmeGetObjectsUnderPoint( ::neash::geom::Point point,Array< ::neash::display::DisplayObject > result);
		Dynamic nmeGetObjectsUnderPoint_dyn();

		virtual ::neash::geom::Rectangle nmeGetPixelBounds( );
		Dynamic nmeGetPixelBounds_dyn();

		virtual Void nmeOnAdded( ::neash::display::DisplayObject inObj,bool inIsOnStage);
		Dynamic nmeOnAdded_dyn();

		virtual Void nmeOnRemoved( ::neash::display::DisplayObject inObj,bool inWasOnStage);
		Dynamic nmeOnRemoved_dyn();

		virtual Void nmeSetColorTransform( ::neash::geom::ColorTransform inTrans);
		Dynamic nmeSetColorTransform_dyn();

		virtual Void nmeSetMatrix( ::neash::geom::Matrix inMatrix);
		Dynamic nmeSetMatrix_dyn();

		virtual ::String toString( );

		virtual double nmeGetAlpha( );
		Dynamic nmeGetAlpha_dyn();

		virtual double nmeSetAlpha( double inAlpha);
		Dynamic nmeSetAlpha_dyn();

		virtual Dynamic nmeGetBG( );
		Dynamic nmeGetBG_dyn();

		virtual Dynamic nmeSetBG( Dynamic inBG);
		Dynamic nmeSetBG_dyn();

		virtual ::neash::display::BlendMode nmeGetBlendMode( );
		Dynamic nmeGetBlendMode_dyn();

		virtual ::neash::display::BlendMode nmeSetBlendMode( ::neash::display::BlendMode inMode);
		Dynamic nmeSetBlendMode_dyn();

		virtual bool nmeGetCacheAsBitmap( );
		Dynamic nmeGetCacheAsBitmap_dyn();

		virtual bool nmeSetCacheAsBitmap( bool inVal);
		Dynamic nmeSetCacheAsBitmap_dyn();

		virtual Dynamic nmeGetFilters( );
		Dynamic nmeGetFilters_dyn();

		virtual Dynamic nmeSetFilters( Dynamic inFilters);
		Dynamic nmeSetFilters_dyn();

		virtual ::neash::display::Graphics nmeGetGraphics( );
		Dynamic nmeGetGraphics_dyn();

		virtual double nmeGetHeight( );
		Dynamic nmeGetHeight_dyn();

		virtual double nmeSetHeight( double inVal);
		Dynamic nmeSetHeight_dyn();

		virtual ::neash::display::DisplayObject nmeSetMask( ::neash::display::DisplayObject inObject);
		Dynamic nmeSetMask_dyn();

		virtual double nmeGetMouseX( );
		Dynamic nmeGetMouseX_dyn();

		virtual double nmeGetMouseY( );
		Dynamic nmeGetMouseY_dyn();

		virtual ::String nmeGetName( );
		Dynamic nmeGetName_dyn();

		virtual ::String nmeSetName( ::String inVal);
		Dynamic nmeSetName_dyn();

		virtual ::neash::display::DisplayObjectContainer nmeGetParent( );
		Dynamic nmeGetParent_dyn();

		virtual ::neash::display::DisplayObjectContainer nmeSetParent( ::neash::display::DisplayObjectContainer inParent);
		Dynamic nmeSetParent_dyn();

		virtual double nmeGetRotation( );
		Dynamic nmeGetRotation_dyn();

		virtual double nmeSetRotation( double inVal);
		Dynamic nmeSetRotation_dyn();

		virtual ::neash::geom::Rectangle nmeGetScale9Grid( );
		Dynamic nmeGetScale9Grid_dyn();

		virtual ::neash::geom::Rectangle nmeSetScale9Grid( ::neash::geom::Rectangle inRect);
		Dynamic nmeSetScale9Grid_dyn();

		virtual double nmeGetScaleX( );
		Dynamic nmeGetScaleX_dyn();

		virtual double nmeSetScaleX( double inVal);
		Dynamic nmeSetScaleX_dyn();

		virtual double nmeGetScaleY( );
		Dynamic nmeGetScaleY_dyn();

		virtual double nmeSetScaleY( double inVal);
		Dynamic nmeSetScaleY_dyn();

		virtual ::neash::geom::Rectangle nmeGetScrollRect( );
		Dynamic nmeGetScrollRect_dyn();

		virtual ::neash::geom::Rectangle nmeSetScrollRect( ::neash::geom::Rectangle inRect);
		Dynamic nmeSetScrollRect_dyn();

		virtual ::neash::display::Stage nmeGetStage( );
		Dynamic nmeGetStage_dyn();

		virtual ::neash::geom::Transform nmeGetTransform( );
		Dynamic nmeGetTransform_dyn();

		virtual ::neash::geom::Transform nmeSetTransform( ::neash::geom::Transform inTransform);
		Dynamic nmeSetTransform_dyn();

		virtual bool nmeGetVisible( );
		Dynamic nmeGetVisible_dyn();

		virtual bool nmeSetVisible( bool inVal);
		Dynamic nmeSetVisible_dyn();

		virtual double nmeGetWidth( );
		Dynamic nmeGetWidth_dyn();

		virtual double nmeSetWidth( double inVal);
		Dynamic nmeSetWidth_dyn();

		virtual double nmeGetX( );
		Dynamic nmeGetX_dyn();

		virtual double nmeSetX( double inVal);
		Dynamic nmeSetX_dyn();

		virtual double nmeGetY( );
		Dynamic nmeGetY_dyn();

		virtual double nmeSetY( double inVal);
		Dynamic nmeSetY_dyn();

		static Dynamic nme_create_display_object; /* REM */ 
		static Dynamic nme_display_object_get_graphics; /* REM */ 
		static Dynamic &nme_display_object_get_graphics_dyn() { return nme_display_object_get_graphics;}
		static Dynamic nme_display_object_draw_to_surface; /* REM */ 
		static Dynamic &nme_display_object_draw_to_surface_dyn() { return nme_display_object_draw_to_surface;}
		static Dynamic nme_display_object_get_id; /* REM */ 
		static Dynamic &nme_display_object_get_id_dyn() { return nme_display_object_get_id;}
		static Dynamic nme_display_object_get_x; /* REM */ 
		static Dynamic &nme_display_object_get_x_dyn() { return nme_display_object_get_x;}
		static Dynamic nme_display_object_set_x; /* REM */ 
		static Dynamic &nme_display_object_set_x_dyn() { return nme_display_object_set_x;}
		static Dynamic nme_display_object_get_y; /* REM */ 
		static Dynamic &nme_display_object_get_y_dyn() { return nme_display_object_get_y;}
		static Dynamic nme_display_object_set_y; /* REM */ 
		static Dynamic &nme_display_object_set_y_dyn() { return nme_display_object_set_y;}
		static Dynamic nme_display_object_get_scale_x; /* REM */ 
		static Dynamic &nme_display_object_get_scale_x_dyn() { return nme_display_object_get_scale_x;}
		static Dynamic nme_display_object_set_scale_x; /* REM */ 
		static Dynamic &nme_display_object_set_scale_x_dyn() { return nme_display_object_set_scale_x;}
		static Dynamic nme_display_object_get_scale_y; /* REM */ 
		static Dynamic &nme_display_object_get_scale_y_dyn() { return nme_display_object_get_scale_y;}
		static Dynamic nme_display_object_set_scale_y; /* REM */ 
		static Dynamic &nme_display_object_set_scale_y_dyn() { return nme_display_object_set_scale_y;}
		static Dynamic nme_display_object_get_mouse_x; /* REM */ 
		static Dynamic &nme_display_object_get_mouse_x_dyn() { return nme_display_object_get_mouse_x;}
		static Dynamic nme_display_object_get_mouse_y; /* REM */ 
		static Dynamic &nme_display_object_get_mouse_y_dyn() { return nme_display_object_get_mouse_y;}
		static Dynamic nme_display_object_get_rotation; /* REM */ 
		static Dynamic &nme_display_object_get_rotation_dyn() { return nme_display_object_get_rotation;}
		static Dynamic nme_display_object_set_rotation; /* REM */ 
		static Dynamic &nme_display_object_set_rotation_dyn() { return nme_display_object_set_rotation;}
		static Dynamic nme_display_object_get_bg; /* REM */ 
		static Dynamic &nme_display_object_get_bg_dyn() { return nme_display_object_get_bg;}
		static Dynamic nme_display_object_set_bg; /* REM */ 
		static Dynamic &nme_display_object_set_bg_dyn() { return nme_display_object_set_bg;}
		static Dynamic nme_display_object_get_name; /* REM */ 
		static Dynamic &nme_display_object_get_name_dyn() { return nme_display_object_get_name;}
		static Dynamic nme_display_object_set_name; /* REM */ 
		static Dynamic &nme_display_object_set_name_dyn() { return nme_display_object_set_name;}
		static Dynamic nme_display_object_get_width; /* REM */ 
		static Dynamic &nme_display_object_get_width_dyn() { return nme_display_object_get_width;}
		static Dynamic nme_display_object_set_width; /* REM */ 
		static Dynamic &nme_display_object_set_width_dyn() { return nme_display_object_set_width;}
		static Dynamic nme_display_object_get_height; /* REM */ 
		static Dynamic &nme_display_object_get_height_dyn() { return nme_display_object_get_height;}
		static Dynamic nme_display_object_set_height; /* REM */ 
		static Dynamic &nme_display_object_set_height_dyn() { return nme_display_object_set_height;}
		static Dynamic nme_display_object_get_alpha; /* REM */ 
		static Dynamic &nme_display_object_get_alpha_dyn() { return nme_display_object_get_alpha;}
		static Dynamic nme_display_object_set_alpha; /* REM */ 
		static Dynamic &nme_display_object_set_alpha_dyn() { return nme_display_object_set_alpha;}
		static Dynamic nme_display_object_get_blend_mode; /* REM */ 
		static Dynamic &nme_display_object_get_blend_mode_dyn() { return nme_display_object_get_blend_mode;}
		static Dynamic nme_display_object_set_blend_mode; /* REM */ 
		static Dynamic &nme_display_object_set_blend_mode_dyn() { return nme_display_object_set_blend_mode;}
		static Dynamic nme_display_object_get_cache_as_bitmap; /* REM */ 
		static Dynamic &nme_display_object_get_cache_as_bitmap_dyn() { return nme_display_object_get_cache_as_bitmap;}
		static Dynamic nme_display_object_set_cache_as_bitmap; /* REM */ 
		static Dynamic &nme_display_object_set_cache_as_bitmap_dyn() { return nme_display_object_set_cache_as_bitmap;}
		static Dynamic nme_display_object_get_visible; /* REM */ 
		static Dynamic &nme_display_object_get_visible_dyn() { return nme_display_object_get_visible;}
		static Dynamic nme_display_object_set_visible; /* REM */ 
		static Dynamic &nme_display_object_set_visible_dyn() { return nme_display_object_set_visible;}
		static Dynamic nme_display_object_set_filters; /* REM */ 
		static Dynamic &nme_display_object_set_filters_dyn() { return nme_display_object_set_filters;}
		static Dynamic nme_display_object_global_to_local; /* REM */ 
		static Dynamic &nme_display_object_global_to_local_dyn() { return nme_display_object_global_to_local;}
		static Dynamic nme_display_object_local_to_global; /* REM */ 
		static Dynamic &nme_display_object_local_to_global_dyn() { return nme_display_object_local_to_global;}
		static Dynamic nme_display_object_set_scale9_grid; /* REM */ 
		static Dynamic &nme_display_object_set_scale9_grid_dyn() { return nme_display_object_set_scale9_grid;}
		static Dynamic nme_display_object_set_scroll_rect; /* REM */ 
		static Dynamic &nme_display_object_set_scroll_rect_dyn() { return nme_display_object_set_scroll_rect;}
		static Dynamic nme_display_object_set_mask; /* REM */ 
		static Dynamic &nme_display_object_set_mask_dyn() { return nme_display_object_set_mask;}
		static Dynamic nme_display_object_set_matrix; /* REM */ 
		static Dynamic &nme_display_object_set_matrix_dyn() { return nme_display_object_set_matrix;}
		static Dynamic nme_display_object_get_matrix; /* REM */ 
		static Dynamic &nme_display_object_get_matrix_dyn() { return nme_display_object_get_matrix;}
		static Dynamic nme_display_object_get_color_transform; /* REM */ 
		static Dynamic &nme_display_object_get_color_transform_dyn() { return nme_display_object_get_color_transform;}
		static Dynamic nme_display_object_set_color_transform; /* REM */ 
		static Dynamic &nme_display_object_set_color_transform_dyn() { return nme_display_object_set_color_transform;}
		static Dynamic nme_display_object_get_pixel_bounds; /* REM */ 
		static Dynamic &nme_display_object_get_pixel_bounds_dyn() { return nme_display_object_get_pixel_bounds;}
		static Dynamic nme_display_object_hit_test_point; /* REM */ 
		static Dynamic &nme_display_object_hit_test_point_dyn() { return nme_display_object_hit_test_point;}
};

} // end namespace neash
} // end namespace display

#endif /* INCLUDED_neash_display_DisplayObject */ 
