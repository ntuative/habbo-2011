package com.sulake.habbo.communication.messages.incoming.friendlist
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class HabboSearchResultData
    {

        private var _avatarId: int;
        private var _avatarName: String;
        private var _avatarMotto: String;
        private var _isAvatarOnline: Boolean;
        private var _canFollow: Boolean;
        private var _avatarGender: int;
        private var _avatarFigure: String;
        private var _lastOnlineDate: String;
        private var _realName: String;

        public function HabboSearchResultData(data: IMessageDataWrapper)
        {
            this._avatarId = data.readInteger();
            this._avatarName = data.readString();
            this._avatarMotto = data.readString();
            this._isAvatarOnline = data.readBoolean();
            this._canFollow = data.readBoolean();
            var _: String = data.readString();
            this._avatarGender = data.readInteger();
            this._avatarFigure = data.readString();
            this._lastOnlineDate = data.readString();
            this._realName = data.readString();
        }

        public function get avatarId(): int
        {
            return this._avatarId;
        }

        public function get avatarName(): String
        {
            return this._avatarName;
        }

        public function get avatarMotto(): String
        {
            return this._avatarMotto;
        }

        public function get isAvatarOnline(): Boolean
        {
            return this._isAvatarOnline;
        }

        public function get canFollow(): Boolean
        {
            return this._canFollow;
        }

        public function get avatarGender(): int
        {
            return this._avatarGender;
        }

        public function get avatarFigure(): String
        {
            return this._avatarFigure;
        }

        public function get lastOnlineDate(): String
        {
            return this._lastOnlineDate;
        }

        public function get realName(): String
        {
            return this._realName;
        }

    }
}
