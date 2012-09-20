package com.obj.dyn {
import com.obj.fixed.Block;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.utils.Timer;

	/**
	 * A block that floats up vertically
	 */
	public class HorizontalBlock extends Block
	{
		//---------------------------Private variables---------------------------
		private var _speedX:int = 0;
		private var _pivot:int = 0;
		private var _start:int = 0;
		private var _startTimer:Timer;
		
		public function HorizontalBlock()
		{
			super();
			_pivot = Math.round(Math.random() * (500 - 200)) + 200;
			_start = Math.round(Math.random() * (700 - 200)) + 200;
			_startTimer = new Timer(_start, 1);
			_startTimer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			_startTimer.start();

			this.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
		}
		
		//-------------------Event Handlers-----------------------
		
		/**
		 * Handler for entering a frame.
		 * @param	e Event object
		 */
		private function onFrame(e:Event):void
		{
			boundsCheck();
			this.x += _speedX;
		}
		
		private function onTimer(e:TimerEvent):void
		{
			_speedX = -4;
		}
		/**
		 * Checks when it should restart to its bottom position.
		 */
		private function boundsCheck():void
		{
			if (!(this.x - this.getOriginalX() < -500 || this.x - this.getOriginalX() > 500))
			{
				this.x += _speedX;
				
			}
			else
			{
				_speedX = -_speedX;
				this.x += _speedX;
			}
		}
		
		public function getSpeedX():int
		{
			return _speedX;
		}
		
		public function setSpeedX(newX:int):void
		{
			_speedX = newX;
		}
	}
}