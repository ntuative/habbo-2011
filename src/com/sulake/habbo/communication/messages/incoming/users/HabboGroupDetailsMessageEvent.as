package com.sulake.habbo.communication.messages.incoming.users
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.users.HabboGroupDetailsMessageParser;

    public class HabboGroupDetailsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboGroupDetailsMessageEvent(param1:Function)
        {
            super(param1, HabboGroupDetailsMessageParser);
        }

        public function get groupId():int
        {
            return ((var_361 as HabboGroupDetailsMessageParser).groupId);
        }

        public function get name():String
        {
            return ((var_361 as HabboGroupDetailsMessageParser).name);
        }

        public function get description():String
        {
            return ((var_361 as HabboGroupDetailsMessageParser).description);
        }

        public function get roomId():int
        {
            return ((var_361 as HabboGroupDetailsMessageParser).roomId);
        }

        public function get roomName():String
        {
            return ((var_361 as HabboGroupDetailsMessageParser).roomName);
        }

    }
}