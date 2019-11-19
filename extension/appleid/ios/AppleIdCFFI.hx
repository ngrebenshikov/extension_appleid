package extension.appleid.ios;

@:build(ShortCuts.mirrors())
@CPP_DEFAULT_LIBRARY("extension_appleid")
@CPP_PRIMITIVE_PREFIX("extension_appleid")
class AppleIdCFFI {


	@CPP public static function init() {}
	@CPP public static function login() {}
	@CPP public static function available() {}

	@CPP public static function setOnLoginSuccessCallback(f : Void->Void);
	@CPP public static function setOnLoginFailedCallback(f : Void->Void);
	@CPP public static function setOnLoginErrorCallback(f : String->Void);

}
