package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpPendingCallsMessageParser implements IMessageParser
    {

        private var _callArray: Array = [];

        public function get callArray(): Array
        {
            return this._callArray;
        }

        public function get callCount(): int
        {
            return this._callArray.length;
        }

        public function flush(): Boolean
        {
            this._callArray = [];

            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            this._callArray = [];
            
            var call: Object;
            var callCount: int = param1.readInteger();
            var i: int;

            while (i < callCount)
            {
                call = {};
                call.callId = param1.readString();
                call.timeStamp = param1.readString();
                call.message = param1.readString();

                this._callArray.push(call);
                i++;
            }

            return true;
        }

    }
}
