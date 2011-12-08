package com.danielcsgomes.particles
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.ParticleDesignerPS;
	import starling.extensions.ParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class FollowParticles extends Sprite
	{
		// particle designer configurations
		
		[Embed(source="../assets/jetfire.pex", mimeType="application/octet-stream")]
		private static const JetFireConfig:Class;
		
		// particle textures
		
		[Embed(source = "../assets/fire.png")]
		private static const JetFireParticle:Class;
		
		private var mParticleSystem:ParticleSystem;
		private var mFrameLabel:TextField;
		private var mFrameCount:int;
		private var mFrameTime:Number;
		
		public function FollowParticles()
		{
			var psConfig:XML = XML(new JetFireConfig());
			var psTexture:Texture = Texture.fromBitmap(new JetFireParticle());
			
			mParticleSystem = new ParticleDesignerPS(psConfig, psTexture);
			
			// add event handlers for touch and FPS
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			//Center the animations at the start	
			mParticleSystem.emitterX = stage.stageWidth/2;
			mParticleSystem.emitterY = stage.stageHeight/2;
			mParticleSystem.start();
			addChild(mParticleSystem);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);			
			
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			Starling.juggler.add(mParticleSystem);
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			Starling.juggler.remove(mParticleSystem);
		}
		
		private function onEnterFrame(event:EnterFrameEvent):void
		{
			mFrameCount++;
			mFrameTime += event.passedTime;
			
			if (mFrameTime > 2)
			{
				mFrameLabel.text = "FPS: " + int(mFrameCount / mFrameTime);
				mFrameTime = mFrameCount = 0;
			}
		}
		
		private function onTouch(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
			mParticleSystem.emitterX = touch.globalX;
			mParticleSystem.emitterY = touch.globalY;
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				mParticleSystem.emitterX = touch.globalX;
				mParticleSystem.emitterY = touch.globalY;
			}
		}
	}
}