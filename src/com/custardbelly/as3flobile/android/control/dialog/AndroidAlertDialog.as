/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidAlertDialog.as</p>
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
	import com.custardbelly.as3flobile.android.enum.DialogOptionEnum;
	import com.custardbelly.as3flobile.android.model.dialog.DialogButtonContext;
	import com.custardbelly.as3flobile.android.model.dialog.DialogContext;
	import com.custardbelly.as3flobile.android.skin.AndroidAlertDialogSkin;
	import com.custardbelly.as3flobile.android.skin.AndroidDialogOptionTitleBarSkin;
	import com.custardbelly.as3flobile.android.util.InstanceFactory;
	import com.custardbelly.as3flobile.controls.label.Label;
	import com.custardbelly.as3flobile.signal.CancelableSignal;
	import com.custardbelly.as3flobile.skin.ISkin;
	import com.custardbelly.as3flobile.skin.ISkinnable;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.signals.Signal;
	
	/**
	 * AndroidAlertDialog is a base dialog for displaying options to the user based on context. 
	 * @author toddanderson
	 */
	public class AndroidAlertDialog extends AndroidModalOverlay implements IAndroidDialog
	{
		protected var _titleBar:AndroidDialogTitleBar;
		protected var _message:Label;
		protected var _buttonBar:AndroidDialogButtonBar;
		
		protected var _context:DialogContext;
		
		protected var _defaultSkinClass:String;
		protected var _defaultTitleSkinClass:String;
		protected var _selectedOption:DialogButtonContext;
		
		protected var _open:Signal;
		protected var _closing:CancelableSignal;
		protected var _close:Signal;
		
		/**
		 * Constructor.
		 */
		public function AndroidAlertDialog() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 240;
			_height = 160;
			
			updatePadding( 10, 10, 10, 10 );
			
			// Set default skins to use.
			_defaultSkinClass = getQualifiedClassName( AndroidAlertDialogSkin );
			_defaultTitleSkinClass = getQualifiedClassName( AndroidDialogOptionTitleBarSkin );
			
			_open = new Signal( IAndroidDialog );
			_closing = new CancelableSignal( IAndroidDialog, int, CancelableSignal );
			_close = new Signal( IAndroidDialog, int );
		}
		
		/**
		 * @inherit
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			_titleBar = new AndroidDialogTitleBar();
			
			_message = new Label();
			_message.autosize = true;
			_message.multiline = true;
			_message.textAlign = TextFormatAlign.CENTER;
			
			_buttonBar = new AndroidDialogButtonBar();
			_buttonBar.selectionChange.add( buttonBarSelectionChange );
		}
		
		/**
		 * @inherit
		 */
		override protected function invalidateSize():void
		{
			super.invalidateSize();
			if( isOnDisplayList() )
			{
				var rect:Rectangle = getBounds( parent );
				_height = rect.height;
			}
		}
		
		/**
		 * @inherit
		 */
		override protected function handleAddedToStage(evt:Event):void
		{
			super.handleAddedToStage( evt );
			_open.dispatch( this ); 
		}
		
		/**
		 * @inherit
		 */
		override protected function handleRemovedFromStage(evt:Event):void
		{
			super.handleRemovedFromStage( evt );
			_close.dispatch( this, ( _selectedOption ) ? _selectedOption.optionCode : DialogOptionEnum.DISMISS );
		}
		
		/**
		 * @private 
		 * 
		 * Validates the context for the dialog display.
		 */
		protected function invalidateContext():void
		{
			// Clear display list.
			while( numChildren > 0 )
				removeChildAt( 0 );
			
			// Set new skin.
			if( _context )
			{
				setSkinFromContext( this, _context.skinClass, _defaultSkinClass );
			}
			
			// If we have a title, add it.
			if( _context && _context.title )
			{
				_titleBar.title = _context.title;
				// update title bar skin.
				setSkinFromContext( _titleBar, _context.titleSkinClass, _defaultTitleSkinClass );
				addChild( _titleBar );
			}
			// If we have a message add it.	
			if( _context && _context.message )
			{
				_message.text = _context.message;
				addChild( _message );
			}	
			// IF we have options, add it.
			if( _context && _context.options.length > 0 )
			{
				_buttonBar.options = _context.options;
				addChild( _buttonBar ); 
			}
		}
		
		/**
		 * @private 
		 * 
		 * Validates the container to add this dialog to.
		 */
		override protected function invalidateContainer():void
		{
			super.invalidateContainer();
			_container.addChild( this );
		}
		
		/**
		 * @private
		 * 
		 * Assigns the approriate skin to the skinTarget. 
		 * @param skinTarget ISkinnable
		 * @param skinClass String
		 * @param defaultSkinClass String
		 */
		protected function setSkinFromContext( skinTarget:ISkinnable, skinClass:String, defaultSkinClass:String ):void
		{
			if( skinClass != null && getQualifiedClassName( skinTarget.skin ) != skinClass )
			{
				skinTarget.skin = InstanceFactory.getInstance( skinClass ) as ISkin;
			}
			else if( skinClass == null )
			{
				skinTarget.skin = InstanceFactory.getInstance( defaultSkinClass );
			}
		}
		
		/**
		 * @private
		 * 
		 * Signal handler for change in selection of button bar.
		 */
		protected function buttonBarSelectionChange( buttonBar:AndroidDialogButtonBar, selection:DialogButtonContext ):void
		{
			_selectedOption = selection;
			
			_closing.dispatch( this, selection.optionCode, _closing );
			var willClose:Boolean = !_closing.cancelled;
			if( willClose )
			{
				dismiss();
			}
			_closing.reset();
		}
		
		/**
		 * @copy IAndroidDialog#inflate()
		 */
		public function inflate( data:Object ):void
		{
			// Typecast to a DialogContext.
			_context = data as DialogContext;
			invalidateContext();
		}
		
		/**
		 * @inherit
		 */
		override public function dismiss():void
		{
			_container.removeChild( this );
			_context = null;
			super.dismiss();
		}
		
		/**
		 * @inherit
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
		 * @copy IAndroidDialog#containsDisplay()
		 */
		public function containsDisplay( display:DisplayObject ):Boolean
		{
			return contains( display );
		}
		
		/**
		 * Returns a reference to the background display of this instance. 
		 * @return Graphics
		 */
		public function get backgroundDisplay():Graphics
		{
			return graphics;
		}
		
		/**
		 * Returns a reference to the title bar control of this instance. 
		 * @return AndroidDialogTitleBar
		 */
		public function get titleBarDisplay():AndroidDialogTitleBar
		{
			return _titleBar;
		}
		
		/**
		 * Returns a reference to the message display of this instance. 
		 * @return Label
		 */
		public function get messageDisplay():Label
		{
			return _message;
		}
		
		/**
		 * Returns a reference to the button bar control of this instance. 
		 * @return AndroidDialogButtonBar
		 */
		public function get buttonBarDisplay():AndroidDialogButtonBar
		{
			return _buttonBar;
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
	}
}