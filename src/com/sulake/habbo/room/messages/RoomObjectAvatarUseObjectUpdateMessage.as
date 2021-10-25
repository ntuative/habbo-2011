package com.sulake.habbo.room.messages
{

    public class RoomObjectAvatarUseObjectUpdateMessage extends RoomObjectUpdateStateMessage
    {

        private var _itemType: int;

        public function RoomObjectAvatarUseObjectUpdateMessage(itemType: int)
        {
            this._itemType = itemType;
        }

        public function get itemType(): int
        {
            return this._itemType;
        }

    }
}
