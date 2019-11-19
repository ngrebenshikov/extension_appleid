package extension.appleid;

#if ios
import extension.appleid.ios.AppleIdCFFI;
#end

import extension.util.task.*;

class AppleID extends TaskExecutor {

	static var initted = false;
	public var userId : String;
	public var email : String;
	public var firstName : String;
	public var lastName : String;

	private static var instance: AppleID = null;

	public static function getInstance(): AppleID {
		if(instance==null) instance = new AppleID();
		return instance;
	}

	private function new() {
		super();
	}

	public function init() {
		if (!initted) {
			#if (ios)
			AppleIdCFFI.init();
			#end
		}
	}

	public function login(
		onComplete : String->String->String->String->Void,
		onFailed : Void->Void,
		onError : String->Void
	) {

		trace("AppleID.login");

		var fOnComplete = function(userId, email, firstName, lastName) {
			addTask(new CallStr4Task(onComplete, userId, email, firstName, lastName));
		}

		var fOnFailed = function() {
			addTask(new CallTask(onFailed));
		}

		var fOnError = function(error) {
			addTask(new CallStrTask(onError, error));
		}

		#if (ios)

		AppleIdCFFI.setOnLoginSuccessCallback(fOnComplete);
		AppleIdCFFI.setOnLoginFailedCallback(fOnFailed);
		AppleIdCFFI.setOnLoginErrorCallback(fOnError);

		AppleIdCFFI.login();

		#end
		
	}

	public function available() {
		#if (ios)
		return AppleIdCFFI.available();
		#else
		return false;
		#end
	}

}
