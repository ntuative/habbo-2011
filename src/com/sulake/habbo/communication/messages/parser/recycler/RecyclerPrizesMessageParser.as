package com.sulake.habbo.communication.messages.parser.recycler
{

    import com.sulake.core.communication.messages.IMessageParser;
    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeLevelMessageData;
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class RecyclerPrizesMessageParser implements IMessageParser
    {

        private var _prizeLevels: Array;

        public function flush(): Boolean
        {
            return true;
        }

        public function parse(data: IMessageDataWrapper): Boolean
        {
            this._prizeLevels = [];
            
            var levelCount: int = data.readInteger();
            var i: int;
            
            while (i < levelCount)
            {
                this._prizeLevels.push(new PrizeLevelMessageData(data));
                i++;
            }

            return true;
        }

        public function get prizeLevels(): Array
        {
            return this._prizeLevels;
        }

    }
}
