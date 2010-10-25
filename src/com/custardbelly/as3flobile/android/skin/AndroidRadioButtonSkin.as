/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidRadioButtonSkin.as</p>
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
	import com.custardbelly.as3flobile.controls.button.ToggleButton;
	import com.custardbelly.as3flobile.controls.radiobutton.RadioButton;
	import com.custardbelly.as3flobile.skin.RadioButtonSkin;
	
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	/**
	 * AndroidRadioButtonSkin is a skin for a radio button targeting the Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidRadioButtonSkin extends RadioButtonSkin
	{
		/**
		 * Constructor.
		 */
		public function AndroidRadioButtonSkin()
		{
			_normalLabelFormat = new ElementFormat( new FontDescription( "DroidSans" ), 14 );
			_selectedLabelFormat = new ElementFormat( new FontDescription( "DroidSans" ), 14 );
		}
		
		/**
		 * @inherit
		 */
		override protected function initializeBoxToggle( display:ToggleButton, width:int, height:int ):void
		{
			display.skin = new AndroidRadioButtonToggleSkin();
			
			const maxSize:int = 34;
			var size:int = ( height > maxSize ) ? maxSize : height;
			display.width = size;
			display.height = size;
		}
		
		/**
		 * Updates the toggle box display. 
		 * @param display ToggleButton
		 * @param width int
		 * @param height int
		 */
		protected function updateBoxToggle( display:ToggleButton, width:int, height:int ):void
		{
			const maxSize:int = 34;
			var size:int = ( height > maxSize ) ? maxSize : height;
			display.width = size;
			display.height = size;
		}
		
		/**
		 * @inherit
		 */
		override public function updateDisplay( width:int, height:int ):void
		{
			var radioTarget:RadioButton = ( _target as RadioButton );
			updateBoxToggle( radioTarget.radioDisplay, width, height );
			super.updateDisplay( width, height );
		}
	}
}