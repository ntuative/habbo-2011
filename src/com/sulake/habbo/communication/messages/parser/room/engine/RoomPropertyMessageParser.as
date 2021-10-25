package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomPropertyMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _floorType: String = null;
        private var _wallType: String = null;
        private var _landscapeType: String = null;
        private var _animatedLandskapeType: String = null;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get floorType(): String
        {
            return this._floorType;
        }

        public function get wallType(): String
        {
            return this._wallType;
        }

        public function get landscapeType(): String
        {
            return this._landscapeType;
        }

        public function get animatedLandskapeType(): String
        {
            return this._animatedLandskapeType;
        }

        public function flush(): Boolean
        {
            this._floorType = null;
            this._wallType = null;
            this._landscapeType = null;
            this._animatedLandskapeType = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            var type: String = data.readString();
            var value: String = data.readString();

            switch (type)
            {
                case "floor":
                    this._floorType = value;
                    break;
                case "wallpaper":
                    this._wallType = value;
                    break;
                case "landscape":
                    this._landscapeType = value;
                    break;
                case "landscapeanim":
                    this._animatedLandskapeType = value;
                    break;
            }

            return true;
        }

    }
}
