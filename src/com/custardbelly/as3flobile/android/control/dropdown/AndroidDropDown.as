/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDropDown.as</p>
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
package com.custardbelly.as3flobile.android.control.dropdown
{
	import com.custardbelly.as3flobile.android.control.list.AndroidScrollList;
	import com.custardbelly.as3flobile.android.skin.AndroidDropDownSkin;
	import com.custardbelly.as3flobile.controls.dropdown.DropDown;
	import com.custardbelly.as3flobile.controls.list.ScrollList;
	import com.custardbelly.as3flobile.controls.list.layout.IScrollListVerticalLayout;
	import com.custardbelly.as3flobile.controls.list.layout.ScrollListVerticalLayout;
	
	import flash.geom.Rectangle;
	
	/**
	 * AndroidDropDown is a convenient control that wires up the composited Android-targetted controls and skins. 
	 * @author toddanderson
	 */
	public class AndroidDropDown extends DropDown
	{
		/**
		 * Constructor.
		 */
		public function AndroidDropDown() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_height = 44;
			
			// Set Android skin.
			_skin = new AndroidDropDownSkin();
			_skin.target = this;
		}
		
		/**
		 * @inherit
		 */
		override protected function getDropDownList():ScrollList
		{
			if( _dropDownList == null )
			{
				var layout:IScrollListVerticalLayout = new ScrollListVerticalLayout();
				layout.itemHeight = 48;
				// Set Android skin.
				_dropDownList = AndroidScrollList.initWithScrollRect( new Rectangle( 0, 0, _dropDownWidth, _dropDownHeight ) );
				_dropDownList.selectionChange.add( listSelectionChange );
				_dropDownList.layout = layout;
			}
			return _dropDownList;
		}
	}
}