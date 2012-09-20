package com.obj.fixed {
	
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import com.char.player.Player;
import com.logic.events.GameEvent;
import flash.geom.Point;

	public class Block extends MovieClip{
		
		//----------Protected Variables-----------------------------
		protected var _originalX:int;
		protected var _originalY:int;
		
		public function Block()
		{	
			this.addEventListener(Event.ADDED, onAdded, false, 0, true);
			_originalX = this.x;
			_originalY = this.y;
		}
		
		private function onAdded(e:Event):void
		{
			dispatchEvent(new GameEvent(GameEvent.CREATION, true, this));
		}
		
		//------------Public Functions----------------------
		
		/**
		 * Original x position
		 * @return original x position relative to container
		 */
		public function getOriginalX():int
		{
			return _originalX;
		}
		
		/**
		 * Original y position
		 * @return original y position relative to container
		 */
		public function getOriginalY():int
		{
			return _originalY;
		}
		
		/**
		 * X position relative to stage.
		 * @return x position
		 */
		public function stageX():int
		{
			return parent.x + this.x;
		}
		
		/**
		 * Y position relative to stage.
		 * @return y position 
		 */
		public function stageY():int
		{
			return parent.y + this.y;
		}
	}
	
}