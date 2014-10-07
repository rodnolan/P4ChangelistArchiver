package events {
	import flash.events.Event;
	
	public class LoginEvent extends Event {
		
		public var un:String;
		public var pw:String;
		
		public static var TYPE:String = "login"
		public function LoginEvent(type:String, un:String, pw:String) {
			super(type);
			this.un = un;
			this.pw = pw;
		}
	}
}