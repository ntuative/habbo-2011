package com.sulake.habbo.communication.messages.parser.room.pets
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PetPlacingErrorParser implements IMessageParser
    {

        private var _errorCode: int;
        private var _roomId: int = 0;
        private var _roomCategory: int = 0;

        public function get errorCode(): int
        {
            return this._errorCode;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function flush(): Boolean
        {
            this._errorCode = -1;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._errorCode = data.readInteger();
            
            return true;
        }

    }
}
