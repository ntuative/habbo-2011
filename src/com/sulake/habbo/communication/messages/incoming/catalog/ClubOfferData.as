package com.sulake.habbo.communication.messages.incoming.catalog
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ClubOfferData 
    {

        private var _offerId:int;
        private var var_2611:String;
        private var var_2612:int;
        private var var_2613:Boolean;
        private var var_2614:Boolean;
        private var var_2615:int;
        private var var_2616:int;
        private var var_2617:int;
        private var var_2618:int;
        private var var_2619:int;

        public function ClubOfferData(param1:IMessageDataWrapper)
        {
            this._offerId = param1.readInteger();
            this.var_2611 = param1.readString();
            this.var_2612 = param1.readInteger();
            this.var_2613 = param1.readBoolean();
            this.var_2614 = param1.readBoolean();
            this.var_2615 = param1.readInteger();
            this.var_2616 = param1.readInteger();
            this.var_2617 = param1.readInteger();
            this.var_2618 = param1.readInteger();
            this.var_2619 = param1.readInteger();
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get productCode():String
        {
            return (this.var_2611);
        }

        public function get price():int
        {
            return (this.var_2612);
        }

        public function get upgrade():Boolean
        {
            return (this.var_2613);
        }

        public function get vip():Boolean
        {
            return (this.var_2614);
        }

        public function get periods():int
        {
            return (this.var_2615);
        }

        public function get daysLeftAfterPurchase():int
        {
            return (this.var_2616);
        }

        public function get year():int
        {
            return (this.var_2617);
        }

        public function get month():int
        {
            return (this.var_2618);
        }

        public function get day():int
        {
            return (this.var_2619);
        }

    }
}