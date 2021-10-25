package com.sulake.habbo.communication.messages.parser.poll
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PollOfferParser implements IMessageParser
    {

        private var _id: int = -1;
        private var _summary: String = "";

        public function get id(): int
        {
            return this._id;
        }

        public function get summary(): String
        {
            return this._summary;
        }

        public function flush(): Boolean
        {
            this._id = -1;
            this._summary = "";

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._id = data.readInteger();
            this._summary = data.readString();

            return true;
        }

    }
}
