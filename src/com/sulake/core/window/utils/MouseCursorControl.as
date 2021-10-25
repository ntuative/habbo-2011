package com.sulake.core.window.utils
{

    import com.sulake.core.window.enum.MouseCursorType;

    import flash.display.Stage;
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;

    public class MouseCursorControl
    {

        private static var _type: uint = MouseCursorType.var_525;//0
        private static var var_1097: Stage;
        private static var var_1023: Boolean = true;
        private static var _disposed: Boolean = false;
        private static var var_1098: Boolean = true;
        private static var var_1096: DisplayObject;
        private static var var_1099: Dictionary = new Dictionary();

        public function MouseCursorControl(param1: DisplayObject)
        {
            var_1097 = param1.stage;
        }

        public static function dispose(): void
        {
            if (!_disposed)
            {
                if (var_1096)
                {
                    var_1097.removeChild(var_1096);
                    var_1097.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                    var_1097.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                    var_1097.removeEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                    var_1097.removeEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                }

                _disposed = true;
            }

        }

        public static function get disposed(): Boolean
        {
            return _disposed;
        }

        public static function get type(): uint
        {
            return _type;
        }

        public static function set type(param1: uint): void
        {
            if (_type != param1)
            {
                _type = param1;
                var_1098 = true;
            }

        }

        public static function get visible(): Boolean
        {
            return var_1023;
        }

        public static function set visible(param1: Boolean): void
        {
            var_1023 = param1;
            if (var_1023)
            {
                if (var_1096)
                {
                    var_1096.visible = true;
                }
                else
                {
                    Mouse.show();
                }

            }
            else
            {
                if (var_1096)
                {
                    var_1096.visible = false;
                }
                else
                {
                    Mouse.hide();
                }

            }

        }

        public static function change(): void
        {
            var _loc1_: DisplayObject;
            if (var_1098)
            {
                _loc1_ = var_1099[_type];
                if (_loc1_)
                {
                    if (var_1096)
                    {
                        var_1097.removeChild(var_1096);
                    }
                    else
                    {
                        var_1097.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                        var_1097.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                        var_1097.addEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                        var_1097.addEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                        Mouse.hide();
                    }

                    var_1096 = _loc1_;
                    var_1097.addChild(var_1096);
                }
                else
                {
                    if (var_1096)
                    {
                        var_1097.removeChild(var_1096);
                        var_1097.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                        var_1097.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                        var_1097.removeEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                        var_1097.removeEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                        var_1096 = null;
                        Mouse.show();
                    }

                    switch (_type)
                    {
                        case MouseCursorType.var_525:
                        case MouseCursorType.ARROW:
                            Mouse.cursor = MouseCursor.ARROW;
                            break;
                        case MouseCursorType.var_1100:
                            Mouse.cursor = MouseCursor.BUTTON;
                            break;
                        case MouseCursorType.var_1101:
                        case MouseCursorType.var_1102:
                        case MouseCursorType.var_1103:
                        case MouseCursorType.var_1104:
                            Mouse.cursor = MouseCursor.HAND;
                            break;
                        case MouseCursorType.NONE:
                            Mouse.cursor = MouseCursor.ARROW;
                            Mouse.hide();
                            break;
                    }

                }

                var_1098 = false;
            }

        }

        public static function defineCustomCursorType(param1: uint, param2: DisplayObject): void
        {
            var_1099[param1] = param2;
        }

        private static function onStageMouseMove(param1: MouseEvent): void
        {
            if (var_1096)
            {
                var_1096.x = param1.stageX - 2;
                var_1096.y = param1.stageY;
                if (_type == MouseCursorType.var_525)
                {
                    var_1023 = false;
                    Mouse.show();
                }
                else
                {
                    var_1023 = true;
                    Mouse.hide();
                }

            }

        }

        private static function onStageMouseLeave(param1: Event): void
        {
            if (var_1096 && _type != MouseCursorType.var_525)
            {
                Mouse.hide();
                var_1023 = false;
            }

        }

    }
}
