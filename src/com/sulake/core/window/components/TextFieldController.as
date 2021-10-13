package com.sulake.core.window.components
{
    import com.sulake.core.window.enum.WindowParam;
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.events.FocusEvent;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import flash.text.TextFieldType;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.WindowController;
    import flash.geom.Point;
    import flash.text.TextFieldAutoSize;
    import com.sulake.core.window.events.WindowKeyboardEvent;
    import com.sulake.core.window.enum.WindowState;
    import com.sulake.core.window.utils.PropertyStruct;
    import com.sulake.core.window.utils.PropertyDefaults;

    public class TextFieldController extends TextController implements ITextFieldWindow 
    {

        protected var var_2006:uint = 500;
        protected var var_2005:String = "";
        protected var var_2053:Boolean = false;
        protected var var_2047:Boolean = false;

        public function TextFieldController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 & (~(WindowParam.var_693)));
            param4 = (param4 | WindowParam.var_593);
            var_1018 = param6;
            _field = TextField(this.getGraphicContext(true).getDisplayObject());
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
            _field.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownEvent);
            _field.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUpEvent);
            _field.addEventListener(Event.CHANGE, this.onChangeEvent);
            _field.addEventListener(FocusEvent.FOCUS_IN, this.onFocusEvent);
            _field.addEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
            _field.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedEvent);
            var_1986 = false;
            this.var_2047 = true;
        }

        public function get focused():Boolean
        {
            if (_field)
            {
                if (_field.stage)
                {
                    return (_field.stage.focus == _field);
                };
            };
            return (false);
        }

        override public function enable():Boolean
        {
            if (super.enable())
            {
                _field.type = TextFieldType.INPUT;
                return (true);
            };
            _field.type = TextFieldType.DYNAMIC;
            return (false);
        }

        override public function disable():Boolean
        {
            if (super.disable())
            {
                _field.type = TextFieldType.DYNAMIC;
                return (true);
            };
            _field.type = TextFieldType.INPUT;
            return (false);
        }

        public function get editable():Boolean
        {
            return (_field.type == TextFieldType.INPUT);
        }

        public function set editable(param1:Boolean):void
        {
            _field.type = ((param1) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
        }

        public function get selectable():Boolean
        {
            return (_field.selectable);
        }

        public function set selectable(param1:Boolean):void
        {
            _field.selectable = param1;
        }

        public function set displayAsPassword(param1:Boolean):void
        {
            _field.displayAsPassword = param1;
        }

        public function get displayAsPassword():Boolean
        {
            return (_field.displayAsPassword);
        }

        public function set mouseCursorType(param1:uint):void
        {
        }

        public function get mouseCursorType():uint
        {
            return (0);
        }

        public function set toolTipCaption(param1:String):void
        {
            this.var_2005 = ((param1 == null) ? "" : param1);
        }

        public function get toolTipCaption():String
        {
            return (this.var_2005);
        }

        public function set toolTipDelay(param1:uint):void
        {
            this.var_2006 = param1;
        }

        public function get toolTipDelay():uint
        {
            return (this.var_2006);
        }

        public function setMouseCursorForState(param1:uint, param2:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }

        public function getMouseCursorByState(param1:uint):uint
        {
            throw (new Error("Unimplemented method!"));
        }

        public function showToolTip(param1:IToolTipWindow):void
        {
            throw (new Error("Unimplemented method!"));
        }

        public function hideToolTip():void
        {
            throw (new Error("Unimplemented method!"));
        }

        override public function set autoSize(param1:String):void
        {
            super.autoSize = param1;
            this.refreshAutoSize();
        }

        public function setSelection(param1:int, param2:int):void
        {
            _field.setSelection(param1, param2);
        }

        public function get selectionBeginIndex():int
        {
            return (_field.selectionBeginIndex);
        }

        public function get selectionEndIndex():int
        {
            return (_field.selectionEndIndex);
        }

        override public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            if (((param1) && (!(var_1154))))
            {
                var_1154 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.var_1155, var_1018);
            };
            return (var_1154);
        }

        override public function get caption():String
        {
            return ((_field) ? _field.text : "");
        }

        override public function dispose():void
        {
            _context.getWindowServices().getFocusManagerService().removeFocusWindow(this);
            this.var_2053 = false;
            if (_field)
            {
                if (this.focused)
                {
                    this.unfocus();
                };
                _field.removeEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDownEvent);
                _field.removeEventListener(KeyboardEvent.KEY_UP, this.onKeyUpEvent);
                _field.removeEventListener(Event.CHANGE, this.onChangeEvent);
                _field.removeEventListener(FocusEvent.FOCUS_IN, this.onFocusEvent);
                _field.removeEventListener(FocusEvent.FOCUS_OUT, this.onFocusEvent);
                _field.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRemovedEvent);
            };
            super.dispose();
        }

        override public function set text(param1:String):void
        {
            super.text = param1;
            this.refreshAutoSize();
        }

        override public function focus():Boolean
        {
            var _loc1_:Boolean = super.focus();
            if (_loc1_)
            {
                if (_field)
                {
                    if (_field.stage)
                    {
                        if (_field.stage.focus != _field)
                        {
                            _field.stage.focus = _field;
                        };
                    };
                };
            };
            return (_loc1_);
        }

        override public function unfocus():Boolean
        {
            if (_field)
            {
                if (_field.stage)
                {
                    if (_field.stage.focus == _field)
                    {
                        _field.stage.focus = null;
                    };
                };
            };
            return (super.unfocus());
        }

        override public function update(param1:WindowController, param2:WindowEvent):Boolean
        {
            var _loc3_:Boolean = super.update(param1, param2);
            switch (param2.type)
            {
                case WindowEvent.var_573:
                    if (param1 == this)
                    {
                        _field.width = this.width;
                        _field.height = this.height;
                    };
                    break;
            };
            if (param1 == this)
            {
                InteractiveController.processInteractiveWindowEvents(this, param2);
            };
            return (_loc3_);
        }

        protected function refreshAutoSize():void
        {
            var _loc1_:Point;
            var _loc2_:Point;
            var _loc3_:Point;
            if (((this.var_2047) && (!(autoSize == TextFieldAutoSize.NONE))))
            {
                if (((!(var_1018.width == _field.width)) || (!(var_1018.height == _field.height))))
                {
                    _loc1_ = _field.localToGlobal(new Point(_field.x, _field.y));
                    _loc2_ = new Point();
                    getGlobalPosition(_loc2_);
                    _loc3_ = new Point((_loc1_.x - _loc2_.x), (_loc1_.y - _loc2_.y));
                    setRectangle((var_1018.x + _loc3_.x), (var_1018.y + _loc3_.y), _field.width, _field.height);
                };
            };
        }

        override protected function refreshTextImage(param1:Boolean=false):void
        {
            var _loc3_:WindowEvent;
            var _loc2_:Boolean;
            if (var_1018.width != _field.width)
            {
                if (autoSize != TextFieldAutoSize.NONE)
                {
                    width = _field.width;
                    _loc2_ = true;
                }
                else
                {
                    _field.width = width;
                };
            };
            if (var_1018.height != _field.height)
            {
                if (autoSize != TextFieldAutoSize.NONE)
                {
                    height = _field.height;
                    _loc2_ = true;
                }
                else
                {
                    _field.height = height;
                };
            };
            if (((!(_loc2_)) && (!(param1))))
            {
                _loc3_ = WindowEvent.allocate(WindowEvent.var_573, this, null);
                _events.dispatchEvent(_loc3_);
                _loc3_.recycle();
            };
        }

        private function onKeyDownEvent(event:KeyboardEvent):void
        {
            var windowEvent:WindowKeyboardEvent;
            try
            {
                windowEvent = WindowKeyboardEvent.allocate(WindowKeyboardEvent.var_1156, event, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1062, e);
            };
        }

        private function onKeyUpEvent(event:KeyboardEvent):void
        {
            var windowEvent:WindowKeyboardEvent;
            try
            {
                windowEvent = WindowKeyboardEvent.allocate(WindowKeyboardEvent.var_715, event, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1062, e);
            };
        }

        private function onChangeEvent(event:Event):void
        {
            var windowEvent:WindowEvent;
            try
            {
                this.refreshAutoSize();
                windowEvent = WindowEvent.allocate(WindowEvent.var_590, this, null);
                this.update(this, windowEvent);
                windowEvent.recycle();
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1062, e);
            };
        }

        private function onFocusEvent(event:FocusEvent):void
        {
            try
            {
                if (event.type == FocusEvent.FOCUS_IN)
                {
                    if (!getStateFlag(WindowState.var_1043))
                    {
                        this.focus();
                    };
                }
                else
                {
                    if (event.type == FocusEvent.FOCUS_OUT)
                    {
                        if (getStateFlag(WindowState.var_1043))
                        {
                            this.unfocus();
                        };
                    };
                };
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1062, e);
            };
        }

        private function onRemovedEvent(event:Event):void
        {
            try
            {
                if (getStateFlag(WindowState.var_1043))
                {
                    this.unfocus();
                };
            }
            catch(e:Error)
            {
                _context.handleError(WindowContext.var_1062, e);
            };
        }

        override public function get properties():Array
        {
            var _loc1_:Array = InteractiveController.writeInteractiveWindowProperties(this, super.properties);
            _loc1_.push(((_field.type == TextFieldType.DYNAMIC) ? new PropertyStruct(PropertyDefaults.var_1157, false, PropertyStruct.var_611, true) : PropertyDefaults.var_1158));
            _loc1_.push(((this.var_2053 != PropertyDefaults.var_1159) ? new PropertyStruct(PropertyDefaults.var_1160, this.var_2053, PropertyStruct.var_611, true) : PropertyDefaults.var_1161));
            _loc1_.push(((_field.selectable != PropertyDefaults.var_1162) ? new PropertyStruct(PropertyDefaults.var_1163, _field.selectable, PropertyStruct.var_611, true) : PropertyDefaults.var_1164));
            _loc1_.push(((_field.displayAsPassword != PropertyDefaults.var_1165) ? new PropertyStruct("display_as_password", _field.displayAsPassword, PropertyStruct.var_611, true) : PropertyDefaults.var_1166));
            return (_loc1_);
        }

        override public function set properties(param1:Array):void
        {
            var _loc2_:PropertyStruct;
            InteractiveController.readInteractiveWindowProperties(this, param1);
            for each (_loc2_ in param1)
            {
                switch (_loc2_.key)
                {
                    case PropertyDefaults.var_1160:
                        this.var_2053 = (_loc2_.value as Boolean);
                        if (this.var_2053)
                        {
                            _context.getWindowServices().getFocusManagerService().registerFocusWindow(this);
                        };
                        break;
                    case PropertyDefaults.var_1163:
                        _field.selectable = (_loc2_.value as Boolean);
                        break;
                    case PropertyDefaults.var_1157:
                        _field.type = ((_loc2_.value) ? TextFieldType.INPUT : TextFieldType.DYNAMIC);
                        break;
                    case PropertyDefaults.var_1167:
                        _field.displayAsPassword = (_loc2_.value as Boolean);
                        break;
                };
            };
            super.properties = param1;
        }

    }
}