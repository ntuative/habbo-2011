package com.sulake.habbo.widget.memenu
{

    import com.sulake.core.window.IWindowContainer;

    import flash.display.BitmapData;

    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;

    import com.sulake.core.assets.BitmapDataAsset;

    public class MeMenuSoundSettingsSlider
    {

        private var var_4839: MeMenuSoundSettingsView;
        private var _sliderContainer: IWindowContainer;
        private var var_4382: BitmapData;
        private var var_4383: BitmapData;
        private var var_4384: int;
        private var _minValue: Number = 0;
        private var var_4385: Number = 1;

        public function MeMenuSoundSettingsSlider(param1: MeMenuSoundSettingsView, param2: IWindowContainer, param3: IAssetLibrary, param4: Number = 0, param5: Number = 1)
        {
            this.var_4839 = param1;
            this._sliderContainer = param2;
            this._minValue = param4;
            this.var_4385 = param5;
            this.storeAssets(param3);
            this.displaySlider();
        }

        public function dispose(): void
        {
            this.var_4839 = null;
            this._sliderContainer = null;
            this.var_4382 = null;
            this.var_4383 = null;
        }

        public function setValue(param1: Number): void
        {
            if (this._sliderContainer == null)
            {
                return;
            }

            var _loc2_: IWindow = this._sliderContainer.findChildByName("slider_button");
            if (_loc2_ != null)
            {
                _loc2_.x = this.getSliderPosition(param1);
            }

        }

        public function set min(param1: Number): void
        {
            this._minValue = param1;
            this.setValue(this.var_4839.volume);
        }

        public function set max(param1: Number): void
        {
            this.var_4385 = param1;
            this.setValue(this.var_4839.volume);
        }

        private function getSliderPosition(param1: Number): int
        {
            return int(this.var_4384 * (Number(param1 - this._minValue) / (this.var_4385 - this._minValue)));
        }

        private function getValue(param1: Number): Number
        {
            return (param1 / this.var_4384) * (this.var_4385 - this._minValue) + this._minValue;
        }

        private function buttonProcedure(param1: WindowEvent, param2: IWindow): void
        {
            if (param1.type != WindowEvent.var_571)
            {
                return;
            }

            this.var_4839.saveVolume(this.getValue(param2.x), false);
        }

        private function displaySlider(): void
        {
            var _loc1_: IWindowContainer;
            var _loc2_: IWindowContainer;
            var _loc3_: IBitmapWrapperWindow;
            if (this._sliderContainer == null)
            {
                return;
            }

            _loc3_ = (this._sliderContainer.findChildByName("slider_base") as IBitmapWrapperWindow);
            if (_loc3_ != null && this.var_4382 != null)
            {
                _loc3_.bitmap = new BitmapData(this.var_4382.width, this.var_4382.height, true, 0xFFFFFF);
                _loc3_.bitmap.copyPixels(this.var_4382, this.var_4382.rect, new Point(0, 0), null, null, true);
            }

            _loc1_ = (this._sliderContainer.findChildByName("slider_movement_area") as IWindowContainer);
            if (_loc1_ != null)
            {
                _loc2_ = (_loc1_.findChildByName("slider_button") as IWindowContainer);
                if (_loc2_ != null)
                {
                    _loc3_ = (_loc2_.findChildByName("slider_bitmap") as IBitmapWrapperWindow);
                    if (_loc3_ != null && this.var_4383 != null)
                    {
                        _loc3_.bitmap = new BitmapData(this.var_4383.width, this.var_4383.height, true, 0xFFFFFF);
                        _loc3_.bitmap.copyPixels(this.var_4383, this.var_4383.rect, new Point(0, 0), null, null, true);
                        _loc2_.procedure = this.buttonProcedure;
                        this.var_4384 = _loc1_.width - _loc3_.width;
                    }

                }

            }

        }

        private function storeAssets(param1: IAssetLibrary): void
        {
            var _loc2_: BitmapDataAsset;
            if (param1 == null)
            {
                return;
            }

            _loc2_ = BitmapDataAsset(param1.getAssetByName("memenu_settings_slider_base"));
            this.var_4382 = BitmapData(_loc2_.content);
            _loc2_ = BitmapDataAsset(param1.getAssetByName("memenu_settings_slider_button"));
            this.var_4383 = BitmapData(_loc2_.content);
        }

    }
}
