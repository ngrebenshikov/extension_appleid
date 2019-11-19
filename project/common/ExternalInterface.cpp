#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include <hxcpp.h>

#include <string>
#include <vector>

#include <AppleID.h>

#define safe_alloc_string(a) (alloc_string(a!=NULL ? a : ""))
#define safe_val_call0(func) if (func!=NULL) val_call0(func->get())
#define safe_val_call1(func, arg1) if (func!=NULL) val_call1(func->get(), arg1)
#define safe_val_call3(func, arg1, arg2, arg3) if (func!=NULL) val_call3(func->get(), arg1, arg2, arg3)
#define safe_val_callN(func, args, num) if (func!=NULL) val_callN(func->get(), args, num)
#define safe_val_string(str) str==NULL ? "" : std::string(val_string(str))

AutoGCRoot* _onAppleIDLoginSuccessCallback;
AutoGCRoot* _onAppleIDLoginFailedCallback;
AutoGCRoot* _onAppleIDLoginErrorCallback;

void extension_appleid::onLoginSuccessCallback(const char *userId, const char *email, const char *firstName, const char *lastName) {
	value args[4] = {
		safe_alloc_string(userId),
		safe_alloc_string(email),
		safe_alloc_string(firstName),
		safe_alloc_string(lastName)
	};

	safe_val_callN(_onAppleIDLoginSuccessCallback, args, 4);
}

void extension_appleid::onLoginFailedCallback() {
	safe_val_call0(_onAppleIDLoginFailedCallback);
}

void extension_appleid::onLoginErrorCallback(const char *error) {
	safe_val_call1(_onAppleIDLoginErrorCallback, safe_alloc_string(error));
}

static value extension_appleid_init() {
	extension_appleid::init();
	return alloc_null();
}
DEFINE_PRIM(extension_appleid_init, 0);


static value extension_appleid_login() {
	extension_appleid::login();
	return alloc_null();
}
DEFINE_PRIM(extension_appleid_login, 0);

static value extension_appleid_available() {
	return alloc_bool(extension_appleid::available());
}
DEFINE_PRIM(extension_appleid_available, 0);

static value extension_appleid_setOnLoginSuccessCallback(value fun) {
	_onAppleIDLoginSuccessCallback = new AutoGCRoot(fun);
	return alloc_null();
}
DEFINE_PRIM(extension_appleid_setOnLoginSuccessCallback, 1);

static value extension_appleid_setOnLoginFailedCallback(value fun) {
	_onAppleIDLoginFailedCallback = new AutoGCRoot(fun);
	return alloc_null();
}
DEFINE_PRIM(extension_appleid_setOnLoginFailedCallback, 1);

static value extension_appleid_setOnLoginErrorCallback(value fun) {
	_onAppleIDLoginErrorCallback = new AutoGCRoot(fun);
	return alloc_null();
}
DEFINE_PRIM(extension_appleid_setOnLoginErrorCallback, 1);

extern "C" void extension_appleid_main () {
	val_int(0); // Fix Neko init
}
DEFINE_ENTRY_POINT (extension_appleid_main);

extern "C" int extension_appleid_register_prims () {
	return 0;
}
