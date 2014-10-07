package commands {
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;

	public class P4CommandBase {
		private var pathToP4:String = "C:\\Program Files (x86)\\Perforce\\p4.exe";
		protected var nativeProcessStartupInfo:NativeProcessStartupInfo;
		protected var p4Exe:File;
		protected var processArgs:Vector.<String>;
		protected var process:NativeProcess;
		
		
		public function P4CommandBase() {
			p4Exe = new File(pathToP4);
			nativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable = p4Exe;
			processArgs = new Vector.<String>();
		}
		
		
		public function execute():void {
			nativeProcessStartupInfo.arguments = processArgs;
			process = new NativeProcess();
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, result);
			process.addEventListener(Event.STANDARD_ERROR_CLOSE, nativeProcessCloseErrorStream);
			process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, nativeProcessError);
			process.addEventListener(IOErrorEvent.STANDARD_INPUT_IO_ERROR, nativeProcessError);
			process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, nativeProcessError);
			process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, nativeProcessError);
			process.addEventListener(NativeProcessExitEvent.EXIT, nativeProcessExit);
			
			process.start(nativeProcessStartupInfo);

		}
		
		public function result():void {
			
		}
		
		public function nativeProcessCloseErrorStream(event:Object):void {
			trace("nativeProcessCloseErrorStream()");			
		}
		public function nativeProcessExit(event:NativeProcessExitEvent):void {
			trace("nativeProcessExit code: " + event.exitCode);
			removeListeners();
		}
		public function nativeProcessError(event:Object):void {
			trace("nativeProcessError() type = {0}", event.type);
			removeListeners();
		}
		
		public function removeListeners():void {
			process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, result);
			process.removeEventListener(Event.STANDARD_ERROR_CLOSE, nativeProcessCloseErrorStream);
			process.removeEventListener(Event.STANDARD_ERROR_CLOSE, nativeProcessError);
			process.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, nativeProcessError);
			process.removeEventListener(IOErrorEvent.STANDARD_INPUT_IO_ERROR, nativeProcessError);
			process.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, nativeProcessError);
			process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, nativeProcessError);
			process.removeEventListener(NativeProcessExitEvent.EXIT, nativeProcessExit);
			process = null;
		}
		
	}
}