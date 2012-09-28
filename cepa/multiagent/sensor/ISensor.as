package cepa.multiagent.sensor 
{
	
	import cepa.multiagent.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface ISensor 
	{
		function receive(agt:Agent):void;
	}
	
}