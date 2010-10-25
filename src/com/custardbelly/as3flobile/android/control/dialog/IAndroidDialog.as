/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: IAndroidDialog.as</p>
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
	import com.custardbelly.as3flobile.signal.CancelableSignal;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import org.osflash.signals.Signal;

	/**
	 * IAndroidDialog is a dialog control to display information to a user.  
	 * @author toddanderson
	 */
	public interface IAndroidDialog extends IAndroidModalOverlay
	{
		/**
		 * Constructs the dialog based on provided model. 
		 * @param data Object Generic model that can change context based on type of dialog.
		 */
		function inflate( data:Object ):void;
		/**
		 * Returns flag of display object being present on the dialog. There can be a case where a skin target needs to know if a display is available based on the context.
		 * @param display DisplayObject
		 * @return Boolean
		 */
		function containsDisplay( display:DisplayObject ):Boolean;
		
		/**
		 * Returns signal reference for open of dialog. 
		 * @return Signal Signal( IAndroidDialog )
		 */
		function get openSignal():Signal;
		/**
		 * Returns signal reference for closing of dialog. Handling clients can invoke preventDefault() on the signal if they wish the dialog not to close. 
		 * @return Signal Signal( IAndroidDialog, int, CancelableSignal )
		 */
		function get closingSignal():CancelableSignal;
		/**
		 * Returns signal reference for close of dialog. 
		 * @return Signal Signal( IAndroidDialog, int )
		 * 
		 */
		function get closeSignal():Signal;
	}
}