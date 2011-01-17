/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidProgressBar.as</p>
 * <p>Version: 0.4</p>
 *
 * <p>Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:</p>
 *
 * <p>The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.</p>
 *
 * <p>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.</p>
 *
 * <p>Licensed under The MIT License</p>
 * <p>Redistributions of files must retain the above copyright notice.</p>
 */
package com.custardbelly.as3flobile.android.control.progress
{
	import com.custardbelly.as3flobile.android.skin.AndroidProgressBarSkin;
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	
	/**
	 * AndroidProgressBar is a display representing the load/progress of an operation targeting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidProgressBar extends AS3FlobileComponent
	{
		protected var _bar:Shape;
		protected var _percent:Number;
		
		/**
		 * Constructor.
		 */
		public function AndroidProgressBar() { super(); }
		
		/**
		 * @inheritDoc
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 120;
			_height = 14;
			
			_skin = new AndroidProgressBarSkin();
			_skin.target = this;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			_bar = new Shape();
			addChild( _bar );
		}
		
		/**
		 * Returns reference of background display. 
		 * @return Graphics
		 */
		public function get backgroundDisplay():Graphics
		{
			return graphics;
		}
		
		/**
		 * Returns reference of bar display. 
		 * @return Graphics
		 */
		public function get barDisplay():Graphics
		{
			return _bar.graphics;
		}
		
		/**
		 * Accessor/Modifier of the percent of completion. Valid values are from 0 to 1. 
		 * @return Number
		 */
		public function get percent():Number
		{
			return _percent;
		}
		public function set percent( value:Number ):void
		{
			if( _percent == value ) return;
			
			_percent = value;
			invalidate( updateDisplay );
		}
	}
}