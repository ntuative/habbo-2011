﻿package com.sulake.habbo.communication.messages.parser.catalog
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PurchaseNotAllowedMessageParser implements IMessageParser 
    {

        private var var_2102:int = 0;

        public function get errorCode():int
        {
            return (this.var_2102);
        }

        public function flush():Boolean
        {
            this.var_2102 = 0;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_2102 = param1.readInteger();
            return (true);
        }

    }
}