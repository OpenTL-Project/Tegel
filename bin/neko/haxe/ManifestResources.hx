package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Dynamic):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_bold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_extrabold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_extralight_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_light_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_medium_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_dosis_dosis_semibold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_bold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_bolditalic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabolditalic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_light_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_lightitalic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_regular_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_semibold_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_open_sans_opensans_semibolditalic_ttf);
		
		#end
		
		var data, manifest, library;
		
		#if kha
		
		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);
		
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");
		
		#else
		
		Assets.libraryPaths["default"] = rootPath + "manifest/default.json";
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
		#end
		
	}
	
	
}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_bold_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_extrabold_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_extralight_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_light_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_medium_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_regular_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_dosis_semibold_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_dosis_ofl_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_license_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_bold_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_bolditalic_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_extrabold_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_extrabolditalic_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_italic_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_light_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_lightitalic_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_regular_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_semibold_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_open_sans_opensans_semibolditalic_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_add_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_code_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_config_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_cursor_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_delete_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_eraser_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_fill_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_hide_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_nodes_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_objects_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_pencil_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_save_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_select_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_tiles_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_icons_visibility_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_openfl_svg extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_styles_dark_theme_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_tilesets_add_txt extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_tilesets_icon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_tilesets_renaine_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)


@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_bold_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Bold.ttf"; name = "Dosis Bold"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_extrabold_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-ExtraBold.ttf"; name = "Dosis ExtraBold"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_extralight_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-ExtraLight.ttf"; name = "Dosis ExtraLight"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_light_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Light.ttf"; name = "Dosis Light"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_medium_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Medium.ttf"; name = "Dosis Medium"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_regular_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Regular.ttf"; name = "Dosis Regular"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_dosis_dosis_semibold_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-SemiBold.ttf"; name = "Dosis SemiBold"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_bold_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Bold.ttf"; name = "Open Sans Bold"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_bolditalic_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf"; name = "Open Sans Bold Italic"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_extrabold_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-ExtraBold.ttf"; name = "Open Sans ExtraBold"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_extrabolditalic_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-ExtraBoldItalic.ttf"; name = "Open Sans ExtraBold Italic"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_italic_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Italic.ttf"; name = "Open Sans Italic"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_light_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Light.ttf"; name = "Open Sans Light"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_lightitalic_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-LightItalic.ttf"; name = "Open Sans Light Italic"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_regular_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Regular.ttf"; name = "Open Sans Regular"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_semibold_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-SemiBold.ttf"; name = "Open Sans SemiBold"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_open_sans_opensans_semibolditalic_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-SemiBoldItalic.ttf"; name = "Open Sans SemiBold Italic"; super (); }}


#else

@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_bold_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_bold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-Bold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis Bold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_extrabold_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_extrabold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-ExtraBold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis ExtraBold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_extralight_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_extralight_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-ExtraLight.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis ExtraLight"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_light_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_light_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-Light.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis Light"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_medium_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_medium_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-Medium.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis Medium"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_regular_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-Regular.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis Regular"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_dosis_dosis_semibold_ttf') #if display private #end class __ASSET__assets_fonts_dosis_dosis_semibold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Dosis/Dosis-SemiBold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Dosis SemiBold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_bold_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_bold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-Bold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans Bold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_bolditalic_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_bolditalic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans Bold Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_extrabold_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_extrabold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-ExtraBold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans ExtraBold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_extrabolditalic_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_extrabolditalic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-ExtraBoldItalic.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans ExtraBold Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_italic_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_italic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-Italic.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_light_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_light_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-Light.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans Light"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_lightitalic_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_lightitalic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-LightItalic.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans Light Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_regular_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_regular_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-Regular.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans Regular"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_semibold_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_semibold_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-SemiBold.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans SemiBold"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_open_sans_opensans_semibolditalic_ttf') #if display private #end class __ASSET__assets_fonts_open_sans_opensans_semibolditalic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Open_Sans/OpenSans-SemiBoldItalic.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Open Sans SemiBold Italic"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_bold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_bold_ttf extends openfl.text.Font { public function new () { name = "Dosis Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_extrabold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_extrabold_ttf extends openfl.text.Font { public function new () { name = "Dosis ExtraBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_extralight_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_extralight_ttf extends openfl.text.Font { public function new () { name = "Dosis ExtraLight"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_light_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_light_ttf extends openfl.text.Font { public function new () { name = "Dosis Light"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_medium_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_medium_ttf extends openfl.text.Font { public function new () { name = "Dosis Medium"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_regular_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_regular_ttf extends openfl.text.Font { public function new () { name = "Dosis Regular"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_semibold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_semibold_ttf extends openfl.text.Font { public function new () { name = "Dosis SemiBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_bold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_bold_ttf extends openfl.text.Font { public function new () { name = "Open Sans Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_bolditalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_bolditalic_ttf extends openfl.text.Font { public function new () { name = "Open Sans Bold Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabold_ttf extends openfl.text.Font { public function new () { name = "Open Sans ExtraBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabolditalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabolditalic_ttf extends openfl.text.Font { public function new () { name = "Open Sans ExtraBold Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_italic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_italic_ttf extends openfl.text.Font { public function new () { name = "Open Sans Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_light_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_light_ttf extends openfl.text.Font { public function new () { name = "Open Sans Light"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_lightitalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_lightitalic_ttf extends openfl.text.Font { public function new () { name = "Open Sans Light Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_regular_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_regular_ttf extends openfl.text.Font { public function new () { name = "Open Sans Regular"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_semibold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_semibold_ttf extends openfl.text.Font { public function new () { name = "Open Sans SemiBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_semibolditalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_semibolditalic_ttf extends openfl.text.Font { public function new () { name = "Open Sans SemiBold Italic"; super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_bold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_bold_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Bold.ttf"; name = "Dosis Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_extrabold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_extrabold_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-ExtraBold.ttf"; name = "Dosis ExtraBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_extralight_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_extralight_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-ExtraLight.ttf"; name = "Dosis ExtraLight"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_light_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_light_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Light.ttf"; name = "Dosis Light"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_medium_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_medium_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Medium.ttf"; name = "Dosis Medium"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_regular_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_regular_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-Regular.ttf"; name = "Dosis Regular"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_dosis_dosis_semibold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_dosis_dosis_semibold_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Dosis/Dosis-SemiBold.ttf"; name = "Dosis SemiBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_bold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_bold_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Bold.ttf"; name = "Open Sans Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_bolditalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_bolditalic_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-BoldItalic.ttf"; name = "Open Sans Bold Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabold_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-ExtraBold.ttf"; name = "Open Sans ExtraBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabolditalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_extrabolditalic_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-ExtraBoldItalic.ttf"; name = "Open Sans ExtraBold Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_italic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_italic_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Italic.ttf"; name = "Open Sans Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_light_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_light_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Light.ttf"; name = "Open Sans Light"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_lightitalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_lightitalic_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-LightItalic.ttf"; name = "Open Sans Light Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_regular_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_regular_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-Regular.ttf"; name = "Open Sans Regular"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_semibold_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_semibold_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-SemiBold.ttf"; name = "Open Sans SemiBold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_open_sans_opensans_semibolditalic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_open_sans_opensans_semibolditalic_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Open_Sans/OpenSans-SemiBoldItalic.ttf"; name = "Open Sans SemiBold Italic"; super (); }}

#end

#end
#end

#end