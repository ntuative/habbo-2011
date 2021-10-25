package com.sulake.habbo.communication.messages.parser.room.engine
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomVisualizationSettingsParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _wallsHidden: Boolean = false;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get wallsHidden(): Boolean
        {
            return this._wallsHidden;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._wallsHidden = false;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._wallsHidden = data.readBoolean();
            
            return true;
        }

    }
}
