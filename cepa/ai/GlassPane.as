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
		private var w:int;
		private var h:int;
		private var registration:int;
		public static const REGISTRATION_CENTER:int = 1;
		public static const REGISTRATION_TOPLEFT:int = 2;
		
		public function GlassPane(w:int, h:int, registration:int=GlassPane.REGISTRATION_TOPLEFT) 
		{
			this.registration = registration;
			this.h = h;
			this.w = w;
			this.addEventListener(Event.ADDED, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			draw();
		}
		
		private function draw():void {
			this.graphics.beginFill(0, 0.7);
			if (registration == 1) {
				this.graphics.drawRect(-(w / 2), -(h / 2), w/2, h/2);	
			} else {
				this.graphics.drawRect(0, 0, w, h);	
			}
			
		}
		
		
		
	}

}