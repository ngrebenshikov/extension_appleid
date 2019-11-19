package extension.util.task;

class CallStr4Task extends Task {

	var fn : String->String->String->String->Void;
	var str1 : String;
	var str2 : String;
	var str3 : String;
	var str4 : String;

	public function new(fn : String->String->String->String->Void, str1 : String, str2 : String, str3 : String, str4 : String) {
		this.fn = fn;
		this.str1 = str1;
		this.str2 = str2;
		this.str3 = str3;
		this.str4 = str4;
	}

	override public function _do() {
		fn(str1, str2, str3, str4);
	}

}
