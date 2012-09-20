package com.char.enemy 
{
	import com.char.hit.HitSpot;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.logic.events.GameEvent;
	import com.char.enemy.Enemy;
	import com.obj.fixed.Block;
	
	/**
	 * This class governs behavior for enemies that creep horizontally on the stage in a fixed area.
	 * @author Brandon Dockery
	 */
	public class CrawlingEnemy extends Enemy
	{
		//---------------Private Variables---------------------
		protected var _speedX:int;
		protected var _closeBricks:Array = new Array();
		
		/**
		 * Constructor for the class. Calls the Enemy constructor.
		 */
		public function CrawlingEnemy()
		{
			super();
			this.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoved, false, 0, true);
			_speedX = 5;
		}
	
		
		/**
		 * Event handler for entering the frame.
		 * @param	e Event object
		 */
		private function onFrame(e:Event):void
		{
			if (!(this.x - this.getOriginalX() < -200 || this.x - this.getOriginalX() > 200))
			{
				this.x += _speedX;
				
			}
			else
			{
				flipHorizontal();
				_speedX = -_speedX;
				this.x += _speedX;
			}
		}
		
		/**
		 * This clears the object from the stage and removes its listeners.
		 */
		public function clearAll():void
		{
			this.removeEventListener(Event.ENTER_FRAME, onFrame, false);
			//parent.removeChild(this);
		}
		
		/**
		 * This passes all of the bricks in the level to the enemy.
		 * @param	allBricks
		 */
		//public override function giveBricks(allBricks:Array):void
		//{
			//for (var i:uint; i < allBricks.length; i++)
			//{
				//if (((allBricks[i] as Block).stageX() < this.stageX() + 200) && ((allBricks[i] as Block).stageX() > this.stageX() - 200) && ((allBricks[i] as Block).stageY() < this.stageY() + 200) && ((allBricks[i] as Block).stageY() > this.stageY() - 200))
				//{	
//
					//_closeBricks.push(allBricks[i]);
										//trace("Hit");
				//}
			//}
		//}
		
		/**
		 * This is the event handler for removal from the stage.
		 * @param	e Event object.
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

		
		