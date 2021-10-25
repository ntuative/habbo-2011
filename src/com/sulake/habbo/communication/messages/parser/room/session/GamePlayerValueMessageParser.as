﻿package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class GamePlayerValueMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _userId: int = 0;
        private var _value: int = 0;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get value(): int
        {
            return this._value;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._userId = data.readInteger();
            this._value = data.readInteger();
            
            return true;
        }

    }
}
