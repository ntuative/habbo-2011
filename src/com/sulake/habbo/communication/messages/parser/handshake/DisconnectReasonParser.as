﻿package com.sulake.habbo.communication.messages.parser.handshake
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DisconnectReasonParser implements IMessageParser
    {

        private var _reason: int;

        public function DisconnectReasonParser()
        {
            this._reason = -1;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._reason = data.readInteger();
            
            return true;
        }

        public function get reason(): int
        {
            return this._reason;
        }

    }
}
