package com.sulake.core.window.utils
{

    import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.events.IEventDispatcher;

    public class MouseEventQueue extends GenericEventQueue
    {

        protected var _mousePosition: Point;

        public function MouseEventQueue(param1: IEventDispatcher)
        {
            super(param1);
            this._mousePosition = new Point();
            _eventDispatcher.addEventListener(MouseEvent.CLICK, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.DOUBLE_CLICK, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_UP, this.mouseEventListener, false);
            _eventDispatcher.addEventListener(MouseEvent.MOUSE_WHEEL, this.mouseEventListener, false);
        }

        public function get mousePosition(): Point
        {
            return this._mousePosition;
        }

        override public function dispose(): void
        {
            if (!_disposed)
            {
                _eventDispatcher.removeEventListener(MouseEvent.CLICK, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.DOUBLE_CLICK, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_UP, this.mouseEventListener, false);
                _eventDispatcher.removeEventListener(MouseEvent.MOUSE_WHEEL, this.mouseEventListener, false);
                super.dispose();
            }

        }

        private function mouseEventListener(param1: MouseEvent): void
        {
            this._mousePosition.x = param1.stageX;
            this._mousePosition.y = param1.stageY;
            var_2294.push(param1);
        }

    }
}
