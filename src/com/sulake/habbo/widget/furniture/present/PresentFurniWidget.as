﻿package com.sulake.habbo.widget.furniture.present
{
    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.widget.events.RoomWidgetPresentDataUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetRoomObjectUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
    import flash.events.IEventDispatcher;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Point;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.habbo.widget.messages.RoomWidgetPresentOpenMessage;

    public class PresentFurniWidget extends RoomWidgetBase 
    {

        private var _window:IWindowContainer;
        private var var_2358:int = -1;
        private var _text:String;
        private var _controller:Boolean;
        private var var_4752:Boolean = false;

        public function PresentFurniWidget(param1:IHabboWindowManager, param2:IAssetLibrary=null)
        {
            super(param1, param2);
        }

        override public function dispose():void
        {
            this.hideInterface();
            super.dispose();
        }

        override public function registerUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1274, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1275, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1276, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1277, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1278, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetPresentDataUpdateEvent.var_1279, this.onObjectUpdate);
            param1.addEventListener(RoomWidgetRoomObjectUpdateEvent.var_1280, this.onRoomObjectRemoved);
            param1.addEventListener(RoomWidgetEcotronBoxDataUpdateEvent.var_1274, this.onEcotronUpdate);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1:IEventDispatcher):void
        {
            if (param1 == null)
            {
                return;
            };
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1274, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1275, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1276, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1277, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1278, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetPresentDataUpdateEvent.var_1279, this.onObjectUpdate);
            param1.removeEventListener(RoomWidgetEcotronBoxDataUpdateEvent.var_1274, this.onEcotronUpdate);
            param1.removeEventListener(RoomWidgetRoomObjectUpdateEvent.var_1280, this.onRoomObjectRemoved);
        }

        private function onObjectUpdate(param1:RoomWidgetPresentDataUpdateEvent):void
        {
            switch (param1.type)
            {
                case RoomWidgetPresentDataUpdateEvent.var_1274:
                    this.hideInterface();
                    this.var_4752 = false;
                    this.var_2358 = param1.objectId;
                    this._text = param1.text;
                    this._controller = param1.controller;
                    this.showInterface();
                    this.showIcon(param1.iconBitmapData);
                    return;
                case RoomWidgetPresentDataUpdateEvent.var_1277:
                    if (!this.var_4752)
                    {
                        return;
                    };
                    this.var_2358 = param1.objectId;
                    this._text = param1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_floor");
                    return;
                case RoomWidgetPresentDataUpdateEvent.var_1278:
                    if (!this.var_4752)
                    {
                        return;
                    };
                    this.var_2358 = param1.objectId;
                    this._text = param1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_landscape");
                    return;
                case RoomWidgetPresentDataUpdateEvent.var_1279:
                    if (!this.var_4752)
                    {
                        return;
                    };
                    this.var_2358 = param1.objectId;
                    this._text = param1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_wallpaper");
                    return;
                case RoomWidgetPresentDataUpdateEvent.var_1276:
                    if (!this.var_4752)
                    {
                        return;
                    };
                    this.var_2358 = param1.objectId;
                    this._text = param1.text;
                    this.showInterface();
                    this.showCustomIcon("packagecard_icon_hc");
                    return;
                case RoomWidgetPresentDataUpdateEvent.var_1275:
                    if (!this.var_4752)
                    {
                        return;
                    };
                    this.var_2358 = param1.objectId;
                    this._text = param1.text;
                    this.showGiftOpenedInterface();
                    this.showIcon(param1.iconBitmapData);
                    return;
            };
        }

        private function showGiftOpenedInterface():void
        {
            this.showInterface();
            if (this._window)
            {
                this._window.findChildByName("title").caption = this._text;
                this._window.findChildByName("text").caption = "${widget.furni.present.instructions}";
            };
        }

        private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent):void
        {
            if (param1.id == this.var_2358)
            {
                this.hideInterface();
            };
        }

        private function onEcotronUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent):void
        {
            switch (param1.type)
            {
                case RoomWidgetEcotronBoxDataUpdateEvent.var_1274:
                    this.hideInterface();
                    return;
            };
        }

        private function showCustomIcon(param1:String):void
        {
            var _loc3_:BitmapData;
            var _loc2_:BitmapDataAsset = (assets.getAssetByName(param1) as BitmapDataAsset);
            if (_loc2_ != null)
            {
                _loc3_ = (_loc2_.content as BitmapData);
            };
            this.showIcon(_loc3_);
        }

        private function showIcon(param1:BitmapData):void
        {
            if (param1 == null)
            {
                param1 = new BitmapData(1, 1);
            };
            if (this._window == null)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("gift_image") as IBitmapWrapperWindow);
            if (_loc2_.bitmap != null)
            {
                _loc2_.bitmap.dispose();
            };
            _loc2_.bitmap = new BitmapData(_loc2_.width, _loc2_.height, true, 0);
            var _loc3_:Point = new Point(((_loc2_.width - param1.width) / 2), ((_loc2_.height - param1.height) / 2));
            _loc2_.bitmap.copyPixels(param1, param1.rect, _loc3_);
        }

        private function showInterface():void
        {
            var _loc4_:ITextWindow;
            var _loc5_:BitmapData;
            if (this.var_2358 < 0)
            {
                return;
            };
            if (this._window != null)
            {
                this._window.dispose();
            };
            var _loc1_:XmlAsset = (assets.getAssetByName("packagecard") as XmlAsset);
            this._window = (windowManager.buildFromXML((_loc1_.content as XML)) as IWindowContainer);
            this._window.center();
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("image_bg") as IBitmapWrapperWindow);
            var _loc3_:BitmapDataAsset = (assets.getAssetByName("yellow_highlight") as BitmapDataAsset);
            if (((_loc2_) && (_loc3_)))
            {
                _loc5_ = (_loc3_.content as BitmapData);
                if (_loc2_.bitmap)
                {
                    _loc2_.bitmap.dispose();
                };
                _loc2_.bitmap = _loc5_.clone();
            };
            _loc4_ = (this._window.findChildByName("text") as ITextWindow);
            if (((!(_loc4_ == null)) && (!(this._text == null))))
            {
                _loc4_.caption = this._text;
            };
            if (!this._controller)
            {
                this.hideOpenButton();
            };
            this._window.procedure = this.handleWindowEvent;
        }

        private function onWindowClose(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            this.var_4752 = false;
            this.hideInterface();
        }

        private function hideInterface():void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (!this.var_4752)
            {
                this.var_2358 = -1;
            };
            this._text = "";
            this._controller = false;
        }

        private function sendOpen():void
        {
            var _loc1_:RoomWidgetPresentOpenMessage;
            if ((((this.var_4752) || (this.var_2358 == -1)) || (!(this._controller))))
            {
                return;
            };
            this.var_4752 = true;
            if (messageListener != null)
            {
                _loc1_ = new RoomWidgetPresentOpenMessage(RoomWidgetPresentOpenMessage.var_1281, this.var_2358);
                messageListener.processWidgetMessage(_loc1_);
            };
        }

        private function hideOpenButton():void
        {
            if (this._window == null)
            {
                return;
            };
            var _loc1_:IWindow = this._window.findChildByName("open");
            if (_loc1_ != null)
            {
                _loc1_.visible = false;
            };
        }

        private function handleWindowEvent(param1:WindowEvent, param2:IWindow):void
        {
            if (param1.type != WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                return;
            };
            switch (param2.name)
            {
                case "open":
                    this.sendOpen();
                    return;
                case "close":
                    this.var_4752 = false;
                    this.hideInterface();
                    return;
                default:
                    if (param2.tags.indexOf("close") != -1)
                    {
                        this.hideInterface();
                    };
            };
        }

    }
}