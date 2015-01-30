package vo {
	[Bindable]
	public class ChangelistFile {
		public static var delim:String = "|";
		
		public var depotPath:String;
		public var localPath:String;
		public var localPathTokens:Array;
		private var _archivePath:String;
		public var revisionNumber:String;
		public var action:String;
		public var cmdData:String;

		public function ChangelistFile(rawString:String) {
			this.cmdData = rawString.replace("... ", "").replace("#", ChangelistFile.delim);
			this.parse();
		}
				
		public function get archivePath():String {
			return _archivePath;
		}

		public function cleanArchivePath(lengthOfCommonPath:int):void {
			_archivePath = localPath.substring(lengthOfCommonPath);
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
		
		public function getBackupCommand(baseFolder:String):String {			
			var destPath:String = baseFolder.replace( /\\/g, '/') + "/";
			var lp:String = localPath.replace( /\//ig, "\\" );
			var dp:String = destPath.replace( /\//ig, "\\" );
			var ap:String = archivePath.replace( /\//ig, "\\" );
			
			return 'echo f | xcopy /f /y "' + lp + '" "' + dp + ap + '"\n';
		}
		
		public function getRestoreCommand(changelistNumber:String):String {			
			var lp:String = localPath.replace( /\//ig, "\\" );
			var ap:String = archivePath.replace( /\//ig, "\\" );
			var dp:String = depotPath.replace( /\//ig, "\\" );
			
			var readOnlyOFF:String='REM attrib -r "' + lp + '"\n';
			var copy:String='echo f | xcopy /f /y "' + ap + '" "' + lp + '"\n';
			var p4reopen:String='p4 reopen -c ' +changelistNumber+ ' "' + dp + '"\n\n';
			
			return readOnlyOFF + copy + p4reopen; 
		}
		
	}
}