package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageRequestedMessageParser implements IMessageParser
    {

        private var _objectId: int = -1;
        private var _petType: int = -1;
        private var _breed: int = -1;
        private var _color: String = "";

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get petType(): int
        {
            return this._petType;
        }

        public function get breed(): int
        {
            return this._breed;
        }

        public function get color(): String
        {
            return this._color;
        }

        public function flush(): Boolean
        {
            this._objectId = -1;
            this._petType = -1;
            this._breed = -1;
            this._color = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._objectId = data.readInteger();
            this._petType = data.readInteger();
            this._breed = data.readInteger();
            this._color = data.readString();
            
            return true;
        }

    }
}
