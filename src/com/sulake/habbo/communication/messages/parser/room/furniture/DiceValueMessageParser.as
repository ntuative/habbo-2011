package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class DiceValueMessageParser implements IMessageParser
    {

        private var _roomId: int = 0;
        private var _roomCategory: int = 0;
        private var _id: int;
        private var _value: int;

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get value(): int
        {
            return this._value;
        }

        public function flush(): Boolean
        {
            this._roomId = 0;
            this._roomCategory = 0;
            this._id = -1;
            this._value = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._id = data.readInteger();
            this._value = data.readInteger();
            
            return true;
        }

    }
}
