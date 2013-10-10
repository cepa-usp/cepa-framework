package cepa.ai
{
	import cepa.tooltip.ToolTip;
	import com.adobe.protocols.dict.Database;
	import com.eclecticdesignstudio.motion.Actuate;
	import com.pipwerks.SCORM;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class AIContainer extends Sprite
	{
		public static const SHADOW_FILTER:DropShadowFilter = new DropShadowFilter(3, 45, 0x000000, 1, 5, 5);
		public static const DISABLE_FILTER:ColorMatrixFilter = new ColorMatrixFilter([
                       0.2225, 0.7169, 0.0606, 0, 0,
                       0.2225, 0.7169, 0.0606, 0, 0,
                       0.2225, 0.7169, 0.0606, 0, 0,
                       0.0000, 0.0000, 0.0000, 1, 0
        ]);		
		private var layerUI:Sprite = new Sprite();
		private var ai:AI;
		private var margin:int = 12;
		//private var _optionButtons:MenuBotoes = new MenuBotoes();
		private var _optionButtons:MenuBotoes2;
		private var glass:GlassPane;			
		private var _messageLabel:TextoExplicativo = new TextoExplicativo();
		private var aboutScreen:Sprite;
		private var border:Sprite = new Sprite();
		private var infoScreen:Sprite;
		private var messageScreen:MessageScreen;
		
		
		public function AIContainer(stagesprite:Sprite, ai:AI, menuVertical:Boolean = true )
		{	
			_optionButtons = new MenuBotoes2(menuVertical);
			this.ai = ai;
			//this.graphics.beginFill(0xFFFFFF);
			//this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			stagesprite.addChild(this);
			this.scrollRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			this.glass = new GlassPane(scrollRect.width, scrollRect.height, GlassPane.REGISTRATION_TOPLEFT)
			glass.visible = false;
			createUI();
			setAboutScreen(new AboutScreenUI());
			bindMenuButtons();
			adjustBorder();
			border.addEventListener(MouseEvent.CLICK, onBorderClick);
		}
		
		private function onBorderClick(e:MouseEvent):void 
		{
			if (ai.debugMode == true) {
				ai.debugScreen.show();
			}
		}
		
		public function disableComponent(display:*):void {
			try {
				display.alpha = 0.5;
				display.mouseEnabled = false;
				display.filters = [DISABLE_FILTER];
			} catch (e:Error) {
				//nada
				trace(e.getStackTrace());
			}
		}
		
		public function enableComponent(display:*):void {
			try {
				display.alpha = 1;
				display.mouseEnabled = true;
				display.filters = [];
			} catch (e:Error) {
				//nada
				trace(e.getStackTrace());
			}
		}		
		
		var b:Borda = new Borda();
		public function adjustBorder():void {
			b.scale9Grid = new Rectangle(20, 20, b.width - 40, b.height - 40);
			b.width = this.stage.stageWidth;
			b.height = this.stage.stageHeight;
			border.addChild(b);
			
		}
		
		public function setAboutScreen(sprite:Sprite):void {
			if(aboutScreen!=null) layerUI.removeChild(aboutScreen);
			aboutScreen = sprite;
			
			//var backgroundScreen:Sprite = new Sprite();
			//backgroundScreen.graphics.beginFill(0x000000, 0.4);
			//backgroundScreen.graphics.drawRect( -this.scrollRect.width / 2, -this.scrollRect.height / 2, this.scrollRect.width, this.scrollRect.height);
			//aboutScreen.addChild(backgroundScreen);
			//aboutScreen.setChildIndex(backgroundScreen, 0);
			
//			var bt:CloseButton = new CloseButton();
			//aboutScreen.addChild(bt);
			aboutScreen.x = stage.stageWidth/2;
			aboutScreen.y = stage.stageHeight / 2;
//			aboutScreen.scaleX = aboutScreen.width / stage.stageWidth
			//aboutScreen.scaleY
			//bt.x = aboutScreen.width - 30;
			//bt.y = 30;
			aboutScreen.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void { closeScreen(aboutScreen) } );				
			optionButtons.btCreditos.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				openScreen(aboutScreen);
			});
			
			layerUI.addChild(glass);
			layerUI.addChild(aboutScreen);
			layerUI.addChild(border);
			aboutScreen.alpha = 0;
			aboutScreen.visible = false;

			closeScreen2(aboutScreen);
		}
		public function setInfoScreen(sprite:Sprite):void {
			if(infoScreen!=null) layerUI.removeChild(infoScreen);
			infoScreen = sprite;
			
			infoScreen.x = stage.stageWidth / 2;
			infoScreen.y = stage.stageHeight/ 2;
			
			//var backgroundScreen:Sprite = new Sprite();
			//backgroundScreen.graphics.beginFill(0x000000, 0.4);
			//backgroundScreen.graphics.drawRect( -this.scrollRect.width / 2, -this.scrollRect.height / 2, this.scrollRect.width, this.scrollRect.height);
			//infoScreen.addChild(backgroundScreen);
			//infoScreen.setChildIndex(backgroundScreen, 0);
			
			var bt:CloseButton = new CloseButton();

			bt.x = infoScreen.width - 30;
			bt.y = 30;
			//Caso a tela de instruções tenha o botão de fechar com o nome de closeButton, ele que receberá os cliques de fechamento.
			var close:SimpleButton = SimpleButton(infoScreen.getChildByName("closeButton"));
			if (close != null) {
				close.addEventListener(MouseEvent.CLICK, 
					function(e:MouseEvent):void { 
						closeScreen(infoScreen);
					}
				);	
			}else{
				infoScreen.addEventListener(MouseEvent.CLICK, 
					function(e:MouseEvent):void { 
						closeScreen(infoScreen);
					}
				);	
			}
			//infoScreen.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void { closeScreen(infoScreen) } );				
			optionButtons.btOrientacoes.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void {
				openScreen(infoScreen);
			});
			layerUI.addChild(infoScreen);
			layerUI.addChild(border);
			infoScreen.alpha = 0;
			infoScreen.visible = false;
			closeScreen2(infoScreen);
			
			 
		}
		public function closeScreen(spriteScreen:Sprite):void {			
			glass.visible = false;
			if (spriteScreen.getChildByName("bgs") != null) {
					var idx:int = spriteScreen.getChildIndex(spriteScreen.getChildByName("bgs"));
					spriteScreen.getChildByName("bgs").alpha = 0;
					spriteScreen.removeChildAt(idx)
					
					//trace("passou")
					//trace(spriteScreen.numChildren)
				}

			Actuate.tween(spriteScreen, 0.6, { alpha:0, scaleX:0.01, scaleY:0.01 } ).onComplete(function():void {
				spriteScreen.visible = false;
				spriteScreen.dispatchEvent(new Event(Event.CLOSE));
			});
		}
		private function closeScreen2(spriteScreen:Sprite):void {
			
				//spriteScreen.alpha = 0;
				
				spriteScreen.visible = false;
		}	
		
		private function createMessageScreen():void {
			messageScreen = new MessageScreen("", MessageScreen.TYPE_OK);
			messageScreen.btOk.addEventListener(MouseEvent.CLICK, onMsgOk);
			messageScreen.btCancel.addEventListener(MouseEvent.CLICK, onMsgCancel);
			layerUI.addChild(messageScreen.screen);
			messageScreen.screen.x = stage.stageWidth / 2;
			messageScreen.screen.y = stage.stageHeight / 2;
			messageScreen.screen.alpha = 0;
			messageScreen.screen.visible = false;
			layerUI.addChild(border);
			closeScreen(messageScreen.screen);			
		}
		
		private var messageBoxCallbackFunction:Function = null;
		public function messageBox(text:String, callback:Function, type:int = MessageScreen.TYPE_OK):void {
			messageScreen.text = text;
			messageBoxCallbackFunction = callback;
			messageScreen.type = type;
			openScreen(messageScreen.screen);
		}
		
		private function onMsgCancel(e:MouseEvent):void 
		{
			closeScreen(messageScreen.screen);
			if(messageBoxCallbackFunction!=null) messageBoxCallbackFunction.call(null, MessageScreen.RESPONSE_CANCEL);
		}
		
		private function onMsgOk(e:MouseEvent):void 
		{
			closeScreen(messageScreen.screen);
			if(messageBoxCallbackFunction!=null) messageBoxCallbackFunction.call(null, MessageScreen.RESPONSE_OK);
		}
		
		public function openScreen(spriteScreen:Sprite):void {
			
			//var backgroundScreen:Sprite = new Sprite();			
			//backgroundScreen.graphics.beginFill(0x000000, 0.4);
			//backgroundScreen.graphics.drawRect( -this.scrollRect.width *100, -this.scrollRect.height *100, this.scrollRect.width*100, this.scrollRect.height*100);
			//spriteScreen.addChild(backgroundScreen);
			//spriteScreen.setChildIndex(backgroundScreen, 0);
			//backgroundScreen.name = "bgs";

			
			
			spriteScreen.scaleX = 1;
			spriteScreen.scaleY = 1;
			var w:Number = spriteScreen.width;
			var h:Number = spriteScreen.height;
			
			//spriteScreen.x = stage.stageWidth/2;
			//spriteScreen.y =  stage.stageHeight / 2;

			
			spriteScreen.scaleX = 0.01;
			spriteScreen.scaleY = 0.01;
			spriteScreen.alpha = 0;			
			spriteScreen.visible = true;
						
			//REMOVER ------------------------------
			
			glass.visible = true;
			//addChild(glass)
			spriteScreen.parent.setChildIndex(spriteScreen, spriteScreen.parent.numChildren - 1);			
			//addChild(border)
			border.parent.setChildIndex(border, border.parent.numChildren - 1);
			// FIM REMOVER -------------------------
			
			Actuate.tween(spriteScreen, 0.6, { alpha:1, scaleX:(1), scaleY:(1) } );
		}

		
		public function createUI():void {
			addChild(layerUI);
			
			// prepare message label
			//messageLabel.scrollRect = 
			messageLabel.width = stage.stageWidth;
			layerUI.addChild(messageLabel);
			messageLabel.x = 0;
			messageLabel.y = stage.stageHeight - messageLabel.height - 17;
			
			setMessageTextValue(" teste de texto");
			
			// prepare option buttons
			layerUI.addChild(optionButtons);
			optionButtons.x = stage.stageWidth - margin - optionButtons.BTN_WIDTH;
			optionButtons.filters = [SHADOW_FILTER];
			optionButtons.y = stage.stageHeight - margin;			
			makeButton(optionButtons.btTutorial);
			makeButton(optionButtons.btStatistics);
			addTooltip(optionButtons.btStatistics, "Desempenho");
			addTooltip(optionButtons.btTutorial, "Tutorial")
			makeButton(optionButtons.btReset);
			addTooltip(optionButtons.btReset, "Reset")
			makeButton(optionButtons.btOrientacoes);
			addTooltip(optionButtons.btOrientacoes, "Orientações");
			
			makeButton(optionButtons.btCreditos);
			addTooltip(optionButtons.btCreditos, "Créditos");
			createMessageScreen();
		}
		
		private function addTooltip(spr:Sprite, tx:String) {
			new ToolTip(spr, tx);
		}
		
		public  function makeButton(spr:Sprite):void {
			spr.buttonMode = true;
			spr.mouseChildren = false;
			spr.mouseEnabled = true;
			spr.scaleX = 1;
			spr.scaleY = 1;
			spr.addEventListener(MouseEvent.MOUSE_OVER, highlightButton);
			spr.addEventListener(MouseEvent.MOUSE_OUT, unHighlightButton);
		}
		
		private function unHighlightButton(e:MouseEvent):void 
		{
			Actuate.tween(e.target, 0.4, { scaleX:1.0, scaleY:1.0 } );
		}
		
		private function highlightButton(e:MouseEvent):void 
		{
			Actuate.tween(e.target, 0.4, {scaleX:1.2, scaleY:1.2 });
		}
		
		public function bindMenuButtons():void {
			// exibir mensagem quando passar mouse nos botoes do menu
			
			// mandar reset pros AI.observers.onResetClick e onTutorialClick
			optionButtons.btTutorial.addEventListener(MouseEvent.CLICK, ai.onTutorialClick);
			optionButtons.btReset.addEventListener(MouseEvent.CLICK, ai.onResetClick);
			optionButtons.btStatistics.addEventListener(MouseEvent.CLICK, ai.onStatsClick);
		}
		
		public function removeButton(name:String):void {
			
		}
		
		
		public function setMessageTextValue(tx:String):void {
			messageLabel.texto.text = tx;
		}
		
		public function setMessageTextVisible(value:Boolean):void {
			trace(this.scrollRect.height)
			trace(this.scrollRect)
			trace(this.parent.height)
			trace(this.stage.stageHeight)
			this.messageLabel.y = this.scrollRect.height;
			//Actuate.tween(messageLabel, 0.8, { y:(value?this.scrollRect.height:0) } ).onComplete();
		}
		
		
		public function setOptionsMenuVisible(value:Boolean):void {
			Actuate.tween(optionButtons, 0.8, { alpha:(value?(this.height - messageLabel.height):this.height)});
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{			
			if (child is AIObserver) {
				ai.addObserver(AIObserver(child));
			}
			var c:DisplayObject =  super.addChild(child);
			setChildIndex(layerUI, numChildren - 1);
			super.addChild(border);
			return c;
		}
		
		public function get messageLabel():TextoExplicativo 
		{
			return _messageLabel;
		}
		
		public function set messageLabel(value:TextoExplicativo):void 
		{
			_messageLabel = value;
		}
		
		public function get optionButtons():MenuBotoes2 
		{
			return _optionButtons;
		}
		
		//public function set optionButtons(value:MenuBotoes2):void 
		//{
			//_optionButtons = value;
		//}

	}

}