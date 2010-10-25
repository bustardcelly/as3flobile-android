/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: IMenuLayoutTarget.as</p>
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
package com.custardbelly.as3flobile.android.control.menu.layout
{
	import com.custardbelly.as3flobile.android.control.menu.renderer.IMenuItemRenderer;
	import com.custardbelly.as3flobile.controls.shape.Divider;
	import com.custardbelly.as3flobile.model.BoxPadding;

	/**
	 * IMenuLayoutTarget is the target display for which an IMenuLayout corresponds to layout items on its display. 
	 * @author toddanderson
	 */
	public interface IMenuLayoutTarget
	{
		/**
		 * Adds a divider to the display based on layout positioning. 
		 * @param width int
		 * @param height int
		 */
		function addDivider():Divider;
		
		/**
		 * Returns the list of IMenuItemRenderer views. 
		 * @return IMenuItemRenderer
		 */
		function get items():Vector.<IMenuItemRenderer>;
		
		/**
		 * Accessor/Modifier for the maximum item amount in the display. 
		 * @return uint
		 */
		function get maximumItemDisplayAmount():uint;
		function set maximumItemDisplayAmount( value:uint ):void;
		
		/**
		 * Returns the BoxPadding of the instance. 
		 * @return BoxPadding
		 */
		function get padding():BoxPadding;
	}
}