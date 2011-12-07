package com.danielcsgomes.experiment1
{
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Game extends Sprite
	{
		private var q:Quad;
		private var s:Sprite;
		
		private var r:Number = 0;
		private var g:Number = 0;
		private var b:Number = 0;
		
		private var rDest:Number;
		private var gDest:Number;
		private var bDest:Number;
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded( e:Event ):void
		{
			resetColors();
			
			q = new Quad(200, 200);
			
			s = new Sprite();
			
			var legend:TextField = new TextField(100, 20, "Hello Starling", "Arial", 14, 0xFFFFFF);
			
			s.addChild(q);
			s.addChild(legend);
			
			s.pivotX = s.width >> 1;
			s.pivotY = s.height >> 1;
			
			s.x = (stage.stageWidth - s.width >> 1 ) + (s.width >> 1);
			s.y = (stage.stageHeight - s.height >> 1) + (s.height >> 1);
			
			addChild(s);
			
			s.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e:Event):void
		{
			r-=(r-rDest)*.01;
			g-=(g-gDest)*.01;
			b-=(b-bDest)*.01;
			
			var color:uint= r << 16 | g << 8 | b; 
			q.color = color;
			
			// when reaching the color, pick another one
			if ( Math.abs( r - rDest) < 1 && Math.abs( g - gDest) < 1 && Math.abs( b - bDest) )
				resetColors();
			(e.currentTarget as DisplayObject).rotation += .01;
		}
		private function resetColors():void
		{
			rDest = Math.random()*255;
			gDest = Math.random()*255;
			bDest = Math.random()*255;
		}
	}
}