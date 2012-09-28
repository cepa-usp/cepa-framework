package  cepa.multiagent.environment
{
	import cepa.multiagent.agent.Agent;
	
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class EnvrPosition 
	{
		private var _posX:int = 0;
		private var _posY:int = 0;
		private var _agentHere:Agent;
		
		public function EnvrPosition() 	{
			
		}
		
		public function removeAgent():void {
			_agentHere = null;
		}
		
		
		public function get posX():int 
		{
			return _posX;
		}
		
		public function set posX(value:int):void 
		{
			_posX = value;
		}
		
		public function get posY():int 
		{
			return _posY;
		}
		
		public function set posY(value:int):void 
		{
			_posY = value;
		}
		
		public function get agentHere():Agent 
		{
			return _agentHere;
		}
		
		public function set agentHere(value:Agent):void 
		{
			_agentHere = value;
		}
		
	}
	
}