package com.sulake.habbo.communication.messages.incoming.room.engine
{

    public class AvatarActionMessageData
    {

        private var _actionType: String;
        private var _actionParameter: String;

        public function AvatarActionMessageData(actionType: String, actionParameter: String)
        {
            this._actionType = actionType;
            this._actionParameter = actionParameter;
        }

        public function get actionType(): String
        {
            return this._actionType;
        }

        public function get actionParameter(): String
        {
            return this._actionParameter;
        }

    }
}
