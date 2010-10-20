/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidScrollBarSkin.as</p>
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
package com.custardbelly.as3flobile.android.skin
{
	import com.custardbelly.as3flobile.android.control.scrollbar.AndroidScrollBar;
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.enum.OrientationEnum;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidScrollBarSkin uses the GraphicLibrary to skin a scrolbar targeting the Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidScrollBarSkin extends Skin
	{
		protected var _verticalScrollBarBitmap:ScaleBitmap;
		protected var _horizontalScrollBarBitmap:ScaleBitmap;
		
		/**
		 * Constructor.
		 */
		public function AndroidScrollBarSkin() { super(); }
		
		/**
		 * @private 
		 * 
		 * Lazily creates the vertical scale bitmap for vertical orientation.
		 */
		protected function createVerticalBitmap():void
		{
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.verticalScrollbar );
			_verticalScrollBarBitmap = new ScaleBitmap( bmd );
			_verticalScrollBarBitmap.scale9Grid = new Rectangle( 2, 4, 3, 211 );
		}
		
		/**
		 * @private 
		 * 
		 * Lazily creates the horizontal scale bitmap for horizontal orientation.
		 */
		protected function createHorizontalBitmap():void
		{
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.horizontalScrollbar );
			_horizontalScrollBarBitmap = new ScaleBitmap( bmd );
			_horizontalScrollBarBitmap.scale9Grid = new Rectangle( 4, 2, 211, 3 );
		}
		
		/**
		 * @private
		 * 
		 * Updates the background scroll display. 
		 * @param display Graphics
		 * @param width int
		 * @param height int
		 */
		protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			var bitmapData:BitmapData;
			var isHorizontalOrientation:Boolean = ( _target as AndroidScrollBar ).orientation == OrientationEnum.HORIZONTAL;
			if( isHorizontalOrientation )
			{
				if( _horizontalScrollBarBitmap == null )
					createHorizontalBitmap();
				
				_horizontalScrollBarBitmap.setSize( width, height );
				bitmapData = _horizontalScrollBarBitmap.bitmapData;
			}
			else
			{
				if( _verticalScrollBarBitmap == null )
					createVerticalBitmap();
				
				_verticalScrollBarBitmap.setSize( width, height );
				bitmapData = _verticalScrollBarBitmap.bitmapData;
			}
			
			display.clear();
			display.beginBitmapFill( bitmapData );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		/**
		 * @inherit
		 */
		override public function updateDisplay( width:int, height:int ):void
		{
			super.updateDisplay( width, height );
			
			updateBackground( ( _target as AndroidScrollBar ).graphics, width, height );
		}
	}
}