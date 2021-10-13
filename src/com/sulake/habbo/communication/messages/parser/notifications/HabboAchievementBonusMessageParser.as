package com.sulake.habbo.communication.messages.parser.notifications
{
    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementBonusMessageParser implements IMessageParser 
    {

        private var var_3261:int;
        private var var_2912:String;

        public function flush():Boolean
        {
            return (true);
        }

        public function parse(param1:IMessageDataWrapper):Boolean
        {
            this.var_3261 = param1.readInteger();
            this.var_2912 = param1.readString();
            return (true);
        }

        public function get bonusPoints():int
        {
            return (this.var_3261);
        }

        public function get realName():String
        {
            return (this.var_2912);
        }

    }
}