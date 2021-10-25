package com.sulake.habbo.communication.messages.parser.friendlist
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RoomInviteErrorMessageParser implements IMessageParser
    {

        private var _errorCode: int;
        private var _failedRecipients: Array;

        public function flush(): Boolean
        {
            this._failedRecipients = [];
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._errorCode = data.readInteger();
            
            if (this._errorCode == 1)
            {
                var failedRecipientCount: int = data.readInteger();
                var i: int = 0;

                while (i < failedRecipientCount)
                {
                    this._failedRecipients.push(data.readInteger());
                    i++;
                }

            }

            return true;
        }

        public function get errorCode(): int
        {
            return this._errorCode;
        }

        public function get failedRecipients(): Array
        {
            return this._failedRecipients;
        }

    }
}
