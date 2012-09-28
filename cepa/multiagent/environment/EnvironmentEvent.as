package  cepa.multiagent.environment
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class EnvironmentEvent extends Event 
	{
		private var env:Environment;
		
		public function EnvironmentEvent(type:String, env:Environment, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.env = env;
			
		} 
		
		public override function clone():Event 
		{ 
			return new EnvironmentEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("EnvironmentEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		
	}
	
}