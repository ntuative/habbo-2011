package com.sulake.habbo.communication.messages.parser.recycler
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RecyclerFinishedMessageParser implements IMessageParser
    {

        private var _recyclerFinishedStatus: int = -1;
        private var _prizeId: int = 0;

        public function get recyclerFinishedStatus(): int
        {
            return this._recyclerFinishedStatus;
        }

        public function get prizeId(): int
        {
            return this._prizeId;
        }

        public function flush(): Boolean
        {
            this._recyclerFinishedStatus = -1;
            this._prizeId = 0;

            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._recyclerFinishedStatus = data.readInteger();
            this._prizeId = data.readInteger();

            return true;
        }

    }
}
