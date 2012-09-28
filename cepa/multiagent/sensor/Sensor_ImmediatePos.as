package cepa.multiagent.sensor 
{
	import adobe.utils.ProductManager;
	import agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Sensor_ImmediatePos implements ISensor
	{
		
		public function Sensor_ImmediatePos() 
		{
			
		}
		
		/* INTERFACE sensor.ISensor */
		
		public function receive(a:Agent):void 
		{
			var env:Environment = a.environment;
			a.vars.gotImmediatePositions = true;
			a.vars.pos = [null, null, null, null];
			try {
				// 0  = cima
				a.vars.pos[0] = env.pos[a.positionX][a.positionY - 1];
			} catch (er:Error) {
				a.vars.pos[0] = null;
			}
			try {
				// 1 = baixo
				a.vars.pos[1]  = env.pos[a.positionX][a.positionY +1];
			} catch (er:Error) {
				a.vars.pos[1] = null;
			}
			try {
				//2 = esq
				a.vars.pos[2]  = env.pos[a.positionX - 1][a.positionY];
			} catch (er:Error) {
				a.vars.pos[3] = null;
			}
			try {
				//3 = dir
				a.vars.pos[3]  = env.pos[a.positionX + 1][a.positionY];
			} catch (er:Error) {
				a.vars.pos[4] = null;
			}			
			
			
			
			
			
		}
		
	}
	
}