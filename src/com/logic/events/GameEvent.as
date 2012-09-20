package com.logic.events {
import flash.events.Event;

	/**
	 * Custom event class for game events.
	 */
	public class GameEvent extends Event
	{
		public static const COLLISION:String = "onCollision";
		public static const CREATION:String = "onCreation";
		public static const SCROLL_RIGHT:String = "onScrollRight";
		public static const SCROLL_LEFT:String = "onScrollLeft";
		public static const SCROLL_UP:String = "onScrollUp";
		public static const SCROLL_DOWN:String = "onScrollDown";
		public static const PLAYER_DEATH:String = "onPlayerDeath";
		public static const LIFE_INCREASE:String = "onLifeUp";
		public static const GAME_OVER:String = "onGameOver";
		public static const LEVEL_UP:String = "onLevelComplete";
		
		public var sourceItem:Object = null;
		
		/**
		 * Constructor
		 * @param	type type of Event
		 * @param	bubbles whether it bubbles
		 * @param	sourceObject object that fired event
		 */
		public function GameEvent(type:String, bubbles:Boolean, sourceObject:* = null)
		{
			super(type, bubbles);
			sourceItem = sourceObject;
		}
	}
}