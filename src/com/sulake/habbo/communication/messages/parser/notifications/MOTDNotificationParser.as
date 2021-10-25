package com.sulake.habbo.communication.messages.parser.notifications
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class MOTDNotificationParser implements IMessageParser
    {

        private var _messages: Array;

        public function flush(): Boolean
        {
            this._messages = [];
            
            return true;
        }

        public function parse(param1: IMessageDataWrapper): Boolean
        {
            var messageCount: int = param1.readInteger();
            var i: int;
            
            while (i < messageCount)
            {
                this._messages.push(param1.readString());
                i++;
            }

            return true;
        }

        public function get messages(): Array
        {
            return this._messages;
        }

    }
}
