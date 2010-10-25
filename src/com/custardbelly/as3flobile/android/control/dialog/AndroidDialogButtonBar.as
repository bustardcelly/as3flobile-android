/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidDialogButtonBar.as</p>
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
	import com.custardbelly.as3flobile.android.model.dialog.DialogButtonContext;
	import com.custardbelly.as3flobile.android.skin.AndroidButtonSkin;
	import com.custardbelly.as3flobile.android.skin.AndroidDialogButtonBarSkin;
	import com.custardbelly.as3flobile.controls.button.Button;
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.util.IObjectPool;
	import com.custardbelly.as3flobile.util.ObjectPool;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * AndroidDialogButtonBar is a button bar that resides in a Dialog targeting the look-and-feel of the Android platform. 
	 * @author toddanderson
	 */
	public class AndroidDialogButtonBar extends AS3FlobileComponent
	{
		protected var _buttons:Vector.<Button>;
		protected var _buttonPool:IObjectPool;
		protected var _skinPool:IObjectPool;
		protected var _options:Vector.<DialogButtonContext>;
		protected var _selectionChange:Signal;
		
		// We have a maximum amount of options as 3. 
		// If more is needed, it is recommended to use another dialog, perhaps one with a list of options.
		protected var _maximumOptionAmount:int;
		
		/**
		 * Constructor.
		 */
		public function AndroidDialogButtonBar() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 240;
			_height = 52;
			
			updatePadding( 5, 5, 5, 5 );
			
			_maximumOptionAmount = 3;
			
			_skin = new AndroidDialogButtonBarSkin();
			_skin.target = this;
			
			// Store reference to buttons on the display.
			_buttons = new Vector.<Button>();
			// Hold a pool of buttons for reuse.
			_buttonPool = new ObjectPool( getQualifiedClassName( Button ), _maximumOptionAmount );
			// Hold a pool of skins applied to buttons for re-use.
			_skinPool = new ObjectPool( getQualifiedClassName( AndroidButtonSkin ) );
			// Signal for selection change.
			_selectionChange = new Signal( AndroidDialogButtonBar, DialogButtonContext );
		}
		
		/**
		 * @private 
		 * 
		 * Validates the button options provided to be displayed in the button bar.
		 */
		protected function invalidateOptions():void
		{
			var i:int;
			var length:int = ( _options.length > _maximumOptionAmount ) ? _maximumOptionAmount : _options.length;
			var button:Button;
			// If we currnetly have less buttons on the display than are provided, create and add them.
			if( numChildren < length )
			{
				var createAmount:int = length - numChildren;
				for( i = 0; i < createAmount; i++ )
				{
					button = _buttonPool.getInstance( {skin:_skinPool.getInstance()} ) as Button
					addChild( button as DisplayObject );
				}
			}
			// Else return to pool for re-use.
			else if( numChildren > length )
			{
				while( numChildren > length )
				{
					button = removeChildAt( numChildren - 1 ) as Button;
					_skinPool.returnInstance( button.skin );
					_buttonPool.returnInstance( button );
				}
			}
			
			// Remove all reference for restore.
			while( _buttons.length > 0 )
			{
				button = _buttons.pop();
				// Remove listeners.
				button.tap.remove( buttonTapped );
			}
			
			// Assign properties and store reference to new button options.
			var context:DialogButtonContext;
			for( i = 0; i < length; i++ )
			{
				context = _options[i];
				button = getChildAt( i ) as Button;
				button.tap.add( buttonTapped );
				button.label = context.label;
				_buttons[_buttons.length] = button;
			}
			// Update the display.
			updateDisplay();
		}
		
		/**
		 * @private
		 * 
		 * Delegate handler for Button operation through as3signal. 
		 * @param evt GenericEvent
		 */
		protected function buttonTapped( evt:GenericEvent ):void
		{
			var button:Button = evt.target as Button;
			var context:DialogButtonContext = _options[getChildIndex( button )];
			_selectionChange.dispatch( this, context );
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			
			var button:Button;
			while( numChildren > 0 )
			{
				button = removeChildAt( numChildren - 1 ) as Button;
				button.tap.remove( buttonTapped );
				_skinPool.returnInstance( button.skin );
				_buttonPool.returnInstance( button );
			}
			
			_skinPool.flush();
			_buttonPool.flush();
			
			// Remove all reference for restore.
			while( _buttons.length > 0 )
				_buttons.pop();
			_buttons = null;
			
			if( _options )
			{
				while( _options.length > 0 )
					_options.pop();
				_options = null;
			}
			
			_selectionChange.removeAll();
			_selectionChange = null;
		}
		
		/**
		 * Returns signal reference for change in selection. 
		 * @return Signal
		 */
		public function get selectionChange():Signal
		{
			return _selectionChange;
		}
		
		/**
		 * Returns reference to the background disply of this control. 
		 * @return Graphics
		 */
		public function get backgroundDisplay():Graphics
		{
			return graphics;
		}
		
		/**
		 * Returns a list of button references display in this control. 
		 * @return Vector.<Button>
		 */
		public function get buttonDisplays():Vector.<Button>
		{
			return _buttons;
		}
		
		/**
		 * Accessor/Modifier for the list of context options to display in the button bar control. 
		 * @return Vector.<DialogButtonContext>
		 */
		public function get options():Vector.<DialogButtonContext>
		{
			return _options;
		}
		public function set options( value:Vector.<DialogButtonContext> ):void
		{
			_options = value;
			invalidateOptions();
		}
	}
}