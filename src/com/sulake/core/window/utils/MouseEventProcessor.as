package com.sulake.core.window.utils
{

    import com.sulake.core.runtime.IDisposable;

    import flash.geom.Point;

    import com.sulake.core.window.WindowController;
    import com.sulake.core.window.graphics.IWindowRenderer;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindowContextStateListener;
    import com.sulake.core.window.enum.MouseCursorType;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.events.WindowMouseEvent;

    import flash.events.MouseEvent;

    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.components.IInteractiveWindow;

    import flash.display.BitmapData;

    import com.sulake.core.window.enum.*;

    public class MouseEventProcessor implements IEventProcessor, IDisposable
    {

        protected static var var_2054: Array;
        protected static var var_2055: Array;
        protected static var var_2056: Point = new Point();

        protected var var_2057: Point;
        protected var var_2058: WindowController;
        protected var var_2059: WindowController;
        protected var var_1063: IWindowRenderer;
        protected var var_2060: IDesktopWindow;
        protected var var_2061: IWindowContextStateListener;
        private var _disposed: Boolean = false;

        public function MouseEventProcessor()
        {
            this.var_2057 = new Point();
            if (var_2054 == null)
            {
                var_2054 = [];
                var_2054[0] = MouseCursorType.var_1100;
                var_2054[1] = MouseCursorType.var_525;
                var_2054[2] = MouseCursorType.var_1100;
                var_2054[3] = MouseCursorType.var_1100;
                var_2054[4] = MouseCursorType.var_1100;
                var_2054[5] = MouseCursorType.var_525;
                var_2054[6] = MouseCursorType.var_1100;
            }

            if (var_2055 == null)
            {
                var_2055 = [];
                var_2055[0] = WindowState.var_1035;
                var_2055[1] = WindowState.var_1043;
                var_2055[2] = WindowState.var_1038;
                var_2055[3] = WindowState.var_1041;
                var_2055[4] = WindowState.var_1112;
                var_2055[5] = WindowState.var_1036;
                var_2055[6] = WindowState.var_1042;
            }

        }

        public static function setMouseCursorByState(param1: uint, param2: uint): void
        {
            var _loc3_: int = var_2055.indexOf(param1);
            if (_loc3_ > -1)
            {
                var_2054[_loc3_] = param2;
            }

        }

        public static function getMouseCursorByState(param1: uint): uint
        {
            var _loc2_: uint = var_2055.length;
            while (_loc2_-- > 0)
            {
                if ((param1 & var_2055[_loc2_]) > 0)
                {
                    return var_2054[_loc2_];
                }

            }

            return MouseCursorType.var_525;
        }

        protected static function convertMouseEventType(param1: MouseEvent, param2: IWindow, param3: IWindow): WindowMouseEvent
        {
            var _loc4_: String;
            var _loc5_: Point;
            var _loc6_: Boolean;
            _loc5_ = new Point(param1.stageX, param1.stageY);
            param2.convertPointFromGlobalToLocalSpace(_loc5_);
            switch (param1.type)
            {
                case MouseEvent.MOUSE_MOVE:
                    _loc4_ = WindowMouseEvent.var_632;
                    break;
                case MouseEvent.MOUSE_OVER:
                    _loc4_ = WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER;
                    break;
                case MouseEvent.MOUSE_OUT:
                    _loc4_ = WindowMouseEvent.var_626;
                    break;
                case MouseEvent.ROLL_OUT:
                    _loc4_ = WindowMouseEvent.var_639;
                    break;
                case MouseEvent.ROLL_OVER:
                    _loc4_ = WindowMouseEvent.var_640;
                    break;
                case MouseEvent.CLICK:
                    _loc4_ = WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK;
                    break;
                case MouseEvent.DOUBLE_CLICK:
                    _loc4_ = WindowMouseEvent.var_627;
                    break;
                case MouseEvent.MOUSE_DOWN:
                    _loc4_ = WindowMouseEvent.var_628;
                    break;
                case MouseEvent.MOUSE_UP:
                    _loc6_ = _loc5_.x > -1 && _loc5_.y > -1 && _loc5_.x < param2.width && _loc5_.y < param2.height;
                    _loc4_ = _loc6_ ? WindowMouseEvent.var_633 : WindowMouseEvent.var_634;
                    break;
                case MouseEvent.MOUSE_WHEEL:
                    _loc4_ = WindowMouseEvent.var_635;
                    break;
                default:
                    _loc4_ = WindowEvent.var_592;
            }

            return WindowMouseEvent.allocate(_loc4_, param2, param3, _loc5_.x, _loc5_.y, param1.stageX, param1.stageY, param1.altKey, param1.ctrlKey, param1.shiftKey, param1.buttonDown, param1.delta);
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                this._disposed = true;
            }

        }

        public function process(state: EventProcessorState, eventQueue: IEventQueue): void
        {
            var event: MouseEvent;
            var index: int;
            var child: WindowController;
            var array: Array;
            var tempWindowEvent: WindowEvent;
            var window: IWindow;
            var temp: IWindow;
            if (eventQueue.length == 0)
            {
                return;
            }

            this.var_2060 = state.desktop;
            this.var_2059 = (state.var_1766 as WindowController);
            this.var_2058 = (state.var_1767 as WindowController);
            this.var_1063 = state.renderer;
            this.var_2061 = state.var_1768;
            eventQueue.begin();
            this.var_2057.x = -1;
            this.var_2057.y = -1;
            var mouseCursorType: int = MouseCursorType.var_525;
            while (true)
            {
                event = (eventQueue.next() as MouseEvent);
                if (event == null)
                {
                    break;
                }
                if (event.stageX != this.var_2057.x || event.stageY != this.var_2057.y)
                {
                    this.var_2057.x = event.stageX;
                    this.var_2057.y = event.stageY;
                    array = [];
                    this.var_2060.groupParameterFilteredChildrenUnderPoint(this.var_2057, array, WindowParam.var_593);
                }

                index = array != null ? array.length : 0;
                if (index == 0)
                {
                    if (event.type == MouseEvent.MOUSE_MOVE)
                    {
                        if (this.var_2059 != this.var_2060 && !this.var_2059.disposed)
                        {
                            this.var_2059.getGlobalPosition(var_2056);
                            tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.var_626, this.var_2059, null, event.stageX - var_2056.x, event.stageY - var_2056.y, event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                            this.var_2059.update(this.var_2059, tempWindowEvent);
                            this.var_2059 = WindowController(this.var_2060);
                            tempWindowEvent.recycle();
                        }

                    }
                    else
                    {
                        if (event.type == MouseEvent.MOUSE_DOWN)
                        {
                            window = this.var_2060.getActiveWindow();
                            if (window)
                            {
                                window.deactivate();
                            }

                        }

                    }

                }

                while (--index > -1)
                {
                    child = this.passMouseEvent(WindowController(array[index]), event);
                    if (child != null && child.visible)
                    {
                        if (event.type == MouseEvent.MOUSE_MOVE)
                        {
                            if (child != this.var_2059)
                            {
                                if (!this.var_2059.disposed)
                                {
                                    this.var_2059.getGlobalPosition(var_2056);
                                    tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.var_626, this.var_2059, child, event.stageX - var_2056.x, event.stageY - var_2056.y, event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                    this.var_2059.update(this.var_2059, tempWindowEvent);
                                    tempWindowEvent.recycle();
                                }

                                if (!child.disposed)
                                {
                                    child.getGlobalPosition(var_2056);
                                    tempWindowEvent = WindowMouseEvent.allocate(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, child, null, event.stageX - var_2056.x, event.stageY - var_2056.y, event.stageX, event.stageY, event.altKey, event.ctrlKey, event.shiftKey, event.buttonDown, event.delta);
                                    child.update(child, tempWindowEvent);
                                    tempWindowEvent.recycle();
                                }

                                if (!child.disposed)
                                {
                                    this.var_2059 = child;
                                }

                            }

                        }
                        else
                        {
                            if (event.type == MouseEvent.MOUSE_UP || event.type == MouseEvent.CLICK)
                            {
                                if (this.var_2059 && !this.var_2059.disposed)
                                {
                                    if (this.var_2061 != null)
                                    {
                                        this.var_2061.mouseEventReceived(event.type, this.var_2059);
                                    }

                                }

                            }

                        }

                        temp = child.parent;
                        while (temp && !temp.disposed)
                        {
                            if (temp is IInputProcessorRoot)
                            {
                                tempWindowEvent = convertMouseEventType(event, temp, child);
                                IInputProcessorRoot(temp).process(tempWindowEvent);
                                tempWindowEvent.recycle();
                                break;
                            }

                            temp = temp.parent;
                        }

                        if (event.altKey)
                        {
                            if (this.var_2059)
                            {
                                Logger.log("HOVER: " + this.var_2059.name);
                            }

                        }

                        if (this.var_2059 is IInteractiveWindow)
                        {
                            try
                            {
                                mouseCursorType = IInteractiveWindow(this.var_2059)
                                        .getMouseCursorByState(this.var_2059.state);
                                if (mouseCursorType == MouseCursorType.var_525)
                                {
                                    mouseCursorType = getMouseCursorByState(this.var_2059.state);
                                }

                            }
                            catch (e: Error)
                            {
                                mouseCursorType = MouseCursorType.var_525;
                            }

                        }

                        if (child != this.var_2060)
                        {
                            event.stopPropagation();
                            eventQueue.remove();
                        }

                        break;
                    }

                }

            }

            eventQueue.end();
            MouseCursorControl.type = mouseCursorType;
            state.desktop = this.var_2060;
            state.var_1766 = this.var_2059;
            state.var_1767 = this.var_2058;
            state.renderer = this.var_1063;
            state.var_1768 = this.var_2061;
        }

        private function passMouseEvent(param1: WindowController, param2: MouseEvent, param3: Boolean = false): WindowController
        {
            if (param1.disposed)
            {
                return null;
            }

            if (param1.testStateFlag(WindowState.var_1042))
            {
                return null;
            }

            var _loc4_: Point = new Point(param2.stageX, param2.stageY);
            param1.convertPointFromGlobalToLocalSpace(_loc4_);
            if (param2.type == MouseEvent.MOUSE_UP)
            {
                if (param1 != this.var_2058)
                {
                    if (this.var_2058 && !this.var_2058.disposed)
                    {
                        this.var_2058.update(this.var_2058, convertMouseEventType(new MouseEvent(MouseEvent.MOUSE_UP, false, true, param2.localX, param2.localY, null, param2.ctrlKey, param2.altKey, param2.shiftKey, param2.buttonDown, param2.delta), this.var_2058, param1));
                        this.var_2058 = null;
                    }

                }

            }

            var _loc5_: BitmapData = this.var_1063.getDrawBufferForRenderable(param1);
            if (!param1.validateLocalPointIntersection(_loc4_, _loc5_))
            {
                return null;
            }

            if (param1.testParamFlag(WindowParam.var_692))
            {
                if (param1.parent != null)
                {
                    return this.passMouseEvent(WindowController(param1.parent), param2);
                }

            }

            if (!param3)
            {
                switch (param2.type)
                {
                    case MouseEvent.MOUSE_DOWN:
                        this.var_2058 = param1;
                        break;
                    case MouseEvent.CLICK:
                        if (this.var_2058 != param1)
                        {
                            return null;
                        }

                        this.var_2058 = null;
                        break;
                    case MouseEvent.DOUBLE_CLICK:
                        if (this.var_2058 != param1)
                        {
                            return null;
                        }

                        this.var_2058 = null;
                        break;
                }

            }

            var _loc6_: IWindow;
            var _loc7_: WindowMouseEvent = convertMouseEventType(param2, param1, _loc6_);
            var _loc8_: Boolean = param1.update(param1, _loc7_);
            _loc7_.recycle();
            if (!_loc8_ && !param3)
            {
                if (param1.parent)
                {
                    return this.passMouseEvent(WindowController(param1.parent), param2);
                }

            }

            return param1;
        }

    }
}
