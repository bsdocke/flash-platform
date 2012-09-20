package com.char.player {

//------------------------------------------------------------------
//****Imports*****
//------------------------------------------------------------------
import com.char.Character;
import com.char.enemy.Enemy;
import com.obj.dyn.HorizontalBlock;
import com.obj.fixed.Background;
import com.obj.fixed.Spike;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.ui.Keyboard;
import flash.utils.Timer;
import flash.display.DisplayObject;
import com.logic.events.GameEvent;
import com.char.hit.*;
import com.obj.fixed.Block;
import com.obj.dyn.Glove;
	
//--------------------------------------------------------------------
//****Begin Class******
//--------------------------------------------------------------------
	public class Player extends Character
	{
		//-----------Private Variables----------------
		private var _jumpState:Boolean = false;
		private var _gravity:Number  = 0.5;
		private var _speedY:Number = 0;
		private var _speedX:Number = 0;
		private var _accX:Number = 0;
		private var _accY:Number = 0;
		
		//---------Private constants----------------------------
		private static const FRICTION:Number  = 0.98;
		
		/**
		 * This is the constructor
		 */
		public function Player()
		{	
			super();
			this.gotoAndStop("faceLeft");
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp, false, 0, true);
			_jumpState = true;
		}
		
		
		//-------------------------------------------------------------------------------------------------
		//Event Handlers
		//-------------------------------------------------------------------------------------------------
		
		/**
		 * This is the enter frame handler. It applies the forces that move the ball and initiates scrolling.
		 * @param	evt   ENTER_FRAME handler for event
		 */
		private function onEnterFrame(evt:Event):void
		{
			if (parent)
			{

				regMove();
				if (_speedY > 0)
				{
					_jumpState = false;
				}

				if (this.y > stage.stageHeight)
				{
					dispatchEvent(new GameEvent(GameEvent.PLAYER_DEATH, true, this));
				}
			
			}
		}
		
		

		/**
		 * This is the handler for key-presses. It checks for the Up, Down, and Left
		 * keyboard keys being pressed.
		 * @param	evt a keyboard press event
		 */
		private function onDown(evt:KeyboardEvent):void
		{
			switch(evt.keyCode){
				case(Keyboard.LEFT) :
					this.gotoAndStop("faceRight");
					if (_accX > -3)
					{
						_accX = -0.5;
					}
					break;
				case(Keyboard.UP) :
					if (_jumpState)
					{
						_gravity = 0;
						_accY = 0.5;
						_speedY = -15;
					}
					_jumpState = false;
					break;
				case(Keyboard.RIGHT) :
					this.gotoAndStop("faceLeft");
					if (_accX < 3)
					{
						
						_accX = 0.5;
					}
					break;
				case(Keyboard.DOWN) :
					if (_jumpState)
					{
						
						if (_speedX < -1)
						{
							_speedX++;
						}
						else if (_speedX > 1)
						{
							_speedX--;
						}
						else
						{
							_speedX = 0;
						}
						if (_speedX < 0)
						{
							gotoAndStop("duckRight");
						}
						else if (_speedX >= 0)
						{
							gotoAndStop("duckLeft");
						}
						break;
					}
			}
				
		}
		
		/**
		 * This is the handler for when keys are released. It allows the ball
		 * to slow and eventually stop.
		 * @param	evt   the keyboard up event
		 */
		private function onUp(evt:KeyboardEvent):void
		{
			if (currentFrameLabel == "duckLeft" || currentFrameLabel == "duckRight")
			{
				while(getObjectsUnderPoint(new Point(this.x, this.y - 5)) is Block)
				{
					trace("close");
					this.x = this.x + 2;
				}
			}
			if (_speedX < 0)
			{
				gotoAndStop("faceRight");
			}
			else if (_speedX >= 0)
			{
				gotoAndStop("faceLeft");
			}
			_gravity = 0.5;
			_accX = 0;
		}
		
		//---------------------PUBLIC FUNCTIONS-------------------------------
		
		/**
		 * Applies normal motion to the player.
		 */
		public function regMove():void
		{
			if (_speedY < 7)
			{
			_speedY += _accY;
			_speedY += _gravity;
			}
			if (_speedX < 6 || _speedX > -6)
			{
				_speedX += _accX;
			}
			_speedX *= FRICTION;
			_speedY *= FRICTION;
			
			this.y += _speedY;
			this.x += _speedX;
		}
		
		
		
		/**
		 * This is the method for stopping the ball when it strikes a platform from the top.
		 * @param	other Collision point that the player has struck.
		 */
		public function platLanding(other:Block):void
		{
				if (other is HorizontalBlock)
				{
					if (_speedX > -10 && _speedX < 10)
					{
						if (_speedX + (other as HorizontalBlock).getSpeedX() > -10 && _speedX + (other as HorizontalBlock).getSpeedX() < 10)
						{
							_speedX = -_speedX;
							_accX = 0;
						}
						else
						{
							_speedX += (other as HorizontalBlock).getSpeedX();
							_accX = 0;
						}
					}
				}
				this.y = other.stageY() - this.height;
				_speedY = 0;
				_jumpState = true;
				
		}
		
		/**
		 * This is the method for stopping the player when it strikes the platform from the bottom.
		 * @param	other Collision point that the player has struck.
		 */
		public function platBottom(other:Block):void
		{
				this.y = other.stageY() + other.height + 1;
				_speedY = 0;
				_jumpState = false;
		}
		
		/**
		 * This is the method for stopping the player when it strikes the platform from the right.
		 * @param	other Collision point that the player has struck.
		 */
		public function platRightSide(other:Block):void
		{
			
			_accX = 0;
			_speedX = 0;
			this.x = other.stageX() + other.width + 1;
		}
		
		/**
		 * This is the method for stopping the player when it strikes the platform from the left.
		 * @param	other Collision point that the player has struck.
		 */
		public function platLeftSide(other:Block):void
		{
		
				_accX = 0;
				_speedX = 0;
				this.x = other.stageX() - this.width - 1;
		}
		
		/**
		 * This method handles collision detection with objects that affect
		 * the player object. It iterates through all potential and relevant
		 * objects each frame that it can collide with.
		 * @param	other
		 */
		public function collisionHandle(other:Array = null):void
		{
			if (other)
			{
				//iterate through all hitspots in character
				for (var i:uint = 0; i < other.length; i++ )
				{
					//iterate through each block in the level
					for (var k:uint = 0; k < this.numChildren; k++)
					{
						if (getChildAt(k) is HitSpot)
						{
							//make sure it is a block first
							if (other[i] is Block)
							{
								//check if the player is hitting each block
								if (getChildAt(k).hitTestObject(other[i]))
								{
									if (getChildAt(k) is TopHit)
									{
										
										platBottom(other[i]);
									}
									if (getChildAt(k) is BottomHit)
									{
										platLanding(other[i]);
									}
									if (getChildAt(k) is LeftSideHit)
									{
										platRightSide(other[i]);
									}
									if (getChildAt(k) is RightSideHit)
									{
										if (this.x <= 0)
										{
											dispatchEvent(new GameEvent(GameEvent.PLAYER_DEATH, true));
										}
										else
										{
											platLeftSide(other[i]);
									
										}
									}
								}
							}
						}	
						
						else if (other[i] is Spike)
						{
							if (getChildAt(k).hitTestObject(other[i]))
							{
								
								dispatchEvent(new GameEvent(GameEvent.PLAYER_DEATH, true, other[i]));	
																
							}
						}
						else if (other[i] is Enemy)
						{
							if (getChildAt(k).hitTestObject(other[i]))
							{
								dispatchEvent(new GameEvent(GameEvent.PLAYER_DEATH, true, other[i]));
							}
						}
					}
				}
			}
		}
		
		/**
		 * Puts back all necessary key listeners.
		 */
		public function restoreKeyListeners():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp, false, 0, true);		
		}
		
		/**
		 * Clears key listeners.
		 */
		public function clearKeyListeners():void
		{
			if (parent)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onDown, false);
				stage.removeEventListener(KeyboardEvent.KEY_UP, onUp, false);
			}
		}
		
		/**
		 * This method clears the enter frame event listener.
		 */
		public function clearAll()
		{	
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame, false);
		}
		
//-------------------------------------------------------------------------------------------------------------------------
//-------------------------------GETTERS AND SETTERS-------------------------------
//-------------------------------------------------------------------------------------------------------------------------
		public function setSpeedX(newX:Number):void
		{
			_speedX = newX;
		}
		
		public function getSpeedX():Number
		{
			return _speedX;
		}
		
		public function setSpeedY(newY:Number):void
		{
			_speedY = newY;
		}
		
		public function getSpeedY():Number
		{
			return _speedY;
		}
		
		public function getJumpState():Boolean
		{
			return _jumpState;
		}
		
		public function setJumpState(newState:Boolean)
		{
			_jumpState = newState;
		}
		
		public function setAccX(newX:Number):void
		{
			_accX = newX;
		}
		
		public function getAccX():Number
		{
			return _accX;
		}
		
		public function setAccY(newY:Number):void
		{
			_accY = newY;
		}
		
		public function getAccY():Number
		{
			return _accY;
		}
		
		public function setGravity(newGrav:Number):void
		{
			_gravity = newGrav;
		}
		
		public function getGravity():Number
		{
			return _gravity;
		}
				
	}
}