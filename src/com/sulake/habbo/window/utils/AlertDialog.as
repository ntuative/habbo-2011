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

        protected static const ALERT_BUTTON_LIST: String = "_alert_button_list";
        protected static const ALERT_BUTTON_OK: String = "_alert_button_ok";
        protected static const ALERT_BUTTON_CANCEL: String = "_alert_button_cancel";
        protected static const ALERT_BUTTON_CUSTOM: String = "_alert_button_custom";
        protected static const HEADER_BUTTON_CLOSE: String = "header_button_close";
        protected static const ALERT_TEXT_SUMMARY: String = "_alert_text_summary";
        private static var INSTANCE_ID: uint = 0;

        protected var _title: String = "";
        protected var _summary: String = "";
        protected var _disposed: Boolean = false;
        protected var _callback: Function = null;
        protected var _window: IFrameWindow;

        public function AlertDialog(windowManager: IHabboWindowManager, layout: XML, title: String, summary: String, flags: uint, callback: Function)
        {
            super();
            var button: IWindow;
            INSTANCE_ID++;
            this._window = (windowManager.buildFromXML(layout, 2) as IFrameWindow);
            
            if (flags == HabboAlertDialogFlag.var_156)
            {
                flags = HabboAlertDialogFlag.var_1047 | HabboAlertDialogFlag.var_1050 | HabboAlertDialogFlag.var_1051;
            }

            var _loc7_: IItemListWindow = this._window.findChildByName(ALERT_BUTTON_LIST) as IItemListWindow;
            if (_loc7_)
            {
                if (!(flags & HabboAlertDialogFlag.var_1047))
                {
                    button = _loc7_.getListItemByName(ALERT_BUTTON_OK);
                    button.dispose();
                }

                if (!(flags & HabboAlertDialogFlag.var_1048))
                {
                    button = _loc7_.getListItemByName(ALERT_BUTTON_CANCEL);
                    button.dispose();
                }

                if (!(flags & HabboAlertDialogFlag.var_1049))
                {
                    button = _loc7_.getListItemByName(ALERT_BUTTON_CUSTOM);
                    button.dispose();
                }

            }

            this._window.procedure = this.dialogEventProc;
            this._window.center();
            this.title = title;
            this.summary = summary;
            this.callback = callback;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                if (this._window && !this._window.disposed)
                {
                    this._window.dispose();
                    this._window = null;
                }

                this._callback = null;
                this._disposed = true;
            }

        }

        protected function dialogEventProc(param1: WindowEvent, param2: IWindow): void
        {
            var _loc3_: WindowEvent;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                switch (param2.name)
                {
                    case ALERT_BUTTON_OK:
                        if (this._callback != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_138, null, null);
                            this._callback(this, _loc3_);
                            _loc3_.recycle();
                        }
                        else
                        {
                            this.dispose();
                        }

                        return;

                    case HEADER_BUTTON_CLOSE:
                        if (this._callback != null)
                        {
                            _loc3_ = WindowEvent.allocate(WindowEvent.var_139, null, null);
                            this._callback(this, _loc3_);
                            _loc3_.recycle();
                        }
                        else
                        {
                            this.dispose();
                        }

                        return;
                }

            }

        }

        public function getButtonCaption(flag: int): ICaption
        {
            var view: IInteractiveWindow;

            if (!this._disposed)
            {
                switch (flag)
                {
                    case HabboAlertDialogFlag.var_1047:
                        view = (this._window.findChildByName(ALERT_BUTTON_OK) as IInteractiveWindow);
                        
                        break;

                    case HabboAlertDialogFlag.var_1048:
                        view = (this._window.findChildByName(ALERT_BUTTON_CANCEL) as IInteractiveWindow);
                        
                        break;

                    case HabboAlertDialogFlag.var_1049:
                        view = (this._window.findChildByName(ALERT_BUTTON_CUSTOM) as IInteractiveWindow);
                        
                        break;

                }

            }

            return view ? new AlertDialogCaption(view.caption, view.toolTipCaption, view.visible) : null;
        }

        public function setButtonCaption(param1: int, param2: ICaption): void
        {
        }

        public function set title(param1: String): void
        {
            this._title = param1;
            if (this._window)
            {
                this._window.caption = this._title;
            }

        }

        public function get title(): String
        {
            return this._title;
        }

        public function set summary(param1: String): void
        {
            this._summary = param1;
            if (this._window)
            {
                ITextWindow(this._window.findChildByTag("DESCRIPTION")).text = this._summary;
            }

        }

        public function get summary(): String
        {
            return this._summary;
        }

        public function set callback(param1: Function): void
        {
            this._callback = param1;
        }

        public function get callback(): Function
        {
            return this._callback;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

    }
}
