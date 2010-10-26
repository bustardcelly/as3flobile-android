/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: IAndroidProgressDialog.as</p>
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
package com.custardbelly.as3flobile.android.control.progress
{
	import com.custardbelly.as3flobile.android.control.dialog.IAndroidDialog;

	/**
	 * IAndroidProgressDialog is a dialog modal overlay to display progress. 
	 * @author toddanderson
	 */
	public interface IAndroidProgressDialog extends IAndroidDialog
	{
		/**
		 * Accessor/Modifier for the message to display. 
		 * @return String
		 */
		function get message():String;
		function set message( value:String ):void;
		
		/**
		 * Accessor/Modifier for the percent complete of the progress. Value is from 0 to 1.
		 * @return Number
		 */
		function get percentComplete():Number;
		function set percentComplete( value:Number ):void;
		
		/**
		 * Accessor/Modifier for the flag of closing this instance on complete of progress (percentComplete = 1) 
		 * @return Boolean
		 */
		function get closeOnComplete():Boolean;
		function set closeOnComplete( value:Boolean ):void;
	}
}