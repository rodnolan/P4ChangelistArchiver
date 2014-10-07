package vo {
	[Bindable]
	public class ChangelistFile {
		public static var delim:String = "|";
		
		public var depotPath:String;
		public var localPath:String;
		public var localPathTokens:Array;
		public var backupPath:String;
		public var revisionNumber:String;
		public var action:String;
		public var cmdData:String;

		public function ChangelistFile(rawString:String) {
			this.cmdData = rawString.replace("... ", "").replace("#", ChangelistFile.delim);
			this.parse();
		}
				
		public function parse():void {
			var tokens:Array = cmdData.split(ChangeList.delim);
			this.depotPath = tokens [0];
			var theRest:Array = tokens[1].split(" ");
			this.revisionNumber = theRest[0]; 
			this.action = theRest[1];
		}
		
		public function localPathStartingAt(folderName:String):String {
			trace("localPath: " + localPath)
			var truncatedPath:String = "";
			var startIdx:int = localPath.indexOf(folderName);
			if (startIdx > -1) {
				truncatedPath = localPath.substring(startIdx);
			}
			return truncatedPath;
		}
		
		public function getPathTokenAtIndex(idx:int):String {
			var tokenToReturn:String = "";
			if (localPathTokens.length > idx) {
				tokenToReturn = localPathTokens[idx];
			}
			return tokenToReturn;
		}

	}
}