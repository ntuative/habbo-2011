package com.sulake.habbo.window.utils
{
    import com.sulake.core.window.utils.INotify;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.window.enum.HabboAlertDialogFlag;
    import com.sulake.core.window.components.IItemListWindow;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IInteractiveWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class AlertDialog implements IAlertDialog, INotify 
    {

        protected static const var_1046:String = "_alert_button_list";
        protected static const var_1047:String = "_alert_button_ok";
        protected static const var_1048:String = "_alert_button_cancel";
        protected static const var_1049:String = "_alert_button_custom";
        protected static const var_1052:String = "header_button_close";
        protected static const var_1051:String = "_alert_text_summary";
        private static var var_1045:uint = 0;

        protected var _title:String = "";
        protected var var_3274:String = "";
        protected var _disposed:Boolean = false;
        protected var var_1095:Function = null;
        protected var _window:IFrameWindow;

        public function AlertDialog(param1:IHabboWindowManager, param2:XML, param3:String, param4:String, param5:uint, param6:Function)
        {
            var _loc8_:IWindow;
            super();
            var_1045++;
            this._window = (param1.buildFromXML(param2, 2) as IFrameWindow);
            if (param5 == HabboAlertDialogFlag.var_156)
            {
                param5 = ((HabboAlertDialogFlag.var_1047 | HabboAlertDialogFlag.var_1050) | HabboAlertDialogFlag.var_1051);
            };
            var _loc7_:IItemListWindow = (this._window.findChildByName(var_1046) as IItemListWindow);
            if (_loc7_)
            {
                if (!(param5 & HabboAlertDialogFlag.var_1047))
                {
                    _loc8_ = _loc7_.getListItemByName(var_1047);
                    _loc8_.dispose();
                };
                if (!(param5 & HabboAlertDialogFlag.var_1048))
                {
                    _loc8_ = _loc7_.getListItemByName(var_1048);
                    _loc8_.dispose();
                };
                if (!(param5 & HabboAlertDialogFlag.var_1049))
                {
                    _loc8_ = _loc7_.getListItemByName(var_1049);
                    _loc8_.dispose();
                };
            };
            this._window.procedure = this.dialogEventProc;
            this._window.center();
            this.title = param3;
            this.summary = param4;
            this.callback = param6;
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (((this._window) && (!(this._window.disposed))))
                {
                    this._window.dispose();
                    this._window = null;
                };
                this.var_1095 = null;
                this._disposed = true;
            };
        }

        protected function dialogEventProc(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:WindowEvent;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case var_1047:
                        if (this.var_1095 != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_138, null, null);
                            this.var_1095(this, _loc3_);
                            _loc3_.recycle();
                        }
                        else
                        {
                            this.dispose();
                        };
                        return;
                    case var_1052:
                        if (this.var_1095 != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_139, null, null);
                            this.var_1095(this, _loc3_);
                            _loc3_.recycle();
                        }
                        else
                        {
                            this.dispose();
                        };
                        return;
                };
            };
        }

        public function getButtonCaption(param1:int):ICaption
        {
            var _loc2_:IInteractiveWindow;
            if (!this._disposed)
            {
                switch (param1)
                {
                    case HabboAlertDialogFlag.var_1047:
                        _loc2_ = (this._window.findChildByName(var_1047) as IInteractiveWindow);
                        break;
                    case HabboAlertDialogFlag.var_1048:
                        _loc2_ = (this._window.findChildByName(var_1048) as IInteractiveWindow);
                        break;
                    case HabboAlertDialogFlag.var_1049:
                        _loc2_ = (this._window.findChildByName(var_1049) as IInteractiveWindow);
                        break;
                };
            };
            return ((_loc2_) ? new AlertDialogCaption(_loc2_.caption, _loc2_.toolTipCaption, _loc2_.visible) : null);
        }

        public function setButtonCaption(param1:int, param2:ICaption):void
        {
        }

        public function set title(param1:String):void
        {
            this._title = param1;
            if (this._window)
            {
                this._window.caption = this._title;
            };
        }

        public function get title():String
        {
            return (this._title);
        }

        public function set summary(param1:String):void
        {
            this.var_3274 = param1;
            if (this._window)
            {
                ITextWindow(this._window.findChildByTag("DESCRIPTION")).text = this.var_3274;
            };
        }

        public function get summary():String
        {
            return (this.var_3274);
        }

        public function set callback(param1:Function):void
        {
            this.var_1095 = param1;
        }

        public function get callback():Function
        {
            return (this.var_1095);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

    }
}