package com.sulake.habbo.communication.messages.incoming.sound
{

    public class PlayListEntry
    {

        protected var _id: int;
        protected var _length: int;
        protected var _songName: String;
        protected var _songCreator: String;
        private var _startPlayHeadPos: Number = 0;

        public function PlayListEntry(id: int, length: int, songName: String, songCreator: String)
        {
            this._id = id;
            this._length = length;
            this._songName = songName;
            this._songCreator = songCreator;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get length(): int
        {
            return this._length;
        }

        public function get name(): String
        {
            return this._songName;
        }

        public function get creator(): String
        {
            return this._songCreator;
        }

        public function get startPlayHeadPos(): Number
        {
            return this._startPlayHeadPos;
        }

        public function set startPlayHeadPos(value: Number): void
        {
            this._startPlayHeadPos = value;
        }

    }
}
