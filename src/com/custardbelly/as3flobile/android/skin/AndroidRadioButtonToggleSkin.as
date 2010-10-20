/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidRadioButtonToggleSkin.as</p>
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
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.enum.BasicStateEnum;
	import com.custardbelly.as3flobile.skin.RadioButtonToggleSkin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidRadioButtonToggleSkin uses the GraphicLibrary to skin a the radio toggle targeting the Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidRadioButtonToggleSkin extends RadioButtonToggleSkin
	{
		protected var _unselectedBitmap:ScaleBitmap;
		protected var _selectedBitmap:ScaleBitmap;
		
		/**
		 * Constructor.
		 */
		public function AndroidRadioButtonToggleSkin()
		{
			super();
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.radioUnselected );
			_unselectedBitmap = new ScaleBitmap( bmd );
			_unselectedBitmap.scale9Grid = new Rectangle( 1, 1, 33, 33 );
			
			bmd = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.radioSelected );
			_selectedBitmap = new ScaleBitmap( bmd );
			_selectedBitmap.scale9Grid = new Rectangle( 1, 1, 33, 33 );
		}
		
		/**
		 * @inherit
		 */
		override protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			if( display == null ) return;
			
			_unselectedBitmap.setSize( width, height );
			_selectedBitmap.setSize( width, height );
			
			var isSelected:Boolean = ( _currentState == BasicStateEnum.SELECTED );
			display.clear();
			display.beginBitmapFill( ( isSelected ) ? _selectedBitmap.bitmapData : _unselectedBitmap.bitmapData );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			_unselectedBitmap = null;
			_selectedBitmap = null;
		}
	}
}