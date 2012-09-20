package com.char.enemy {
	import com.char.player.Player;
	import com.logic.events.GameEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import com.char.enemy.Enemy;
	import flash.events.Event;
	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	/**
	 * This class describes enemies that fly horizontally across the screen on a fixed course.
	 */
	public class FlyingEnemy extends Enemy
	{
		//---------------PROTECTED VARIABLES----------------------------------
		protected var _player:Player;
		protected var _smart:Boolean;
		
		public function FlyingEnemy(player:Player, imageFile:BitmapData, smart:Boolean = false)
		{
			super();
	
			var bmp:Bitmap = new Bitmap(imageFile);
			addChild(bmp);

			_player = player;
			_smart = smart;
			this.y = pickPoint(0, 370);			
			this.x = 800;
			
			this.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved, false, 0, true);

		}
		
		//-------------------PUBLIC FUNCTIONS---------------------------------		
		
		/**
		 * This clears event listeners and removes the object from the parent.
		 */
		public function clearAll():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onFrame, false);
			parent.removeChild(this);
		}
		
		//------------------PRIVATE FUNCTIONS------------------------------
		
		//
		//Adapted from:
		//http://scriptplayground.com/tutorials/as/Generate-random-number-in-ActionScript-3/
		//
		private function pickPoint(lowerBound:Number, upperBound:Number):Number
		{
			if (_smart && _player.y > 0)
			{
				return _player.y - 40;
				
			}
			else
			{
				return Math.round(Math.random() * (upperBound - lowerBound)) + lowerBound;
			}
		}
		
		private function onFrame(e:Event):void
		{
			if (parent)
			{
				if (this.x + this.width < 0)
				{
					parent.removeChild(this);
					this.removeEventListener(Event.ENTER_FRAME, onFrame, false);
				}
				else if (hitTestObject(_player))
				{
					dispatchEvent(new GameEvent(GameEvent.PLAYER_DEATH, true, this));
					removeEventListener(Event.ENTER_FRAME, onFrame, false);
					if (parent)
					{
						parent.removeChild(this);
					}
				}
				else if (parent)
				{
					this.x -= 10;
				}
				else
				{
					this.removeEventListener(Event.ENTER_FRAME, onFrame, false);
				}
			}
		}

		
		/**
		 * This is the removal event handler.
		 * @param	e Event object
		 */
		private function onRemoved(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, onFrame, false);
		}
		
		/**
		 * Definition of clearFrameListener from Enemy class.
		 */
		public override function clearFrameListener():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onFrame, false);
		}
	}
}