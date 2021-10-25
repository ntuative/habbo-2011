﻿package com.sulake.habbo.communication.messages.parser.moderation
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class ModeratorActionResultMessageParser implements IMessageParser
    {

        private var _userId: int;
        private var _success: Boolean;

        public function get userId(): int
        {
            return this._userId;
        }

        public function get success(): Boolean
        {
            return this._success;
        }

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._userId = data.readInteger();
            this._success = data.readBoolean();
            
            return true;
        }

    }
}
