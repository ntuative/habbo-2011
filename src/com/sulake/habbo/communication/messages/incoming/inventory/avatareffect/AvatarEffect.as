package com.sulake.habbo.communication.messages.incoming.inventory.avatareffect
{
    public class AvatarEffect 
    {

        private var _type:int;
        private var var_2930:int;
        private var var_2931:int;
        private var var_2932:int;

        public function get type():int
        {
            return (this._type);
        }

        public function set type(param1:int):void
        {
            this._type = param1;
        }

        public function get duration():int
        {
            return (this.var_2930);
        }

        public function set duration(param1:int):void
        {
            this.var_2930 = param1;
        }

        public function get inactiveEffectsInInventory():int
        {
            return (this.var_2931);
        }

        public function set inactiveEffectsInInventory(param1:int):void
        {
            this.var_2931 = param1;
        }

        public function get secondsLeftIfActive():int
        {
            return (this.var_2932);
        }

        public function set secondsLeftIfActive(param1:int):void
        {
            this.var_2932 = param1;
        }

    }
}