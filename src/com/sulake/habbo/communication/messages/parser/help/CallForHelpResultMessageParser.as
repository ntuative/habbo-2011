package com.sulake.habbo.communication.messages.parser.help
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class CallForHelpResultMessageParser implements IMessageParser
    {

        private var _resultType: int;

        public function get resultType(): int
        {
            return this._resultType;
        }

        public function flush(): Boolean
        {
            this._resultType = -1;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._resultType = data.readInteger();
            
            return true;
        }

    }
}
