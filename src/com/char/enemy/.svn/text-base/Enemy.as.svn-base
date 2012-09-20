package com.char.enemy 
{
	import com.char.Character;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.logic.events.GameEvent;
	
	/**
	 * Enemy class. It's mainly a base class for specific types of enemies.
	 * @author Brandon Dockery
	 */
	public class Enemy extends Character
	{

		
		public function Enemy()
		{
			super();
			this.addEventListener(Event.ADDED, onAdded, false, 0, true);
		}
		
		//-------------------------------------------------------------------------
		//---------PROTECTED FUNCTIONS-----------------------
		//-------------------------------------------------------------------------
		protected function onAdded(e:Event):void
		{
			dispatchEvent(new GameEvent(GameEvent.CREATION, true, this));
		}
		
		//--------------------Public Functions-------------------------------------
		/**
		 * Meant to be overridden by descendants to handle ENTER_FRAME event listener removal.
		 */
		public function clearFrameListener():void
		{
		}
		
	}
	
}