/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidProgressBarSkin.as</p>
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
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.skin.Skin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidProgressBarSkin is a skin for a progress bar targeting the loo-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidProgressBarSkin extends Skin
	{
		protected var _scaleBitmap:ScaleBitmap;
		
		/**
		 * Constructor.
		 */
		public function AndroidProgressBarSkin() 
		{ 
			super();
			
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.titleBarGraphic );
			_scaleBitmap = new ScaleBitmap( bmd );
			_scaleBitmap.scale9Grid = new Rectangle( 2, 2, 316, 21 );
		}
		
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
			const radius:int = 3;
			_scaleBitmap.setSize( width, height );
			display.clear();
			display.beginBitmapFill( _scaleBitmap.bitmapData );
			display.drawRoundRectComplex( 0, 0, width, height, radius, radius, radius, radius );
			display.endFill(); 
		}
		
		/**
		 * @private
		 * 
		 * Updates the bar display of the target control. 
		 * @param display Graphics
		 * @param width int
		 * @param height int
		 */
		protected function updateBarDisplay( display:Graphics, width:int, height:int ):void
		{
			const radius:int = 3;
			display.clear();
			display.beginFill( 0xFFD13A );
			display.drawRoundRectComplex( 0, 0, width, height, radius, 0, radius, 0 );
			display.endFill();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function initializeDisplay( width:int, height:int ):void
		{
			super.initializeDisplay( width, height );
			
			var progressTarget:AndroidProgressBar = ( _target as AndroidProgressBar );
			updateBackgroundDisplay( progressTarget.backgroundDisplay, width, height );
			updateBarDisplay( progressTarget.barDisplay, width * progressTarget.percent, height ); 
		}
		
		/**
		 * @inheritDoc
		 */
		override public function updateDisplay( width:int, height:int ):void
		{
			super.updateDisplay( width, height );
			
			var progressTarget:AndroidProgressBar = ( _target as AndroidProgressBar );
			updateBackgroundDisplay( progressTarget.backgroundDisplay, width, height );
			updateBarDisplay( progressTarget.barDisplay, width * progressTarget.percent, height );
		}
	}
}