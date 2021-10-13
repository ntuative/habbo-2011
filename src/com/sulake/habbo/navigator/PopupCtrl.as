package com.sulake.habbo.navigator
{
    import flash.utils.Timer;
    import com.sulake.core.window.IWindowContainer;
    import flash.events.TimerEvent;
    import com.sulake.habbo.window.enum.HabboWindowParam;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;

    public class PopupCtrl 
    {

        private var _navigator:HabboNavigator;
        private var var_3427:String;
        private var var_3455:int;
        private var _popupIndentLeft:int;
        private var var_3453:Timer = new Timer(500, 1);
        private var var_3454:Timer = new Timer(100, 1);
        private var var_3456:IWindowContainer;

        public function PopupCtrl(param1:HabboNavigator, param2:int, param3:int, param4:String)
        {
            this._navigator = param1;
            this.var_3427 = param4;
            this.var_3455 = param2;
            this._popupIndentLeft = param3;
            this.var_3453.addEventListener(TimerEvent.TIMER, this.onDisplayTimer);
            this.var_3454.addEventListener(TimerEvent.TIMER, this.onHideTimer);
        }

        public function get navigator():HabboNavigator
        {
            return (this._navigator);
        }

        public function dispose():void
        {
            this._navigator = null;
            if (this.var_3453)
            {
                this.var_3453.removeEventListener(TimerEvent.TIMER, this.onDisplayTimer);
                this.var_3453.reset();
                this.var_3453 = null;
            };
            if (this.var_3454)
            {
                this.var_3454.removeEventListener(TimerEvent.TIMER, this.onHideTimer);
                this.var_3454.reset();
                this.var_3454 = null;
            };
        }

        public function showPopup(param1:IWindow):void
        {
            if (this.var_3456 == null)
            {
                this.var_3456 = IWindowContainer(this._navigator.getXmlWindow(this.var_3427));
                this.var_3456.visible = false;
                this.var_3456.setParamFlag(HabboWindowParam.var_157, true);
                this.var_3456.procedure = this.onPopup;
            };
            Util.hideChildren(this.var_3456);
            this.refreshContent(this.var_3456);
            this.var_3456.height = (Util.getLowestPoint(this.var_3456) + 5);
            var _loc2_:Point = new Point();
            param1.getGlobalPosition(_loc2_);
            this.var_3456.x = ((_loc2_.x + this.var_3455) + param1.width);
            this.var_3456.y = ((_loc2_.y - (this.var_3456.height * 0.5)) + (param1.height * 0.5));
            var _loc3_:Point = new Point();
            this.var_3456.getGlobalPosition(_loc3_);
            if ((_loc3_.x + this.var_3456.width) > this.var_3456.desktop.width)
            {
                this.var_3456.x = ((-(this.var_3456.width) + _loc2_.x) + this._popupIndentLeft);
                this.refreshPopupArrows(this.var_3456, false);
            }
            else
            {
                this.refreshPopupArrows(this.var_3456, true);
            };
            if (!this.var_3456.visible)
            {
                this.var_3453.reset();
                this.var_3453.start();
            };
            this.var_3454.reset();
            this.var_3456.activate();
        }

        public function closePopup():void
        {
            this.var_3454.reset();
            this.var_3453.reset();
            this.var_3454.start();
        }

        private function refreshPopupArrows(param1:IWindowContainer, param2:Boolean):void
        {
            this.refreshPopupArrow(param1, true, param2);
            this.refreshPopupArrow(param1, false, (!(param2)));
        }

        private function refreshPopupArrow(param1:IWindowContainer, param2:Boolean, param3:Boolean):void
        {
            var _loc4_:String = ("popup_arrow_" + ((param2) ? "left" : "right"));
            var _loc5_:IBitmapWrapperWindow = IBitmapWrapperWindow(param1.findChildByName(_loc4_));
            if (!param3)
            {
                if (_loc5_ != null)
                {
                    _loc5_.visible = false;
                };
            }
            else
            {
                if (_loc5_ == null)
                {
                    _loc5_ = this._navigator.getButton(_loc4_, _loc4_, null);
                    _loc5_.setParamFlag(HabboWindowParam.var_158, false);
                    param1.addChild(_loc5_);
                };
                _loc5_.visible = true;
                _loc5_.y = ((param1.height * 0.5) - (_loc5_.height * 0.5));
                _loc5_.x = ((param2) ? (1 - _loc5_.width) : (param1.width - 1));
            };
        }

        private function onDisplayTimer(param1:TimerEvent):void
        {
            this.var_3456.visible = true;
            this.var_3456.activate();
        }

        private function onHideTimer(param1:TimerEvent):void
        {
            if (this.var_3456 != null)
            {
                this.var_3456.visible = false;
            };
        }

        public function hideInstantly():void
        {
            if (this.var_3456 != null)
            {
                this.var_3456.visible = false;
            };
            this.var_3453.reset();
            this.var_3454.reset();
        }

        public function get visible():Boolean
        {
            return ((!(this.var_3456 == null)) && (this.var_3456.visible));
        }

        public function refreshContent(param1:IWindowContainer):void
        {
        }

        private function onPopup(param1:WindowEvent, param2:IWindow):void
        {
            if ((param1 as WindowMouseEvent) == null)
            {
                return;
            };
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_OVER)
            {
                this.var_3454.reset();
            }
            else
            {
                if (param1.type == WindowMouseEvent.var_626)
                {
                    if (!Util.containsMouse(this.var_3456))
                    {
                        this.closePopup();
                    };
                };
            };
        }

    }
}