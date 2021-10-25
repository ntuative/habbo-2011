package com.sulake.habbo.room.messages
{

    import com.sulake.room.messages.RoomObjectUpdateMessage;

    import flash.display.BitmapData;

    public class RoomObjectRoomAdUpdateMessage extends RoomObjectUpdateMessage
    {

        public static const RORUM_ROOM_AD_ACTIVATE: String = "RORUM_ROOM_AD_ACTIVATE";
        public static const RORUM_ROOM_BILLBOARD_IMAGE_LOADED: String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADED";
        public static const RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED: String = "RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED";

        private var _type: String;
        private var _asset: String;
        private var _dynamic: String;
        private var _objectId: int;
        private var _bitmapData: BitmapData;

        public function RoomObjectRoomAdUpdateMessage(type: String, asset: String, dynamic: String, objectId: int = -1, bitmapData: BitmapData = null)
        {
            super(null, null);
            this._type = type;
            this._asset = asset;
            this._dynamic = dynamic;
            this._objectId = objectId;
            this._bitmapData = bitmapData;
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get asset(): String
        {
            return this._asset;
        }

        public function get clickUrl(): String
        {
            return this._dynamic;
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get bitmapData(): BitmapData
        {
            return this._bitmapData;
        }

    }
}
