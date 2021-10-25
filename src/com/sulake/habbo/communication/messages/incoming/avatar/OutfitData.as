package com.sulake.habbo.communication.messages.incoming.avatar
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OutfitData
    {

        private var _slotId: int;
        private var _figureString: String;
        private var _gender: String;

        public function OutfitData(data: IMessageDataWrapper)
        {
            this._slotId = data.readInteger();
            this._figureString = data.readString();
            this._gender = data.readString();
        }

        public function get slotId(): int
        {
            return this._slotId;
        }

        public function get figureString(): String
        {
            return this._figureString;
        }

        public function get gender(): String
        {
            return this._gender;
        }

    }
}
