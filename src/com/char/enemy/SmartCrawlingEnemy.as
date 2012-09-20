package com.char.enemy {
	import com.char.enemy.CrawlingEnemy;
	import com.char.hit.HitSpot;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class SmartCrawlingEnemy extends CrawlingEnemy
	{
		public function SmartCrawlingEnemy()
		{
			super();
		}
		
		private function onFrame(e:Event):void
		{
			if (speedX > 0)
			{
				if (stage.getObjectsUnderPoint(new Point(this.x + this.width + 2, this.y + 5)) is HitSpot)
				{
					flipHorizontal();
					_speedX = -_speedX;
				}
				else
				{
					this.x += _speedX;
				}
			}
			else
			{
				if (stage.getObjectsUnderPoint(new Point(this.x - 2, this.y + 5)) is HitSpot)
				{
					flipHorizontal();
					_speedX = -_speedX;
				}
				else
				{
					this.x += _speedX;
				}
			}
		}
	}