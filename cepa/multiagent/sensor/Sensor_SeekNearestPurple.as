package cepa.multiagent.sensor 
{
	import agent.Agent;
	import agent.square.Reasoning_Default;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Sensor_SeekNearestPurple implements ISensor
	{
		
		public function Sensor_SeekNearestPurple() 
		{
			
		}
		
		/* INTERFACE sensor.ISensor */
			
		
		public function receive(agt:Agent):void 
		{
			if (agt.vars.selectedTarget == undefined) {
				selectTarget(agt)
			} else {
				if (agt.vars.selectedTarget == null) {
					selectTarget(agt)
				}
			}
			
		}
		
		public function selectTarget(agt:Agent):void {
			var minDist:Number = 99999;
			var sel:Agent = null;
			for each(var a:Agent in agt.environment.agents){
				if (a != agt && a.color == Agent.colorPurple && a.spinning==false) {
					var d:Number = Math.abs(Point.distance(new Point(agt.positionX, agt.positionY), new Point(a.positionX, a.positionY)))
					if (minDist > d) {
						minDist = d;
						sel = a;
					}
				}
			}
			if (sel != null) {
				agt.vars.selectedTarget = sel;
			}
		}
		
		
	}
	
}