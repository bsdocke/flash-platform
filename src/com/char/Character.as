package com.char {
import flash.display.MovieClip;
	public class Character extends MovieClip
	{
		//----------Protected Variables----------------------------------
		protected var _originalX:int;
		protected var _originalY:int;
		
		public function Character()
		{
			_originalX = this.x;
			_originalY = this.y;
		}
		
		//-----------------------------PUBLIC FUNCTIONS---------------------------
		
		/**
		 * returns X position relative to stage.
		 * @return x position relative to stage.
		 */
		public function stageX():int
		{
			if (parent)
			{
				return parent.x + this.x;
			}
			else
			{
				return 0;
			}
		}
		
		/**
		 * Returns y position relative to stage.
		 * @return y position relative to stage.
		 */
		public function stageY():int
		{
			if (parent)
			{
				return parent.y + this.y;
			}
			else
			{
				return 0;
			}
		}
		
		/**
		 * Getter for original x position relative to container.
		 * @return original container x position
		 */
		public function getOriginalX():int
		{
			return _originalX;
		}
		
		/**
		 * Getter for original y position relative to container.
		 * @return original container y position
		 */
		public function getOriginalY():int
		{
			return _originalY;
		}
		
		/**
		 * From http://www.dreaminginflash.com/2008/06/11/as3-flip-vertical-and-flip-horizontal/, "xleon" in comments
		 * Works by negating the object's X or Y scale.
		 */
		
		public function flipHorizontal()
		{
			this.scaleX = -this.scaleX;
		}
		
		public function flipVertical()
		{
			this.scaleY = -this.scaleY;
		}
		
	}
}