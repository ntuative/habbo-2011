package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboAchievementShareIdMessageParser implements IMessageParser
    {

        private var _badgeId: String = "";
        private var _shareId: String = "";

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._badgeId = data.readString();
            this._shareId = data.readString();
            
            return true;
        }

        public function get badgeID(): String
        {
            return this._badgeId;
        }

        public function get shareID(): String
        {
            return this._shareId;
        }

    }
}
