package com.sulake.habbo.communication.messages.parser.navigator
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class FlatCreatedMessageParser implements IMessageParser
    {

        private var _flatId: int;
        private var _flatName: String;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._flatId = data.readInteger();
            this._flatName = data.readString();

            Logger.log("FLAT CREATED: " + this._flatId + ", " + this._flatName);
            
            return true;
        }

        public function get flatId(): int
        {
            return this._flatId;
        }

        public function get flatName(): String
        {
            return this._flatName;
        }

    }
}
