/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidTitleBarSkin.as</p>
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
	import com.custardbelly.as3flobile.android.control.title.AndroidTitleBar;
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontWeight;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidTitleBar skin uses the ScaleBitmap to skin a title bar targeting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidTitleBarSkin extends Skin
	{
		protected var _scaleBitmap:ScaleBitmap;
		protected var _originalTitleFormat:ElementFormat;
		
		/**
		 * Constructor.
		 */
		public function AndroidTitleBarSkin() 
		{ 
			super(); 
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.titleBarGraphic );
			_scaleBitmap = new ScaleBitmap( bmd );
			_scaleBitmap.scale9Grid = new Rectangle( 2, 2, 316, 21 );
		}
		
		override protected function clearDisplay():void
		{
			super.clearDisplay();
			var titleBarTarget:AndroidTitleBar = ( _target as AndroidTitleBar );
			titleBarTarget.labelDisplay.format = _originalTitleFormat;
			titleBarTarget.backgroundDisplay.clear();
		}
		
		/**
		 * @private
		 * 
		 * Initializes the label format for the title bar. 
		 * @param display Label
		 * @param width int
		 * @param height int
		 */
		protected function initializeLabel( display:Label, width:int, height:int ):void
		{
			_originalTitleFormat = display.format;
			var format:ElementFormat = _originalTitleFormat.clone();
			format.fontDescription = new FontDescription( "_sans", FontWeight.BOLD );
			format.color = 0xFFFFFF;
			display.format = format;
		}
		
		/**
		 * @private
		 * 
		 * Updates the background display for the title bar. 
		 * @param display Graphics
		 * @param width int
		 * @param height int
		 */
		protected function updateBackground( display:Graphics, width:int, height:int ):void
		{
			_scaleBitmap.setSize( width, height );
			display.clear();
			display.beginBitmapFill( _scaleBitmap.bitmapData );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		/**
		 * @private
		 * 
		 * UPdates the layout of elements in the title bar. 
		 * @param width int
		 * @param height int
		 */
		protected function updateLayout( width:int, height:int ):void
		{
			var titleBar:AndroidTitleBar = ( _target as AndroidTitleBar );
			var padding:BoxPadding = titleBar.padding;
			var labelDisplay:Label = titleBar.labelDisplay;
			labelDisplay.width = width;
			labelDisplay.x = padding.left;
			labelDisplay.y = ( height - labelDisplay.height ) * 0.5;
		}
		
		/**
		 * @inherit
		 */
		override public function initializeDisplay(width:int, height:int):void
		{
			super.initializeDisplay( width, height );
			
			var titleBar:AndroidTitleBar = ( _target as AndroidTitleBar );
			updateBackground( titleBar.backgroundDisplay, width, height );
			initializeLabel( titleBar.labelDisplay, width, height );
			updateLayout( width, height );
		}
		
		/**
		 * @inherit
		 */
		override public function updateDisplay(width:int, height:int):void
		{
			super.updateDisplay( width, height );
			
			var titleBar:AndroidTitleBar = ( _target as AndroidTitleBar );
			updateBackground( titleBar.backgroundDisplay, width, height );
			updateLayout( width, height );
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			_scaleBitmap = null;
			_originalTitleFormat = null;
		}
	}
}