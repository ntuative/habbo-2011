package com.sulake.habbo.communication.messages.incoming.recycler
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeMessageData 
    {

        private var var_2705:String;
        private var var_2706:int;

        public function PrizeMessageData(param1:IMessageDataWrapper)
        {
            this.var_2705 = param1.readString();
            this.var_2706 = param1.readInteger();
        }

        public function get productItemType():String
        {
            return (this.var_2705);
        }

        public function get productItemTypeId():int
        {
            return (this.var_2706);
        }

    }
}