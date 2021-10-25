package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class UserChangeMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _id: int;
        private var _figure: String;
        private var _sex: String;
        private var _customInfo: String;
        private var _achievementScore: int;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get figure(): String
        {
            return this._figure;
        }

        public function get sex(): String
        {
            return this._sex;
        }

        public function get customInfo(): String
        {
            return this._customInfo;
        }

        public function get achievementScore(): int
        {
            return this._achievementScore;
        }

        public function flush(): Boolean
        {
            this._id = 0;
            this._figure = "";
            this._sex = "";
            this._customInfo = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._id = data.readInteger();
            this._figure = data.readString();
            this._sex = data.readString();
            this._customInfo = data.readString();
            this._achievementScore = data.readInteger();

            if (this._sex != null)
            {
                this._sex = this._sex.toUpperCase();
            }

            return true;
        }

    }
}
