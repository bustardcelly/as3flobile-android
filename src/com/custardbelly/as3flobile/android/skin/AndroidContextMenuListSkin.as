/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidContextMenuListSkin.as</p>
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
	import com.custardbelly.as3flobile.skin.ScrollListSkin;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * AndroidContextMenuListSkin is a skin for the list of a context menu targeting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidContextMenuListSkin extends ScrollListSkin
	{
		/**
		 * Constructor.
		 */
		public function AndroidContextMenuListSkin() { super(); }
		
		/**
		 * @inheritDoc
		 */
		override protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox( width, height );
			
			display.clear();
			display.beginGradientFill( GradientType.LINEAR, [0xFFFFFF, 0x999999, 0x999999, 0xFFFFFF], [1.0, 1.0, 1.0, 1.0], [0, 38, 217, 255], matrix );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
	}
}