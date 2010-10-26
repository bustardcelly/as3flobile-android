/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidProgressDialogSkin.as</p>
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
	import com.custardbelly.as3flobile.android.control.progress.AndroidProgressBar;
	import com.custardbelly.as3flobile.android.control.progress.AndroidProgressDialog;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.Graphics;
	import flash.text.Font;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	/**
	 * AndroidProgressDialogSkin is a custom skin for a progress dialog targeting the look-and-feel of the Android platofrm. 
	 * @author toddanderson
	 */
	public class AndroidProgressDialogSkin extends Skin
	{
		/**
		 * Constructor.
		 */
		public function AndroidProgressDialogSkin() { super(); }
		
		/**
		 * @private
		 * 
		 * Updates the background display of the target control. 
		 * @param display Graphics
		 * @param width int
		 * @param height int
		 */
		protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			const lineSize:int = 2;
			const doubleSize:int = 4;
			const radius:int = 10;
			
			display.clear();
			display.beginFill( 0xFFFFFF );
			display.drawRoundRectComplex( 0, 0, width, height, radius, radius, radius, radius );
			display.endFill();
			display.beginFill( 0x414541 );
			display.drawRoundRectComplex( lineSize, lineSize, width - doubleSize, height - doubleSize, radius, radius, radius, radius );
			display.endFill();
		}
		
		/**
		 * @private
		 * 
		 * Initializes the message display format. 
		 * @param display Label
		 * @param width int
		 * @param height int
		 */
		protected function initializeMessageDisplay( display:Label, width:int, height:int ):void
		{
			display.width = width;
			display.format = new ElementFormat( new FontDescription( "DroidSans" ), 14, 0xFFFFFF );
		}
		
		/**
		 * @private
		 * 
		 * Initializes the percent display format. 
		 * @param display Label
		 * @param width int
		 * @param height int
		 */
		protected function initializePercentDisplay( display:Label, width:int, height:int ):void
		{
			display.width = width;
			display.format = new ElementFormat( new FontDescription( "DroidSans" ), 12, 0xDDDDDD );
		}
		
		/**
		 * @private
		 * 
		 * Updates the layout of elements for the target control. 
		 * @param width int
		 * @param height int
		 */
		protected function updateLayout( width:int, height:int ):void
		{
			const offset:int = 5;
			
			var progressTarget:AndroidProgressDialog = ( _target as AndroidProgressDialog );
			var padding:BoxPadding = progressTarget.padding;
			var backgroundDisplay:Graphics = progressTarget.backgroundDisplay;
			var messageField:Label = progressTarget.messageFieldDisplay;
			var percentField:Label = progressTarget.percentFieldDisplay;
			var progressBar:AndroidProgressBar = progressTarget.progressBarDisplay;
			
			var ypos:int = padding.top;
			var displayHeight:int = height;
			var displayWidth:int = width - ( padding.left + padding.bottom );
			
			messageField.width = displayWidth;
			messageField.x = padding.left;
			messageField.y = ypos;
			ypos = messageField.y + messageField.height + offset;
			
			progressBar.width = displayWidth;
			progressBar.x = padding.left;
			progressBar.y = ypos;
			ypos = progressBar.y + progressBar.height + offset;
			
			percentField.width = displayWidth;
			percentField.x = padding.left;
			percentField.y = ypos;
			
			displayHeight = percentField.y + percentField.height + padding.bottom;
			
			updateBackground( backgroundDisplay, width, displayHeight );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initializeDisplay( width:int, height:int ):void
		{
			super.initializeDisplay( width, height );
			
			var progressTarget:AndroidProgressDialog = ( _target as AndroidProgressDialog );
			initializeMessageDisplay( progressTarget.messageFieldDisplay, width, height );
			initializePercentDisplay( progressTarget.percentFieldDisplay, width, height );
			updateLayout( width, height );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function updateDisplay( width:int, height:int ):void
		{
			super.updateDisplay( width, height );
			updateLayout( width, height );
		}
	}
}