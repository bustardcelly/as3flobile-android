/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: LongPressMediator.as</p>
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
package com.custardbelly.as3flobile.android.helper
{
	import flash.display.InteractiveObject;
	
	import org.osflash.signals.Signal;
	
	/**
	 * LongPressMediator is a mouse/touch gesture mediator for a long press on an InteractiveObject. 
	 * @author toddanderson
	 */
	public class LongPressMediator implements ILongPressMediator
	{
		protected var _trigger:int;
		protected var _movementThreshold:int;
		protected var _targetDisplay:InteractiveObject;
		protected var _isMediating:Boolean;
		
		protected var _longPress:Signal;
		
		/**
		 * Constructor. 
		 * @param trigger int The length of time for a long press.
		 * @param movementThreshold int The maximum distance of movement to recognize as a long press.
		 */
		public function LongPressMediator( trigger:int = 1000, movementThreshold:int = 12 )
		{
			_trigger = trigger;
			_movementThreshold = movementThreshold;
			_longPress = new Signal( InteractiveObject, Number, Number );
		}
		
		/**
		 * @copy ILongPressMediator#mediateLongPress()
		 */
		public function mediateLongPress( display:InteractiveObject ):void
		{
			_targetDisplay = display;
			_isMediating = true;
		}
		
		/**
		 * @copy ILongPressMediator#unmediateLongPress()
		 */
		public function unmediateLongPress( display:InteractiveObject ):void
		{
			_targetDisplay = null;
			_isMediating = false;
		}
		
		/**
		 * @copy ILongPressMediator#isMediating()
		 */
		public function isMediating( display:InteractiveObject ):Boolean
		{
			return ( _isMediating && _targetDisplay == display );
		}
		
		/**
		 * @copy ILongPressMediator#longPress
		 */
		public function get longPress():Signal
		{
			return _longPress;
		}
	}
}