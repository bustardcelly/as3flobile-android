/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: Menu.as</p>
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
package com.custardbelly.as3flobile.android.control.menu
{
	import com.custardbelly.as3flobile.android.control.menu.behaviour.IMenuRevealBehaviour;
	import com.custardbelly.as3flobile.android.control.menu.behaviour.MenuRevealBehaviourStateEnum;
	import com.custardbelly.as3flobile.android.control.menu.behaviour.SlideUpMenuBehaviour;
	import com.custardbelly.as3flobile.android.control.menu.layout.GridMenuLayout;
	import com.custardbelly.as3flobile.android.control.menu.layout.VerticalMenuLayout;
	import com.custardbelly.as3flobile.android.control.menu.panel.IMenuPanelDisplay;
	import com.custardbelly.as3flobile.android.control.menu.panel.MenuPanel;
	import com.custardbelly.as3flobile.android.control.menu.panel.MenuPanelDisplayContext;
	import com.custardbelly.as3flobile.android.control.menu.renderer.IMenuItemRenderer;
	import com.custardbelly.as3flobile.android.model.menu.MenuItem;
	import com.custardbelly.as3flobile.android.skin.AndroidSubmenuItemRendererSkin;
	import com.custardbelly.as3flobile.android.skin.AndroidSubmenuPanelSkin;
	import com.custardbelly.as3flobile.controls.core.AS3FlobileComponent;
	import com.custardbelly.as3flobile.enum.DimensionEnum;
	import com.custardbelly.as3flobile.signal.CancelableSignal;
	import com.custardbelly.as3flobile.util.IObjectPool;
	import com.custardbelly.as3flobile.util.ObjectPool;
	import com.custardbelly.as3flobile.util.PropertyUtil;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	import org.osflash.signals.DeluxeSignal;
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.GenericEvent;
	
	/**
	 * Menu is a composite control of submenu panels that are transitioned in and out of view based on display history. 
	 * @author toddanderson
	 */
	// TODO: Extend ModalOverlay.
	public class AndroidMenu extends AS3FlobileComponent
	{	
		protected var _menuPanelList:Vector.<IMenuPanelDisplay>;
		protected var _menuHistory:MenuHistoryFlow;
		
		protected var _mainMenuPanelContext:MenuPanelDisplayContext;
		protected var _mainMenuPanelContextChanged:Boolean;
		protected var _submenuPanelContext:MenuPanelDisplayContext;
		protected var _submenuPanelContextChanged:Boolean;
		
		protected var _moreMenuItemPool:IObjectPool;
		protected var _panelBehaviourType:String;
		
		protected var _dataProvider:Vector.<MenuItem>;
		protected var _maximumItemDisplayAmount:uint;
		protected var _moreMenuItem:MenuItem;
		protected var _moreMenuItemDescription:Vector.<String>;
		
		protected var _open:Signal;
		protected var _close:Signal;
		
		protected var _selectionChange:CancelableSignal;
		
		/**
		 * Constructor.
		 */
		public function AndroidMenu() { super(); }
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			// undefine dimensions by default.
			//	Menus will assume the width of the stage if width is not explicitly set.
			//	Height is based on number of items and layout.
			_width = DimensionEnum.UNDEFINED;
			_height = DimensionEnum.UNDEFINED;
			
			// Default to grid of 6.
			_maximumItemDisplayAmount = 6;
			
			// Default more menu item for overflow.
			_moreMenuItemPool = new ObjectPool( getQualifiedClassName( MenuItem ) );
			_moreMenuItem = _moreMenuItemPool.getInstance( {title:"More"} ) as MenuItem;
			_moreMenuItemDescription = PropertyUtil.getReadWriteDescription( _moreMenuItem );
			
			// Lst of menu panels.
			_menuPanelList = new Vector.<IMenuPanelDisplay>();
			
			// Configurations.
			_mainMenuPanelContext = new MenuPanelDisplayContext( getQualifiedClassName( MenuPanel ) );
			_mainMenuPanelContext.layoutType = getQualifiedClassName( GridMenuLayout );
			
			_submenuPanelContext = new MenuPanelDisplayContext( getQualifiedClassName( MenuPanel ) );
			_submenuPanelContext.layoutType = getQualifiedClassName( VerticalMenuLayout );
			_submenuPanelContext.skinType = getQualifiedClassName( AndroidSubmenuPanelSkin );
			_submenuPanelContext.itemRendererSkinType = getQualifiedClassName( AndroidSubmenuItemRendererSkin );
			
			// Reveal behaviour type.
			_panelBehaviourType = getQualifiedClassName( SlideUpMenuBehaviour );
			
			// Navigation history.
			_menuHistory = new MenuHistoryFlow();
			_menuHistory.behaviourEnd.add( menuBehaviourDidEnd );
			_menuHistory.behaviourType = _panelBehaviourType;
			
			_open = new Signal( AndroidMenu, IMenuPanelDisplay );
			_close = new Signal( AndroidMenu, IMenuPanelDisplay ); 
			
			_selectionChange = new CancelableSignal( AndroidMenu, MenuItem, CancelableSignal );
		}
		
		/**
		 * @inherit
		 */
		override protected function invalidateSize():void
		{
			super.invalidateSize();
			
			// Update container panel sizes.
			var i:int = _menuPanelList.length;
			var menuPanel:IMenuPanelDisplay;
			while( --i > -1 )
			{
				menuPanel = _menuPanelList[i];
				menuPanel.width = _width;
			}
		}
		
		/**
		 * @private
		 * 
		 * Validates the model list of MenuItems to display across multiple menu panels.
		 */
		protected function invalidateDataProvider():void
		{	
			// Empty the panel list held for reference.
			emptyMenuPanelList();
			// Flush the pool of "more" menu items.
			_moreMenuItemPool.flush();
			
			// Update the models on the menu panels.
			var i:int;
			var listLength:int = _dataProvider.length;
			var length:int = listLength > _maximumItemDisplayAmount ? _maximumItemDisplayAmount - 1 : listLength;
			var startIndex:int;
			var endIndex:int;
			var menuPanel:IMenuPanelDisplay;
			var menuDataProvider:Vector.<MenuItem>;
			while( startIndex < listLength )
			{
				endIndex = startIndex + length;
				menuPanel = getSubmenuContainer();
				menuDataProvider = _dataProvider.slice( startIndex, endIndex );
				if( endIndex < listLength - 1 )
					menuDataProvider[menuDataProvider.length] = getMoreItemClone();
						
				menuPanel.dataProvider = menuDataProvider;
				( menuPanel as AS3FlobileComponent ).draw();
				startIndex = endIndex;
				length = ( startIndex + _maximumItemDisplayAmount >= listLength ) ? listLength - startIndex : _maximumItemDisplayAmount - 1;
			}
			// Supply the stack to the menu panel.
			_menuHistory.stack = _menuPanelList;
			// Update display.
			updateDisplay();
		}
		
		protected function invalidateConfigurations():void
		{
			invalidateDataProvider();
			_mainMenuPanelContextChanged = false;
			_submenuPanelContextChanged = false;
		}
		
		/**
		 * @private 
		 * 
		 * Validates the maximum item display amount.
		 */
		protected function invalidateMaximumItemDisplay():void
		{
			if( _dataProvider && _dataProvider.length > 0 )
				invalidateDataProvider();
		}
		
		/**
		 * @private 
		 * 
		 * Empties the list of menu panels and returns instances to pool for re-use.
		 */
		protected function emptyMenuPanelList():void
		{
			var i:int = _menuPanelList.length;
			var isMain:Boolean;
			var menuPanel:IMenuPanelDisplay;
			var configuration:MenuPanelDisplayContext;
			while( --i > -1 )
			{
				configuration = null;
				menuPanel = _menuPanelList.pop();
				isMain = ( i == 0 );
				// Determine configuration based on being main or submenu and the change to configuration property.
				// Do not return already created panels to their configuration if it has changed.
				if( isMain && !_mainMenuPanelContextChanged )
				{
					configuration = _mainMenuPanelContext;
				}
				else if( !_submenuPanelContextChanged )
				{
					configuration = _submenuPanelContext;
				}
				if( configuration ) configuration.returnInstance( menuPanel );
			}
		}
		
		/**
		 * @private
		 * 
		 * Gets an IMenuPanelDisplay instance constructed from item pools. 
		 * @return IMenuPanelDisplay
		 */
		protected function getSubmenuContainer():IMenuPanelDisplay
		{
			var isMain:Boolean = ( _menuPanelList.length == 0 );
			var config:MenuPanelDisplayContext = ( isMain ) ? _mainMenuPanelContext : _submenuPanelContext;
			var submenu:IMenuPanelDisplay = config.getInstance() as IMenuPanelDisplay;
			submenu.selectionChange.add( menuPanelItemSelected );
			submenu.maximumItemDisplayAmount = _maximumItemDisplayAmount;
			submenu.width = _width;
			_menuPanelList[_menuPanelList.length] = submenu;
			return submenu;
		}
		
		/**
		 * @private
		 * 
		 * Gets an instance of the specified "more" menu item populated with properties. 
		 * @return MenuItem
		 */
		protected function getMoreItemClone():MenuItem
		{
			var pack:Object = {};
			var property:String;
			for each( property in _moreMenuItemDescription )
			{
				pack[property] = _moreMenuItem[property];
			}
			return _moreMenuItemPool.getInstance( pack ) as MenuItem;
		}
		
		/**
		 * @private
		 * 
		 * Signal handler for change in selection from focused panel.
		 */
		protected function menuPanelItemSelected( evt:GenericEvent ):void
		{
			var panel:IMenuPanelDisplay = evt.target as IMenuPanelDisplay;
			var item:MenuItem = panel.selectedItem;
			var view:IMenuItemRenderer = panel.selectedItemRenderer;
			
			// Check if the delegate would like to override the functionality of closing the menu on item selection.
			_selectionChange.dispatch( this, item, _selectionChange );
			var shouldClose:Boolean = !_selectionChange.cancelled;
			
			// Check to see if the user has selected the "More" button in context of the panel.
			var menuItems:Vector.<MenuItem> = panel.dataProvider;
			var isRequestingNextPanel:Boolean = ( getPanelIndex( panel ) != _menuPanelList.length - 1 ) && ( menuItems.indexOf( item ) == menuItems.length - 1 );
			// If we have selected the "More" button, move forward in display of panel list.
			if( isRequestingNextPanel )
			{
				_menuHistory.next();
			}
			// Else we have made a selection on a list item, and dependant on how the delegate wants to handle the action, close the menu.
			else if( shouldClose )
			{
				_menuHistory.end();
			}
			_selectionChange.reset();
		}
		
		/**
		 * @private
		 * 
		 * Signal handler for end in behaviour of panel.
		 */
		protected function menuBehaviourDidEnd( behaviour:IMenuRevealBehaviour ):void
		{
			var targetPanel:IMenuPanelDisplay = behaviour.targetDisplay;
			var behaviourState:int = behaviour.getState();
			// Notify display delegate if available based on state of behaviour.
			if( behaviourState == MenuRevealBehaviourStateEnum.REVEALED )
			{
				_open.dispatch( this, targetPanel );
			}
			else if( behaviourState == MenuRevealBehaviourStateEnum.CONCEALED )
			{
				_close.dispatch( this, targetPanel );	
			}
		}
		
		/**
		 * @inherit
		 */
		override public function dispose():void
		{
			super.dispose();
			
			// Remove all children.
			while( numChildren > 0 )
				removeChildAt( 0 );
			
			// Remove items from model.
			while( _dataProvider.length > 0 )
				_dataProvider.shift();
			
			_dataProvider = null;
			
			// Kill history.
			_menuHistory.dispose();
			_menuHistory = null;
			
			// Dispose of panels.
			var menuPanel:IMenuPanelDisplay;
			while( _menuPanelList.length > 0 )
			{
				menuPanel = _menuPanelList.shift();
				menuPanel.dispose();
			}
			_menuPanelList = null;
			
			// More item pool.
			_moreMenuItemPool.dispose();
			_moreMenuItem = null;
			
			// Flush re-use pools.
			_mainMenuPanelContext.dispose();
			_mainMenuPanelContext = null;
			
			_submenuPanelContext.dispose();
			_submenuPanelContext = null;
			
			// Kill signals.
			_open.removeAll();
			_open = null;
			_close.removeAll();
			_close = null;
			
			_selectionChange.removeAll();
			_selectionChange = null;
		}
		
		/**
		 * Opens the first submenu of the control and starts view history. 
		 * @param target DisplayObjectContainer The target display to add the Menu submenus.
		 * @param origin Point The origin point at which to transition submenus into view.
		 */
		public function open( target:DisplayObjectContainer, origin:Point ):void
		{
			// Run immediate update on display.
			draw();
			if( !isActive() ) _menuHistory.start( target, origin );
		}
		
		/**
		 * Goes back on in view history to transition submenus in and out of view. If history has a length of 1, the menu will be considered closed.
		 */
		public function back():void
		{
			if( isActive() && !_menuHistory.previous() )
				_menuHistory.end();
		}
		
		/**
		 * Closes the menu from display.
		 */
		public function close():void
		{
			if( isActive() ) _menuHistory.end();
		}
		
		/**
		 * Returns flag of Menu being active on display. This is determined by the history count of being 0. 
		 * @return Boolean
		 */
		public function isActive():Boolean
		{
			return _menuHistory.length > 0;
		}
		
		/**
		 * Returns the elemental index of the IMenuPanelDisplay within the internally held list of submenus. 
		 * @param panel IMenuPanelDisplay
		 * @return int
		 */
		public function getPanelIndex( panel:IMenuPanelDisplay ):int
		{
			return _menuPanelList.indexOf( panel );
		}
		
		/**
		 * Returns the IMenuPanelDisplay at the elemental index within the internally held list of submenus. 
		 * @param index int
		 * @return IMenuPanelDisplay
		 */
		public function getPanelAt( index:int ):IMenuPanelDisplay
		{
			return _menuPanelList[index]
		}
		
		/**
		 * Returns the length of submenus. 
		 * @return int
		 */
		public function get numPanels():int
		{
			return _menuPanelList.length;
		}
		
		/**
		 * Returns signal reference for open of menu. 
		 * @return Signal
		 */
		public function get openSignal():Signal
		{
			return _open; 
		}
		/**
		 * Returns signal reference for close of menu. 
		 * @return Signal
		 */
		public function get closeSignal():Signal
		{
			return _close;
		}
		
		/**
		 * Returns signal reference for change in selection of menu. 
		 * @return CancelableSignal Signal( AndroidMenu, MenuItem, CancelableSignal )
		 */
		public function get selectionChange():CancelableSignal
		{
			return _selectionChange;
		}
		
		/**
		 * Accessor/Modifier for the maximum display amount of items in each submenu. 
		 * @return uint
		 */
		public function get maximumItemDisplayAmount():uint
		{
			return _maximumItemDisplayAmount;
		}
		public function set maximumItemDisplayAmount( value:uint ):void
		{
			if( _maximumItemDisplayAmount == value ) return;
			
			_maximumItemDisplayAmount = value;
			invalidate( invalidateMaximumItemDisplay );
		}

		/**
		 * Accessor/Modifier for the MenuItem model to be re-used as each "more" item if necessary in submenus. 
		 * @return MenuItem
		 */
		public function get moreMenuItem():MenuItem
		{
			return _moreMenuItem;
		}
		public function set moreMenuItem(value:MenuItem):void
		{
			if( _moreMenuItem == value ) return;
			
			_moreMenuItem = value;
			_moreMenuItemDescription = PropertyUtil.getReadWriteDescription( _moreMenuItem );
			if( _dataProvider != null ) invalidateAt( invalidateDataProvider, 0 );
		}
		
		/**
		 * Accessor/Modifier for the model list of MenuItems to display across multiple submenus. 
		 * @return Vector.<MenuItem>
		 */
		public function get dataProvider():Vector.<MenuItem>
		{
			return _dataProvider;
		}
		public function set dataProvider( value:Vector.<MenuItem> ):void
		{
			if( _dataProvider == value ) return;
			
			_dataProvider = value;
			invalidateAt( invalidateDataProvider, 0 );
			// If we were previously active in history, restart with new data.
			if( isActive() ) _menuHistory.restart();
		}
		
		/**
		 * Accessor/Modifier for the MenuPanelDisplayContext to use when creating the main panel within the submenus of this control. 
		 * @return MenuPanelDisplayContext
		 */
		public function get mainMenuPanelDisplayContext():MenuPanelDisplayContext
		{
			return _mainMenuPanelContext;
		}
		public function set mainMenuPanelDisplayContext( value:MenuPanelDisplayContext ):void
		{
			if( _mainMenuPanelContext.isEqual( value ) ) return;
			
			// Dispose previous config.
			_mainMenuPanelContext.dispose();
			// Update config reference and flip property change value.
			_mainMenuPanelContext = value;
			_mainMenuPanelContextChanged = true;
			invalidate( invalidateConfigurations );
		}
		
		/**
		 * Accessor/Modifier fot the MenuPanelDisplayContext to use when creating submenus other than the main menu in this control. 
		 * @return MenuPanelDisplayContext
		 */
		public function get submenuPanelDisplayContext():MenuPanelDisplayContext
		{
			return _submenuPanelContext;
		}
		public function set submenuPanelDisplayContext( value:MenuPanelDisplayContext ):void
		{
			if( _submenuPanelContext.isEqual( value ) ) return;
			
			_submenuPanelContext.dispose();
			_submenuPanelContext = value;
			_submenuPanelContextChanged = true;
			invalidate( invalidateConfigurations );
		}
		
		/**
		 * Accessor/Modifier for the behaviour type to use in transitioning submenus in and out of view. 
		 * @return String Fully-qualified class name of the IMenuRevealBehaviour. Default is #SlideUpMenuBehaviour.
		 */
		public function get panelBehaviourType():String
		{
			return _panelBehaviourType;
		}
		public function set panelBehaviourType( value:String ):void
		{
			if( _panelBehaviourType == value ) return;
			
			_panelBehaviourType = value;
			_menuHistory.behaviourType = _panelBehaviourType;
		}
	}
}