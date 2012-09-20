package com.obj.fixed {
import flash.display.MovieClip;
import flash.events.Event;
import com.logic.events.GameEvent;

	/**
	 * A fixed spike object.
	 */
	public class Spike extends MovieClip
	{
		public function Spike()
		{
			this.addEventListener(Event.ADDED, onAdded, false, 0, true);
		}
		
		//------------Event Listeners---------------------------
		
		/**
		 * This is the event handler for entering a frame.
		 * @param	e Event target
		 */
		private function onAdded(e:Event):void
		{
			dispatchEvent(new GameEvent(GameEvent.CREATION, true, this));
		}
	}
}