package cepa.multiagent.agent 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class AgentEvent extends Event 
	{
		public static const AGENT_REQUEST:String = "AGENT_REQUEST"
		public static const MOVE_REQUEST:String = "MOVE_REQUEST"
		static public const AGENT_REGISTERED:String = "agentRegistered";
		static public const AGENT_POSITIONED:String = "agentPositioned";
		static public const AGENT_POSITION_REACHED:String = "agentPositionReached";
		static public const AGENT_MOVEMENT_ALLOWED:String = "agentMovementAllowed";
		static public const AGENT_MOVEMENT_DENIED:String = "agentMovementDenied";
		static public const MOVEMENT_STATE_CHANGED:String = "movementStateChanged";
		static public const DIRECTION_CHANGED:String = "directionChanged";
		static public const AGENT_VELOCITY_CHANGED:String = "agentVelocityChanged";
		
		private var _agent:Agent;
		private var _walkX:int = 0;
		private var _walkY:int = 0;

		
		public function AgentEvent(type:String, agt:Agent, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_agent = agt;
		} 
		
		public function setWalkPosition(x:int, y:int):AgentEvent {
			this.walkX = x;
			this.walkY = y;
			return this;
		}
		
		public override function clone():Event 
		{ 
			return new AgentEvent(type, _agent, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ActuatorEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get agent():Agent 
		{
			return _agent;
		}
		
		public function get walkX():int 
		{
			return _walkX;
		}
		
		public function set walkX(value:int):void 
		{
			_walkX = value;
		}
		
		public function get walkY():int 
		{
			return _walkY;
		}
		
		public function set walkY(value:int):void 
		{
			_walkY = value;
		}
		

		
	}
	
}