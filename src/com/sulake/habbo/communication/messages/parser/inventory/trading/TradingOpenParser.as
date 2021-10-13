package com.sulake.habbo.communication.messages.parser.inventory.trading
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class TradingOpenParser implements IMessageParser 
    {

        private var _userID:int;
        private var var_3210:Boolean;
        private var var_3211:int;
        private var var_3212:Boolean;

        public function get userID():int
        {
            return (this._userID);
        }

        public function get userCanTrade():Boolean
        {
            return (this.var_3210);
        }

        public function get otherUserID():int
        {
            return (this.var_3211);
        }

        public function get otherUserCanTrade():Boolean
        {
            return (this.var_3212);
        }

        public function flush():Boolean
        {
            this._userID = -1;
            this.var_3210 = false;
            this.var_3211 = -1;
            this.var_3212 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._userID = param1.readInteger();
            this.var_3210 = (param1.readInteger() == 1);
            this.var_3211 = param1.readInteger();
            this.var_3212 = (param1.readInteger() == 1);
            return (true);
        }

    }
}