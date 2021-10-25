package com.sulake.habbo.communication.messages.parser.roomsettings
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomSettingsSaveErrorMessageParser implements IMessageParser
    {

        public static const ROOM_SETTINGS_UNKNOWN_1: int = 1;
        public static const ROOM_SETTINGS_UNKNOWN_2: int = 2;
        public static const ROOM_SETTINGS_UNKNOWN_3: int = 3;
        public static const ROOM_SETTINGS_UNKNOWN_4: int = 4;
        public static const ROOM_SETTINGS_PASSWORD_IS_MANDATORY: int = 5;
        public static const ROOM_SETTINGS_UNKNOWN_5: int = 6;
        public static const ROOM_SETTINGS_NAME_IS_MANDATORY: int = 7;
        public static const ROOM_SETTINGS_UNACCEPTABLE_WORDS_1: int = 8;
        public static const ROOM_SETTINGS_UNKNOWN_6: int = 9;
        public static const ROOM_SETTINGS_UNACCEPTABLE_WORDS_2: int = 10;
        public static const ROOM_SETTINGS_UNACCEPTABLE_WORDS_3: int = 11;
        public static const ROOM_SETTINGS_NON_CHOOSABLE_TAG: int = 12;

        private var _roomId: int;
        private var _errorCode: int;
        private var _info: String;

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._roomId = data.readInteger();
            this._errorCode = data.readInteger();
            this._info = data.readString();

            return true;
        }

        public function flush(): Boolean
        {
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

        public function get info(): String
        {
            return this._info;
        }

    }
}
