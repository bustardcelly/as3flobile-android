/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: GraphicLibrary.as</p>
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
package com.custardbelly.as3flobile.android.library
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	/**
	 * GraphicLibrary is an access point to embedded graphics package with this library. 
	 * @author toddanderson
	 */
	public class GraphicLibrary
	{
		[Embed(source="/assets/title_bar.png")]
		public static var titleBarGraphic:Class;
		
		[Embed(source="/assets/button_background.png")]
		public static var buttonGraphic:Class;
		
		[Embed(source="/assets/button_down.png")]
		public static var buttonDownGraphic:Class;
		
		[Embed(source="/assets/checkbox_unselected.png")]
		public static var checkBoxUnselected:Class;
		
		[Embed(source="/assets/checkbox_selected.png")]
		public static var checkBoxSelected:Class;
		
		[Embed(source="/assets/dropdown_arrow.png")]
		public static var dropDownArrow:Class;
		
		[Embed(source="/assets/dropdown_arrow_button.png")]
		public static var dropDownArrowButton:Class;
		
		[Embed(source="/assets/dropdown_background.png")]
		public static var dropDownBackground:Class;
		
		[Embed(source="/assets/radio_unselected.png")]
		public static var radioUnselected:Class;
		
		[Embed(source="/assets/radio_selected.png")]
		public static var radioSelected:Class;
		
		[Embed(source="/assets/text_input_background.png")]
		public static var textInputBackground:Class;
		
		[Embed(source="/assets/text_input_focused.png")]
		public static var textInputFocused:Class;
		
		[Embed(source="/assets/dialog_alert_icon.png")]
		public static var dialogWarningIcon:Class;
		
		[Embed(source="/assets/dialog_title_icon.png")]
		public static var dialogOptionIcon:Class;
		
		[Embed(source="/assets/vertical_scrollbar.png")]
		public static var verticalScrollbar:Class;
		
		[Embed(source="/assets/horizontal_scrollbar.png")]
		public static var horizontalScrollbar:Class;
		
		/**
		 * @private
		 * 
		 * Hold map of previously requesting graphics. 
		 */
		private static var library:Dictionary;
		
		/**
		 * @private
		 * 
		 * Adds a graphic from the library to the map. 
		 * @param graphic Class The Class acts as a key in the map and creates a new instance from the embed.
		 */
		private static function setGraphicOnLibrary( graphic:Class ):void
		{
			library[graphic] = ( new graphic() as Bitmap ).bitmapData;
		}
		
		/**
		 * Returns the BitmapData associated with a graphic embedded. 
		 * @param key Class The key within the library to access the BitmapData
		 * @return BitmapData
		 */
		public static function getGraphicFromLibrary( key:Class ):BitmapData
		{
			if( library == null ) library = new Dictionary( true );
			if( library[key] == null )
				setGraphicOnLibrary( key );
			return library[key];
		}
		
		/**
		 * Empties cached BitmapData library.
		 */
		public static function flush():void
		{
			var bitmap:BitmapData;
			for each( bitmap in library )
			{
				bitmap.dispose();
			}
			library = null;
		}
	}
}