/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidContextMenuItemRendererSkin.as</p>
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
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.controls.list.renderer.DefaultScrollListItemRenderer;
	import com.custardbelly.as3flobile.controls.list.renderer.IScrollListItemRenderer;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.ScrollListItemRendererSkin;
	
	import flash.display.Graphics;
	
	/**
	 * AndroidContextMenuItemRendererSkin is a skin for the item renderer of a context menu targting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidContextMenuItemRendererSkin extends ScrollListItemRendererSkin
	{
		/**
		 * Constructor.
		 */
		public function AndroidContextMenuItemRendererSkin() { super(); }
		
		/**
		 * @inheritDoc
		 */
		override protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			display.clear();
			display.beginFill( 0xFFFFFF );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateLayout( width:int, height:int ):void
		{
			var itemTarget:IScrollListItemRenderer = ( _target as IScrollListItemRenderer );
			var padding:BoxPadding = _target.padding;
			var label:Label = ( _target as DefaultScrollListItemRenderer ).labelDisplay;
			
			label.x = padding.left;
			label.y = ( height - label.height ) * 0.5;
		}
	}
}