package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementBonusMessageParser implements IMessageParser
    {

        private var _bonusPoints: int;
        private var _realName: String;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._bonusPoints = data.readInteger();
            this._realName = data.readString();
            
            return true;
        }

        public function get bonusPoints(): int
        {
            return this._bonusPoints;
        }

        public function get realName(): String
        {
            return this._realName;
        }

    }
}
