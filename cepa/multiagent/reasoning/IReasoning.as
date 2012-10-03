package cepa.multiagent.reasoning 
{
	
	import cepa.multiagent.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface IReasoning 
	{
		function get description():String;
		function get isDeterministic():Boolean;
		function process(agt:Agent):void;
		function cancel():void;

	}
	
}