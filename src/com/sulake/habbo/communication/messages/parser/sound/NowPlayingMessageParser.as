package com.sulake.habbo.communication.messages.parser.sound
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class NowPlayingMessageParser implements IMessageParser
    {

        private var _currentSongId: int;
        private var _currentPosition: int;
        private var _nextSongId: int;
        private var _nextPosition: int;
        private var _syncCount: int;

        public function get currentSongId(): int
        {
            return this._currentSongId;
        }

        public function get currentPosition(): int
        {
            return this._currentPosition;
        }

        public function get nextSongId(): int
        {
            return this._nextSongId;
        }

        public function get nextPosition(): int
        {
            return this._nextPosition;
        }

        public function get syncCount(): int
        {
            return this._syncCount;
        }

        public function flush(): Boolean
        {
            this._currentSongId = -1;
            this._currentPosition = -1;
            this._nextSongId = -1;
            this._nextPosition = -1;
            this._syncCount = -1;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._currentSongId = data.readInteger();
            this._currentPosition = data.readInteger();
            this._nextSongId = data.readInteger();
            this._nextPosition = data.readInteger();
            this._syncCount = data.readInteger();

            return true;
        }

    }
}
