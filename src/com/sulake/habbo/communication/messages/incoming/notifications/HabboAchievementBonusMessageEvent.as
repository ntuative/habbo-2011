package com.sulake.habbo.communication.messages.incoming.notifications
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementBonusMessageParser;

    public class HabboAchievementBonusMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function HabboAchievementBonusMessageEvent(param1: Function)
        {
            super(param1, HabboAchievementBonusMessageParser);
        }

        public function get bonusPoints(): int
        {
            return (_parser as HabboAchievementBonusMessageParser).bonusPoints;
        }

        public function get realName(): String
        {
            return (_parser as HabboAchievementBonusMessageParser).realName;
        }

    }
}
