/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidModalOverlay.as</p>
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
package com.custardbelly.as3flobile.android.control.dialog
{
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.model.BoxPadding;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * AndroidModalOverlay is a overlay display on a target container. 
	 * @author toddanderson
	 */
	public class AndroidModalOverlay extends AS3FlobileComponent implements IAndroidModalOverlay
	{
		protected var _modalScreen:Shape;
		protected var _container:DisplayObjectContainer;
		protected var _modalPadding:BoxPadding;
		
		/**
		 * Constructor.
		 */
		public function AndroidModalOverlay() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_modalPadding = new BoxPadding( 60, 0, 60, 0 );
		}
		
		/**
		 * @inherit
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			_modalScreen = new Shape();
		}
		
		/**
		 * @inherit
		 */
		override protected function addDisplayHandlers():void
		{
			super.addDisplayHandlers();
			
			stage.addEventListener( Event.RESIZE, handleResize, false, 0, true );
			handleResize( null );
		}
		
		/**
		 * @inherit
		 */
		override protected function removeDisplayHandlers():void
		{
			super.removeDisplayHandlers();
			if( stage != null ) stage.removeEventListener( Event.RESIZE, handleResize, false );
		}
		
		/**
		 * @private 
		 * 
		 * Validates the target container to add the modal overlay to.
		 */
		protected function invalidateContainer():void
		{
			_container.addChild( _modalScreen );
		}
		
		/**
		 * @private 
		 * 
		 * Updates the modal display on the target container.
		 */
		protected function updateModalScreen():void
		{
			_modalScreen.graphics.clear();
			_modalScreen.graphics.beginFill( 0, 0.75 );
			_modalScreen.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight );
			_modalScreen.graphics.endFill();
		}
		
		/**
		 * @private
		 * 
		 * Handles resize of stage to update the modal. 
		 * @param evt Event
		 */
		protected function handleResize( evt:Event ):void
		{
			width = stage.stageWidth - ( _modalPadding.left + _modalPadding.right );
			x = ( stage.stageWidth - _width ) * 0.5;
			y = ( stage.stageHeight - _height ) * 0.5;
			updateModalScreen();
		}
		
		/**
		 * @copy IAndroidModalOverlay#show()
		 */
		public function show( container:DisplayObjectContainer ):void
		{	
			_container = container;
			invalidateContainer();
			updateDisplay();
		}
		
		/**
		 * @copy IAndroidModalOverlay#dismiss()
		 */
		public function dismiss():void
		{
			_container.removeChild( _modalScreen );
			_container = null;
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			_container = null;
			_modalPadding = null;
		}
		
		/**
		 * @copy IAndroidModalOverlay#modalPadding
		 */
		public function get modalPadding():BoxPadding
		{
			return _modalPadding;
		}
		public function set modalPadding(value:BoxPadding):void
		{
			if( BoxPadding.equals( value, _modalPadding ) ) return;
			
			_modalPadding = value;
			invalidateSize();
		}
	}
}