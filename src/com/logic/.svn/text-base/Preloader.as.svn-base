package com.logic {
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	import flash.text.TextField;
	import flash.text.TextField;
	
	/**
	 * The preloader to the game.
	 * @author ...
	 */
	public class Preloader extends MovieClip
	{
		//----------------------Private Variables-----------------------------------------
		private var _root:MovieClip;
		private var loadFld:TextField;
		
		public function Preloader()
		{
			loadFld = addChild(new TextField()) as TextField;
			
			loadFld.x = 400;
			loadFld.y = 200;
			loadFld.text = "Loading 0";
			
			stop();
			_root = MovieClip(root);
			_root.loaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoading, false, 0, true);
		}
		
		private function onLoading(e:ProgressEvent):void
		{
			loadFld.text = "Loading " + (e.bytesLoaded / e.bytesTotal);
			if (e.bytesLoaded == e.bytesTotal)
			{
				
				_root.play();
			}
		}
	}
	
}
}