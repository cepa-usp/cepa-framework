package  cepa.multiagent.environment
{
	import cepa.multiagent.agent.Agent;
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Util 
	{
		public static var selectedAgent:Agent = null;
		private static var currentId:uint = 0;
		public function Util() 
		{
			
		}
		
		public static function nextID():uint {
			return ++currentId;
		}
		
		
	}
	
}