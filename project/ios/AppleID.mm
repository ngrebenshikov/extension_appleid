#import <AppleIDCallbacksDelegate.h>
#import <AppleID.h>
#import <AuthenticationServices/AuthenticationServices.h>

namespace extension_appleid {

	AppleIDCallbacksDelegate *callbacks;
	UIViewController *root;

	void init() {
		root = [[[UIApplication sharedApplication] keyWindow] rootViewController];
		callbacks = [[AppleIDCallbacksDelegate alloc] init];
	}

	void login() {
	    if (@available(iOS 13.0, *)) {
	        // A mechanism for generating requests to authenticate users based on their Apple ID.
	        ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
	        
	        // Creates a new Apple ID authorization request.
	        ASAuthorizationAppleIDRequest *request = appleIDProvider.createRequest;
	        // The contact information to be requested from the user during authentication.
	        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
	        
	        // A controller that manages authorization requests created by a provider.
	        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
	        
	        // A delegate that the authorization controller informs about the success or failure of an authorization attempt.
	        controller.delegate = callbacks;
	        
	        // A delegate that provides a display context in which the system can present an authorization interface to the user.
	        //controller.presentationContextProvider = ;
	        
	        // starts the authorization flows named during controller initialization.
	        [controller performRequests];
	    }
	}

	bool available() {
		if (@available(iOS 13.0, *)) {
			return true;
		} else {
			return false;
		}
	}
}
