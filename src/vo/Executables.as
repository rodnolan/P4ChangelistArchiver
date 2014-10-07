package vo {
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	public class Executables {
		public static var P4:String = "p4";
		public static var SLASH_CONVERTER:String = "slashConverter";
		public static var P4_LOGIN:String = "p4Login";
		public static var BACKUP_CHANGELIST:String = "backupChangelist";
	
		public static var exes:Dictionary = new Dictionary();
		public static function addExe(file:File, key:String):void {
			Executables.exes[key] = file;
		}
		
		public static function getExe(key:String):File {
			if (Executables.exes[key]) {
				return Executables[key]
			} else {
				throw new Error("no executable registered for " + key)
			}
		}
		
		public static var commands:Dictionary = new Dictionary();
		public static function addCommand(command:String, exe:String):void {
			Executables.commands[command] = exe;
		}
		public static function getExeForCommand(command:String):File {
			return Executables.exes[Executables.commands[command]];
		}
		
	}
}