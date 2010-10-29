/**
 * <p>Original Author: toddanderson</p>
 * <p>Class File: MouseLongPressMediator.as</p>
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
package com.custardbelly.as3flobile.android.helper
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * MouseLongPressMediator is an extension of LongPressMediator to use mouse recognition for the gesture. 
	 * @author toddanderson
	 * 
	 */
	public class MouseLongPressMediator extends LongPressMediator
	{
		protected var _startX:int;
		protected var _startY:int;
		protected var _longPressTimer:Timer;
		
		/**
		 * Constructor. 
		 * @param trigger int
		 * @param movementThreshold int
		 */
		public function MouseLongPressMediator( trigger:int = 1000, movementThreshold:int = 12 )
		{
			super( trigger, movementThreshold );
		}
		
		/**
		 * @private
		 * 
		 * Returns flag of target residing in bounds of x/y position. 
		 * @param x int
		 * @param y int
		 * @return Boolean
		 */
		protected function isWithinTargetBounds( x:int, y:int ):Boolean
		{
			if( _targetDisplay == null || _targetDisplay.stage == null ) return false;
			
			var scaledBounds:Rectangle = _targetDisplay.getBounds( _targetDisplay.stage );
			return ( x >= scaledBounds.x && x <= scaledBounds.x + scaledBounds.width ) &&
				( y >= scaledBounds.y && y <= scaledBounds.y + scaledBounds.height );
		}
		
		/**
		 * @private
		 * 
		 * Creates timer for long press recognition.
		 */
		protected function assembleTimer():void
		{
			_longPressTimer = new Timer( _trigger, 1 );
			_longPressTimer.addEventListener(TimerEvent.TIMER_COMPLETE, handleLongPressTimer, false, 0, true );
		}
		/**
		 * @private 
		 * 
		 * Disassemlbes timer for long press recognition.
		 */
		protected function disassembleTimer():void
		{
			if( _longPressTimer == null ) return;
			
			_longPressTimer.stop();
			_longPressTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, handleLongPressTimer, false );
		}
		
		/**
		 * @private 
		 * 
		 * Assigns handlers for target display.
		 */
		protected function assignDisplayHandlers():void
		{
			_targetDisplay.addEventListener( Event.ADDED_TO_STAGE, handleTargetDisplayAdded, false, 0, true );
			_targetDisplay.addEventListener( Event.REMOVED_FROM_STAGE, handleTargetDisplayRemoved, false, 0, true );
		}
		/**
		 * @private 
		 * 
		 * Removes handlers on target display.
		 */
		protected function removeDisplayHandlers():void
		{
			_targetDisplay.removeEventListener( Event.ADDED_TO_STAGE, handleTargetDisplayAdded, false );
			_targetDisplay.removeEventListener( Event.REMOVED_FROM_STAGE, handleTargetDisplayRemoved, false );	
		}
		
		/**
		 * @private
		 * 
		 * Event handler for target added to stage to start a mediating session. 
		 * @param evt Event
		 */
		protected function handleTargetDisplayAdded( evt:Event ):void
		{
			if( _isMediating ) assignMouseHandlers();
		}
		/**
		 * @private
		 * 
		 * Event handler for target removed from stage to end a mediating session. 
		 * @param evt Event
		 */
		protected function handleTargetDisplayRemoved( evt:Event ):void
		{
			if( _isMediating ) removeMouseHandlers();
		}
		
		/**
		 * @private
		 * 
		 * Assigns mouse handlers on target for recognition.
		 */
		protected function assignMouseHandlers():void
		{
			_targetDisplay.stage.addEventListener( MouseEvent.MOUSE_DOWN, handlePressBegin, false, 1, true );
		}
		/**
		 * @private 
		 * 
		 * Removes mouse handlers on target for recognition.
		 */
		protected function removeMouseHandlers():void
		{
			_targetDisplay.stage.removeEventListener( MouseEvent.MOUSE_DOWN, handlePressBegin, false );
			_targetDisplay.stage.removeEventListener( MouseEvent.MOUSE_MOVE, handlePressMove, false );
			_targetDisplay.stage.removeEventListener( MouseEvent.MOUSE_UP, handlePressEnd, false );
		}
		
		/**
		 * @private
		 * 
		 * Event handler for begin of press gesture. 
		 * @param evt MouseEvent
		 */
		protected function handlePressBegin( evt:MouseEvent ):void
		{
			if( isWithinTargetBounds( evt.stageX, evt.stageY ) )
			{	
				_startX = evt.stageX;
				_startY = evt.stageY;
				
				_targetDisplay.stage.addEventListener( MouseEvent.MOUSE_UP, handlePressEnd, false, 1, true );
				_targetDisplay.stage.addEventListener( MouseEvent.MOUSE_MOVE, handlePressMove, false, 1, true );
				
				_longPressTimer.reset();
				_longPressTimer.start();
			}
		}
		
		/**
		 * @private
		 * 
		 * Event handler for mouse move on target to recognize gesture. 
		 * @param evt MouseEvent
		 */
		protected function handlePressMove( evt:MouseEvent ):void
		{
			if( isWithinTargetBounds( evt.stageX, evt.stageY ) )
			{
				var x:int = evt.stageX - _startX;
				var y:int = evt.stageY - _startY;
				var len:int = Math.sqrt( x * x + y * y );
				if( len > _movementThreshold )
					handlePressEnd( null );
			}
		}
		
		/**
		 * @private
		 * 
		 * Event handler for complete of mouse event to recognize gesture. 
		 * @param evt MouseEvent
		 */
		protected function handlePressEnd( evt:MouseEvent ):void
		{
			if( _targetDisplay && _targetDisplay.stage )
			{
				_targetDisplay.stage.removeEventListener( MouseEvent.MOUSE_MOVE, handlePressMove, false );
				_targetDisplay.stage.removeEventListener( MouseEvent.MOUSE_UP, handlePressEnd, false );
			}
			_longPressTimer.stop();
		}
		
		/**
		 * @private
		 * 
		 * Event handler for timer to recognize as long press gesture. 
		 * @param evt TimerEvent
		 */
		protected function handleLongPressTimer( evt:TimerEvent ):void
		{
			_longPressTimer.stop();
			_longPress.dispatch( _targetDisplay, _targetDisplay.mouseX, _targetDisplay.mouseY );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function mediateLongPress( display:InteractiveObject ):void
		{
			super.mediateLongPress( display );
			if( display.stage )
			{
				assignMouseHandlers();
			}
			assignDisplayHandlers();
			assembleTimer();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function unmediateLongPress( display:InteractiveObject ):void
		{	
			removeMouseHandlers();
			removeDisplayHandlers();
			disassembleTimer();
			super.unmediateLongPress( display );
		}
	}
}