/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: DialogContext.as</p>
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
package com.custardbelly.as3flobile.android.model.dialog
{
	/**
	 * DialogContext is a modal context reprenting the content for a dialog. 
	 * @author toddanderson
	 */
	public class DialogContext
	{
		public var title:String;
		public var message:String;
		public var options:Vector.<DialogButtonContext>;
		public var titleSkinClass:String;
		public var skinClass:String; 
		
		/**
		 * Constructor.
		 */
		public function DialogContext() 
		{
			options = new Vector.<DialogButtonContext>();
		}
		
		/**
		 * Adds an option to the list representing the buttons within the dialog button bar. If no options available, no dialog button bar. 
		 * @param label String The label of the option button.
		 * @param optionCode int The option code. Valid option codes are from DialogOptionEnum
		 */
		public function addOption( label:String, optionCode:int ):void
		{
			options[options.length] = new DialogButtonContext( label, optionCode );
		}
		
		/**
		 * Removes previously provided references from the context for re-use.
		 */
		public function clear():void
		{
			title = null;
			message = null;
			skinClass = null;
			titleSkinClass = null;
			while( options.length > 0 )
				options.pop();
		}
	}
}