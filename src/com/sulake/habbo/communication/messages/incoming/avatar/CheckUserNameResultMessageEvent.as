package com.sulake.habbo.communication.messages.incoming.avatar
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;

    public class CheckUserNameResultMessageEvent extends MessageEvent implements IMessageEvent
    {

        public static var var_1425: int = 0;
        public static var var_1856: int = 1;
        public static var var_1857: int = 2;
        public static var var_1858: int = 3;
        public static var var_1859: int = 4;
        public static var var_1860: int = 5;

        public function CheckUserNameResultMessageEvent(param1: Function)
        {
            super(param1, CheckUserNameResultMessageParser);
        }

        public function getParser(): CheckUserNameResultMessageParser
        {
            return _parser as CheckUserNameResultMessageParser;
        }

    }
}
