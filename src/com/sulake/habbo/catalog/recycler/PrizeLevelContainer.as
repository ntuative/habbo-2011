package com.sulake.habbo.catalog.recycler
{

    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeMessageData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.communication.messages.incoming.recycler.PrizeLevelMessageData;
    import com.sulake.habbo.catalog.IHabboCatalog;

    public class PrizeLevelContainer
    {

        private var _priceLevelId: int;
        private var _prizes: Array;

        public function PrizeLevelContainer(messageData: PrizeLevelMessageData, catalog: IHabboCatalog)
        {
            super();
            this._priceLevelId = messageData.prizeLevelId;
            this._prizes = [];

            catalog.localization.registerParameter("recycler.prizes.odds." + this._priceLevelId, "odds", "1:" + messageData.probabilityDenominator);

            var prizeMessageData: PrizeMessageData;
            var furnitureData: IFurnitureData;
            var prizeContainer: PrizeContainer;

            for (var i: int = 0; i < messageData.prizes.length; i++)
            {
                prizeMessageData = messageData.prizes[i];
                furnitureData = catalog.getFurnitureData(prizeMessageData.productItemTypeId, prizeMessageData.productItemType);
                prizeContainer = new PrizeContainer(prizeMessageData.productItemType, prizeMessageData.productItemTypeId, furnitureData, this._priceLevelId);
                this._prizes.push(prizeContainer);
            }

        }

        public function get prizeLevelId(): int
        {
            return this._priceLevelId;
        }

        public function get prizes(): Array
        {
            return this._prizes;
        }

    }
}
