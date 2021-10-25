package com.sulake.habbo.communication.messages.incoming.recycler
{

    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class PrizeMessageData
    {

        private var _productItemType: String;
        private var _productItemTypeId: int;

        public function PrizeMessageData(data: IMessageDataWrapper)
        {
            this._productItemType = data.readString();
            this._productItemTypeId = data.readInteger();
        }

        public function get productItemType(): String
        {
            return this._productItemType;
        }

        public function get productItemTypeId(): int
        {
            return this._productItemTypeId;
        }

    }
}
