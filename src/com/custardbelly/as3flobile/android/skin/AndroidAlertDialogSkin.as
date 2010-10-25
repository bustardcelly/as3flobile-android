/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidAlertDialogSkin.as</p>
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
	import com.custardbelly.as3flobile.android.control.dialog.AndroidAlertDialog;
	import com.custardbelly.as3flobile.android.control.dialog.AndroidDialogButtonBar;
	import com.custardbelly.as3flobile.android.control.dialog.AndroidDialogTitleBar;
	import com.custardbelly.as3flobile.controls.button.Button;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.enum.DimensionEnum;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	/**
	 * AndroidAlertDialogSkin is a skin target for an IAndroidAlertDialog to provide the look-and-feel targeting the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidAlertDialogSkin extends Skin
	{
		/**
		 * Constructor.
		 */
		public function AndroidAlertDialogSkin() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function clearDisplay():void
		{
			super.clearDisplay();
			var alertTarget:AndroidAlertDialog = ( _target as AndroidAlertDialog );
			alertTarget.backgroundDisplay.clear();
		}
		
		/**
		 * @private
		 * 
		 * Updates the backtround display of the target dialog. 
		 * @param display Graphics
		 * @param width int
		 * @param height int
		 * @param dividerPosition int The position to place the divider if required. Cases may show that since there may be no existance of a title bar in the dailog, then a divider is not rendered.
		 */
		protected function updateBackgroundDisplay( display:Graphics, width:int, height:int, dividerPosition:int ):void
		{
			const lineSize:int = 2;
			const doubleSize:int = 4;
			const radius:int = 10;
			
			// Draw border.
			display.clear();
			display.beginFill( 0xFFFFFF );
			display.drawRoundRectComplex( 0, 0, width, height, radius, radius, radius, radius );
			display.endFill();
			// Draw inner rect.
			display.beginFill( 0x414541 );
			display.drawRoundRectComplex( lineSize, lineSize, width - doubleSize, height - doubleSize, radius, radius, radius, radius );
			display.endFill();
			
			// If we reuire a divider add it to the graphic display.
			if( dividerPosition != DimensionEnum.UNDEFINED )
			{
				var matrix:Matrix = new Matrix();
				matrix.createGradientBox( width, 2, 0 );
				display.lineStyle( 1 );
				display.lineGradientStyle( GradientType.LINEAR, [0x414541, 0xEEEEEE, 0xEEEEEE, 0x414541], [1.0, 1.0, 1.0, 1.0], [0, 75, 180, 255], matrix );
				display.moveTo( lineSize + 1, dividerPosition );
				display.lineTo( width - doubleSize - 1, dividerPosition );
			}
		}
		
		/**
		 * @private
		 * 
		 * Initialized the format for the message dispay. 
		 * @param display Label
		 * @param width int
		 * @param height int
		 */
		protected function initializeMessageDisplay( display:Label, width:int, height:int ):void
		{
			display.format = new ElementFormat( new FontDescription( "DroidSans" ), 14, 0xFFFFFF );
		}
		
		/**
		 * @private
		 * 
		 * Updates the layout of the elements of the target dialog based on their availability on the display list determined by the dialog context. 
		 * @param width int
		 * @param height int
		 */
		protected function updateLayout( width:int, height:int ):void
		{
			const offset:int = 2;
			const space:int = 10;
			const maxButtonWidth:int = 136;
			
			var alertTarget:AndroidAlertDialog = ( _target as AndroidAlertDialog );
			var padding:BoxPadding = alertTarget.padding;
			var titleBar:AndroidDialogTitleBar = alertTarget.titleBarDisplay;
			var message:Label = alertTarget.messageDisplay;
			var buttonBar:AndroidDialogButtonBar = alertTarget.buttonBarDisplay;
			var dividerPosition:int = DimensionEnum.UNDEFINED;
			var yoffset:int = padding.top + offset;
			if( alertTarget.containsDisplay( titleBar ) )
			{
				titleBar.y = yoffset;
				titleBar.x = padding.left + offset;
				titleBar.width = width - ( padding.left + padding.right ) - ( offset * 2 );
				yoffset = titleBar.y + titleBar.height + space;
				// Update for space on divider in background.
				dividerPosition = yoffset;
				yoffset += space;
			}
			
			if( alertTarget.containsDisplay( message ) )
			{
				message.width = width - ( padding.left + padding.right ) - ( offset * 2 );
				message.y = yoffset
				message.x = padding.left + offset;
				yoffset = message.y + message.height + space;
			}
			
			if( alertTarget.containsDisplay( buttonBar ) )
			{
				buttonBar.x = offset;
				buttonBar.y = yoffset;
				buttonBar.width = width - ( offset * 2 );
				yoffset += buttonBar.height + 1;
			}
			else
			{
				yoffset += padding.bottom;
			}
			yoffset += offset;
			// Update th background based on element availability.
			updateBackgroundDisplay( alertTarget.backgroundDisplay, width, yoffset, dividerPosition );
		}
		
		/**
		 * @inherit
		 */
		override public function initializeDisplay( width:int, height:int ):void
		{
			super.initializeDisplay( width, height );
			
			var alertTarget:AndroidAlertDialog = ( _target as AndroidAlertDialog );
			initializeMessageDisplay( alertTarget.messageDisplay, width, height );
			updateLayout( width, height );
		}
		
		/**
		 * @inherit
		 */
		override public function updateDisplay( width:int, height:int ):void
		{
			super.updateDisplay( width, height );
			
			var alertTarget:AndroidAlertDialog = ( _target as AndroidAlertDialog );
			updateLayout( width, height );
		}
	}
}