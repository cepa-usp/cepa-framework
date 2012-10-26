package cepa.ai 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GlassPane extends Sprite 
	{
		
		public function GlassPane() 
		{
			this.addEventListener(Event.ADDED, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			draw();
		}
		
		private function draw():void {
			this.graphics.beginFill(0, 0.7);
			this.graphics.drawRect( -(stage.stageWidth / 2), -(stage.stageHeight / 2), stage.stageWidth, stage.stageHeight);
		}
		
		
		
	}

}