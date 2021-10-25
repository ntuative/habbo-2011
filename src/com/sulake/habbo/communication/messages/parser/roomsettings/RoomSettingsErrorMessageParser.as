﻿package com.sulake.habbo.communication.messages.parser.roomsettings
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsErrorMessageParser implements IMessageParser
    {

        private var _roomId: int;
        private var _errorCode: int;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._roomId = data.readInteger();
            this._errorCode = data.readInteger();

            return true;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._errorCode = 0;

            return true;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

    }
}
