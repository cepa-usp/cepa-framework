package cepa.ai 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Arthur
	 */
	public class MessageEvent extends Event 
	{
		
		public function MessageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event 
		{ 
			return new MessageEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MessageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}