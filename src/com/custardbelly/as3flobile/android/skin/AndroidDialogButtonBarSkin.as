/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDialogButtonBarSkin.as</p>
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
	import com.custardbelly.as3flobile.android.control.dialog.AndroidDialogButtonBar;
	import com.custardbelly.as3flobile.controls.button.Button;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.Graphics;
	
	/**
	 * AndroidDialogButtonBarSkin is a skin for a dialog button bar targeting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidDialogButtonBarSkin extends Skin
	{
		/**
		 * Constructor.
		 */
		public function AndroidDialogButtonBarSkin() { super(); }
		
		/**
		 * @private
		 * 
		 * Updates the background display of the dialog bar. 
		 * @param display GRaphics
		 * @param width int
		 * @param height int
		 */
		protected function updateBackgroundDisplay( display:Graphics, width:int, height:int ):void
		{
			display.clear();
			display.beginFill( 0xBDBDBD );
			display.drawRoundRectComplex( 0, 0, width, height, 0, 0, 10, 10 );
		}
		
		/**
		 * @private
		 * 
		 * Updates the layout of buttons along the dialog button bar. 
		 * @param width int
		 * @param height int
		 */
		protected function updateLayout( width:int, height:int ):void
		{
			const offset:int = 10;
			const maxButtonWidth:int = 136;
			var barTarget:AndroidDialogButtonBar = ( _target as AndroidDialogButtonBar );
			var padding:BoxPadding = barTarget.padding;
			var buttons:Vector.<Button> = barTarget.buttonDisplays;
			
			var length:int = buttons.length;
			var availableSpace:int = ( width - padding.left - padding.right );
			var buttonWidth:int = ( availableSpace - ( ( length - 1 ) * offset ) ) / length;
			buttonWidth = ( buttonWidth > maxButtonWidth ) ? maxButtonWidth : buttonWidth;
			var buttonHeight:int = height - padding.top - padding.bottom;
			
			var i:int;
			var xpos:int = padding.left;
			var ypos:int = ( height - buttonHeight ) * 0.5;
			var button:Button;
			var center:int = width * 0.5;
			// DialogButtonBar accepts a maximum of three buttons. If more is needed, it is recomennded to use a different type of dialog with list selection.
			if( length == 3 )
			{
				setButtonSize( buttons[0], buttonWidth, buttonHeight );
				setButtonPosition( buttons[0], center - ( buttonWidth * 1.5 ) - offset, ypos );
				setButtonSize( buttons[1], buttonWidth, buttonHeight );
				setButtonPosition( buttons[1], center - ( buttonWidth * 0.5 ), ypos );
				setButtonSize( buttons[2], buttonWidth, buttonHeight );
				setButtonPosition( buttons[2], center + ( buttonWidth * 0.5 ) + offset, ypos );
			}
			else if( length == 2 )
			{
				setButtonSize( buttons[0], buttonWidth, buttonHeight );
				setButtonPosition( buttons[0], center - buttonWidth - offset, ypos );
				setButtonSize( buttons[1], buttonWidth, buttonHeight );
				setButtonPosition( buttons[1], center + offset, ypos );
			}
			else if( length == 1 )
			{
				setButtonSize( buttons[0], buttonWidth, buttonHeight );
				setButtonPosition( buttons[0], center - ( buttonWidth * 0.5 ), ypos );
			}
		}
		
		/**
		 * @private
		 * 
		 * Sets the button size of a single button in the button bar. 
		 * @param button Button
		 * @param width int
		 * @param height int
		 */
		protected function setButtonSize( button:Button, width:int, height:int ):void
		{
			button.width = width;
			button.height = height;
		}
		
		/**
		 * @private
		 * 
		 * Sets the position of a single button in the button bar. 
		 * @param button Button
		 * @param x int
		 * @param y int
		 */
		protected function setButtonPosition( button:Button, x:int, y:int ):void
		{
			button.x = x;
			button.y = y;
		}
		
		/**
		 * @inherit
		 */
		override public function updateDisplay(width:int, height:int):void
		{
			super.updateDisplay( width, height );
			
			var barTarget:AndroidDialogButtonBar = ( _target as AndroidDialogButtonBar );
			updateBackgroundDisplay( barTarget.backgroundDisplay, width, height );
			updateLayout( width, height );
		}
	}
}