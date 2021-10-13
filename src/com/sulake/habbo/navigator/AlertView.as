package com.sulake.habbo.navigator
{
    import com.sulake.core.runtime.IDisposable;
    import flash.utils.Dictionary;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.IWindow;
    import flash.geom.Rectangle;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class AlertView implements IDisposable 
    {

        private static var var_3426:Dictionary = new Dictionary();

        private var _navigator:HabboNavigator;
        protected var var_3859:IFrameWindow;
        protected var var_3427:String;
        protected var _title:String;
        protected var _disposed:Boolean;

        public function AlertView(param1:HabboNavigator, param2:String, param3:String=null)
        {
            this._navigator = param1;
            this.var_3427 = param2;
            this._title = param3;
        }

        public static function findAlertView(param1:IWindow):AlertView
        {
            var _loc2_:AlertView;
            if (var_3426 != null)
            {
                for each (_loc2_ in var_3426)
                {
                    if (_loc2_.var_3859 == param1)
                    {
                        return (_loc2_);
                    };
                };
            };
            return (null);
        }

        public function show():void
        {
            var _loc1_:AlertView = (var_3426[this.var_3427] as AlertView);
            if (_loc1_ != null)
            {
                _loc1_.dispose();
            };
            this.var_3859 = this.getAlertWindow();
            if (this._title != null)
            {
                this.var_3859.caption = this._title;
            };
            this.setupAlertWindow(this.var_3859);
            var _loc2_:Rectangle = Util.getLocationRelativeTo(this.var_3859.desktop, this.var_3859.width, this.var_3859.height);
            this.var_3859.x = _loc2_.x;
            this.var_3859.y = _loc2_.y;
            var_3426[this.var_3427] = this;
            this.var_3859.activate();
        }

        public function dispose():void
        {
            if (this._disposed)
            {
                return;
            };
            if (var_3426[this.var_3427] == this)
            {
                var_3426[this.var_3427] = null;
            };
            this._disposed = true;
            if (this.var_3859 != null)
            {
                this.var_3859.destroy();
                this.var_3859 = null;
            };
            this._navigator = null;
        }

        internal function setupAlertWindow(param1:IFrameWindow):void
        {
        }

        internal function onClose(param1:WindowMouseEvent):void
        {
            this.dispose();
        }

        private function getAlertWindow():IFrameWindow
        {
            var _loc1_:IFrameWindow = (this._navigator.getXmlWindow(this.var_3427, 2) as IFrameWindow);
            var _loc2_:IWindow = _loc1_.findChildByTag("close");
            if (_loc2_ != null)
            {
                _loc2_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onClose);
            };
            return (_loc1_);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get navigator():HabboNavigator
        {
            return (this._navigator);
        }

    }
}