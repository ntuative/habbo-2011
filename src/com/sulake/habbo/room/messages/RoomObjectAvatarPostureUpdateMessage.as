package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarPostureUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _postureType: String;
        private var _parameter: String;

        public function RoomObjectAvatarPostureUpdateMessage(postureType: String, parameter: String = "")
        {
            this._postureType = postureType;
            this._parameter = parameter;
        }

        public function get postureType(): String
        {
            return this._postureType;
        }

        public function get parameter(): String
        {
            return this._parameter;
        }

    }
}
