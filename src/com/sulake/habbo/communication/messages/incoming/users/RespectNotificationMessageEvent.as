package com.sulake.habbo.communication.messages.incoming.users
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.RespectNotificationMessageParser;

    public class RespectNotificationMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function RespectNotificationMessageEvent(param1: Function)
        {
            super(param1, RespectNotificationMessageParser);
        }

        public function get userId(): int
        {
            return (_parser as RespectNotificationMessageParser).userId;
        }

        public function get respectTotal(): int
        {
            return (_parser as RespectNotificationMessageParser).respectTotal;
        }

    }
}
