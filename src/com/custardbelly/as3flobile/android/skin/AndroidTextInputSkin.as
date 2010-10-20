/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidTextInputSkin.as</p>
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
	import com.custardbelly.as3flobile.controls.textinput.TextInput;
	import com.custardbelly.as3flobile.enum.BasicStateEnum;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.TextInputSkin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidTextInputSkin uses the GraphicLibrary to skin a textinput targeting the Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidTextInputSkin extends TextInputSkin
	{
		protected var _unfocusedBitmap:ScaleBitmap;
		protected var _focusedBitmap:ScaleBitmap;
		
		/**
		 * Constructor.
		 */
		public function AndroidTextInputSkin()
		{
			super();
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.textInputBackground );
			_unfocusedBitmap = new ScaleBitmap( bmd );
			_unfocusedBitmap.scale9Grid = new Rectangle( 6, 6, 172, 32 );
			
			bmd = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.textInputFocused );
			_focusedBitmap = new ScaleBitmap( bmd );
			_focusedBitmap.scale9Grid = new Rectangle( 6, 6, 172, 32 );
		}
		
		/**
		 * @inherit
		 */
		override protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			_unfocusedBitmap.setSize( width, height );
			_focusedBitmap.setSize( width, height );
			
			var isFocused:Boolean = ( _currentState == BasicStateEnum.FOCUSED );
			display.clear();
			display.beginBitmapFill( ( isFocused ) ? _focusedBitmap.bitmapData : _unfocusedBitmap.bitmapData );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		/**
		 * @inherit
		 */
		override protected function updateClearDisplay( display:Sprite, width:int, height:int ):void
		{
			display.graphics.clear();
		}
		
		/**
		 * @inherit
		 */
		override protected function updatePosition( width:int, height:int ):void
		{
			const offset:int = 8;
			var padding:BoxPadding = _target.padding;
			var inputTarget:TextInput = ( _target as TextInput );
			var inputDisplay:TextField = inputTarget.inputDisplay;
			
			// Update input size and position.
			inputDisplay.width = width - ( offset + padding.right );
			inputDisplay.x = offset;
			
			// Base height on multiline.
			if( inputDisplay.multiline )
			{
				inputDisplay.height = height - ( offset * 2 );
				inputDisplay.y = offset;
			}
			else
			{
				// Base height on font size. This will be overwritten if multiline is true on input.
				var fontSize:int = ( _target.skinState == BasicStateEnum.NORMAL ) ? int(_defaultFormat.size) : int(_boilerFormat.size);
				inputDisplay.height = ( fontSize * 2 );
				inputDisplay.y = ( height - ( fontSize * 1.5 ) ) * 0.5;
			}
		}
	}
}