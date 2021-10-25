package com.sulake.habbo.widget.memenu
{

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;

    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;

    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IButtonWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.display.BitmapData;
    import flash.geom.Point;

    import com.sulake.core.assets.BitmapDataAsset;

    public class EffectView
    {

        private const var_4833: int = 1000;

        private var _container: MeMenuEffectsView;
        private var _window: IWindowContainer;
        private var var_3943: IWidgetAvatarEffect;
        private var var_4834: IWindow;
        private var var_2340: Number;
        private var var_4835: ITextWindow;
        private var var_2270: Timer;
        private var var_4836: IWindow;

        public function EffectView()
        {
            this.var_2270 = new Timer(this.var_4833);
            this.var_2270.addEventListener(TimerEvent.TIMER, this.onUpdate);
        }

        public function get effect(): IWidgetAvatarEffect
        {
            return this.var_3943;
        }

        public function init(param1: MeMenuEffectsView, param2: String, param3: IWidgetAvatarEffect): void
        {
            this.var_3943 = param3;
            this._container = param1;
            this.createWindow(param2);
        }

        public function dispose(): void
        {
            if (this.var_2270 != null)
            {
                this.var_2270.stop();
                this.var_2270.removeEventListener(TimerEvent.TIMER, this.onUpdate);
                this.var_2270 = null;
            }

            this._container = null;
            if (this._window != null)
            {
                this._window.dispose();
                this._window = null;
            }

        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        private function onUpdate(param1: Event = null): void
        {
            var _loc2_: Number;
            if (this.var_4834 == null)
            {
                this.var_2270.stop();
                return;
            }

            if (this.var_3943.isActive)
            {
                _loc2_ = this.var_3943.secondsLeft / Number(this.var_3943.duration);
                this.var_4834.width = _loc2_ * this.var_2340;
            }
            else
            {
                this.var_4834.width = 0;
                this.var_2270.stop();
            }

            this.setTimeLeft();
        }

        private function setTimeLeft(): void
        {
            if (this.var_4835 == null)
            {
                this.var_4835 = (this._window.findChildByName("time_left") as ITextWindow);
                if (this.var_4835 == null)
                {
                    return;
                }

            }

            if (!this.var_3943.isActive)
            {
                this.var_4835.caption = "${widgets.memenu.effects.activate}";
                return;
            }

            this.var_4835.caption = "${widgets.memenu.effects.active.timeleft}";
            var _loc1_: String = this.var_4835.text;
            var _loc2_: int = this.var_3943.secondsLeft;
            var _loc3_: int = int(Math.floor(_loc2_ / (60 * 60)));
            var _loc4_: int = int(Math.floor(_loc2_ / 60) % 60);
            var _loc5_: int = _loc2_ % 60;
            var _loc6_: String = _loc3_ < 10 ? "0" : "";
            var _loc7_: String = _loc4_ < 10 ? "0" : "";
            var _loc8_: String = _loc5_ < 10 ? "0" : "";
            if (_loc3_ > 0)
            {
                _loc1_ = _loc1_.replace("%time_left%", _loc6_ + _loc3_ + ":" + _loc7_ + _loc4_ + ":" + _loc8_ + _loc5_);
            }
            else
            {
                _loc1_ = _loc1_.replace("%time_left%", _loc7_ + _loc4_ + ":" + _loc8_ + _loc5_);
            }

            this.var_4835.text = _loc1_;
        }

        private function createWindow(param1: String): void
        {
            var _loc2_: XmlAsset;
            var _loc7_: IButtonWindow;
            var _loc3_: String = "";
            if (this.var_3943.isInUse)
            {
                _loc3_ = "memenu_effect_selected";
            }
            else
            {
                if (this.var_3943.isActive)
                {
                    _loc3_ = "memenu_effect_unselected";
                }
                else
                {
                    _loc3_ = "memenu_effect_inactive";
                }

            }

            _loc2_ = (this._container.widget.assets.getAssetByName(_loc3_) as XmlAsset);
            this._window = (this._container.widget.windowManager.buildFromXML(_loc2_.content as XML) as IWindowContainer);
            if (this._window == null)
            {
                throw new Error("Failed to construct window from XML!");
            }

            this._window.name = param1;
            this._container.effectsContainer.addChild(this._window);
            var _loc4_: ITextWindow = this._window.findChildByName("effect_name") as ITextWindow;
            if (_loc4_ != null)
            {
                _loc4_.caption = "${fx_" + this.var_3943.type + "}";
            }

            var _loc5_: ITextWindow = this._window.findChildByName("effect_amount") as ITextWindow;
            if (_loc5_ != null)
            {
                _loc5_.caption = this.var_3943.effectsInInventory + "";
            }

            var _loc6_: IWindowContainer = this._window.findChildByName("effect_amount_bg1") as IWindowContainer;
            if (this.var_3943.effectsInInventory < 2)
            {
                if (_loc6_ != null)
                {
                    _loc6_.visible = false;
                }

            }

            if (_loc3_ == "memenu_effect_inactive")
            {
                _loc7_ = (this._window.findChildByName("activate_effect") as IButtonWindow);
                if (_loc7_ != null)
                {
                    _loc7_.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                }

            }
            else
            {
                this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseEvent);
                if (this.var_3943.isActive)
                {
                    this._window.addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER, this.onMouseEvent);
                    this._window.addEventListener(WindowMouseEvent.var_626, this.onMouseEvent);
                }

                if (this.var_3943.isInUse)
                {
                    this.setElementImage("effect_hilite", "memenu_fx_pause");
                }
                else
                {
                    this.setElementImage("effect_hilite", "memenu_fx_play");
                }

                this.var_4836 = this._window.findChildByName("effect_hilite");
                this.var_4836.visible = false;
            }

            this.setTimeLeft();
            this.var_4834 = this._window.findChildByName("loader_bar");
            if (this.var_4834 != null)
            {
                this.var_2340 = this.var_4834.width;
                this.var_2270.start();
                this.onUpdate();
            }

            if (this.var_3943.icon)
            {
                this.setElementBitmap("effect_icon", this.var_3943.icon);
            }

        }

        private function setElementBitmap(param1: String, param2: BitmapData): void
        {
            var _loc3_: IBitmapWrapperWindow = this._window.findChildByName(param1) as IBitmapWrapperWindow;
            if (_loc3_ != null)
            {
                _loc3_.bitmap = new BitmapData(_loc3_.width, _loc3_.height, true, 0);
                _loc3_.bitmap.copyPixels(param2, param2.rect, new Point(0, 0));
            }
            else
            {
                Logger.log("Could not find element: " + param1);
            }

        }

        private function onMouseEvent(param1: WindowMouseEvent): void
        {
            switch (param1.type)
            {
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER:
                    if (this.var_4836 != null)
                    {
                        this.var_4836.visible = true;
                    }

                    return;
                case WindowMouseEvent.var_626:
                    if (this.var_4836 != null)
                    {
                        this.var_4836.visible = false;
                    }

                    return;
                case WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK:
                    this._container.selectEffect(this);
                    return;
            }

        }

        private function setElementImage(param1: String, param2: String): void
        {
            var _loc3_: BitmapDataAsset = this._container.widget.assets.getAssetByName(param2) as BitmapDataAsset;
            var _loc4_: BitmapData = _loc3_.content as BitmapData;
            this.setElementBitmap(param1, _loc4_);
        }

    }
}
