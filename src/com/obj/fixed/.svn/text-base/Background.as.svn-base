package com.obj.fixed {
	
import com.logic.events.GameEvent;
import flash.display.MovieClip;
import flash.events.Event;

	/**
	 * The background for the game.
	 */
	public class Background extends MovieClip
	{
		public function Background()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded, false, 0, true);
		}
		
		//---------------------Event Handler----------------
		
		/**
		 * This is the handler for entering a frame.
		 * @param	e Event object
		 */
		private function onAdded(e:Event):void
		{
			dispatchEvent(new GameEvent(GameEvent.CREATION, true, this));
			removeEventListener(Event.ADDED_TO_STAGE, onAdded, false);
		}
	}
}