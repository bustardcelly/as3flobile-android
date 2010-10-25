/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDropDownSkin.as</p>
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
	import com.custardbelly.as3flobile.android.library.GraphicLibrary;
	import com.custardbelly.as3flobile.controls.button.Button;
	import com.custardbelly.as3flobile.skin.DropDownSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import org.bytearray.display.ScaleBitmap;
	
	/**
	 * AndroidDropDownSkin uses the GraphicLibrary to skin a dropdown control targeting Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidDropDownSkin extends DropDownSkin
	{
		protected var _arrow:Bitmap;
		protected var _arrowWidth:int;
		
		/**
		 * Constructor.
		 */
		public function AndroidDropDownSkin() 
		{ 
			super();
			_arrow = new Bitmap( GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.dropDownArrow ) );
			_arrowWidth = 42;
		}
		
		/**
		 * @inherit
		 */
		override protected function initializeLabelButton( display:Button, width:int, height:int ):void
		{
			display.skin = new AndroidLabelButtonSkin();
			updateLabelButton( display, width, height );
		}
		
		/**
		 * @inherit
		 */
		override protected function initializeArrowButton( display:Button, width:int, height:int ):void
		{
			display.skin = new AndroidArrowButtonSkin();
			display.label = "";
			display.width = _arrowWidth;
			display.addChild( _arrow );
			updateArrowButton( display, width, height );	
		}
		
		/**
		 * @inherit
		 */
		override protected function updateLabelButton( display:Button, width:int, height:int ):void
		{
			display.width = width - _arrowWidth;
			display.height = height;
		}
		
		/**
		 * @inherit
		 */
		override protected function updateArrowButton( display:Button, width:int, height:int ):void
		{
			display.x = width - display.width;
			display.height = height;
			_arrow.x = ( display.width - _arrow.width ) * 0.5;
			_arrow.y = ( display.height - _arrow.height ) * 0.5;
		}
	}
}
import com.custardbelly.as3flobile.android.library.GraphicLibrary;
import com.custardbelly.as3flobile.controls.label.Label;
import com.custardbelly.as3flobile.skin.ButtonSkin;

import flash.display.BitmapData;
import flash.display.Graphics;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;
import flash.text.engine.ElementFormat;

import org.bytearray.display.ScaleBitmap;

/**
 * AndroidLabelButtonSkin is a button skin for the main dropdown button. 
 * @author toddanderson
 */
class AndroidLabelButtonSkin extends ButtonSkin
{
	protected var _dropDownBitmap:ScaleBitmap;
	
	/**
	 * Constructor. 
	 */
	public function AndroidLabelButtonSkin()
	{
		super();
		var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.dropDownBackground );
		_dropDownBitmap = new ScaleBitmap( bmd );
		_dropDownBitmap.scale9Grid = new Rectangle( 6, 6, 172, 39 );
	}
	
	/**
	 * @inherit
	 */
	override protected function updateBackground( display:Graphics, width:int, height:int ):void
	{	
		_dropDownBitmap.setSize( width, height );
		
		display.clear();
		display.beginBitmapFill( _dropDownBitmap.bitmapData );
		display.drawRect( 0, 0, width, height );
		display.endFill();
	}
	
	/**
	 * @inherit
	 */
	override protected function initializeLabel( label:Label, width:int, height:int, padding:int = 0 ):void
	{
		super.initializeLabel( label, width, height, padding );
		// Left align and truncate.
		label.truncationText = "...";
		label.multiline = false;
		label.autosize = false;
		label.textAlign = TextFormatAlign.LEFT;
		
		var format:ElementFormat = label.format.clone();
		format.color = 0x333333;
		label.format = format;
	}
	
	/**
	 * @inherit
	 */
	override protected function updateLabel( label:Label, width:int, height:int, padding:int = 0, fromStateChange:Boolean = false ):void
	{
		super.updateLabel( label, width, height, padding );
		const offset:int = 4;
		label.x = padding + offset;
	} 
	
	/**
	 * @inherit
	 */
	override public function dispose():void
	{
		super.dispose();
		_dropDownBitmap = null;
	}
}

/**
 * AndroidArrowSkin is a skin for the dropdown arrow button. 
 * @author toddanderson
 */
class AndroidArrowButtonSkin extends ButtonSkin
{
	protected var _dropDownArrow:ScaleBitmap;
	
	/**
	 * Constructor.
	 */
	public function AndroidArrowButtonSkin()
	{
		super();
		var bmd:BitmapData = GraphicLibrary.getGraphicFromLibrary( GraphicLibrary.dropDownArrowButton );
		_dropDownArrow = new ScaleBitmap( bmd );
		_dropDownArrow.scale9Grid = new Rectangle( 6, 6, 36, 39 );
	}
	
	/**
	 * @inherit
	 */
	override protected function updateBackground( display:Graphics, width:int, height:int ):void
	{	
		_dropDownArrow.setSize( width, height );
		
		display.clear();
		display.beginBitmapFill( _dropDownArrow.bitmapData );
		display.drawRect( 0, 0, width, height );
		display.endFill();
	}
	
	/**
	 * @inherit
	 */
	override public function dispose():void
	{
		super.dispose();
		_dropDownArrow = null;
	}
}