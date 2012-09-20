package com.logic {
	
	import com.char.enemy.CrawlingEnemy;
	import com.char.enemy.Enemy;
	import com.char.enemy.FlyingEnemy;
	import com.obj.dyn.OneUp;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.logic.events.GameEvent;
	import com.char.player.Player;
	import com.obj.fixed.*;
	import com.obj.dyn.Glove;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import com.logic.Global;
	
	/**
	 * Main class for game logic.
	 */
	public class Main extends MovieClip
	{
		//--------------Protected Variables-----------------------
		protected var _blockArray:Array = new Array();
		protected var _closeArray:Array = new Array();
		protected var _fixedEnemyArray:Array = new Array();
		protected var _enemyArray:Array = new Array();
		
		protected var _player:Player = null;
		protected var _bg:Background = null;
		protected var _objArray:Array = new Array();
		protected var _gloves:int;
		
		//-----------------Display Objects-------------------------
		protected var _brickClip:MovieClip;
		protected var _gloveClip:MovieClip;
		protected var _enemyClip:MovieClip;

		//------------------Timer Objects------------------------
		protected var _flyTime:Timer = new Timer(3000, 0);
		protected var _deadTime:Timer = new Timer(2000, 1);
		
		//----------------Text Fields--------------------------------
		public var _livesField:TextField = null;
		public var _glovesField:TextField = null;

		
		public function Main()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded, false, 0, true);
					
		}
		//=============================================================================
		//====================PRIVATE FUNCTIONS====================
		//=============================================================================
		/**
		 * This adds all of the Event listeners the container uses.
		 */
		protected function addAllListeners():void
		{
			stage.addEventListener(GameEvent.SCROLL_RIGHT, onScrollHandle, false, 0, true);
			stage.addEventListener(GameEvent.SCROLL_LEFT, onLeftScrollHandle, false, 0, true);
			//stage.addEventListener(GameEvent.SCROLL_UP, onUpScrollHandle, false, 0, true);
			//stage.addEventListener(GameEvent.SCROLL_DOWN, onDownScrollHandle, false, 0, true);
			stage.addEventListener(GameEvent.GAME_OVER, onGameOver, false, 0, true);
			this.addEventListener(GameEvent.PLAYER_DEATH, onPlayerDeath, false, 0, true);
			this.addEventListener(TimerEvent.TIMER, onDeathTimer, false, 0, true);
			this.addEventListener(GameEvent.LEVEL_UP, onLevelUp, false, 0, true);
		}
		
		/**
		 * This method handles the scoring by checking for collisions between the player and tokens/ powerups.
		 * It also fires events governing level changes.
		 */
		protected function scoreHandler():void
		{
			if (_gloves > 0)
			{
				for (var i:uint = 0; i < _objArray.length; i++)
				{
					if (_player.hitTestObject(_objArray[i]))
					{
						if (_objArray[i] is Glove)
						{
							(_objArray[i] as Glove).visible = false;
							_objArray.splice(i, 1);	
							_gloves--;
							_glovesField.text = "Remaining Gloves: " + _gloves;
						}
						else if (_objArray[i] is OneUp)
						{
							Global._lives++;
							(_objArray[i] as OneUp).visible = false;
							_objArray.splice(i, 1);	
							_livesField.text = "Lives: " + Global._lives;
						}
						
					}
				}
			}
			else
			{
				dispatchEvent(new GameEvent(GameEvent.LEVEL_UP, true));
			}
			
		}
		
		/**
		 * This method populates the arrays for platforms, enemies, tokens, and anything else that is
		 * checked for collisions.
		 */
		protected function arrayPopulation():void
		{
			for (var k:uint = 0; k < _brickClip.numChildren; k++)
			{
				if (_brickClip.getChildAt(k) is Block)
				{
					_blockArray.push(_brickClip.getChildAt(k));
				}

			}
			
			
			for (var j:uint = 0; j < _gloveClip.numChildren; j++)
			{
				_objArray.push(_gloveClip.getChildAt(j));
			}
			
		
			for ( var i:uint = 0; i < this.numChildren; i++)
			{
				if (getChildAt(i) is Player)
				{
					_player = getChildAt(i) as Player;
				}
				else if (getChildAt(i) is Spike)
				{
					_fixedEnemyArray.push(getChildAt(i));
				}
			}
			
			if (_enemyClip)
			{
				for (var l:uint = 0; l < _enemyClip.numChildren; l++)
				{
					if (_enemyClip.getChildAt(l) is Enemy)
					{
						_enemyArray.push(_enemyClip.getChildAt(l));
					}
				}
			}
			stage.addEventListener(Event.ENTER_FRAME, onFrame, false, 0, true);
		}
		
		/**
		 * This moves the objects on stage when the character has moved far enough to the right.
		 * @param	...args
		 */
		protected function scrollRightMove(...args):void
		{
			if (args)
			{
				for (var i:uint; i < args.length; i++)
				{	
					(args[i] as DisplayObject).x -= (_player.getSpeedX()*0.85);
					_player.x = 400;
				}
			}
		}
		
		/**
		 * This handles scrolling of objects on stage when the player has moved far enough to the left.
		 * @param	...args
		 */
		protected function scrollLeftMove(...args):void
		{
			for (var i:uint; i < args.length; i++)
			{
				(args[i] as DisplayObject).x -= (_player.getSpeedX()*0.85);
				_player.x = 100;
			}
		}
		
		//protected function scrollUpMove(...args):void
		//{
			//for (var i:uint; i < args.length; i++)
			//{
				//(args[i] as DisplayObject).y -= (_player.getSpeedY()*0.85);
				//_player.y = 100;
			//}
		//}
		
		//protected function scrollDownMove(...args):void
		//{
			//for (var i:uint; i < args.length; i++)
			//{
	//
				//(args[i] as DisplayObject).y -= (_player.getSpeedY()*0.85);
				//_player.y = 200;
			//}
		//}
		//====================================================================================================================
		//========================EVENT HANDLERS==============================================================================
		//====================================================================================================================

		/**
		 * Behavior to execute when an object is added to the stage.
		 * @param	e Event object
		 */
		protected function onAdded(e:Event):void
		{
			addAllListeners();
			_flyTime.addEventListener(TimerEvent.TIMER, onFlyTime, false, 0, true);
			_flyTime.start();
			
			_gloveClip = getChildByName("gloveBox" + (MovieClip(root).currentFrame - 2)) as MovieClip;
			_brickClip = getChildByName("brickBox" + (MovieClip(root).currentFrame - 2)) as MovieClip;
			_enemyClip = getChildByName("enemyBox" + (MovieClip(root).currentFrame - 2)) as MovieClip;
			_bg = getChildByName("bg" + (MovieClip(root).currentFrame - 2)) as Background;
			
			arrayPopulation();
			
			_gloves = 0;
			for (var j:uint; j < _objArray.length; j++)
			{
				if (_objArray[j] is Glove)
				{
					_gloves++;
				}
			}
			_livesField.text = "Lives: " + Global._lives;
						
			_glovesField.text = "Remaining Gloves: " + _gloves; 

		}
		
		
		/**
		 * Behavior to execute each time the frame is entered.
		 * @param	e Event object
		 */
		protected function onFrame(e:Event):void
		{
			_closeArray = [];
			if (_player)
			{					
				for (var i:uint; i < _blockArray.length; i++)
				{
					if (((_blockArray[i] as Block).stageX() < _player.x + 200) && ((_blockArray[i] as Block).stageX() > _player.x - 200) && ((_blockArray[i] as Block).stageY() < _player.y + 200) && ((_blockArray[i] as Block).stageY() > _player.y - 200))
					{	
						_closeArray.push(_blockArray[i]);
					}
					
				}
				
				_player.collisionHandle(_closeArray);
				_player.collisionHandle(_fixedEnemyArray);
				_player.collisionHandle(_objArray);
				_player.collisionHandle(_enemyArray);
							
				scrollCheck();
				
				//Handle scoring
				scoreHandler();
			}
		}
		
		protected function scrollCheck():void
		{
			if (_player)
			{
				if (_player.x >= 400)
				{
					dispatchEvent(new GameEvent(GameEvent.SCROLL_RIGHT, true));
				}

				if (_player.x <= 100)
				{
					dispatchEvent(new GameEvent(GameEvent.SCROLL_LEFT, true));
				}
				
				//if (_player.y <= 100)
				//{
					//dispatchEvent(new GameEvent(GameEvent.SCROLL_UP, true));
				//}
				//if (_player.y > 200 && _brickClip.y > 0)
				//{
					//dispatchEvent(new GameEvent(GameEvent.SCROLL_DOWN, true));
				//}
			}
		}
		
		
		/**
		 * This handles the scrolling for the game.
		 * @param	e GameEvent object
		 */
		protected function onScrollHandle(e:GameEvent):void
		{
			for (var i:uint; i < numChildren; i++)
			{
				if (!(getChildAt(i) is Player || getChildAt(i) is Spike || getChildAt(i) is TextField ))
				{
					scrollRightMove(getChildAt(i));
				}
			}
		}
		
		/**
		 * This is the event handler for scrolling left.
		 * @param	e GameEvent object
		 */
		protected function onLeftScrollHandle(e:GameEvent):void
		{
			for (var i:uint; i < numChildren; i++)
			{
				if (!(getChildAt(i) is Player || getChildAt(i) is Spike || getChildAt(i) is TextField))
				{
					scrollLeftMove(getChildAt(i));
				}
			}
		}
		
		//protected function onUpScrollHandle(e:GameEvent):void
		//{
			//for (var i:uint; i < numChildren; i++)
			//{
				//if (!(getChildAt(i) is Player || getChildAt(i) is Background || getChildAt(i) is TextField))
				//{
					//scrollUpMove(getChildAt(i));
				//}
			//}
		//}
		//
		//protected function onDownScrollHandle(e:GameEvent):void
		//{
			//for (var i:uint; i < numChildren; i++)
			//{
				//if (!(getChildAt(i) is Player || getChildAt(i) is Background || getChildAt(i) is TextField))
				//{
					//scrollDownMove(getChildAt(i));
				//}
			//}
		//}
		/**
		 * This is the handler for when a 1-up has been touched.
		 * @param	e GameEvent object
		 */
		protected function onLifeUp(e:GameEvent):void
		{
			Global._lives--;
			_livesField.text = "Lives: " + Global._lives;
		}
		
		/**
		 * This is the event handler for when the player dies. It generates the necessary animations and
		 * adjusts the life counter and checks for a game-over.
		 * @param	e GameEvent object.
		 */
		protected function onPlayerDeath(e:GameEvent):void
		{
			//Adjust lives
			Global._lives--;
			if (Global._lives >= 0)
			{
				_livesField.text = "Lives: " + Global._lives;
			}
			else
			{
				_livesField.text = "Oh shit...";
			}
			
			//Pause flying enemies generation
			_flyTime.stop();
			//stage.removeEventListener(GameEvent.SCROLL_UP, onUpScrollHandle, false);
			
			//Sound to play
			var deathSnd:Sound = new DeathSound();
			deathSnd.play();
			
			//Spike death animation
			var deadMan:DisplayObject = addChild(new charDead());
			deadMan.name = "deadMeat";

			if (e.sourceItem is Enemy)
			{
				deadMan.x = (e.sourceItem as Enemy).stageX();
				deadMan.y = (e.sourceItem as Enemy).stageY() - (e.sourceItem as DisplayObject).height;
			}
			else
			{
				deadMan.x = (e.sourceItem as DisplayObject).x;
				deadMan.y = (e.sourceItem as DisplayObject).y - (e.sourceItem as DisplayObject).height;
			}

			//Reset main player
			_player.clearKeyListeners();


			_player.x = 150;

			_player.y = -60;

			
			_player.setSpeedX(0);
			_player.setSpeedY(0);
			_player.setGravity(0);
			_player.setAccY(0);
			_player.setAccX(0);

			
			//Set timer to allow death sprite to stay before regeneration
			_deadTime.addEventListener(TimerEvent.TIMER, onDeathTimer, false, 0, true);
			_deadTime.start();
		}
		
		
		/**
		 * This is the event handler for the timer that regulates how the game handles a player death.
		 * @param	e TimerEvent object
		 */
		protected function onDeathTimer(e:TimerEvent):void
		{
			removeChild(getChildByName("deadMeat"));
			if (Global._lives < 0)
			{

				dispatchEvent(new GameEvent(GameEvent.GAME_OVER, true));
			}
			else
			{
				_player.x = _player.getOriginalX();
				_player.y = _player.getOriginalY();
				_player.setJumpState(false);
				_player.setAccY(0.5);
				_player.setGravity(0.5);
				_player.restoreKeyListeners();
				_flyTime.start();
				
				_brickClip.x = 0;
				_brickClip.y = 0;
				if (_enemyClip)
				{
					_enemyClip.x = 0;
					_enemyClip.y = 0;
				}
				
				_gloveClip.x = 0;
				_gloveClip.y = 0;
				_bg.x = 0;
				//stage.addEventListener(GameEvent.SCROLL_UP, onUpScrollHandle, false, 0, true);
			}
		}
		
		/**
		 * This is the event handler for when a game is over (all lives lost).
		 * @param	e GameEvent object
		 */
		protected function onGameOver(e:GameEvent):void
		{	
			_player.clearAll();
			_deadTime.stop();
			_flyTime.stop();
			_deadTime.removeEventListener(TimerEvent.TIMER, onFlyTime, false);


			for (var i:uint; i < parent.numChildren; i++)
			{
				if (getChildAt(i) is Enemy)
				{
					(getChildAt(i) as Enemy).clearFrameListener();
				}
			}

			stage.removeEventListener(Event.ENTER_FRAME, onFrame, false);
			Global._lives = 5;
			MovieClip(root).gotoAndStop("gameover");
		}
		
		/**
		 * This handles how to navigate levels.
		 * @param	e GameEvent object
		 */
		protected function onLevelUp(e:GameEvent):void
		{	
			_player.clearAll();

			for (var i:uint; i < this.numChildren; i++)
			{
				this.removeChildAt(i);
			}
			_flyTime.stop();
			stage.removeEventListener(Event.ENTER_FRAME, onFrame, false);
			Global._last++;
			MovieClip(root).gotoAndStop(MovieClip(root).currentFrame + 1);
		}
		
		/**
		 * This handles the generation of Flying Enemies on stage.
		 * @param	e TimerEvent object
		 */
		
		protected function onFlyTime(e:TimerEvent):void
		{
			var bmpDat:BitmapData; 
			switch(this.name) {
				case("level2"):
					bmpDat = new elvis(0, 0);
					addChild(new FlyingEnemy(_player, bmpDat));
					break;
				case("level4"):
					bmpDat = new elvis(0, 0);
					addChild(new FlyingEnemy(_player, bmpDat));
					break;
				case("level5"):
					bmpDat = new gary(0, 0);
					addChild(new FlyingEnemy(_player, bmpDat, true));
					break;
			}
			
		}
	}
}