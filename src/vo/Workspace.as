package vo {
	[Bindable]
	public class Workspace {
		public static var delim:String = "|";

		public var name:String;
		public var lastUpdated:String;
		public var root:String;
		public var cmdData:String;
		
		public function Workspace(rawString:String) {
			this.cmdData = rawString.replace("Client ", "").replace(" root ", delim).replace(" 'Created by ", delim);
			this.parse();
		}
		
		public function parse():void {
			var tokens:Array = cmdData.split(Workspace.delim);
			var namedate:Array = tokens[0].split(" ");
			this.name = namedate[0];
			this.lastUpdated = namedate[1];
			this.root = tokens [1];
		}
	}
}