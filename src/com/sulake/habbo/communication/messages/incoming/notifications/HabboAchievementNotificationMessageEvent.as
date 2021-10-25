package com.sulake.habbo.communication.messages.incoming.notifications
{

    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;

    public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent
    {

        public function HabboAchievementNotificationMessageEvent(param1: Function)
        {
            super(param1, HabboAchievementNotificationMessageParser);
        }

        public function get type(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).type;
        }

        public function get level(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).level;
        }

        public function get points(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).points;
        }

        public function get levelRewardPoints(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).levelRewardPoints;
        }

        public function get levelRewardPointType(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).levelRewardPointType;
        }

        public function get bonusPoints(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).bonusPoints;
        }

        public function get badgeID(): String
        {
            return (_parser as HabboAchievementNotificationMessageParser).badgeID;
        }

        public function get achievementID(): int
        {
            return (_parser as HabboAchievementNotificationMessageParser).achievementID;
        }

        public function get removedBadgeID(): String
        {
            return (_parser as HabboAchievementNotificationMessageParser).removedBadgeID;
        }

    }
}
