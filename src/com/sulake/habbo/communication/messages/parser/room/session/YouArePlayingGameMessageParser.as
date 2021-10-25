package com.sulake.habbo.communication.messages.parser.room.session
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class YouArePlayingGameMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _isPlaying: Boolean = false;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get isPlaying(): Boolean
        {
            return this._isPlaying;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._isPlaying = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._isPlaying = data.readBoolean();

            return true;
        }

    }
}
