package com.sulake.habbo.communication.messages.parser.room.furniture
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenPetPackageResultMessageParser implements IMessageParser
    {

        private var _objectId: int = 0;
        private var _nameValidationStatus: int = 0;
        private var _nameValidationInfo: String = null;

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get nameValidationStatus(): int
        {
            return this._nameValidationStatus;
        }

        public function get nameValidationInfo(): String
        {
            return this._nameValidationInfo;
        }

        public function flush(): Boolean
        {
            this._objectId = 0;
            this._nameValidationStatus = 0;
            this._nameValidationInfo = null;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            if (data == null)
            {
                return false;
            }

            this._objectId = data.readInteger();
            this._nameValidationStatus = data.readInteger();
            this._nameValidationInfo = data.readString();
            
            return true;
        }

    }
}
