package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeLevelMessageData 
    {

        private var var_2709:int;
        private var var_3029:int;
        private var var_2710:Array;

        public function PrizeLevelMessageData(param1:IMessageDataWrapper)
        {
            this.var_2709 = param1.readInteger();
            this.var_3029 = param1.readInteger();
            this.var_2710 = new Array();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                this.var_2710.push(new PrizeMessageData(param1));
                _loc3_++;
            };
        }

        public function get prizeLevelId():int
        {
            return (this.var_2709);
        }

        public function get probabilityDenominator():int
        {
            return (this.var_3029);
        }

        public function get prizes():Array
        {
            return (this.var_2710);
        }

    }
}