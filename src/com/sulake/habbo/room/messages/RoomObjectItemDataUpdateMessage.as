package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    public class RoomObjectItemDataUpdateMessage extends RoomObjectUpdateMessage
    {

        private var _itemData: String;

        public function RoomObjectItemDataUpdateMessage(itemData: String)
        {
            super(null, null);
            this._itemData = itemData;
        }

        public function get itemData(): String
        {
            return this._itemData;
        }

    }
}
