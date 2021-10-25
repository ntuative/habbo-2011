package com.sulake.habbo.communication.messages.parser.room.action
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class AvatarEffectMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _userId: int = 0;
        private var _effectId: int = 0;
        private var _delayMilliSeconds: int = 0;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get userId(): int
        {
            return this._userId;
        }

        public function get effectId(): int
        {
            return this._effectId;
        }

        public function get delayMilliSeconds(): int
        {
            return this._delayMilliSeconds;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._userId = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._userId = data.readInteger();
            this._effectId = data.readInteger();
            this._delayMilliSeconds = data.readInteger();
            
            return true;
        }

    }
}
