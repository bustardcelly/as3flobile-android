/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: ProgressDialogContext.as</p>
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
package com.custardbelly.as3flobile.android.model.progress
{
	/**
	 * ProgressDialogContext is a model representing the context to inflate a progress dialog. 
	 * @author toddanderson
	 * 
	 */
	public class ProgressDialogContext
	{
		public var message:String;
		public var percent:Number;
		public var closeOnComplete:Boolean;
		
		/**
		 * Constructor. 
		 * @param message String The textual message to display.
		 * @param percent Number The percent complete. Valid values are 0 to 1.
		 * @param closeOnComplete Boolean Flag to close on completion.
		 */
		public function ProgressDialogContext( message:String = null, percent:Number = 0.0, closeOnComplete:Boolean = true )
		{
			this.message = message;
			this.percent = percent;
			this.closeOnComplete = closeOnComplete;
		}
	}
}