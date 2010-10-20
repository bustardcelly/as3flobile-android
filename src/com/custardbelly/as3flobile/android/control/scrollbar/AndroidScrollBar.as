/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidScrollBar.as</p>
 * <p>Version: 0.1</p>
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
package com.custardbelly.as3flobile.android.control.scrollbar
{
	import com.custardbelly.as3flobile.android.skin.AndroidScrollBarSkin;
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.enum.OrientationEnum;
	
	/**
	 * AndroidScrollBar is a base class for scrollbar controls whose skin renders based on orientation. 
	 * @author toddanderson
	 */
	public class AndroidScrollBar extends AS3FlobileComponent
	{
		protected var _orientation:int;
		
		/**
		 * Constructor.
		 */
		public function AndroidScrollBar() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_orientation = OrientationEnum.VERTICAL;
			
			_skin = new AndroidScrollBarSkin();
			_skin.target = this;
		}
		
		/**
		 * Accessor/Modifier for the orientation of this item renderer based on the layout of parenting list.
		 * Valid values are from OrientationEnum
		 * @return int
		 */
		public function get orientation():int
		{
			return _orientation;
		}
		public function set orientation(value:int):void
		{
			if( _orientation == value ) return;
			
			_orientation = value;
			updateDisplay();
		}
	}
}