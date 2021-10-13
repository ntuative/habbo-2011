package com.sulake.habbo.inventory.effects
{
    import com.sulake.habbo.widget.memenu.IWidgetAvatarEffect;
    import com.sulake.habbo.inventory.common.IThumbListDrawableItem;
    import flash.display.BitmapData;

    public class Effect implements IWidgetAvatarEffect, IThumbListDrawableItem 
    {

        private var _type:int;
        private var var_2930:int;
        private var var_3540:int = 1;
        private var var_3541:int;
        private var var_3542:Boolean = false;
        private var _isSelected:Boolean = false;
        private var var_3525:Boolean = false;
        private var var_2456:BitmapData;
        private var var_3543:Date;

        public function get type():int
        {
            return (this._type);
        }

        public function get duration():int
        {
            return (this.var_2930);
        }

        public function get effectsInInventory():int
        {
            return (this.var_3540);
        }

        public function get isActive():Boolean
        {
            return (this.var_3542);
        }

        public function get isInUse():Boolean
        {
            return (this.var_3525);
        }

        public function get isSelected():Boolean
        {
            return (this._isSelected);
        }

        public function get icon():BitmapData
        {
            return (this.var_2456);
        }

        public function get iconImage():BitmapData
        {
            return (this.var_2456);
        }

        public function get secondsLeft():int
        {
            var _loc1_:int;
            if (this.var_3542)
            {
                _loc1_ = int((this.var_3541 - ((new Date().valueOf() - this.var_3543.valueOf()) / 1000)));
                _loc1_ = Math.floor(_loc1_);
                if (_loc1_ < 0)
                {
                    _loc1_ = 0;
                };
                return (_loc1_);
            };
            return (this.var_3541);
        }

        public function set type(param1:int):void
        {
            this._type = param1;
        }

        public function set duration(param1:int):void
        {
            this.var_2930 = param1;
        }

        public function set secondsLeft(param1:int):void
        {
            this.var_3541 = param1;
        }

        public function set isSelected(param1:Boolean):void
        {
            this._isSelected = param1;
        }

        public function set isInUse(param1:Boolean):void
        {
            this.var_3525 = param1;
        }

        public function set iconImage(param1:BitmapData):void
        {
            this.var_2456 = param1;
        }

        public function set effectsInInventory(param1:int):void
        {
            this.var_3540 = param1;
        }

        public function set isActive(param1:Boolean):void
        {
            if (((param1) && (!(this.var_3542))))
            {
                this.var_3543 = new Date();
            };
            this.var_3542 = param1;
        }

        public function setOneEffectExpired():void
        {
            this.var_3540--;
            if (this.var_3540 < 0)
            {
                this.var_3540 = 0;
            };
            this.var_3541 = this.var_2930;
            this.var_3542 = false;
            this.var_3525 = false;
        }

    }
}