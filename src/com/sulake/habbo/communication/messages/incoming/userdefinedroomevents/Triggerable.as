package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Triggerable
    {

        private var _stuffTypeSelectionEnabled: Boolean;
        private var _furniLimit: int;
        private var _stuffIds: Array = [];
        private var _id: int;
        private var _stringParam: String;
        private var _intParams: Array = [];
        private var _stuffTypeId: int;
        private var _stuffTypeSelectionCode: int;

        public function Triggerable(data: IMessageDataWrapper)
        {
            super();
            this._stuffTypeSelectionEnabled = data.readBoolean();
            this._furniLimit = data.readInteger();
            
            var stuffIdCount: int = data.readInteger();
            var i: int;
            
            while (i < stuffIdCount)
            {
                this._stuffIds.push(data.readInteger());
                i++;
            }

            this._stuffTypeId = data.readInteger();
            this._id = data.readInteger();
            this._stringParam = data.readString();
            
            var intParamsCount: int = data.readInteger();
            i = 0;
            
            while (i < intParamsCount)
            {
                this._intParams.push(data.readInteger());
                i++;
            }

            this._stuffTypeSelectionCode = data.readInteger();
        }

        public function get stuffTypeSelectionEnabled(): Boolean
        {
            return this._stuffTypeSelectionEnabled;
        }

        public function get stuffTypeSelectionCode(): int
        {
            return this._stuffTypeSelectionCode;
        }

        public function set stuffTypeSelectionCode(value: int): void
        {
            this._stuffTypeSelectionCode = value;
        }

        public function get furniLimit(): int
        {
            return this._furniLimit;
        }

        public function get stuffIds(): Array
        {
            return this._stuffIds;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get stringParam(): String
        {
            return this._stringParam;
        }

        public function get intParams(): Array
        {
            return this._intParams;
        }

        public function get code(): int
        {
            return 0;
        }

        public function get stuffTypeId(): int
        {
            return this._stuffTypeId;
        }

        public function getBoolean(value: int): Boolean
        {
            return this._intParams[value] == 1;
        }

    }
}
