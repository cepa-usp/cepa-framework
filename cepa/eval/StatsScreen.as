package cepa.eval {
	
	import cepa.ai.AI;
	import cepa.ai.AIConstants;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class StatsScreen extends MovieClip {
		private var eval:ProgressiveEvaluator;
		private var ai:AI;
		private var _stats:StatsScreenView = new StatsScreenView();
		
		
		public function StatsScreen(eval:ProgressiveEvaluator, ai:AI) {
			this.ai = ai;
			this.eval = eval;
			stats.name = "stats";
			
			//REMOVER --------------------------------------
			//var bkg:Sprite = new Sprite();
			//bkg.graphics.beginFill(0x000000, 0.6);
			//bkg.graphics.drawRect(-700/2, -500/2, 700, 500);
			//stats.addChild(bkg);
			//stats.setChildIndex(bkg, 0);
			
		}
		
		public function bindButton(button:DisplayObject):void {
			button.addEventListener(MouseEvent.CLICK, onButtonClick)
		}
		
		private function onButtonClick(e:MouseEvent):void 
		{
			openStatScreen();
		}
		
		public function openStatScreen():void {
			var nTotal:int = eval.numTrials;
			var nValendo:int = eval.numTrialsByMode(AIConstants.PLAYMODE_EVALUATE);
			var nNaoValendo:int = eval.numTrialsByMode(AIConstants.PLAYMODE_FREEPLAY);
			var scoreMin:int = eval.minimumScoreForAcceptance * 100;
			var scoreTotal:int = eval.scoreGeneralMean * 100;
			var scoreValendo:int = eval.score * 100;
			stats.valendoMC.gotoAndStop((eval.currentPlayMode == AIConstants.PLAYMODE_FREEPLAY?2:1));
			stats.nTotal.text = nTotal.toString();
			stats.nValendo.text = nValendo.toString();
			stats.nNaoValendo.text = nNaoValendo.toString();
			stats.valendoText.visible =  (eval.currentPlayMode==AIConstants.PLAYMODE_FREEPLAY)
			stats.scoreMin.text = scoreMin.toString();
			stats.scoreTotal.text = scoreTotal.toString();
			stats.scoreValendo.text = scoreValendo.toString();
			stats.closeButton.addEventListener(MouseEvent.CLICK, function(e:Event) {
				ai.container.closeScreen(Sprite(ai.container.getChildByName("stats")));
			});
			stats.addEventListener(Event.CLOSE, function(e:Event) {
				if(ai.container.getChildByName("stats")!=null){
					ai.container.removeChild(ai.container.getChildByName("stats"));
				}
			});
			ai.container.addChild(stats);
			ai.container.openScreen(stats)
		}				
		
		public function get stats():StatsScreenView 
		{
			return _stats;
		}
	}
	
}
