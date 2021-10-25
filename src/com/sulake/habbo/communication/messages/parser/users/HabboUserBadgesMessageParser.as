package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboUserBadgesMessageParser implements IMessageParser
    {

        private var _userId: int;
        private var _badges: Array;

        public function flush(): Boolean
        {
            this._userId = -1;
            this._badges = [];

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._userId = data.readInteger();
            
            var id: int;
            var name: String;
            
            var badgeCount: int = data.readInteger();
            var i: int;
            
            while (i < badgeCount)
            {
                id = data.readInteger();
                name = data.readString();

                this._badges.push(name);
                
                i++;
            }

            return true;
        }

        public function get badges(): Array
        {
            return this._badges;
        }

        public function get userId(): int
        {
            return this._userId;
        }

    }
}
