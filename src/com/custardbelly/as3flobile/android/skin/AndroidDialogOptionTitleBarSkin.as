/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDialogOptionTitleBarSkin.as</p>
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
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	
	import flash.display.BitmapData;
	import flash.display.Shape;

	/**
	 * AndroidDialogOptionTitleBarSkin is an extension of AndroidDialogTitleBarSkin in order to present an option icon in the title bar of the target control. 
	 * @author toddanderson
	 */
	public class AndroidDialogOptionTitleBarSkin extends AndroidDialogTitleBarSkin
	{
		/**
		 * Constructor.
		 */
		public function AndroidDialogOptionTitleBarSkin() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initializeIcon( display:Shape, width:int, height:int ):void
		{
			// Set option icon graphic.
			var graphic:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.dialogOptionIcon );
			if( graphic )
			{
				display.graphics.clear();
				display.graphics.beginBitmapFill( graphic, null, false );
				display.graphics.drawRect( 0, 0, graphic.width, graphic.height );
				display.graphics.endFill();
				_iconWidth = graphic.width;
				_iconHeight = graphic.height;
			}
		}
	}
}