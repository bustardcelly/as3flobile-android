/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidContextMenu.as</p>
 * <p>Version: 0.4</p>
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
package com.custardbelly.as3flobile.android.control.contextmenu
{
	import com.custardbelly.as3flobile.android.control.dialog.AndroidModalOverlay;
	import com.custardbelly.as3flobile.android.control.list.AndroidScrollList;
	import com.custardbelly.as3flobile.android.enum.DialogOptionEnum;
	import com.custardbelly.as3flobile.android.model.contextmenu.ContextMenuOption;
	import com.custardbelly.as3flobile.android.renderer.AndroidContextMenuItemRenderer;
	import com.custardbelly.as3flobile.android.skin.AndroidContextMenuListSkin;
	import com.custardbelly.as3flobile.android.skin.AndroidContextMenuSkin;
	import com.custardbelly.as3flobile.controls.list.IScrollListContainer;
	import com.custardbelly.as3flobile.controls.list.ScrollList;
	import com.custardbelly.as3flobile.controls.list.layout.IScrollListVerticalLayout;
	import com.custardbelly.as3flobile.controls.list.layout.ScrollListVerticalLayout;
	import com.custardbelly.as3flobile.model.BoxPadding;
	import com.custardbelly.as3flobile.signal.CancelableSignal;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * AndroidContextMenu is a modal overlay extension to provide a context menu list of options. 
	 * @author toddanderson
	 */
	public class AndroidContextMenu extends AndroidModalOverlay implements IAndroidContextMenu
	{
		protected var _list:ScrollList;
		protected var _layout:IScrollListVerticalLayout;
		
		protected var _selectedOption:ContextMenuOption;
		protected var _options:Vector.<ContextMenuOption>;
		
		protected var _open:Signal;
		protected var _closing:CancelableSignal;
		protected var _close:Signal;
		
		/**
		 * Constructor.
		 */
		public function AndroidContextMenu() { super(); }
		
		/**
		 * @inheritDoc
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			_width = 240;
			_height = 160;
			
			updatePadding( 5, 5, 5, 5 );
			
			_skin = new AndroidContextMenuSkin();
			_skin.target = this;
			
			_open = new Signal( IAndroidContextMenu );
			_closing = new CancelableSignal( IAndroidContextMenu, int, CancelableSignal );
			_close = new Signal( IAndroidContextMenu, int );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			// Set custom list for Android look-and-feel.
			_list = AndroidScrollList.initWithScrollRect( new Rectangle( 0, 0, 240, 160 ) );
			_list.itemRenderer = getQualifiedClassName( AndroidContextMenuItemRenderer );
			_list.skin = new AndroidContextMenuListSkin();
			_list.seperatorLength = 1;
			_list.padding = new BoxPadding( 0, 0, 0, 0 );
			_list.selectionChange.add( listSelectionChange );
			
			// ensure we are using a vertical list.
			_layout = _list.layout as IScrollListVerticalLayout;
			if( _layout == null )
			{
				_layout = new ScrollListVerticalLayout();
				_list.layout = _layout;
			}
			_layout.itemHeight = 50;
			addChild( _list );
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
			_close.dispatch( this, ( _selectedOption ) ? _selectedOption.optionCode : DialogOptionEnum.DISMISS );
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function invalidateSize():void
		{
			_height = _list.getBounds( this ).height;
			_height += ( padding.top + padding.bottom );
			super.invalidateSize();
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
		 * @private 
		 * 
		 * Validates the options to present in the context menu list.
		 */
		protected function invalidateOptions():void
		{
			_selectedOption = null;
			_list.dataProvider = vectorToArray( _options );
			updateDisplay();
		}
		
		/**
		 * @private
		 * 
		 * Converts a vector of ContextMenuOption to an Array/ 
		 * @param options Vector.<ContextMenuOption>
		 * @return Array
		 */
		protected function vectorToArray( options:Vector.<ContextMenuOption> ):Array
		{
			var arr:Array = [];
			var i:int = 0;
			var length:int = options.length;
			for( i = 0; i < length; i++ )
			{
				arr[arr.length] = options[i];
			}
			return arr;
		}
		
		/**
		 * @private 
		 * 
		 * Handler for selection change signal from list.
		 * @param evt GenericEvent
		 */
		protected function listSelectionChange( evt:GenericEvent ):void
		{
			var list:IScrollListContainer = evt.target as IScrollListContainer;
			var selectedIndex:int = list.selectedIndex;
			
			_selectedOption = _options[selectedIndex];
			// Notify of closing.
			_closing.dispatch( this, _selectedOption.optionCode, _closing );
			// If client did not prevent default, close it.
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
			_options = data as Vector.<ContextMenuOption>;
			invalidate( invalidateOptions );
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
			_options = null;
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
		 * Returns reference to background display. 
		 * @return Graphics
		 */
		public function get backgroundDisplay():Graphics
		{
			return graphics;
		}
		
		/**
		 * Returns reference to list display. 
		 * @return ScrollList
		 */
		public function get listDisplay():ScrollList
		{
			return _list;
		}

		/**
		 * Accessor/Modifier of the list of ContextMenuOptions that fill the display list. 
		 * @return Vector.<ContextMenuOption>
		 */
		public function get options():Vector.<ContextMenuOption>
		{
			return _options;
		}
		public function set options(value:Vector.<ContextMenuOption>):void
		{
			_options = value;
			invalidate( invalidateOptions );
		}
	}
}