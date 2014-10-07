package vo {
	public class ClientInfo {
		public var userName:String;
		public var workspaceName:String;
		public var host:String;
		public var root:String;
		
		public function ClientInfo(properties:Array) {
			userName = properties[0].split(": ")[1];
			workspaceName = properties[1].split(": ")[1];
			host = properties[2].split(": ")[1];
			root = properties[3].split(": ")[1];
		}
	}
}