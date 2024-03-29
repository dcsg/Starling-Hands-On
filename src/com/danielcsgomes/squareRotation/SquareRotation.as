package com.danielcsgomes.squareRotation
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import net.hires.debug.Stats;
	
	import starling.core.Starling;
	
	[SWF(width="1280", height="752", frameRate="60", backgroundColor="#002143")]
	public class SquareRotation extends Sprite
	{
		private var mStarling:Starling;
		
		public function SquareRotation() 
		{
			// stats class for fps 
			addChild ( new Stats() );
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// create our Starling instance 
			mStarling = new Starling(SquareRotationAnimation, stage);
			
			// set anti-aliasing (higher the better quality but slower performance) 
			mStarling.antiAliasing = 4;
			
			// start it!
			mStarling.start(); 
		}
	}
}