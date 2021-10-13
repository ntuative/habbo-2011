package com.sulake.habbo.help
{
    import com.sulake.core.runtime.IUpdateReceiver;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.configuration.IHabboConfigurationManager;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import flash.utils.Timer;
    import com.sulake.habbo.toolbar.HabboToolbarIconEnum;
    import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.XmlAsset;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IFrameWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.toolbar.events.HabboToolbarSetIconEvent;
    import com.sulake.core.window.components.IDesktopWindow;
    import com.sulake.core.window.IWindow;

    public class WelcomeScreenController implements IUpdateReceiver 
    {

        private var var_3498:HabboHelp;
        private var _windowManager:IHabboWindowManager;
        private var _config:IHabboConfigurationManager;
        private var _disposed:Boolean;
        private var _window:IWindowContainer;
        private var var_3520:Point = new Point(72, 10);
        private var var_3521:Timer;
        private var _notifications:Array = [new WelcomeNotification(HabboToolbarIconEnum.NAVIGATOR, "welcome.screen.title", "welcome.screen.message")];
        private var var_3522:int = 0;

        public function WelcomeScreenController(param1:HabboHelp, param2:IHabboWindowManager, param3:IHabboConfigurationManager)
        {
            this.var_3498 = param1;
            this._windowManager = param2;
            this._config = param3;
        }

        public function set notifications(param1:Array):void
        {
            this._notifications = param1;
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        private function get current():WelcomeNotification
        {
            return (this._notifications[this.var_3522]);
        }

        public function dispose():void
        {
            if (this.var_3498)
            {
                this.var_3498.removeUpdateReceiver(this);
                this.var_3498.toolbar.events.removeEventListener(HabboToolbarEvent.var_49, this.onToolbarClicked);
                this.var_3498.toolbar.events.removeEventListener(HabboToolbarEvent.var_364, this.onToolbarResized);
                this.var_3498 = null;
            };
            this._windowManager = null;
            this._config = null;
            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            };
            if (this.var_3521)
            {
                this.var_3521.stop();
                this.var_3521.removeEventListener(TimerEvent.TIMER, this.onReminderTimer);
                this.var_3521 = null;
            };
            this._notifications = null;
            this._disposed = true;
        }

        public function showWelcomeScreen(param1:Boolean):void
        {
            if (this._disposed)
            {
                return;
            };
            var _loc2_:Boolean = Boolean(parseInt(this._config.getKey("new.identity", "0")));
            var _loc3_:Boolean = ((Boolean(parseInt(this._config.getKey("welcome.screen.enabled", "0")))) && (_loc2_));
            if (((!(param1)) || (!(_loc3_))))
            {
                this.dispose();
                return;
            };
            this.var_3498.toolbar.events.addEventListener(HabboToolbarEvent.var_49, this.onToolbarClicked);
            this.var_3498.toolbar.events.addEventListener(HabboToolbarEvent.var_364, this.onToolbarResized);
            var _loc4_:int = parseInt(this._config.getKey("welcome.screen.delay", "5000"));
            this.var_3521 = new Timer(_loc4_);
            this.var_3521.addEventListener(TimerEvent.TIMER, this.onReminderTimer);
            this.var_3521.start();
        }

        public function onReminderTimer(param1:TimerEvent):void
        {
            if (this.hasBlockingWindow())
            {
                return;
            };
            if (this._window == null)
            {
                this.initializeWindow();
            };
            this.var_3520.y = (this.var_3498.toolbar.getIconLocation(this.current.targetIconId) - (this._window.height / 2));
            this._window.y = this.var_3520.y;
            this._window.findChildByName("title").caption = ((("$" + "{") + this.current.titleLocalizationKey) + "}");
            this._window.findChildByName("text").caption = ((("$" + "{") + this.current.descriptionLocalizationKey) + "}");
            this.highlightToolbarIcon(true);
            this._window.x = -(this._window.width);
            this.registerUpdates();
            this._window.visible = true;
            this._window.activate();
        }

        private function initializeWindow():void
        {
            var _loc1_:XmlAsset = (this.var_3498.assets.getAssetByName("welcome_screen_xml") as XmlAsset);
            this._window = (this._windowManager.buildFromXML((_loc1_.content as XML), 2) as IWindowContainer);
            var _loc2_:IBitmapWrapperWindow = (this._window.findChildByName("arrow") as IBitmapWrapperWindow);
            var _loc3_:BitmapDataAsset = (this.var_3498.assets.getAssetByName("welcome_screen_arrow") as BitmapDataAsset);
            _loc2_.bitmap = (_loc3_.content as BitmapData).clone();
            var _loc4_:IFrameWindow = (this._window.findChildByName("frame") as IFrameWindow);
            _loc4_.header.visible = false;
            _loc4_.content.y = (_loc4_.content.y - 20);
            var _loc5_:ITextWindow = (this._window.findChildByName("text") as ITextWindow);
            _loc5_.height = (_loc5_.textHeight + 5);
            _loc4_.content.setParamFlag(WindowParam.var_669, false);
            _loc4_.height = (_loc4_.height - 20);
            this._window.findChildByName("close").addEventListener(WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK, this.onMouseClick);
        }

        private function highlightToolbarIcon(param1:Boolean):void
        {
            var _loc2_:HabboToolbarSetIconEvent = new HabboToolbarSetIconEvent(HabboToolbarSetIconEvent.var_176, this.current.targetIconId);
            _loc2_.iconState = ((param1) ? "highlight_blue" : "0");
            this.var_3498.toolbar.events.dispatchEvent(_loc2_);
        }

        private function onMouseClick(param1:WindowMouseEvent):void
        {
            this.closeWindow();
        }

        private function onToolbarClicked(param1:HabboToolbarEvent):void
        {
            this.closeWindow();
        }

        private function onToolbarResized(param1:HabboToolbarEvent):void
        {
            if (!this._window)
            {
                return;
            };
            if (this.var_3498)
            {
                this.registerUpdates();
            };
            this.var_3520.y = (this.var_3498.toolbar.getIconLocation(this.current.targetIconId) - (this._window.height / 2));
        }

        private function closeWindow():void
        {
            if (!this._window)
            {
                return;
            };
            this._window.visible = false;
            this.highlightToolbarIcon(false);
            if (this.var_3522 < (this._notifications.length - 1))
            {
                this.var_3522++;
            }
            else
            {
                this.dispose();
            };
        }

        public function update(param1:uint):void
        {
            var _loc3_:Point;
            if (this._window == null)
            {
                this.var_3498.removeUpdateReceiver(this);
                return;
            };
            var _loc2_:Number = Point.distance(this._window.rectangle.topLeft, this.var_3520);
            if (_loc2_ > 5)
            {
                _loc3_ = Point.interpolate(this._window.rectangle.topLeft, this.var_3520, 0.5);
                this._window.x = _loc3_.x;
                this._window.y = _loc3_.y;
            }
            else
            {
                this._window.x = this.var_3520.x;
                this._window.y = this.var_3520.y;
                this.var_3498.removeUpdateReceiver(this);
            };
        }

        private function hasBlockingWindow():Boolean
        {
            var _loc2_:IDesktopWindow;
            var _loc1_:int;
            while (_loc1_ <= 2)
            {
                _loc2_ = this._windowManager.getDesktop(_loc1_);
                if (((!(_loc2_ == null)) && (this.hasBlockingWindowInLayer(_loc2_))))
                {
                    return (true);
                };
                _loc1_++;
            };
            return (false);
        }

        private function hasBlockingWindowInLayer(param1:IWindowContainer):Boolean
        {
            var _loc2_:int;
            var _loc3_:IWindow;
            while (_loc2_ < param1.numChildren)
            {
                _loc3_ = param1.getChildAt(_loc2_);
                if (((!(_loc3_ == null)) && (_loc3_.visible)))
                {
                    if ((_loc3_ as IFrameWindow) != null)
                    {
                        if (_loc3_.name != "mod_start_panel")
                        {
                            return (true);
                        };
                    }
                    else
                    {
                        if (_loc3_.name == "welcome_screen")
                        {
                            return (true);
                        };
                    };
                };
                _loc2_++;
            };
            return (false);
        }

        private function registerUpdates():void
        {
            this.var_3498.removeUpdateReceiver(this);
            this.var_3498.registerUpdateReceiver(this, 10);
        }

    }
}