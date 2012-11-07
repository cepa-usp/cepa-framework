package cepa.ai 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author ...
	 */
	public class MessageScreen 
	{
		
		static public const TYPE_OK:int = 1;
		static public const TYPE_OKCANCEL:int= 2;
		
		static public const RESPONSE_OK:int = 1;
		static public const RESPONSE_CANCEL:int = 2;

		
		private var _type:int;
		private var _screen:MsgScreen = new MsgScreen();
		private var _text:String;
		public function MessageScreen(text:String, type:int=MessageScreen.TYPE_OK) 
		{
			this.text = text;
			this.type = type;
			//this.screen.txMessage.width = 416
			//this.screen.txMessage.height = 279
			//this.screen.txMessage.multiline = true;
			this.screen.txMessage.selectable = false;


			
		}
		
		
		public function get btOk():DisplayObject {
			return DisplayObject(screen.btOk)
		}
		public function get btCancel():DisplayObject {
			return DisplayObject(screen.btCancel)
		}		
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
			screen.txMessage.text = value;

			
		}
		
		public function get type():int 
		{
			return _type;
		}
		
		public function set type(value:int):void 
		{
			_type = value;
			if (type == MessageScreen.TYPE_OK) {
				screen.btCancel.visible = false;
			} else if (type == MessageScreen.TYPE_OKCANCEL) {
				screen.btCancel.visible = true;
			}
			

		}
		
		public function get screen():MsgScreen 
		{
			return _screen;
		}
		
		public function set screen(value:MsgScreen):void 
		{
			_screen = value;
		}
		
		
		
		
		
	}

}