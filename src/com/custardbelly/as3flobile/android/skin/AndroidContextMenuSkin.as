/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidContextMenuSkin.as</p>
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
	import com.custardbelly.as3flobile.android.control.contextmenu.AndroidContextMenu;
	import com.custardbelly.as3flobile.controls.list.ScrollList;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.Graphics;
	
	/**
	 * AndroidContextMenuSkin is a custom skin for a context menu targeting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidContextMenuSkin extends Skin
	{
		/**
		 * Constructor.
		 */
		public function AndroidContextMenuSkin() { super(); }
		
		/**
		 * @private
		 * 
		 * Updates the background display of the target control. 
		 * @param display Graphics
		 * @param width int
		 * @param height int
		 */
		protected function updateBackgroundDisplay( display:Graphics, width:int, height:int ):void
		{
			const radius:int = 10;
			display.clear();
			display.beginFill( 0xFFFFFF );
			display.drawRoundRectComplex( 0, 0, width, height, radius, radius, radius, radius );
			display.endFill();
		}
		
		/**
		 * @private
		 * 
		 * Updates the layout of the target control.  
		 * @param width int
		 * @param height int
		 */
		protected function updateLayout( width:int, height:int ):void
		{
			var menuTarget:AndroidContextMenu = ( _target as AndroidContextMenu );
			var padding:BoxPadding = menuTarget.padding;
			var list:ScrollList = menuTarget.listDisplay;
			
			list.x = padding.left;
			list.y = padding.top;
			list.width = width - padding.left - padding.right;
			list.height = height - list.y - padding.bottom;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initializeDisplay(width:int, height:int):void
		{
			super.initializeDisplay( width, height );
			
			var menuTarget:AndroidContextMenu = ( _target as AndroidContextMenu );
			updateBackgroundDisplay( menuTarget.backgroundDisplay, width, height );
			updateLayout( width, height );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function updateDisplay(width:int, height:int):void
		{
			super.updateDisplay( width, height );
			
			var menuTarget:AndroidContextMenu = ( _target as AndroidContextMenu );
			updateBackgroundDisplay( menuTarget.backgroundDisplay, width, height );
			updateLayout( width, height );
		}
	}
}