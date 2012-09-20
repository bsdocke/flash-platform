package com.logic.buttons {
	
import flash.display.MovieClip;
import flash.events.MouseEvent;
import com.logic.Global;

	/**
	 * This button plays the game.
	 */
	public class PlayButton extends MovieClip
	{
		public function PlayButton()
		{
			this.addEventListener(MouseEvent.CLICK, onClickHandle, false, 0, true);
		}
		
		//--------------------------------------------------------------------------------------
		//------------------------Event Handlers-----------------------------------------------
		//--------------------------------------------------------------------------------------
		private function onClickHandle(e:MouseEvent):void
		{
			MovieClip(root).gotoAndStop(3);
		}
	}
}