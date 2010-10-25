/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDialogTitleBar.as</p>
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
package com.custardbelly.as3flobile.android.control.dialog
{
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.controls.label.Label;
	
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	
	/**
	 * AndroidDialogTitleBar is a title bar for a dialog control tageting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidDialogTitleBar extends AS3FlobileComponent
	{
		protected var _icon:Shape;
		protected var _label:Label;
		protected var _title:String;
		
		/**
		 * Constructor.
		 */
		public function AndroidDialogTitleBar() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 240;
			_height = 100;
			
			updatePadding( 0, 0, 0, 0 );
			
			// * [NOTE]
			// No default skin is applied. 
			// It is required that the client instantiating this control supply a proper skin that details icon and title formatting.
		}
		
		/**
		 * @inherit
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			_icon = new Shape();
			addChild( _icon );
			
			_label = new Label();
			_label.multiline = false;
			_label.autosize = false;
			_label.truncate = true;
			addChild( _label );
		}
		
		/**
		 * @inherit
		 */
		override protected function invalidateSize():void
		{
			super.invalidateSize();
			
			// This title bar height is based on its content rather than the supplied height property.
			if( isOnDisplayList() )
			{
				var bounds:Rectangle = getBounds( parent );
				_height = bounds.height + _padding.bottom;
			}
		}
		
		/**
		 * @private
		 * 
		 * Validates the textual title content for this control.
		 */
		protected function invalidateTitle():void
		{
			_label.text = _title;
			updateDisplay();
		}
		
		/**
		 * Returns a reference to the optional icon to be displayed in this control. Icon is updated by custom skin provided. 
		 * @return Shape
		 */
		public function get iconDisplay():Shape
		{
			return _icon;
		}
		
		/**
		 * Returns a reference to the label dispay used in this control. 
		 * @return Label
		 */
		public function get labelDisplay():Label
		{
			return _label;
		}
		
		/**
		 * Accessor/Modifier of the textua title content to display in this control. 
		 * @return String
		 */
		public function get title():String
		{
			return _title;
		}
		public function set title( value:String ):void
		{
			if( _title == value ) return;
			
			_title = value;
			invalidateTitle();
		}
	}
}