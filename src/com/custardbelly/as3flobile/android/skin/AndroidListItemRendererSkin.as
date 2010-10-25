/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidListItemRendererSkin.as</p>
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
	import com.custardbelly.as3flobile.enum.BasicStateEnum;
	import com.custardbelly.as3flobile.enum.OrientationEnum;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.ScrollListItemRendererSkin;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * AndroidListItemRendererSkin uses the GraphicLibrary to skin an item renderer targeting the Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidListItemRendererSkin extends ScrollListItemRendererSkin
	{
		protected var _fillMatrix:Matrix;
		protected var _lineMatrix:Matrix;
		
		/**
		 * Constructor.
		 */
		public function AndroidListItemRendererSkin() 
		{ 
			super();
			_fillMatrix = new Matrix();
			_lineMatrix = new Matrix();
		}
		
		/**
		 * @inherit
		 */
		override protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			const lineHeight:int = 1;
			
			var itemTarget:IScrollListItemRenderer = ( _target as IScrollListItemRenderer );
			var isHorizontalOrientation:Boolean = itemTarget.orientation == OrientationEnum.HORIZONTAL;
			
			var isSelected:Boolean = ( _target.skinState == BasicStateEnum.SELECTED );
			display.clear();
			// If selected, draw a gradient background of orange selection common on Android.
			if( isSelected )
			{
				_fillMatrix.createGradientBox( width, height, ( isHorizontalOrientation ) ? 0 : Math.PI * 0.5 );
				display.beginGradientFill( GradientType.LINEAR, [0xF26B04, 0xED9121, 0xED9121, 0xF26B04], [1.0, 1.0, 1.0, 1.0], [0, 38, 217, 255], _fillMatrix );
			}
			// Else just fill with white.
			else
			{
				display.beginFill( 0xFFFFFF );	
			}
			display.drawRect( 0, 0, width, height );
			display.endFill();
			
			// Draw seperator.
			// If horiztonal orientation. draw divider to the right.
			if( isHorizontalOrientation )
			{
				_lineMatrix.createGradientBox( lineHeight, height, Math.PI * 0.5 );
				display.beginGradientFill( GradientType.LINEAR, [0xFFFFFF, 0x999999, 0x999999, 0xFFFFFF], [1.0, 1.0, 1.0, 1.0], [0, 38, 217, 255], _lineMatrix );
				display.drawRect( width - lineHeight, 0, lineHeight, height );
				display.endFill();
			}
			// Else place on bottom.
			else
			{
				_lineMatrix.createGradientBox( width, lineHeight, 0 );
				display.beginGradientFill( GradientType.LINEAR, [0xFFFFFF, 0x999999, 0x999999, 0xFFFFFF], [1.0, 1.0, 1.0, 1.0], [0, 38, 217, 255], _lineMatrix );
				display.drawRect( 0, height - lineHeight, width, lineHeight );	
				display.endFill();
			}
		}
		
		/**
		 * @inherit
		 */
		override protected function updatePosition( width:int, height:int ):void
		{
			var itemTarget:IScrollListItemRenderer = ( _target as IScrollListItemRenderer );
			var padding:BoxPadding = _target.padding;
			var labelDisplay:Label = ( itemTarget as DefaultScrollListItemRenderer ).labelDisplay;
			
			labelDisplay.x = padding.left;
			labelDisplay.width = width - labelDisplay.x - padding.right;
			labelDisplay.y = ( height - labelDisplay.measuredHeight ) * 0.5;
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			_fillMatrix = null;
			_lineMatrix = null;
		}
	}
}