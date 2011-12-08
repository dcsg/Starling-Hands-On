package com.danielcsgomes.particles
{
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

	public class Particles extends Sprite
	{
		// particle designer configurations
		
		[Embed(source="../assets/fire.pex", mimeType="application/octet-stream")]
		private static const FireConfig:Class;
		
		// particle textures
		
		[Embed(source = "../assets/fire.png")]
		private static const FireParticle:Class;
		
		private var mParticleSystem:ParticleSystem;
		private var mFrameLabel:TextField;
		private var mFrameCount:int;
		private var mFrameTime:Number;
		
		public function Particles()
		{
			var psConfig:XML = XML(new FireConfig());
			var psTexture:Texture = Texture.fromBitmap(new FireParticle());
			
			mParticleSystem = new ParticleDesignerPS(psConfig, psTexture);
			mParticleSystem.emitterX = 500;
			mParticleSystem.emitterY = 300;
			mParticleSystem.start();
			addChild(mParticleSystem);
			
			// add event handlers for touch and FPS
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onAddedToStage(event:Event):void
		{
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
			if (touch && touch.phase != TouchPhase.HOVER)
			{
				mParticleSystem.emitterX = touch.globalX;
				mParticleSystem.emitterY = touch.globalY;
			}
		}
	}
}