package com.sulake.habbo.inventory.effects
{

    import com.sulake.habbo.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.habbo.inventory.common.IThumbListDrawableItem;

    import flash.display.BitmapData;

    public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem
    {

        private var _type: int;
        private var _duration: int;
        private var _effectsInInventory: int = 1;
        private var _secondsLeft: int;
        private var _isActive: Boolean = false;
        private var _isSelected: Boolean = false;
        private var _isInUse: Boolean = false;
        private var _iconImage: BitmapData;
        private var _activatedOn: Date;

        public function get type(): int
        {
            return this._type;
        }

        public function get duration(): int
        {
            return this._duration;
        }

        public function get effectsInInventory(): int
        {
            return this._effectsInInventory;
        }

        public function get isActive(): Boolean
        {
            return this._isActive;
        }

        public function get isInUse(): Boolean
        {
            return this._isInUse;
        }

        public function get isSelected(): Boolean
        {
            return this._isSelected;
        }

        public function get icon(): BitmapData
        {
            return this._iconImage;
        }

        public function get iconImage(): BitmapData
        {
            return this._iconImage;
        }

        public function get secondsLeft(): int
        {
            var total: int;

            if (this._isActive)
            {
                total = int(this._secondsLeft - (new Date().valueOf() - this._activatedOn.valueOf()) / 1000);
                
                total = Math.floor(total);
                
                if (total < 0)
                {
                    total = 0;
                }

                return total;
            }

            return this._secondsLeft;
        }

        public function set type(value: int): void
        {
            this._type = value;
        }

        public function set duration(value: int): void
        {
            this._duration = value;
        }

        public function set secondsLeft(value: int): void
        {
            this._secondsLeft = value;
        }

        public function set isSelected(value: Boolean): void
        {
            this._isSelected = value;
        }

        public function set isInUse(value: Boolean): void
        {
            this._isInUse = value;
        }

        public function set iconImage(value: BitmapData): void
        {
            this._iconImage = value;
        }

        public function set effectsInInventory(value: int): void
        {
            this._effectsInInventory = value;
        }

        public function set isActive(value: Boolean): void
        {
            if (value && !this._isActive)
            {
                this._activatedOn = new Date();
            }

            this._isActive = value;
        }

        public function setOneEffectExpired(): void
        {
            this._effectsInInventory--;

            if (this._effectsInInventory < 0)
            {
                this._effectsInInventory = 0;
            }

            this._secondsLeft = this._duration;
            this._isActive = false;
            this._isInUse = false;
        }

    }
}
