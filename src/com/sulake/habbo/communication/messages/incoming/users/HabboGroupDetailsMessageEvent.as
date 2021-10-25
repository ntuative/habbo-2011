package com.sulake.habbo.communication.messages.incoming.users
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupDetailsMessageParser;

    public class HabboGroupDetailsMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function HabboGroupDetailsMessageEvent(param1: Function)
        {
            super(param1, HabboGroupDetailsMessageParser);
        }

        public function get groupId(): int
        {
            return (_parser as HabboGroupDetailsMessageParser).groupId;
        }

        public function get name(): String
        {
            return (_parser as HabboGroupDetailsMessageParser).name;
        }

        public function get description(): String
        {
            return (_parser as HabboGroupDetailsMessageParser).description;
        }

        public function get roomId(): int
        {
            return (_parser as HabboGroupDetailsMessageParser).roomId;
        }

        public function get roomName(): String
        {
            return (_parser as HabboGroupDetailsMessageParser).roomName;
        }

    }
}
