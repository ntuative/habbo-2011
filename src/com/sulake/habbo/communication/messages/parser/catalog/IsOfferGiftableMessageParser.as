package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IsOfferGiftableMessageParser implements IMessageParser 
    {

        private var _offerId:int;
        private var var_3134:Boolean;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._offerId = param1.readInteger();
            this.var_3134 = param1.readBoolean();
            return (true);
        }

        public function get offerId():int
        {
            return (this._offerId);
        }

        public function get isGiftable():Boolean
        {
            return (this.var_3134);
        }

    }
}