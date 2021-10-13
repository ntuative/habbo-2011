package com.sulake.habbo.roomevents.userdefinedroomevents.common
{
    import com.sulake.core.runtime.events.EventDispatcher;
    import com.sulake.core.window.IWindowContainer;
    import flash.display.BitmapData;
    import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
    import com.sulake.core.assets.IAssetLibrary;
    import flash.events.Event;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.core.window.components.IContainerButtonWindow;
    import flash.geom.Point;
    import com.sulake.core.assets.BitmapDataAsset;

    public class SliderWindowController extends EventDispatcher 
    {

        private var var_4380:Number = 0;
        private var _sliderContainer:IWindowContainer;
        private var var_4381:Boolean = false;
        private var var_4382:BitmapData;
        private var var_4383:BitmapData;
        private var var_4384:int;
        private var _minValue:Number = 0;
        private var var_4385:Number = 1;
        private var var_4386:Number = 0;

        public function SliderWindowController(param1:HabboUserDefinedRoomEvents, param2:IWindowContainer, param3:IAssetLibrary, param4:Number=0, param5:Number=1, param6:Number=0)
        {
            this._sliderContainer = IWindowContainer(param1.getXmlWindow("ude_slider"));
            param2.addChild(this._sliderContainer);
            this._minValue = param4;
            this.var_4385 = param5;
            this.var_4386 = param6;
            this.var_4380 = 0;
            this.storeAssets(param3);
            this.displaySlider();
        }

        override public function dispose():void
        {
            super.dispose();
            this._sliderContainer = null;
            this.var_4382 = null;
            this.var_4383 = null;
        }

        public function setValue(param1:Number, param2:Boolean=true):void
        {
            param1 = Math.max(this._minValue, param1);
            param1 = Math.min(this.var_4385, param1);
            this.var_4380 = param1;
            if (param2)
            {
                this.updateSliderPosition();
            };
            dispatchEvent(new Event(Event.CHANGE));
        }

        public function getValue():Number
        {
            return (this.var_4380);
        }

        public function set min(param1:Number):void
        {
            this._minValue = param1;
        }

        public function set max(param1:Number):void
        {
            this.var_4385 = param1;
        }

        private function updateSliderPosition():void
        {
            if (this._sliderContainer == null)
            {
                return;
            };
            var _loc1_:IWindow = this._sliderContainer.findChildByName("slider_button");
            if (_loc1_ != null)
            {
                _loc1_.x = this.getSliderPosition(this.var_4380);
            };
            _loc1_.parent.invalidate();
        }

        private function getSliderPosition(param1:Number):int
        {
            return (int((this.var_4384 * (Number((param1 - this._minValue)) / (this.var_4385 - this._minValue)))));
        }

        private function getValueAtPosition(param1:Number):Number
        {
            return (((param1 / this.var_4384) * (this.var_4385 - this._minValue)) + this._minValue);
        }

        private function sliderProcedure(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Number;
            var _loc4_:Number;
            if (param1.type == WindowMouseEvent.var_628)
            {
                this.var_4381 = true;
            };
            if (this.var_4381)
            {
                if (((param1.type == WindowMouseEvent.var_633) || (param1.type == WindowMouseEvent.var_634)))
                {
                    this.var_4381 = false;
                };
            };
            if (((!(this.var_4381)) || (!(param1.type == WindowEvent.var_571))))
            {
                return;
            };
            if (this.var_4386 != 0)
            {
                _loc3_ = this.getValueAtPosition(param2.x);
                _loc4_ = (Math.round((_loc3_ / this.var_4386)) * this.var_4386);
                this.setValue(_loc4_, false);
            };
        }

        private function sliderButtonRightProcedure(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Number;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4381 = false;
                if (this.var_4386 != 0)
                {
                    _loc3_ = (this.var_4380 + this.var_4386);
                    this.setValue(_loc3_);
                };
            };
        }

        private function sliderButtonLeftProcedure(param1:WindowEvent, param2:IWindow):void
        {
            var _loc3_:Number;
            if (param1.type == WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK)
            {
                this.var_4381 = false;
                if (this.var_4386 != 0)
                {
                    _loc3_ = (this.var_4380 - this.var_4386);
                    this.setValue(_loc3_);
                };
            };
        }

        private function displaySlider():void
        {
            var _loc1_:IWindowContainer;
            var _loc2_:IBitmapWrapperWindow;
            var _loc3_:IContainerButtonWindow;
            var _loc4_:IContainerButtonWindow;
            if (this._sliderContainer == null)
            {
                return;
            };
            _loc2_ = (this._sliderContainer.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (((!(_loc2_ == null)) && (!(this.var_4382 == null))))
            {
                _loc2_.bitmap = new BitmapData(this.var_4382.width, this.var_4382.height, true, 0xFFFFFF);
                _loc2_.bitmap.copyPixels(this.var_4382, this.var_4382.rect, new Point(0, 0), null, null, true);
            };
            _loc1_ = (this._sliderContainer.findChildByName("slider_movement_area") as IWindowContainer);
            if (_loc1_ != null)
            {
                _loc2_ = (_loc1_.findChildByName("slider_button") as IBitmapWrapperWindow);
                if (((!(_loc2_ == null)) && (!(this.var_4383 == null))))
                {
                    _loc2_.bitmap = new BitmapData(this.var_4383.width, this.var_4383.height, true, 0xFFFFFF);
                    _loc2_.bitmap.copyPixels(this.var_4383, this.var_4383.rect, new Point(0, 0), null, null, true);
                    _loc2_.procedure = this.sliderProcedure;
                    this.var_4384 = (_loc1_.width - _loc2_.width);
                };
            };
            _loc4_ = (this._sliderContainer.findChildByName("slider_button_left") as IContainerButtonWindow);
            if (_loc4_)
            {
                _loc4_.procedure = this.sliderButtonLeftProcedure;
            };
            _loc3_ = (this._sliderContainer.findChildByName("slider_button_right") as IContainerButtonWindow);
            if (_loc3_)
            {
                _loc3_.procedure = this.sliderButtonRightProcedure;
            };
        }

        private function storeAssets(param1:IAssetLibrary):void
        {
            var _loc2_:BitmapDataAsset;
            if (param1 == null)
            {
                return;
            };
            _loc2_ = BitmapDataAsset(param1.getAssetByName("slider_bg_png"));
            this.var_4382 = BitmapData(_loc2_.content);
            _loc2_ = BitmapDataAsset(param1.getAssetByName("slider_obj_png"));
            this.var_4383 = BitmapData(_loc2_.content);
        }

    }
}