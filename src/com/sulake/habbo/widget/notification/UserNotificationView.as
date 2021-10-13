package com.sulake.habbo.widget.notification
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class UserNotificationView implements IDisposable 
    {

        protected static const var_4867:String = "button_ok";
        protected static const var_4868:String = "text_title";
        protected static const DESCRIPTION_NAME:String = "text_description";
        protected static const var_4869:String = "widget_notification_frame";

        private var _widget:UserNotificationWidget;
        private var _disposed:Boolean = false;
        private var var_4870:Array;

        public function UserNotificationView(param1:UserNotificationWidget)
        {
            this._widget = param1;
            this.var_4870 = new Array();
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                if (this.var_4870)
                {
                    while (this.var_4870.length > 0)
                    {
                        this.var_4870.pop().dispose();
                    };
                    this.var_4870 = null;
                };
                this._widget = null;
                this._disposed = true;
            };
        }

        public function showNotification(title:String, description:String):Boolean
        {
            var asset:XmlAsset = (this._widget.assets.getAssetByName("notification") as XmlAsset);
            if (!asset)
            {
                return (false);
            };
            var xml:XML = XML(asset.content);
            var dialog:IFrameWindow = IFrameWindow(this._widget.windowManager.buildFromXML(xml));
            if (!dialog)
            {
                return (false);
            };
            dialog.caption = title;
            dialog.findChildByName(var_4868).caption = title;
            dialog.findChildByName(DESCRIPTION_NAME).caption = description;
            dialog.center();
            dialog.findChildByName(var_4867).addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, function (param1:WindowMouseEvent):void
            {
                hideNotification(IFrameWindow(param1.window.host));
            });
            dialog.findChildByName("header_button_close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, function (param1:WindowMouseEvent):void
            {
                hideNotification(IFrameWindow(param1.window.host));
            });
            this.var_4870.push(dialog);
            return (true);
        }

        public function hideNotification(param1:IFrameWindow):void
        {
            var _loc2_:int;
            if (param1 != null)
            {
                _loc2_ = this.var_4870.indexOf(param1);
                if (_loc2_ > -1)
                {
                    this.var_4870.splice(_loc2_, 1);
                };
                param1.dispose();
            };
        }

    }
}