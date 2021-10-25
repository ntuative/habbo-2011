package com.sulake.habbo.notifications
{

    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.toolbar.IHabboToolbar;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.utils.Map;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.assets.IAsset;
    import com.sulake.habbo.window.IHabboWindowManager;

    import flash.display.BitmapData;

    import com.sulake.habbo.session.events.BadgeImageReadyEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;

    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class HabboNotificationItemView implements IUpdateReceiver
    {

        public static const var_542: int = 70;
        public static const var_1651: int = 4;
        private static const var_2541: int = 0;
        private static const var_1835: int = 1;
        private static const var_3895: int = 2;
        private static const var_1836: int = 3;
        private static const var_3896: Number = 50;

        private var _toolbar: IHabboToolbar;
        private var _window: IWindow;
        private var var_3299: HabboNotificationItem;
        private var var_3897: Boolean = false;
        private var _unknown1: Map;
        private var var_3899: Map;
        private var var_3900: uint;
        private var var_3901: uint;
        private var var_3902: uint;
        private var _verticalPosition: int;
        private var _blend: Number;
        private var var_3904: int;
        private var var_3905: int;
        private var _state: int;

        public function HabboNotificationItemView(param1: IAsset, window: IHabboWindowManager, param3: Map, param4: Map, param5: IHabboToolbar, param6: HabboNotificationItem)
        {
            this._unknown1 = param3;
            this.var_3899 = param4;
            var _loc7_: XmlAsset = param1 as XmlAsset;
            if (_loc7_ == null)
            {
                return;
            }

            this._window = window.buildFromXML(_loc7_.content as XML, 1);
            this._window.tags.push("notificationview");
            this._window.context.getDesktopWindow().addEventListener(WindowEvent.var_573, this.onRoomViewResized);
            this._window.procedure = this.onWindowEvent;
            this._window.blend = 0;
            this._window.visible = false;
            var _loc8_: ITextWindow = IWindowContainer(this._window).findChildByTag("notification_text") as ITextWindow;
            if (_loc8_ != null)
            {
                this.var_3904 = this._window.height - _loc8_.rectangle.bottom;
            }
            else
            {
                this.var_3904 = 15;
            }

            this.var_3905 = this._window.height;
            this._verticalPosition = 4;
            this._blend = 0;
            this._state = var_2541;
            this._toolbar = param5;
            this.showItem(param6);
        }

        public function get disposed(): Boolean
        {
            return this._window == null;
        }

        public function get ready(): Boolean
        {
            return this._state == var_2541;
        }

        public function get verticalPosition(): int
        {
            return this._verticalPosition;
        }

        private function showItem(param1: HabboNotificationItem): void
        {
            if (param1 == null)
            {
                return;
            }

            var _loc2_: String = param1.content;
            this.setNotificationText(_loc2_);
            var _loc3_: BitmapData = param1.style.icon;
            this.setNotificationIcon(_loc3_);
            this.var_3299 = param1;
            this.reposition();
            this.startFadeIn();
        }

        public function replaceIcon(param1: BadgeImageReadyEvent): void
        {
            if (param1.badgeId != this.var_3299.style.iconSrc)
            {
                return;
            }

            if (param1.badgeImage != null)
            {
                this.setNotificationIcon(param1.badgeImage);
            }

        }

        public function update(param1: uint): void
        {
            var _loc2_: Number;
            var _loc3_: Number;
            switch (this._state)
            {
                case var_2541:
                    return;
                case var_1835:
                    this.var_3900 = this.var_3900 + param1;
                    _loc2_ = Number(this.var_3900) / Number(this.var_3899["time_fade_in"]);
                    if (this.var_3900 > int(this.var_3899["time_fade_in"]))
                    {
                        this.startDisplay();
                    }

                    this.adjustBlend(_loc2_);
                    return;
                case var_3895:
                    this.var_3902 = this.var_3902 + param1;
                    if (this.var_3902 > int(this.var_3899["time_display"]) && !this.var_3897)
                    {
                        this.startFadeOut();
                    }

                    return;
                case var_1836:
                    this.var_3901 = this.var_3901 + param1;
                    _loc3_ = 1 - Number(this.var_3901) / Number(this.var_3899["time_fade_out"]);
                    this.adjustBlend(_loc3_);
                    if (this.var_3901 > int(this.var_3899["time_fade_in"]))
                    {
                        this.startIdling();
                    }

                    return;
            }

        }

        public function dispose(): void
        {
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            }

            if (this.var_3299 != null)
            {
                this.var_3299.dispose();
                this.var_3299 = null;
            }

        }

        private function setNotificationText(param1: String): void
        {
            var _loc2_: ITextWindow = IWindowContainer(this._window).findChildByTag("notification_text") as ITextWindow;
            if (_loc2_ == null || param1 == null)
            {
                return;
            }

            this._window.height = 0;
            _loc2_.text = param1;
            _loc2_.height = _loc2_.textHeight + this.var_3904;
            if (this._window.height < this.var_3905)
            {
                this._window.height = this.var_3905;
            }

        }

        private function setNotificationIcon(param1: BitmapData): void
        {
            var _loc3_: BitmapData;
            var _loc4_: int;
            var _loc5_: int;
            var _loc6_: int;
            var _loc2_: IBitmapWrapperWindow = IWindowContainer(this._window)
                    .findChildByTag("notification_icon") as IBitmapWrapperWindow;
            if (_loc2_ == null)
            {
                return;
            }

            if (param1 == null)
            {
                _loc2_.bitmap = null;
                return;
            }

            if (param1.width < _loc2_.width && param1.height < _loc2_.height)
            {
                _loc3_ = new BitmapData(_loc2_.width, _loc2_.height, true, 0);
                _loc5_ = int((_loc2_.width - param1.width) / 2);
                _loc6_ = int((_loc2_.height - param1.height) / 2);
                _loc3_.copyPixels(param1, param1.rect, new Point(_loc5_, _loc6_));
            }
            else
            {
                if (param1.width < param1.height)
                {
                    _loc3_ = new BitmapData(param1.height, param1.height, true, 0);
                    _loc4_ = int((param1.height - param1.width) / 2);
                    _loc3_.copyPixels(param1, param1.rect, new Point(_loc4_, 0));
                }
                else
                {
                    if (param1.width > param1.height)
                    {
                        _loc3_ = new BitmapData(param1.width, param1.width, true, 0);
                        _loc4_ = int((param1.width - param1.height) / 2);
                        _loc3_.copyPixels(param1, param1.rect, new Point(0, _loc4_));
                    }
                    else
                    {
                        _loc3_ = new BitmapData(param1.width, param1.height);
                        _loc3_.copyPixels(param1, param1.rect, new Point(0, 0));
                    }

                }

            }

            _loc2_.bitmap = _loc3_;
        }

        private function startFadeIn(): void
        {
            this.var_3900 = 0;
            this._state = var_1835;
            this._window.visible = true;
        }

        private function startFadeOut(): void
        {
            this.var_3901 = 0;
            this._state = var_1836;
        }

        private function startDisplay(): void
        {
            this.var_3902 = 0;
            this._state = var_3895;
        }

        private function startIdling(): void
        {
            this._state = var_2541;
            this._window.visible = false;
        }

        public function reposition(param1: int = -1): void
        {
            if (this._window == null)
            {
                return;
            }

            if (this._toolbar == null)
            {
                return;
            }

            var _loc2_: IDesktopWindow = this._window.context.getDesktopWindow();
            if (_loc2_ == null)
            {
                return;
            }

            if (param1 != -1)
            {
                this._verticalPosition = param1;
            }

            var _loc3_: int = this._toolbar.orientation == "TOP" ? var_3896 : 0;
            var _loc4_: int = this._toolbar.orientation == "BOTTOM" ? _loc2_.height - var_3896 : _loc2_.height;
            var _loc5_: int = this._toolbar.orientation == "LEFT" ? var_3896 : 0;
            var _loc6_: int = this._toolbar.orientation == "RIGHT" ? _loc2_.width - var_3896 : _loc2_.width;
            if (this.var_3899["position_horizontal_follow_toolbar"] == "true" && (this._toolbar.orientation != "TOP" && this._toolbar.orientation != "BOTTOM"))
            {
                if (this._toolbar.orientation == "LEFT")
                {
                    this._window.x = _loc5_ + var_1651;
                }
                else
                {
                    this._window.x = _loc6_ - this._window.width - var_1651;
                }

            }
            else
            {
                if (this.var_3899["position_horizontal"] == "left")
                {
                    this._window.x = _loc5_ + var_1651;
                }
                else
                {
                    this._window.x = _loc6_ - this._window.width - var_1651;
                }

            }

            if (this.var_3899["position_vertical_follow_toolbar"] == "true" && (this._toolbar.orientation != "RIGHT" && this._toolbar.orientation != "LEFT"))
            {
                if (this._toolbar.orientation == "TOP")
                {
                    this._window.y = _loc3_ + this._verticalPosition;
                }
                else
                {
                    this._window.y = _loc4_ - this._window.height - this._verticalPosition;
                }

            }
            else
            {
                if (this.var_3899["position_vertical"] == "top")
                {
                    this._window.y = _loc3_ + this._verticalPosition;
                }
                else
                {
                    this._window.y = _loc4_ - this._window.height - this._verticalPosition;
                }

            }

        }

        public function onWindowEvent(param1: WindowEvent, param2: IWindow): void
        {
            if (param1 == null)
            {
                return;
            }

            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                this.var_3897 = true;
                Logger.log("notifications - hover on");
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_626)
                {
                    this.var_3897 = false;
                    Logger.log("notifications - hover off");
                }
                else
                {
                    if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
                    {
                        if (this.var_3299 != null)
                        {
                            this.var_3299.ExecuteUiLinks();
                        }

                    }

                }

            }

        }

        private function onRoomViewResized(event: WindowEvent): void
        {
            this.reposition();
        }

        private function adjustBlend(value: Number): void
        {
            this._blend = value;

            if (this._blend > 1)
            {
                this._blend = 1;
            }

            if (this._blend < 0)
            {
                this._blend = 0;
            }

            this._window.blend = this._blend;
        }

    }
}
