/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidCheckBoxSkin.as</p>
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
	import com.custardbelly.as3flobile.controls.button.ToggleButton;
	import com.custardbelly.as3flobile.controls.checkbox.CheckBox;
	import com.custardbelly.as3flobile.skin.CheckBoxSkin;
	
	/**
	 * AndroidCheckBoxSkin uses the GraphicLibrary assets to target the Android look-and-feel of a checkbox. 
	 * @author toddanderson
	 */
	public class AndroidCheckBoxSkin extends CheckBoxSkin
	{
		/**
		 * Constructor.
		 */
		public function AndroidCheckBoxSkin() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initializeBoxToggle( display:ToggleButton, width:int, height:int ):void
		{
			// Set skin to toggle skin for check box.
			display.skin = new AndroidCheckBoxToggleSkin();
			
			const maxSize:int = 34;
			var size:int = ( height > maxSize ) ? maxSize : height;
			display.width = size;
			display.height = size;
		}
		
		/**
		 * Updates the box toggle display. 
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
			var checkBoxTarget:CheckBox = ( _target as CheckBox );
			updateBoxToggle( checkBoxTarget.boxDisplay, width, height );
			super.updateDisplay( width, height );
		}
	}
}