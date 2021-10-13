package com.sulake.habbo.widget.roominfo
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.navigator.IHabboNavigator;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.widget.RoomWidgetFactory;
    import flash.events.IEventDispatcher;

    public class RoomInfoWidget extends RoomWidgetBase 
    {

        private var _view:IWindowContainer;
        private var _navigator:IHabboNavigator;

        public function RoomInfoWidget(param1:RoomWidgetFactory)
        {
            var _loc3_:IWindowContainer;
            var _loc4_:int;
            super(param1.windowManager, param1.assets, param1.localizations);
            this._navigator = param1.navigator;
            var _loc2_:XmlAsset = (assets.getAssetByName("room_info_widget") as XmlAsset);
            if (_loc2_)
            {
                this._view = (windowManager.buildFromXML((_loc2_.content as XML), 1) as IWindowContainer);
                _loc3_ = this._view.desktop;
                this._view.x = ((_loc3_.width - this._view.width) - 5);
                _loc4_ = ((param1.config.getKey("friendbar.enabled") == "true") ? 32 : 5);
                this._view.y = ((_loc3_.height - this._view.height) - _loc4_);
                this._view.visible = true;
                this._view.findChildByName("room_info").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onRoomInfoClick);
            };
        }

        override public function dispose():void
        {
            if (disposed)
            {
                return;
            };
            if (this._view)
            {
                this._view.dispose();
                this._view = null;
            };
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (!param1)
            {
                return;
            };
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
        }

        private function onRoomInfoClick(param1:WindowMouseEvent):void
        {
            this._navigator.toggleRoomInfo();
        }

    }
}