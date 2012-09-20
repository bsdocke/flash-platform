package com.obj.dyn {
import com.obj.fixed.Block;
import flash.events.Event;

	/**
	 * A block that floats up vertically
	 */
	public class VertBlock extends Block
	{
		//---------------------------Private variables---------------------------
		private var _speedY:int = 0;
		
		public function VertBlock()
		{
			super();
			_speedY = -4;

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
			this.y += _speedY;
		}
		
		/**
		 * Checks when it should restart to its bottom position.
		 */
		private function boundsCheck():void
		{
			if ( this.stageY() < -20)
			{
				this.y = 420;
				
			}
		}
	}
}