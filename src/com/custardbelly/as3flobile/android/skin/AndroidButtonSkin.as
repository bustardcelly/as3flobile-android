/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidButtonSkin.as</p>
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
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.enum.BasicStateEnum;
	import com.custardbelly.as3flobile.skin.ButtonSkin;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidButtonSkin uses the GraphicLibrary to draw the up and down states of a button targeting Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidButtonSkin extends ButtonSkin
	{
		protected var _upScaleBitmap:ScaleBitmap;
		protected var _downScaleBitmap:ScaleBitmap;
		
		/**
		 * Constructor.
		 */
		public function AndroidButtonSkin()
		{
			super();
			var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.buttonGraphic );
			_upScaleBitmap = new ScaleBitmap( bmd );
			_upScaleBitmap.scale9Grid = new Rectangle( 2, 2, 74, 40 );
			
			bmd = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.buttonDownGraphic );
			_downScaleBitmap = new ScaleBitmap( bmd );
			_downScaleBitmap.scale9Grid = new Rectangle( 2, 2, 74, 40 );
		}
		
		/**
		 * @inherit
		 */
		override protected function initializeBackground(display:Graphics, width:int, height:int):void
		{
			_upScaleBitmap.setSize( width, height );
			display.clear();
			display.beginBitmapFill( _upScaleBitmap.bitmapData );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		override protected function updateBackground(display:Graphics, width:int, height:int):void
		{	
			_upScaleBitmap.setSize( width, height );
			_downScaleBitmap.setSize( width, height );
			
			var isDown:Boolean = ( _currentState == BasicStateEnum.DOWN );
			display.clear();
			display.beginBitmapFill( ( isDown ) ? _downScaleBitmap.bitmapData : _upScaleBitmap.bitmapData );
			display.drawRect( 0, 0, width, height );
			display.endFill();
		}
		
		/**
		 * @inherit
		 */
		override protected function initializeLabel( label:Label, width:int, height:int, padding:int = 0 ):void
		{	
			_originalFormat = label.format;
			var format:ElementFormat = label.format.clone();
			_enabledLabelColor = format.color;
			
			var isDisabled:Boolean = ( _currentState == BasicStateEnum.DISABLED ) || ( _currentState == BasicStateEnum.SELECTED_DISABLED );
			var color:uint = 0x333333;
			if( format.fontDescription.fontName != "DroidSans-Bold" )
			{
				var fontDesc:FontDescription = format.fontDescription.clone();
				fontDesc.fontName = "DroidSans-Bold";
				format.fontDescription = fontDesc;
			}
			format.color = color;
			label.format = format;
			label.textAlign = TextFormatAlign.CENTER;
			updateLabel( label, width, height, padding );
		}
		
		/**
		 * @inherit
		 */
		override protected function updateLabel(label:Label, width:int, height:int, padding:int=0, fromStateChange:Boolean=false):void
		{
			if( label == null ) return;
			
			label.width = width - ( padding * 2 );
			label.x = ( width - label.width ) * 0.5;
			label.y = ( height - label.height ) * 0.5;
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			_upScaleBitmap = null;
			_downScaleBitmap = null;
		}
	}
}