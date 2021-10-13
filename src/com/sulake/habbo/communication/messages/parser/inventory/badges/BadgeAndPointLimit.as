package com.sulake.habbo.communication.messages.parser.inventory.badges
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class BadgeAndPointLimit 
    {

        private var var_2925:String;
        private var var_3193:int;

        public function BadgeAndPointLimit(param1:String, param2:IMessageDataWrapper)
        {
            this.var_2925 = (("ACH_" + param1) + param2.readInteger());
            this.var_3193 = param2.readInteger();
        }

        public function get badgeId():String
        {
            return (this.var_2925);
        }

        public function get limit():int
        {
            return (this.var_3193);
        }

    }
}