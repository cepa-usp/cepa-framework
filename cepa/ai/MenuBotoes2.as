package cepa.ai
{
	import cepa.tooltip.ToolTip;
	import com.eclecticdesignstudio.motion.Actuate;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Alexandre
	 */
	public class MenuBotoes2 extends Sprite
	{
		public const BTN_WIDTH:Number = 44;
		public const BTN_HEIGHT:Number = 30;
		private const BTN_TWEEN_TIME:Number = 0.2;
		private const HEIGHT_BORDER:Number = 3;
		private const ROUND_RECT_ELIPSE:Number = 10;
		
		private var totalHeight:Number = 0;
		private var overAnimated:Boolean = true;
		private var doublInicialFinalBorder:Boolean = true;
		
		private var buttons:Vector.<Sprite> = new Vector.<Sprite>();
		private var background:Sprite;
		private var vertical:Boolean;
		
		private var _btTutorial:Btin = new Btin();
		private var _btStatistics:BtEstatisticas = new BtEstatisticas();
		private var _btReset:Btn_Reset = new Btn_Reset();
		private var _btOrientacoes:Btn_Instructions = new Btn_Instructions();
		private var _btCreditos:Btn_CC = new Btn_CC();
		
		public function MenuBotoes2(vertical:Boolean = true) 
		{
			if (doublInicialFinalBorder) totalHeight = HEIGHT_BORDER;
			this.vertical = vertical;
		}
		
		public function addAllButtons():void
		{
			if(vertical){
				addCreditosButton();
				addResetButton();
				addOrientacoesButton();
				addTutorialButton();
				addStatisticsButton();
			}else {
				addStatisticsButton();
				addTutorialButton();
				addOrientacoesButton();
				addResetButton();
				addCreditosButton();
			}
		}
		
		public function addTutorialButton():void
		{
			addButton(_btTutorial);
		}
		
		public function addStatisticsButton():void
		{
			addButton(_btStatistics);
		}
		
		public function addResetButton():void
		{
			addButton(_btReset);
		}
		
		public function addOrientacoesButton():void
		{
			addButton(_btOrientacoes);
		}
		
		public function addCreditosButton():void
		{
			addButton(_btCreditos);
		}
		
		private var first:Boolean = true;
		public function addButton(spr:Sprite/*, func:Function = null, descricao:String = null*/):void
		{
			var sprRect:Rectangle = spr.getBounds(spr);
			var diffToCenter:Number = ((Math.abs(sprRect.topLeft.y) + Math.abs(sprRect.bottomRight.y)) / 2) - sprRect.bottomRight.y;
			if(vertical){
				spr.x = BTN_WIDTH / 2;
				//spr.x = spr.width / 2;
				
				spr.y = -totalHeight - HEIGHT_BORDER - spr.height / 2 + diffToCenter;
				totalHeight += spr.height + 2 * HEIGHT_BORDER;
				//spr.y = -totalHeight - HEIGHT_BORDER - BTN_HEIGHT / 2;
				//totalHeight += BTN_HEIGHT + 2 * HEIGHT_BORDER;
			}else {
				spr.y = -BTN_WIDTH / 2 + diffToCenter;
				spr.x = totalHeight + HEIGHT_BORDER + spr.width / 2;
				totalHeight += spr.width + 2 * HEIGHT_BORDER;
				if (first) {
					first = false;
					this.x += BTN_WIDTH - 5;
				}
				this.x -= spr.width + (2* HEIGHT_BORDER);
			}
			
			buttons.push(spr);
			/*makeButton(spr, func);
			if (descricao != null) createToolTip(spr, descricao);
			*/
			
			drawBackground();
			
			addChild(spr);
		}
		
		private function createToolTip(spr:Sprite, descricao:String):void 
		{
			var btnTT:ToolTip = new ToolTip(spr, descricao, 12, 0.8, 150, 0.6, 0.1);
			stage.addChild(btnTT);
		}
		
		private function makeButton(spr:Sprite, func:Function):void 
		{
			spr.buttonMode = true;
			spr.addEventListener(MouseEvent.MOUSE_OVER, overBtn);
			spr.addEventListener(MouseEvent.MOUSE_OUT, outBtn);
			spr.addEventListener(MouseEvent.CLICK, func);
		}
		
		private function overBtn(e:MouseEvent):void 
		{
			var btn:Sprite = Sprite(e.target);
			if (overAnimated) Actuate.tween(btn, BTN_TWEEN_TIME, { scaleX:1.2, scaleY:1.2 } );
			else btn.scaleX = btn.scaleY = 1.2;
		}
		
		private function outBtn(e:MouseEvent):void 
		{
			var btn:Sprite = Sprite(e.target);
			if (overAnimated) Actuate.tween(btn, BTN_TWEEN_TIME, { scaleX:1, scaleY:1 } );
			else btn.scaleX = btn.scaleY = 1;
		}
		
		private function drawBackground():void 
		{
			if (background == null) {
				background = new Sprite();
				background.filters = [new DropShadowFilter(3, 45, 0x000000, 1, 5, 5)];
				addChild(background);
				setChildIndex(background, 0);
			}
			
			background.graphics.clear();
			background.graphics.beginFill(0xDBDBDB, 1);
			if (vertical) background.graphics.drawRoundRect(0, (doublInicialFinalBorder ? -totalHeight - HEIGHT_BORDER : -totalHeight), BTN_WIDTH, (doublInicialFinalBorder ? totalHeight + HEIGHT_BORDER : totalHeight), ROUND_RECT_ELIPSE, ROUND_RECT_ELIPSE);
			else background.graphics.drawRoundRect(0, -BTN_WIDTH, (doublInicialFinalBorder ? totalHeight + HEIGHT_BORDER : totalHeight), BTN_WIDTH, ROUND_RECT_ELIPSE, ROUND_RECT_ELIPSE);
		}
		
		override public function get rotation():Number 
		{
			return super.rotation;
		}
		
		override public function set rotation(value:Number):void 
		{
			for each (var item:Sprite in buttons) 
			{
				item.rotation = -value;
			}
			super.rotation = value;
		}
		
		public function get btTutorial():Btin 
		{
			return _btTutorial;
		}
		
		public function get btStatistics():BtEstatisticas 
		{
			return _btStatistics;
		}
		
		public function get btReset():Btn_Reset 
		{
			return _btReset;
		}
		
		public function get btOrientacoes():Btn_Instructions 
		{
			return _btOrientacoes;
		}
		
		public function get btCreditos():Btn_CC 
		{
			return _btCreditos;
		}
		
	}

}