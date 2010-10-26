/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidContextMenuItemRenderer.as</p>
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
package com.custardbelly.as3flobile.android.renderer
{
	import com.custardbelly.as3flobile.android.skin.AndroidContextMenuItemRendererSkin;
	import com.custardbelly.as3flobile.controls.list.renderer.DefaultScrollListItemRenderer;
	import com.custardbelly.as3flobile.enum.BasicStateEnum;
	import com.custardbelly.as3flobile.model.BoxPadding;
	
	/**
	 * AndroidContextMenuItemRenderer is an item renderer for a context menu to target the look-and-feel of the Android platform.
	 * AndroidContextMenuItemRenderer is considered more of a convenience class to easily drop in. No new functionality is incorporated, just skin and size/position.
	 * @author toddanderson
	 */
	public class AndroidContextMenuItemRenderer extends DefaultScrollListItemRenderer
	{
		/**
		 * Constructor.
		 */
		public function AndroidContextMenuItemRenderer() { super(); }
		
		/**
		 * @inheritDoc
		 */
		override protected function initialize():void
		{
			// Override without super to just set a custom skin and padding/size properties.
			_padding = new BoxPadding();
			_skinState = BasicStateEnum.NORMAL;
			_enabled = true;
			
			this.cacheAsBitmap = true;
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			_width = 300;
			_height = 54;
			
			updatePadding( 5, 5, 5, 5 );
			
			_skin = new AndroidContextMenuItemRendererSkin();
			_skin.target = this;
		}
	}
}