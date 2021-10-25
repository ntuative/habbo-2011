﻿package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboActivityPointNotificationMessageParser implements IMessageParser
    {

        private var _amount: int = 0;
        private var _change: int = 0;
        private var _type: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._amount = data.readInteger();
            this._change = data.readInteger();
            this._type = data.readInteger();
            
            return true;
        }

        public function get amount(): int
        {
            return this._amount;
        }

        public function get change(): int
        {
            return this._change;
        }

        public function get type(): int
        {
            return this._type;
        }

    }
}
