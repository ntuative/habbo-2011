package com.sulake.habbo.inventory
{
    import flash.utils.Timer;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import flash.events.TimerEvent;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class ItemPopupCtrl 
    {

        public static const var_1967:int = 1;
        public static const var_1791:int = 2;
        private static const var_3615:int = 5;
        private static const var_3610:int = 250;
        private static const var_3611:int = 100;
        private static const var_3616:int = 180;
        private static const var_3617:int = 200;

        private var var_3613:Timer = new Timer(var_3610, 1);
        private var var_3614:Timer = new Timer(var_3611, 1);
        private var _assets:IAssetLibrary;
        private var var_3612:IWindowContainer;
        private var _parent:IWindowContainer;
        private var var_3618:int = 2;
        private var var_3619:BitmapData;
        private var var_3620:BitmapData;

        public function ItemPopupCtrl(param1:IWindowContainer, param2:IAssetLibrary)
        {
            if (param1 == null)
            {
                return;
            };
            if (param2 == null)
            {
                return;
            };
            this.var_3612 = param1;
            this.var_3612.visible = false;
            this._assets = param2;
            this.var_3613.addEventListener(TimerEvent.TIMER, this.onDisplayTimer);
            this.var_3614.addEventListener(TimerEvent.TIMER, this.onHideTimer);
            var _loc3_:BitmapDataAsset = (this._assets.getAssetByName("popup_arrow_right_png") as BitmapDataAsset);
            if (((!(_loc3_ == null)) && (!(_loc3_.content == null))))
            {
                this.var_3620 = (_loc3_.content as BitmapData);
            };
            _loc3_ = (this._assets.getAssetByName("popup_arrow_left_png") as BitmapDataAsset);
            if (((!(_loc3_ == null)) && (!(_loc3_.content == null))))
            {
                this.var_3619 = (_loc3_.content as BitmapData);
            };
        }

        public function dispose():void
        {
            if (this.var_3613 != null)
            {
                this.var_3613.removeEventListener(TimerEvent.TIMER, this.onDisplayTimer);
                this.var_3613.stop();
                this.var_3613 = null;
            };
            if (this.var_3614 != null)
            {
                this.var_3614.removeEventListener(TimerEvent.TIMER, this.onHideTimer);
                this.var_3614.stop();
                this.var_3614 = null;
            };
            this._assets = null;
            this.var_3612 = null;
            this._parent = null;
            this.var_3619 = null;
            this.var_3620 = null;
        }

        public function updateContent(param1:IWindowContainer, param2:String, param3:BitmapData, param4:int=2):void
        {
            var _loc7_:BitmapData;
            if (this.var_3612 == null)
            {
                return;
            };
            if (param1 == null)
            {
                return;
            };
            if (param3 == null)
            {
                param3 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
            if (this._parent != null)
            {
                this._parent.removeChild(this.var_3612);
            };
            this._parent = param1;
            this.var_3618 = param4;
            var _loc5_:ITextWindow = ITextWindow(this.var_3612.findChildByName("item_name_text"));
            if (_loc5_)
            {
                _loc5_.text = param2;
            };
            var _loc6_:IBitmapWrapperWindow = (this.var_3612.findChildByName("item_image") as IBitmapWrapperWindow);
            if (_loc6_)
            {
                _loc7_ = new BitmapData(Math.min(var_3616, param3.width), Math.min(var_3617, param3.height), true, 0xFFFFFF);
                _loc7_.copyPixels(param3, new Rectangle(0, 0, _loc7_.width, _loc7_.height), new Point(0, 0), null, null, true);
                _loc6_.bitmap = _loc7_;
                _loc6_.width = _loc6_.bitmap.width;
                _loc6_.height = _loc6_.bitmap.height;
                _loc6_.x = ((this.var_3612.width - _loc6_.width) / 2);
                this.var_3612.height = (_loc6_.rectangle.bottom + 10);
            };
        }

        public function show():void
        {
            this.var_3614.reset();
            this.var_3613.reset();
            if (this._parent == null)
            {
                return;
            };
            this.var_3612.visible = true;
            this._parent.addChild(this.var_3612);
            this.refreshArrow(this.var_3618);
            switch (this.var_3618)
            {
                case var_1967:
                    this.var_3612.x = ((-1 * this.var_3612.width) - var_3615);
                    break;
                case var_1791:
                    this.var_3612.x = (this._parent.width + var_3615);
                    break;
            };
            this.var_3612.y = ((this._parent.height - this.var_3612.height) / 2);
        }

        public function hide():void
        {
            this.var_3612.visible = false;
            this.var_3614.reset();
            this.var_3613.reset();
            if (this._parent != null)
            {
                this._parent.removeChild(this.var_3612);
            };
        }

        public function showDelayed():void
        {
            this.var_3614.reset();
            this.var_3613.reset();
            this.var_3613.start();
        }

        public function hideDelayed():void
        {
            this.var_3614.reset();
            this.var_3613.reset();
            this.var_3614.start();
        }

        private function refreshArrow(param1:int=2):void
        {
            if (((this.var_3612 == null) || (this.var_3612.disposed)))
            {
                return;
            };
            var _loc2_:IBitmapWrapperWindow = IBitmapWrapperWindow(this.var_3612.findChildByName("arrow_pointer"));
            if (!_loc2_)
            {
                return;
            };
            switch (param1)
            {
                case var_1967:
                    _loc2_.bitmap = this.var_3620.clone();
                    _loc2_.width = this.var_3620.width;
                    _loc2_.height = this.var_3620.height;
                    _loc2_.y = ((this.var_3612.height - this.var_3620.height) / 2);
                    _loc2_.x = (this.var_3612.width - 1);
                    break;
                case var_1791:
                    _loc2_.bitmap = this.var_3619.clone();
                    _loc2_.width = this.var_3619.width;
                    _loc2_.height = this.var_3619.height;
                    _loc2_.y = ((this.var_3612.height - this.var_3619.height) / 2);
                    _loc2_.x = ((-1 * this.var_3619.width) + 1);
                    break;
            };
            _loc2_.invalidate();
        }

        private function onDisplayTimer(param1:TimerEvent):void
        {
            this.show();
        }

        private function onHideTimer(param1:TimerEvent):void
        {
            this.hide();
        }

    }
}