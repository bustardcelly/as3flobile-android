/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: ILongPressMediator.as</p>
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
	 * ILongPressMediator is a mouse/touch gesture mediator for a long press on an InteractiveObject. 
	 * @author toddanderson
	 */
	public interface ILongPressMediator
	{
		/**
		 * Begins the mediating session for recognition of long press. 
		 * @param display InteractiveObject
		 */
		function mediateLongPress( display:InteractiveObject ):void;
		/**
		 * Ends the mediating session for recognition of long press. 
		 * @param display InteractiveObject
		 */
		function unmediateLongPress( display:InteractiveObject ):void;
		/**
		 * Returns flag of currently mediating long press recognition. 
		 * @param display InteractiveObject
		 * @return Boolean
		 */
		function isMediating( display:InteractiveObject ):Boolean;
		
		/**
		 * Returns signal reference for clients to register for receipt of long press. 
		 * @return Signal Signal( InteractiveObject, Number, Number )
		 */
		function get longPress():Signal;
	}
}