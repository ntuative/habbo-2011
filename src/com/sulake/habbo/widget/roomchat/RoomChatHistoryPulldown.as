package com.sulake.habbo.widget.roomchat
{
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IRegionWindow;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.window.enum.HabboWindowType;
    import com.sulake.habbo.window.enum.HabboWindowStyle;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Rectangle;
    import com.sulake.core.window.enum.WindowType;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.assets.XmlAsset;
    import flash.geom.Point;

    public class RoomChatHistoryPulldown 
    {

        public static const var_1836:int = 3;
        public static const var_1835:int = 2;
        public static const var_1834:int = 1;
        public static const var_1833:int = 0;
        public static const var_1322:int = 39;
        private static const var_4906:int = 150;
        private static const var_4907:int = 250;

        private var _widget:RoomChatWidget;
        private var _windowManager:IHabboWindowManager;
        private var _window:IWindowContainer;
        private var var_4905:IBitmapWrapperWindow;
        private var var_2083:IWindowContainer;
        private var _region:IRegionWindow;
        private var _assetLibrary:IAssetLibrary;
        private var var_4908:int = 0;
        private var _state:int = -1;
        private var var_4909:BitmapData;
        private var var_4910:BitmapData;
        private var var_4911:BitmapData;
        private var var_4912:BitmapData;
        private var var_4913:BitmapData;
        private var var_4914:BitmapData;
        private var var_4915:BitmapData;
        private var var_4916:int = 30;

        public function RoomChatHistoryPulldown(param1:RoomChatWidget, param2:IHabboWindowManager, param3:IWindowContainer, param4:IAssetLibrary)
        {
            this._widget = param1;
            this._windowManager = param2;
            this._assetLibrary = param4;
            this.var_2083 = param3;
            this.var_4909 = ((this._assetLibrary.getAssetByName("chat_grapbar_bg") as BitmapDataAsset).content as BitmapData);
            this.var_4910 = ((this._assetLibrary.getAssetByName("chat_grapbar_grip") as BitmapDataAsset).content as BitmapData);
            this.var_4911 = ((this._assetLibrary.getAssetByName("chat_grapbar_handle") as BitmapDataAsset).content as BitmapData);
            this.var_4912 = ((this._assetLibrary.getAssetByName("chat_grapbar_x") as BitmapDataAsset).content as BitmapData);
            this.var_4913 = ((this._assetLibrary.getAssetByName("chat_grapbar_x_hi") as BitmapDataAsset).content as BitmapData);
            this.var_4914 = ((this._assetLibrary.getAssetByName("chat_grapbar_x_pr") as BitmapDataAsset).content as BitmapData);
            this.var_4915 = ((this._assetLibrary.getAssetByName("chat_history_bg") as BitmapDataAsset).content as BitmapData);
            this.var_4905 = (this._windowManager.createWindow("chat_history_bg", "", HabboWindowType.var_155, HabboWindowStyle.var_525, HabboWindowParam.var_158, new Rectangle(0, 0, param3.width, (param3.height - var_1322)), null, 0, 0) as IBitmapWrapperWindow);
            this.var_2083.addChild(this.var_4905);
            this._window = (this._windowManager.createWindow("chat_pulldown", "", HabboWindowType.var_182, HabboWindowStyle.var_525, (HabboWindowParam.var_157 | HabboWindowParam.var_158), new Rectangle(0, (this.var_2083.height - var_1322), param3.width, var_1322), null, 0) as IWindowContainer);
            this.var_2083.addChild(this._window);
            this._region = (this._windowManager.createWindow("REGIONchat_pulldown", "", WindowType.var_1000, HabboWindowStyle.var_156, (((HabboWindowParam.var_157 | HabboWindowParam.var_158) | HabboWindowParam.var_793) | HabboWindowParam.var_798), new Rectangle(0, 0, param3.width, (param3.height - var_1322)), null, 0) as IRegionWindow);
            if (this._region != null)
            {
                this._region.background = true;
                this._region.mouseThreshold = 0;
                this._region.addEventListener(WindowMouseEvent.var_628, this.onPulldownMouseDown);
                this.var_2083.addChild(this._region);
                this._region.toolTipCaption = "${chat.history.drag.tooltip}";
                this._region.toolTipDelay = 250;
            };
            var _loc5_:XmlAsset = (param4.getAssetByName("chat_history_pulldown") as XmlAsset);
            this._window.buildFromXML((_loc5_.content as XML));
            this._window.addEventListener(WindowMouseEvent.var_628, this.onPulldownMouseDown);
            var _loc6_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc6_ != null)
            {
                _loc6_.mouseThreshold = 0;
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.get);
                _loc6_.addEventListener(WindowMouseEvent.var_633, this.onCloseButtonMouseUp);
                _loc6_.addEventListener(WindowMouseEvent.var_628, this.onCloseButtonMouseDown);
                _loc6_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onCloseButtonMouseOver);
                _loc6_.addEventListener(WindowMouseEvent.var_626, this.onCloseButtonMouseOut);
            };
            this._window.background = true;
            this._window.color = 0;
            this._window.mouseThreshold = 0;
            this.state = var_1833;
            this.buildWindowGraphics();
        }

        public function dispose():void
        {
            if (this._region != null)
            {
                this._region.dispose();
                this._region = null;
            };
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_4905 != null)
            {
                this.var_4905.dispose();
                this.var_4905 = null;
            };
        }

        public function update(param1:uint):void
        {
            switch (this.state)
            {
                case var_1835:
                    this.var_4905.blend = (this.var_4905.blend + (param1 / var_4907));
                    this._window.blend = (this._window.blend + (param1 / var_4907));
                    if (this._window.blend >= 1)
                    {
                        this.state = var_1834;
                    };
                    return;
                case var_1836:
                    this.var_4905.blend = (this.var_4905.blend - (param1 / var_4906));
                    this._window.blend = (this._window.blend - (param1 / var_4906));
                    if (this._window.blend <= 0)
                    {
                        this.state = var_1833;
                    };
                    return;
            };
        }

        public function set state(param1:int):void
        {
            if (param1 == this._state)
            {
                return;
            };
            switch (param1)
            {
                case var_1834:
                    if (this._state == var_1833)
                    {
                        this.state = var_1835;
                    }
                    else
                    {
                        if (((this._window == null) || (this.var_4905 == null)))
                        {
                            return;
                        };
                        this._window.visible = true;
                        this.var_4905.visible = true;
                        this._region.visible = true;
                        this._state = param1;
                    };
                    return;
                case var_1833:
                    if (((this._window == null) || (this.var_4905 == null)))
                    {
                        return;
                    };
                    this._window.visible = false;
                    this.var_4905.visible = false;
                    this._region.visible = false;
                    this._state = param1;
                    return;
                case var_1835:
                    if (((this._window == null) || (this.var_4905 == null)))
                    {
                        return;
                    };
                    this._window.blend = 0;
                    this.var_4905.blend = 0;
                    this._window.visible = true;
                    this.var_4905.visible = true;
                    this._state = param1;
                    return;
                case var_1836:
                    if (((this._window == null) || (this.var_4905 == null)))
                    {
                        return;
                    };
                    this._window.blend = 1;
                    this.var_4905.blend = 1;
                    this._state = param1;
                    return;
            };
        }

        public function get state():int
        {
            return (this._state);
        }

        public function containerResized(param1:Rectangle):void
        {
            if (this._window != null)
            {
                this._window.x = 0;
                this._window.y = (this.var_2083.height - var_1322);
                this._window.width = this.var_2083.width;
            };
            if (this._region != null)
            {
                this._region.x = 0;
                this._region.y = (this.var_2083.height - var_1322);
                this._region.width = (this.var_2083.width - this.var_4916);
            };
            if (this.var_4905 != null)
            {
                this.var_4905.rectangle = this.var_2083.rectangle;
                this.var_4905.height = (this.var_4905.height - var_1322);
            };
            this.buildWindowGraphics();
        }

        private function buildWindowGraphics():void
        {
            var _loc7_:BitmapData;
            var _loc8_:BitmapData;
            var _loc9_:BitmapData;
            if (this._window == null)
            {
                return;
            };
            if (this.var_4908 == this._window.width)
            {
                return;
            };
            this.var_4908 = this._window.width;
            var _loc1_:IBitmapWrapperWindow = (this._window.findChildByName("grapBarBg") as IBitmapWrapperWindow);
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            var _loc3_:IBitmapWrapperWindow = (this._window.findChildByName("grapBarGripL") as IBitmapWrapperWindow);
            var _loc4_:IBitmapWrapperWindow = (this._window.findChildByName("grapBarGripR") as IBitmapWrapperWindow);
            var _loc5_:IBitmapWrapperWindow = (this._window.findChildByName("grapBarHandle") as IBitmapWrapperWindow);
            var _loc6_:int = 5;
            if (((!(_loc2_ == null)) && (!(_loc5_ == null))))
            {
                _loc5_.bitmap = this.var_4911;
                _loc5_.disposesBitmap = false;
                _loc2_.bitmap = this.var_4912;
                _loc2_.disposesBitmap = false;
                this.var_4916 = (this._window.width - _loc2_.x);
            };
            _loc3_.width = (_loc5_.x - _loc6_);
            _loc3_.x = 0;
            _loc4_.x = ((_loc5_.x + _loc5_.width) + _loc6_);
            _loc4_.width = ((_loc2_.x - _loc6_) - _loc4_.x);
            if (_loc3_.width < 0)
            {
                _loc3_.width = 0;
            };
            if (_loc4_.width < 0)
            {
                _loc4_.width = 0;
            };
            if ((((!(_loc1_ == null)) && (!(_loc3_ == null))) && (!(_loc4_ == null))))
            {
                if (((_loc1_.width > 0) && (_loc1_.height > 0)))
                {
                    _loc7_ = new BitmapData(_loc1_.width, _loc1_.height);
                    this.tileBitmapHorz(this.var_4909, _loc7_);
                    _loc1_.disposesBitmap = true;
                    _loc1_.bitmap = _loc7_;
                };
                if (((_loc3_.width > 0) && (_loc3_.height > 0)))
                {
                    _loc8_ = new BitmapData(_loc3_.width, _loc3_.height);
                    this.tileBitmapHorz(this.var_4910, _loc8_);
                    _loc3_.disposesBitmap = true;
                    _loc3_.bitmap = _loc8_;
                };
                if (((_loc4_.width > 0) && (_loc4_.height > 0)))
                {
                    _loc9_ = new BitmapData(_loc4_.width, _loc4_.height);
                    this.tileBitmapHorz(this.var_4910, _loc9_);
                    _loc4_.disposesBitmap = true;
                    _loc4_.bitmap = _loc9_;
                };
            };
            if (this.var_4905 == null)
            {
                return;
            };
            this.var_4905.bitmap = this.var_4915;
            this.var_4905.disposesBitmap = false;
        }

        private function tileBitmapHorz(param1:BitmapData, param2:BitmapData):void
        {
            var _loc3_:int = int((param2.width / param1.width));
            var _loc4_:int;
            while (_loc4_ < (_loc3_ + 1))
            {
                param2.copyPixels(param1, param1.rect, new Point((_loc4_ * param1.width), 0));
                _loc4_++;
            };
        }

        private function onPulldownMouseDown(param1:WindowMouseEvent):void
        {
            if (this._widget != null)
            {
                this._widget.onPulldownMouseDown(param1);
            };
        }

        private function get(param1:WindowMouseEvent):void
        {
            if (this._widget != null)
            {
                this._widget.onPulldownCloseButtonClicked(param1);
            };
        }

        private function onCloseButtonMouseOver(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_4913;
            };
        }

        private function onCloseButtonMouseOut(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_4912;
            };
        }

        private function onCloseButtonMouseDown(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_4914;
            };
        }

        private function onCloseButtonMouseUp(param1:WindowMouseEvent):void
        {
            if (this._window == null)
            {
                return;
            };
            if (!this._window.visible)
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("GrapBarX") as IBitmapWrapperWindow);
            if (_loc2_ != null)
            {
                _loc2_.disposesBitmap = false;
                _loc2_.bitmap = this.var_4913;
            };
        }

    }
}