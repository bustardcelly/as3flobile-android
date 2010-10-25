/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDialogTitleBarSkin.as</p>
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
package com.custardbelly.as3flobile.android.skin
{
	import com.custardbelly.as3flobile.android.control.dialog.AndroidDialogTitleBar;
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidDialogAlertTitleBarSkin is a title bar skin for a dialog targeting the look-and-feel of the Android platofrm. 
	 * @author toddanderson
	 */
	public class AndroidDialogTitleBarSkin extends Skin
	{
		protected var _iconWidth:int;
		protected var _iconHeight:int;
		
		/**
		 * Constructor.
		 */
		public function AndroidDialogTitleBarSkin() { super(); }
		
		/**
		 * Initializes the format for the lable in the target control.  
		 * @param display Label
		 * @param width int
		 * @param height int
		 */
		protected function initializeLabel( display:Label, width:int, height:int ):void
		{
			display.format = new ElementFormat( new FontDescription( "DroidSans" ), 20, 0xFFFFFF );
		}
		
		/**
		 * Initializes the icon display from the GraphicLibrary. 
		 * @param display Shape
		 * @param width int
		 * @param height int
		 */
		protected function initializeIcon( display:Shape, width:int, height:int ):void
		{
			display.graphics.clear();
		}
		
		/**
		 * @private
		 * 
		 * Updates the layout of elements in the target control. 
		 * @param width int
		 * @param height int
		 */
		protected function updateLayout( width:int, height:int ):void
		{
			const offset:int = 10;
			
			var bar:AndroidDialogTitleBar = ( _target as AndroidDialogTitleBar );
			var padding:BoxPadding = bar.padding;
			var icon:Shape = bar.iconDisplay;
			var label:Label = bar.labelDisplay;
			
			icon.x = padding.left;
			icon.y = padding.top;
			
			label.x = icon.x + _iconWidth + offset;
			label.width = width - label.x - padding.right;
			label.y = icon.y + ( _iconHeight - label.height ) * 0.5;
		}
		
		/**
		 * @inherit
		 */
		override public function initializeDisplay( width:int, height:int ):void
		{
			super.initializeDisplay( width, height );
			
			var bar:AndroidDialogTitleBar = ( _target as AndroidDialogTitleBar );
			initializeLabel( bar.labelDisplay, width, height );
			initializeIcon( bar.iconDisplay, width, height );
			updateLayout( width, height );
		}
		
		/**
		 * @inherit
		 */
		override public function updateDisplay( width:int, height:int ):void
		{
			super.updateDisplay( width, height );
			updateLayout( width, height );
		}
	}
}