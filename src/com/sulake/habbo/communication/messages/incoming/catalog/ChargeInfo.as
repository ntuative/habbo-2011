package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ChargeInfo 
    {

        private var var_2900:int;
        private var var_2901:int;
        private var var_2829:int;
        private var var_2830:int;
        private var var_2831:int;
        private var var_2902:int;

        public function ChargeInfo(param1:IMessageDataWrapper)
        {
            this.var_2900 = param1.readInteger();
            this.var_2901 = param1.readInteger();
            this.var_2829 = param1.readInteger();
            this.var_2830 = param1.readInteger();
            this.var_2831 = param1.readInteger();
            this.var_2902 = param1.readInteger();
        }

        public function get stuffId():int
        {
            return (this.var_2900);
        }

        public function get charges():int
        {
            return (this.var_2901);
        }

        public function get priceInCredits():int
        {
            return (this.var_2829);
        }

        public function get priceInActivityPoints():int
        {
            return (this.var_2830);
        }

        public function get chargePatchSize():int
        {
            return (this.var_2902);
        }

        public function get activityPointType():int
        {
            return (this.var_2831);
        }

    }
}