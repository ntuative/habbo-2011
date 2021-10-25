package com.sulake.habbo.navigator.roomsettings
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.navigator.Util;

    import flash.geom.Rectangle;

    import com.sulake.core.window.components.ITextWindow;

    public class ConfirmDialogView implements IDisposable
    {

        private var _disposed: Boolean;
        private var _window: IFrameWindow;
        private var var_3814: Function;
        private var var_3815: Object;
        private var var_2373: Array;

        public function ConfirmDialogView(param1: IFrameWindow, param2: Object, param3: Function, param4: Array)
        {
            this._window = param1;
            this.var_3814 = param3;
            this.var_3815 = param2;
            this.var_2373 = param4;
            this._window.findChildByTag("close")
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            this._window.findChildByName("cancel")
                    .addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onCancel);
            this._window.findChildByName("ok").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onOk);
        }

        private function onCancel(param1: WindowMouseEvent): void
        {
            this.dispose();
        }

        private function onOk(param1: WindowMouseEvent): void
        {
            this.var_3814.apply(this.var_3815, [param1].concat(this.var_2373));
            this.dispose();
        }

        public function show(): void
        {
            var _loc1_: Rectangle = Util.getLocationRelativeTo(this._window.desktop, this._window.width, this._window.height);
            this._window.x = _loc1_.x;
            this._window.y = _loc1_.y;
            this._window.visible = true;
            this._window.activate();
        }

        public function dispose(): void
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
            if (this._window != null)
            {
                this._window.destroy();
                this._window = null;
            }

            this.var_3815 = null;
            this.var_3814 = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function set message(param1: String): void
        {
            ITextWindow(this._window.findChildByName("message")).text = param1;
        }

    }
}
