package com.sulake.habbo.widget.furniture.dimmer
{

    import com.sulake.habbo.widget.RoomWidgetBase;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.widget.events.RoomWidgetDimmerUpdateEvent;
    import com.sulake.habbo.widget.events.RoomWidgetDimmerStateUpdateEvent;

    import flash.events.IEventDispatcher;

    import com.sulake.habbo.widget.events.RoomWidgetDimmerUpdateEventPresetItem;
    import com.sulake.habbo.widget.messages.RoomWidgetDimmerPreviewMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetDimmerSavePresetMessage;
    import com.sulake.habbo.widget.messages.RoomWidgetDimmerChangeStateMessage;

    public class DimmerFurniWidget extends RoomWidgetBase
    {

        private static const var_1284: Array = [7665141, 21495, 15161822, 15353138, 15923281, 8581961, 0];
        private static const var_1285: Array = [int(0.3 * 0xFF), int(0.3 * 0xFF)];

        private var _view: DimmerView;
        private var _presets: Array;
        private var var_4740: int;
        private var _dimmerState: int;
        private var var_3931: int;
        private var var_3286: int;
        private var _color: uint = 0xFFFFFF;
        private var var_3932: uint = 0xFF;

        public function DimmerFurniWidget(param1: IHabboWindowManager, param2: IAssetLibrary = null, param3: IHabboLocalizationManager = null)
        {
            super(param1, param2, param3);
        }

        public function get dimmerState(): int
        {
            return this._dimmerState;
        }

        public function get presets(): Array
        {
            return this._presets;
        }

        public function get colors(): Array
        {
            return var_1284;
        }

        public function get minLights(): Array
        {
            return var_1285;
        }

        public function get selectedPresetIndex(): int
        {
            return this.var_4740;
        }

        public function set selectedPresetIndex(param1: int): void
        {
            this.var_4740 = param1;
        }

        override public function dispose(): void
        {
            if (this._view != null)
            {
                this._view.dispose();
                this._view = null;
            }

            this._presets = null;
            super.dispose();
        }

        override public function registerUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.addEventListener(RoomWidgetDimmerUpdateEvent.var_1286, this.onPresets);
            param1.addEventListener(RoomWidgetDimmerUpdateEvent.var_1287, this.onHide);
            param1.addEventListener(RoomWidgetDimmerStateUpdateEvent.var_400, this.onDimmerState);
            super.registerUpdateEvents(param1);
        }

        override public function unregisterUpdateEvents(param1: IEventDispatcher): void
        {
            if (param1 == null)
            {
                return;
            }

            param1.removeEventListener(RoomWidgetDimmerUpdateEvent.var_1286, this.onPresets);
            param1.removeEventListener(RoomWidgetDimmerUpdateEvent.var_1287, this.onHide);
            param1.removeEventListener(RoomWidgetDimmerStateUpdateEvent.var_400, this.onDimmerState);
        }

        private function onPresets(param1: RoomWidgetDimmerUpdateEvent): void
        {
            var _loc3_: RoomWidgetDimmerUpdateEventPresetItem;
            var _loc4_: DimmerFurniWidgetPresetItem;
            this.var_4740 = param1.selectedPresetId - 1;
            this._presets = [];
            var _loc2_: int;
            while (_loc2_ < param1.presets.length)
            {
                _loc3_ = param1.presets[_loc2_];
                _loc4_ = new DimmerFurniWidgetPresetItem(_loc3_.id, _loc3_.type, _loc3_.color, _loc3_.light);
                this._presets.push(_loc4_);
                _loc2_++;
            }

            this.showInterface();
        }

        private function onHide(param1: RoomWidgetDimmerUpdateEvent): void
        {
            this.dispose();
        }

        private function onDimmerState(param1: RoomWidgetDimmerStateUpdateEvent): void
        {
            var _loc2_: RoomWidgetDimmerPreviewMessage;
            if (param1 == null)
            {
                return;
            }

            this._dimmerState = param1.state;
            this.var_3931 = param1.presetId;
            this.var_3286 = param1.effectId;
            this._color = param1.color;
            this.var_3932 = param1.brightness;
            if (this._view != null)
            {
                this._view.update();
            }

            if (!this.validateBrightness(this.var_3932, this.var_3286))
            {
                return;
            }

            _loc2_ = new RoomWidgetDimmerPreviewMessage(this._color, this.var_3932, this.var_3286 == 2);
            messageListener.processWidgetMessage(_loc2_);
        }

        private function showInterface(): void
        {
            if (this._view == null)
            {
                this._view = new DimmerView(this);
            }

            if (this._view != null)
            {
                this._view.showInterface();
            }

        }

        public function storeCurrentSetting(param1: Boolean): void
        {
            var _loc7_: RoomWidgetDimmerSavePresetMessage;
            if (this._dimmerState == 0)
            {
                return;
            }

            if (messageListener == null)
            {
                return;
            }

            var _loc2_: int = this.var_4740 + 1;
            if (this._presets == null || _loc2_ < 0 || _loc2_ > this._presets.length)
            {
                return;
            }

            var _loc3_: int = this._view.selectedType;
            var _loc4_: uint = this.colors[this._view.selectedColorIndex];
            var _loc5_: int = this._view.selectedBrightness;
            var _loc6_: DimmerFurniWidgetPresetItem = this._presets[this.var_4740] as DimmerFurniWidgetPresetItem;
            if (_loc6_ != null && _loc6_.type == _loc3_ && _loc6_.color == _loc4_ && _loc6_.light == _loc5_ && !param1)
            {
                return;
            }

            _loc6_.type = _loc3_;
            _loc6_.color = _loc4_;
            _loc6_.light = _loc5_;
            if (!this.validateBrightness(_loc5_, _loc3_))
            {
                return;
            }

            _loc7_ = new RoomWidgetDimmerSavePresetMessage(_loc2_, _loc3_, _loc4_, _loc5_, param1);
            messageListener.processWidgetMessage(_loc7_);
        }

        public function previewCurrentSetting(): void
        {
            var _loc1_: RoomWidgetDimmerPreviewMessage;
            if (this._dimmerState == 0)
            {
                return;
            }

            if (messageListener == null)
            {
                return;
            }

            if (!this.validateBrightness(this._view.selectedBrightness, this._view.selectedType))
            {
                return;
            }

            _loc1_ = new RoomWidgetDimmerPreviewMessage(this.colors[this._view.selectedColorIndex], this._view.selectedBrightness, this._view.selectedType == 2);
            messageListener.processWidgetMessage(_loc1_);
        }

        public function changeRoomDimmerState(): void
        {
            var _loc1_: RoomWidgetDimmerChangeStateMessage;
            if (messageListener != null)
            {
                _loc1_ = new RoomWidgetDimmerChangeStateMessage();
                messageListener.processWidgetMessage(_loc1_);
            }

        }

        public function removePreview(): void
        {
            var _loc1_: RoomWidgetDimmerPreviewMessage;
            if (messageListener == null)
            {
                return;
            }

            if (!this.validateBrightness(this.var_3932, this.var_3286))
            {
                return;
            }

            _loc1_ = new RoomWidgetDimmerPreviewMessage(this._color, this.var_3932, this.var_3286 == 2);
            messageListener.processWidgetMessage(_loc1_);
        }

        private function validateBrightness(param1: uint, param2: int): Boolean
        {
            return true;
        }

    }
}
