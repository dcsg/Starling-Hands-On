package com.danielcsgomes.particles
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(width="100%", height="100%", frameRate="60", backgroundColor="#222222")]
	public class Main extends Sprite
	{
		private var mStarling:Starling;
		
		public function Main()
		{
			
			// stats class for fps 
			addChild ( new Stats() );
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			mStarling = new Starling(Particles, stage);
			mStarling.enableErrorChecking = false;
			mStarling.start();
		}
	}
}