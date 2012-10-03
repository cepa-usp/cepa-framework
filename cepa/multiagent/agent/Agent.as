package cepa.multiagent.agent
{
	
	import cepa.multiagent.actuator.IActuator;
	import cepa.multiagent.environment.Environment;
	import cepa.multiagent.environment.Util;
	import cepa.multiagent.reasoning.IReasoning;
	import cepa.multiagent.sensor.ISensor;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Agent 
	{
		private var _uid:uint;		
		public var sensors:Vector.<ISensor> = new Vector.<ISensor>();
		public var actions:Vector.<IActuator> = new Vector.<IActuator>();
		public var reasoning:Vector.<IReasoning> = new Vector.<IReasoning>();
		private var _environment:Environment;		
		public var positionX:int = -1;
		public var positionY:int = -1;
		static public const STATE_CREATING:int = 0;
		static public const STATE_RUNNING:int = 1;
		static public const STATE_PAUSED:int = 2;
		private var _velocity:Number = 2;
		private var _direction:Point = null;
		
		// estímulos produzidos pelos sensores
		private var _vars:Object = new Object;
		private var _needings:Object = new Object;
		private var _state:int = STATE_RUNNING;
		// filtros

		
		public function Agent() 
		{
			_uid = Util.nextID();
		}
		
		public function removeReasoning(reas:IReasoning):void 
		{
			reasoning.splice(reasoning.indexOf(reas), 1);
		}		
		
		public function get environment():Environment 
		{
			return _environment;
		}
		
		public function set environment(value:Environment):void 
		{
			_environment = value;
			if (value == null) return;
			onEnvironmentChanged();
		}
		
		protected function onEnvironmentChanged():void 
		{
			
		}
		
		public function get uid():uint 
		{
			return _uid;
		}
		
		public function get vars():Object 
		{
			return _vars;
		}
		
		public function set vars(value:Object):void 
		{
			_vars = value;
		}
		
		public function get needings():Object 
		{
			return _needings;
		}
		
		public function set needings(value:Object):void 
		{
			_needings = value;
		}
		
		public function get state():int 
		{
			return _state;
		}
		
		public function set state(value:int):void 
		{
			_state = value;
		}


		
		public function run():void {
			
			state = Agent.STATE_RUNNING;
			receiveData();
			processReasoning();
		}
		
		/**
		 * Receives stimulus data from sensors
		 */
		private function receiveData():void {
			//trace("receiving data ag:", uid)
			vars = new Object();
			for each(var s:ISensor in sensors) {
				s.receive(this);
			}						
		}
		
		/**
		 * Processes all the reasonings
		 */
		private function processReasoning():void {
			for each(var r:IReasoning in reasoning) {
				r.process(this);
			}
		}


		public function get velocity():Number 
		{
			return _velocity;
		}
		
		public function set velocity(value:Number):void 
		{
			_velocity = value;
			environment.eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_VELOCITY_CHANGED, this))
			
		}

		
		public function get direction():Point 
		{
			return _direction;
		}
		
		public function set direction(value:Point):void 
		{
			_direction = value;
			environment.eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.DIRECTION_CHANGED, this))
		}
				
		
	}	

}