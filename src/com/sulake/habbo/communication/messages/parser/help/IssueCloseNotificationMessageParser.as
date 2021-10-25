package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class IssueCloseNotificationMessageParser implements IMessageParser
    {

        private var _closeReason: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._closeReason = data.readInteger();
            
            return true;
        }

        public function get closeReason(): int
        {
            return this._closeReason;
        }

    }
}
