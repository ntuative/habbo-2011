package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementNotificationMessageParser implements IMessageParser 
    {

        private var _type:int;
        private var var_2924:int;
        private var var_3259:int;
        private var var_2927:int;
        private var var_2928:int;
        private var var_3261:int;
        private var var_3262:String = "";
        private var var_3263:String = "";
        private var var_3264:int;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this._type = param1.readInteger();
            this.var_2924 = param1.readInteger();
            this.var_3262 = param1.readString();
            this.var_3259 = param1.readInteger();
            this.var_2927 = param1.readInteger();
            this.var_2928 = param1.readInteger();
            this.var_3261 = param1.readInteger();
            this.var_3264 = param1.readInteger();
            this.var_3263 = param1.readString();
            return (true);
        }

        public function get type():int
        {
            return (this._type);
        }

        public function get level():int
        {
            return (this.var_2924);
        }

        public function get points():int
        {
            return (this.var_3259);
        }

        public function get levelRewardPoints():int
        {
            return (this.var_2927);
        }

        public function get levelRewardPointType():int
        {
            return (this.var_2928);
        }

        public function get bonusPoints():int
        {
            return (this.var_3261);
        }

        public function get badgeID():String
        {
            return (this.var_3262);
        }

        public function get achievementID():int
        {
            return (this.var_3264);
        }

        public function get removedBadgeID():String
        {
            return (this.var_3263);
        }

    }
}