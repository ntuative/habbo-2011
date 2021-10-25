package com.sulake.habbo.communication.messages.incoming.recycler
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeLevelMessageData
    {

        private var _prizeLevelId: int;
        private var _probabilityDenominator: int;
        private var _prizes: Array;

        public function PrizeLevelMessageData(data: IMessageDataWrapper)
        {
            this._prizeLevelId = data.readInteger();
            this._probabilityDenominator = data.readInteger();
            this._prizes = [];
            
            var prizeCount: int = data.readInteger();
            var i: int;
            
            while (i < prizeCount)
            {
                this._prizes.push(new PrizeMessageData(data));
                i++;
            }

        }

        public function get prizeLevelId(): int
        {
            return this._prizeLevelId;
        }

        public function get probabilityDenominator(): int
        {
            return this._probabilityDenominator;
        }

        public function get prizes(): Array
        {
            return this._prizes;
        }

    }
}
