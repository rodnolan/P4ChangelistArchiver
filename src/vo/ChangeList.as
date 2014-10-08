package vo {
	[Bindable]
	public class ChangeList {
		public static var delim:String = "|";

		public var number:String;
		public var date:String;
		public var client:String;
		public var status:String;
		public var description:String;
		public var cmdData:String;
		
		public function ChangeList(rawString:String) {
			this.cmdData = rawString.replace("Change ", "").replace(" on ", delim).replace(" by ", delim).replace(" *", delim).replace("* ", delim);
			this.parse();
		}
		
		public function parse():void {
			var tokens:Array = cmdData.split(ChangeList.delim);
			this.number = tokens [0];
			this.date = tokens [1];
			this.client = tokens [2];
			this.status = tokens [3];
			this.description = tokens [4];
		}
	}
}