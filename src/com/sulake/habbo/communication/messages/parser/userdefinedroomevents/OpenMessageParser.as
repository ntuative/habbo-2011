package com.sulake.habbo.communication.messages.parser.userdefinedroomevents
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class OpenMessageParser implements IMessageParser
    {

        private var _stuffId: int;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._stuffId = data.readInteger();
            
            return true;
        }

        public function get stuffId(): int
        {
            return this._stuffId;
        }

    }
}
