package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.HabboAchievementNotificationMessageParser;

    public class HabboAchievementNotificationMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function HabboAchievementNotificationMessageEvent(param1:Function)
        {
            super(param1, HabboAchievementNotificationMessageParser);
        }

        public function get type():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).type);
        }

        public function get level():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).level);
        }

        public function get points():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).points);
        }

        public function get levelRewardPoints():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).levelRewardPoints);
        }

        public function get levelRewardPointType():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).levelRewardPointType);
        }

        public function get bonusPoints():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).bonusPoints);
        }

        public function get badgeID():String
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).badgeID);
        }

        public function get achievementID():int
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).achievementID);
        }

        public function get removedBadgeID():String
        {
            return ((var_361 as HabboAchievementNotificationMessageParser).removedBadgeID);
        }

    }
}