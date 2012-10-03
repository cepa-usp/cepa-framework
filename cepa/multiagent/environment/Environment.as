package  cepa.multiagent.environment
{
	import cepa.multiagent.agent.Agent;
	import cepa.multiagent.agent.AgentEvent;
	import cepa.multiagent.reasoning.IReasoning;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Environment
	{
		private var _width:uint = 25;
		private var _height:uint = 17;
		private var _eventDispatcher:EventDispatcher = new EventDispatcher();
		private var _positions:Vector.<EnvrPosition> = new Vector.<EnvrPosition>();
		private var _pos:Vector.<Vector.<EnvrPosition>>;
		private var _agents:Vector.<Agent> = new Vector.<Agent>();		
		
		public function Environment() 
		{
			createPositions();
			eventDispatcher.addEventListener(AgentEvent.MOVE_REQUEST, onAgentMoveRequested);
		}

		public function createPositions():void {
			var i:uint; 
			var j:uint;			
			pos = new Vector.<Vector.<EnvrPosition>>(width + 1);
			
			for (i = 0; i <= width; i++) {
				pos[i] = new Vector.<EnvrPosition>(height + 1);
			}
			for (i = 0; i <= width; i++) {
				for (j= 0; j <= height; j++) {
					var p:EnvrPosition = new EnvrPosition();
					positions.push(p);
					p.posX = i;
					p.posY = j;
					pos[i][j] = p;
				}
			}
			
		}
		
		public function removeAgent(a:Agent):void {
			agents.splice(agents.indexOf(a), 1);
			for each(var r:IReasoning in a.reasoning) {
				r.cancel()
			}
			a.state = Agent.STATE_PAUSED;
			EnvrPosition(pos[a.positionX][a.positionY]).removeAgent();			
			//a.positionX = -1
			//a.positionY = -1
			
			eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_REMOVED, a));
		}
		
		
		public function registerAgent(a:Agent, xIni:int, yIni:int):void {
			agents.push(a);			
			a.state = Agent.STATE_CREATING;
			a.environment = this;
			eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_REGISTERED, a));
			setAgentPosition(a, xIni, yIni);
			
			//a.run();
			
		}
		
		public function unRegisterAgent(a:Agent):void {
			agents.splice(agents.indexOf(a), 1);
			a.environment = null;
			
		}
				
		
		public function checkPosition(agt:Agent, x:int, y:int):Boolean {
			if (x < 0 || x>=this.width) return true;
			if (y <0 || y >= this.height) return true;			
			var p:EnvrPosition = pos[x][y];
			if (p.agentHere != null) {
				return true;
			}
			return false;
		}
		
		
		public function findNearestFreePosition(srcPoint:Point):Point {
			var dmin:Number = 99999;
			var pmin:Point = srcPoint.clone();
			var lpt:Point = new Point(0, 0)
			var d:Number = 0;
			for each(var ep:EnvrPosition in positions) {
				lpt.x = ep.posX; 
				lpt.y = ep.posY;
				d = Point.distance(srcPoint, lpt);
				if (ep.agentHere==null && d<dmin) {
					dmin = d;
					pmin = new Point(ep.posX, ep.posY);
				}
			}
			return pmin;
		}
		
		private function onAgentMoveRequested(e:AgentEvent):void 
		{
			// TODO:verificar se o agente pode se mover pra posição que ele está querendo
			if (e.agent.environment != this) return;
			var deny:Boolean = checkPosition(e.agent, e.walkX, e.walkY);
			if (!deny) {
				eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_MOVEMENT_ALLOWED, e.agent).setWalkPosition(e.walkX, e.walkY));	
				
			} else {
				eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_MOVEMENT_DENIED, e.agent).setWalkPosition(e.walkX, e.walkY));	
				
			}
		}
		

		public function setAgentPosition(a:Agent,  px:int, py:int):void {
			if(a.positionX>=0 && a.positionX<=this.width && a.positionY>=0 && a.positionY<=this.height){
				var vv:EnvrPosition = pos[a.positionX][a.positionY]
				vv.removeAgent();
			} 
			var p:EnvrPosition = pos[px][py];
			a.positionX = px;
			a.positionY = py;
			p.agentHere = a;
			eventDispatcher.dispatchEvent(new AgentEvent(AgentEvent.AGENT_POSITIONED, a));			
		}
		

		

		

		public function get agents():Vector.<Agent> 
		{
			return _agents;
		}
		
		public function set agents(value:Vector.<Agent>):void 
		{
			_agents = value;
		}
		
		public function get pos():Vector.<Vector.<EnvrPosition>> 
		{
			return _pos;
		}
		
		public function set pos(value:Vector.<Vector.<EnvrPosition>>):void 
		{
			_pos = value;
		}
		
		public function get positions():Vector.<EnvrPosition> 
		{
			return _positions;
		}
		
		public function set positions(value:Vector.<EnvrPosition>):void 
		{
			_positions = value;
		}
		
		public function get eventDispatcher():EventDispatcher 
		{
			return _eventDispatcher;
		}
		
		public function set eventDispatcher(value:EventDispatcher):void 
		{
			_eventDispatcher = value;
		}
		
		public function get width():uint 
		{
			return _width;
		}
		
		public function set width(value:uint):void 
		{
			_width = value;
		}
		
		public function get height():uint 
		{
			return _height;
		}
		
		public function set height(value:uint):void 
		{
			_height = value;
		}
		
	}
	
}