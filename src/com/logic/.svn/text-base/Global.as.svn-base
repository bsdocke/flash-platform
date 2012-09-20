package com.logic {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * Contains some game elements that must carry between levels.
	 */
	public class Global extends MovieClip
	{
		//------Public static variables--------------
		public static var _lives:int = 5;
		public static var _last:int = 7;
		
		//------Private variables--------------------
		private var _bgSound:Sound;
		
		public function Global()
		{
			_bgSound = new BillieJean();
			
			var sndChan:SoundChannel = _bgSound.play();
			sndChan.addEventListener(Event.SOUND_COMPLETE, onComplete, false, 0, true);
		}
		
		//---------------------------------------------------------------------
		//-----------EVENT HANDLERS-----------------------------------------
		//---------------------------------------------------------------------
		private function onComplete(e:Event):void
		{
			_bgSound.play();
		}
	}
}