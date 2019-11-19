#include <string>
#include <vector>

#ifndef _APPLEID_H_
#define _APPLEID_H_

namespace extension_appleid {
	void login();
	void init();
	bool available();

	void onLoginSuccessCallback(const char *userId, const char *email, const char *firstName, const char *lastName);
	void onLoginFailedCallback();
	void onLoginErrorCallback(const char *error);
}

#endif
