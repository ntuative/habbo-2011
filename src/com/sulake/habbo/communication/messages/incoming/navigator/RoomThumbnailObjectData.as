package com.sulake.habbo.communication.messages.incoming.navigator
{

    public class RoomThumbnailObjectData
    {

        private var _pos: int;
        private var _imgId: int;

        public function getCopy(): RoomThumbnailObjectData
        {
            var thumbnailObjectData: RoomThumbnailObjectData = new RoomThumbnailObjectData();
            
            thumbnailObjectData._pos = this._pos;
            thumbnailObjectData._imgId = this._imgId;
            
            return thumbnailObjectData;
        }

        public function set pos(param1: int): void
        {
            this._pos = param1;
        }

        public function set imgId(param1: int): void
        {
            this._imgId = param1;
        }

        public function get pos(): int
        {
            return this._pos;
        }

        public function get imgId(): int
        {
            return this._imgId;
        }

    }
}
