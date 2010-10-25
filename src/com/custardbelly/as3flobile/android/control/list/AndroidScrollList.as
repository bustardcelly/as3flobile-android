/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: AndroidScrollList.as</p>
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
package com.custardbelly.as3flobile.android.control.list
{
	import com.custardbelly.as3flobile.android.control.scrollbar.AndroidScrollBar;
	import com.custardbelly.as3flobile.android.renderer.AndroidListItemRenderer;
	import com.custardbelly.as3flobile.android.skin.AndroidListSkin;
	import com.custardbelly.as3flobile.controls.list.ScrollList;
	import com.custardbelly.as3flobile.enum.OrientationEnum;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * AndroidScrollList is a convenience control to wire up skins targeting Android look-and-feel. 
	 * @author toddanderson
	 */
	public class AndroidScrollList extends ScrollList
	{
		protected var _visibleArea:Rectangle;
		protected var _verticalScrollRange:int;
		protected var _horizontalScrollRange:int;
		protected var _requiresHorizontalScroll:Boolean;
		protected var _requiresVerticalScroll:Boolean;
		
		protected var _topVerticalScrollLimit:int;
		protected var _bottomVerticalScrollLimit:int;
		protected var _leftHorizontalScrollLimit:int;
		protected var _rightHorizontalScrollLimit:int;
		
		protected var _horizontalScrollBar:AndroidScrollBar;
		protected var _verticalScrollBar:AndroidScrollBar;
		
		/**
		 * Constructor.
		 */
		public function AndroidScrollList() { super(); }
		
		/**
		 * Static convenience method to create a new instance with initialization properties. 
		 * @param bounds Rectangle
		 * @return AndroidScrollList
		 */
		static public function initWithScrollRect( bounds:Rectangle ):AndroidScrollList
		{
			var list:AndroidScrollList = new AndroidScrollList();
			list.width = bounds.width;
			list.height = bounds.height;
			return list; 
		}
		
		/**
		 * @inherit
		 */
		override protected function initialize():void
		{
			super.initialize();
			
			updatePadding( 2, 2, 2, 2 );
			// Dropping seperator to 0 because renderer/skin handle seperator graphics.
			_seperatorLength = 0;
			// Define Android list renderer.
			_itemRenderer = getQualifiedClassName( AndroidListItemRenderer );
			// Set Android skin.
			_skin = new AndroidListSkin();
			_skin.target = this;
			
			_visibleArea = new Rectangle();
		}
		
		/**
		 * @inherit
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			// Create scrollbars.
			_verticalScrollBar = new AndroidScrollBar();
			_verticalScrollBar.orientation = OrientationEnum.VERTICAL;
			_verticalScrollBar.width = 6;
			
			_horizontalScrollBar = new AndroidScrollBar();
			_horizontalScrollBar.orientation = OrientationEnum.HORIZONTAL;
			_horizontalScrollBar.height = 6;
		}
		
		/**
		 * @inherit
		 */
		override protected function invalidateSize():void
		{
			super.invalidateSize();
			
			updateVisibleArea();
			updateScrollLayout();
			updateScrollRangeAndLimit();
		}
		
		/**
		 * @inherit
		 */
		override protected function updateDisplay():void
		{
			super.updateDisplay();
			
			updateVisibleArea();
			updateScrollLayout();
			updateScrollRangeAndLimit();
		}
		
		/**
		 * @private
		 * 
		 * Updates the visible area bounds of content.
		 */
		protected function updateVisibleArea():void
		{
			_visibleArea.width = _listHolder.width - _width;
			_visibleArea.height = _listHolder.height - _height;
			_requiresHorizontalScroll = ( _visibleArea.width > _width );
			_requiresVerticalScroll = ( _visibleArea.height > _height );
		}
		
		/**
		 * @private
		 * 
		 * Updates the position and dimension of scroll controls.
		 */
		protected function updateScrollLayout():void
		{
			_verticalScrollBar.x = _width - _verticalScrollBar.width - _padding.right;
			_verticalScrollBar.height = _height * ( _height / _listHolder.height );
			
			_horizontalScrollBar.y = _height - _horizontalScrollBar.height - _padding.bottom;
			_horizontalScrollBar.width = _width * ( _width / _listHolder.width );
		}
		
		/**
		 * @private 
		 * 
		 * Updates the scroll limits for scroll controls.
		 */
		protected function updateScrollRangeAndLimit():void
		{
			_topVerticalScrollLimit = _padding.top;
			_bottomVerticalScrollLimit = _height - _padding.bottom - _verticalScrollBar.height;
			_verticalScrollRange = _bottomVerticalScrollLimit - _topVerticalScrollLimit;
			
			_leftHorizontalScrollLimit = _padding.left;
			_rightHorizontalScrollLimit = _width - _padding.right - _horizontalScrollBar.width;
			_horizontalScrollRange = _rightHorizontalScrollLimit - _leftHorizontalScrollLimit;
		}
		
		/**
		 * @private
		 * 
		 * Updates the position of a vertical scroll control based on position of content. 
		 * @param position Point
		 */
		protected function updateVerticalScrollBarPosition( position:Point ):void
		{
			var percent:Number = -position.y / _visibleArea.height;
			_verticalScrollBar.y = _topVerticalScrollLimit + ( _verticalScrollRange * percent );
		}
		
		/**
		 * @private
		 * 
		 * Updates the position of a horizontal scroll control based on position of content.
		 *  
		 * @param position Point
		 */
		protected function updateHorizontalScrollBarPosition( position:Point ):void
		{
			var percent:Number = -position.x / _visibleArea.width;
			_horizontalScrollBar.x = _leftHorizontalScrollLimit + ( _horizontalScrollRange * percent );
		}
		
		/**
		 * @inherit
		 */
		override protected function scrollViewDidStart( position:Point ):void
		{
			super.scrollViewDidStart( position );
			if( _requiresVerticalScroll )
			{
				updateVerticalScrollBarPosition( position );
				addChild( _verticalScrollBar );	
			}
			if( _requiresHorizontalScroll )
			{
				updateHorizontalScrollBarPosition( position );
				addChild( _horizontalScrollBar );
			}
		}
		
		/**
		 * @inherit
		 */
		override protected function scrollViewDidAnimate( position:Point ):void
		{
			super.scrollViewDidAnimate( position );
			
			if( _requiresVerticalScroll ) 
			{
				updateVerticalScrollBarPosition( position );	
			}
			if( _requiresHorizontalScroll )
			{
				updateHorizontalScrollBarPosition( position );	
			}
		}
		
		/**
		 * @inherit
		 */
		override protected function scrollViewDidEnd( position:Point ):void
		{
			super.scrollViewDidEnd( position );
			if( _requiresVerticalScroll ) removeChild( _verticalScrollBar );
			if( _requiresHorizontalScroll ) removeChild( _horizontalScrollBar );
		}
	}
}