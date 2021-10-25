package com.sulake.habbo.communication.messages.incoming.avatar
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.ChangeUserNameResultMessageParser;

    public class ChangeUserNameResultMessageEvent extends MessageEvent implements IMessageEvent
    {

        public static var NAME_CHANGE_SUCCESS: int = 0;
        public static var NAME_CHANGE_UNKNOWN_ERROR: int = 1;
        public static var NAME_CHANGE_RESULT_NAME_TOO_SHORT: int = 2;
        public static var NAME_CHANGE_RESULT_NAME_TOO_LONG: int = 3;
        public static var NAME_CHANGE_RESULT_NAME_INVALID: int = 4;
        public static var NAME_CHANGE_RESULT_NAME_TAKEN: int = 5;
        public static var NAME_CHANGE_RESULT_NOT_ALLOWED: int = 6;
        public static var NAME_CHANGE_RESULT_HOTEL_MERGE_DOWN: int = 7;

        public function ChangeUserNameResultMessageEvent(param1: Function)
        {
            super(param1, ChangeUserNameResultMessageParser);
        }

        public function getParser(): ChangeUserNameResultMessageParser
        {
            return _parser as ChangeUserNameResultMessageParser;
        }

    }
}
