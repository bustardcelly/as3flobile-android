/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidProgressDialog.as</p>
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
	import com.custardbelly.as3flobile.android.control.dialog.AndroidModalOverlay;
	import com.custardbelly.as3flobile.android.enum.DialogOptionEnum;
	import com.custardbelly.as3flobile.android.model.progress.ProgressDialogContext;
	import com.custardbelly.as3flobile.android.skin.AndroidProgressDialogSkin;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.signal.CancelableSignal;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	
	import org.osflash.signals.Signal;

	/**
	 * AndroidProgressDialog presents a progress modal overlay representing the progress of an operation. 
	 * @author toddanderson
	 */
	public class AndroidProgressDialog extends AndroidModalOverlay implements IAndroidProgressDialog
	{
		protected var _messageField:Label;
		protected var _percentField:Label;
		protected var _progressBar:AndroidProgressBar;
		
		protected var _message:String;
		protected var _percent:Number;
		protected var _closeOnComplete:Boolean;
		
		protected var _open:Signal;
		protected var _closing:CancelableSignal;
		protected var _close:Signal;
		
		/**
		 * Constructor.
		 */
		public function AndroidProgressDialog() { super(); }
		
		/**
		 * @inheritDoc
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 240;
			_height = 160;
			
			_message = "Loading...";
			_percent = 0;
			_closeOnComplete = true;
			
			updatePadding( 10, 10, 10, 10 );
			
			_skin = new AndroidProgressDialogSkin();
			_skin.target = this;
			
			_open = new Signal( IAndroidProgressDialog );
			_closing = new CancelableSignal( IAndroidProgressDialog, int, CancelableSignal );
			_close = new Signal( IAndroidProgressDialog, int );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			_messageField = new Label();
			_messageField.autosize = true;
			_messageField.multiline = true;
			_messageField.text = _message;
			addChild( _messageField );
			
			_percentField = new Label();
			_percentField.autosize = false;
			_percentField.multiline = false;
			_percentField.textAlign = TextFormatAlign.RIGHT;
			_percentField.text = _percent + "%";
			addChild( _percentField );
			
			_progressBar = new AndroidProgressBar();
			addChild( _progressBar );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleAddedToStage(evt:Event):void
		{
			super.handleAddedToStage( evt );
			_open.dispatch( this ); 
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function handleRemovedFromStage(evt:Event):void
		{
			super.handleRemovedFromStage( evt );
			_close.dispatch( this, DialogOptionEnum.OK );
		}
		
		/**
		 * @private 
		 * 
		 * Validates the textual message to display.
		 */
		protected function invalidateMessage():void
		{
			_messageField.text = _message;
			updateDisplay();
		}
		
		/**
		 * @private 
		 * 
		 * Validates the percent complete to display.
		 */
		protected function invalidatePercent():void
		{
			_percentField.text = int( _percent * 100 ).toString() + "%";
			_progressBar.percent = _percent;
			updateDisplay();
			
			if( _percent >= 1 )
			{
				handlePercentComplete();
			}
		}
		
		/**
		 * @private 
		 * 
		 * Handler for percent being deemed complete. (typically == 1).
		 */
		protected function handlePercentComplete():void
		{
			if( !_closeOnComplete ) return;
			
			// Notify of closing.
			_closing.dispatch( this, DialogOptionEnum.OK, _closing );
			var willClose:Boolean = !_closing.cancelled;
			// If client has not prevent default, dismiss.
			if( willClose )
			{
				dismiss();
			}
			_closing.reset();
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function invalidateContainer():void
		{
			super.invalidateContainer();
			_container.addChild( this );
		}
		
		/**
		 * @copy IAndroidDialog#inflate()
		 */
		public function inflate( data:Object ):void
		{
			// Cast as ProgressDialogContext
			var context:ProgressDialogContext = ( data ) ? data as ProgressDialogContext : null;
			if( context != null )
			{
				message = context.message;
				percentComplete = context.percent;
				updateDisplay();
			}
		}
		
		/**
		 * @copy IAndroidDialog#containsDisplay()
		 */
		public function containsDisplay( display:DisplayObject ):Boolean
		{
			return contains( display );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dismiss():void
		{
			_container.removeChild( this );
			super.dismiss();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose():void
		{
			super.dispose();
			_open.removeAll();
			_open = null;
			_closing.removeAll();
			_closing = null;
			_close.removeAll();
			_close = null;
		}
		
		/**
		 * @copy IAndroidDialog#openSignal
		 */
		public function get openSignal():Signal
		{
			return _open;
		}
		/**
		 * @copy IAndroidDialog#closingSignal
		 */
		public function get closingSignal():CancelableSignal
		{
			return _closing;
		}
		/**
		 * @copy IAndroidDialog#closeSignal
		 */
		public function get closeSignal():Signal
		{
			return _close;
		}
		
		/**
		 * Returnd background display reference for skinning. 
		 * @return Graphics
		 */
		public function get backgroundDisplay():Graphics
		{
			return graphics;
		}
		
		/**
		 * Returns message field dislay reference. 
		 * @return Label
		 */
		public function get messageFieldDisplay():Label
		{
			return _messageField;
		}
		
		/**
		 * Returns percentage field display reference. 
		 * @return Label
		 */
		public function get percentFieldDisplay():Label
		{
			return _percentField;
		}
		
		/**
		 * Returns progress bar display reference. 
		 * @return AndroidProgressBar
		 */
		public function get progressBarDisplay():AndroidProgressBar
		{
			return _progressBar;
		}
		
		/**
		 * @copy IAndroidProgressDialog#message
		 */
		public function get message():String
		{
			return _message;
		}
		public function set message( value:String ):void
		{
			if( _message == value ) return;
			
			_message = value;
			invalidateMessage();
		}
		
		/**
		 * @copy IAndroidProgressDialog#percentComplete
		 */
		public function get percentComplete():Number
		{
			return _percent;
		}
		public function set percentComplete( value:Number ):void
		{
			if( _percent == value ) return;
			
			_percent = value;
			invalidatePercent();
		}
		
		/**
		 * @copy IAndroidProgressDialog#closeOnComplet
		 */
		public function get closeOnComplete():Boolean
		{
			return _closeOnComplete;
		}
		public function set closeOnComplete( value:Boolean ):void
		{
			_closeOnComplete = value;
		}
	}
}