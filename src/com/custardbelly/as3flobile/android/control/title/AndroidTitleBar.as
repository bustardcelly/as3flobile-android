/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidTitleBar.as</p>
 * <p>Version: 0.3</p>
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
package com.custardbelly.as3flobile.android.control.title
{
	import com.custardbelly.as3flobile.android.skin.AndroidTitleBarSkin;
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.controls.label.Label;
	
	import flash.display.Graphics;
	
	/**
	 * AndroidTitleBar is a title bar control that targets the look-and-feel of a title bar on the Android Platform. 
	 * @author toddanderson
	 */
	public class AndroidTitleBar extends AS3FlobileComponent
	{
		protected var _label:Label;
		
		/**
		 * Constructor.
		 */
		public function AndroidTitleBar() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 100;
			_height = 25;
			
			updatePadding( 3, 3, 3, 3 );
			
			// Set android skin.
			_skin = new AndroidTitleBarSkin();
			_skin.target = this;
		}
		
		/**
		 * @inherit
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			_label = new Label();
			_label.multiline = false;
			_label.truncate = true;
			addChild( _label );
		}
		
		/**
		 * Returns a reference to the backtround display for this control. 
		 * @return Graphics
		 */
		public function get backgroundDisplay():Graphics
		{
			return graphics;
		}
		/**
		 * Returns a reference to the label display of this control. 
		 * @return Label
		 */
		public function get labelDisplay():Label
		{
			return _label;
		}
		
		/**
		 * Accessor/Modifier for the textual content of the label in this control. 
		 * @return String
		 */
		public function get label():String
		{
			return _label.text;
		}
		public function set label( value:String ):void
		{
			_label.text = value;
		}
	}
}