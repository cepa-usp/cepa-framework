package cepa.multiagent.actuator 
{
	
	import cepa.multiagent.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface IActuator 
	{
		function execute(agt:Agent):void;
		function finish():Boolean;
		function cancelOthers():Boolean
		function get descr():String;
		function get info():String
	}
	
}