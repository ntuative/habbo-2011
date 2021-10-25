package com.sulake.habbo.communication.messages.parser.users
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboGroupDetailsMessageParser implements IMessageParser
    {

        private var _groupId: int = -1;
        private var _name: String = "";
        private var _description: String = "";
        private var _roomId: int = -1;
        private var _roomName: String = "";

        public function flush(): Boolean
        {
            this._groupId = -1;
            this._name = "";
            this._description = "";
            this._roomId = -1;
            this._roomName = "";
            
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._groupId = data.readInteger();

            if (this._groupId != -1)
            {
                this._name = data.readString();
                this._description = data.readString();
                this._roomId = data.readInteger();
                this._roomName = data.readString();
            }

            return true;
        }

        public function get groupId(): int
        {
            return this._groupId;
        }

        public function get name(): String
        {
            return this._name;
        }

        public function get description(): String
        {
            return this._description;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomName(): String
        {
            return this._roomName;
        }

    }
}
