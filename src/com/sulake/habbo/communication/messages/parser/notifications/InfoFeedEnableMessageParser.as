﻿package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class InfoFeedEnableMessageParser implements IMessageParser 
    {

        private var var_3268:Boolean;

        public function flush():Boolean
        {
            this.var_3268 = false;
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3268 = param1.readBoolean();
            return (true);
        }

        public function get enabled():Boolean
        {
            return (this.var_3268);
        }

    }
}