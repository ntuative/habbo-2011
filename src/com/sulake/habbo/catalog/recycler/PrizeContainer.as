package com.sulake.habbo.catalog.recycler
{

    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.IRoomEngine;

    public class PrizeContainer extends PrizeGridItem
    {

        private var _productItemType: String;
        private var _productItemTypeId: int;
        private var _oddsLevelId: int;
        private var _furnitureData: IFurnitureData;
        private var _gridItem: PrizeGridItem;

        public function PrizeContainer(productItemType: String, productItemTypeId: int, furnitureData: IFurnitureData, oddsLevelId: int)
        {
            this._productItemType = productItemType;
            this._productItemTypeId = productItemTypeId;
            this._furnitureData = furnitureData;
            this._oddsLevelId = oddsLevelId;
        }

        public function setIcon(roomEngine: IRoomEngine): void
        {
            if (roomEngine == null || this._furnitureData == null)
            {
                return;
            }


            initProductIcon(roomEngine, this._furnitureData.type, this._productItemTypeId);
        }

        public function get productItemType(): String
        {
            return this._productItemType;
        }

        public function get productItemTypeId(): int
        {
            return this._productItemTypeId;
        }

        public function get gridItem(): PrizeGridItem
        {
            return this._gridItem;
        }

        public function get oddsLevelId(): int
        {
            return this._oddsLevelId;
        }

        public function get title(): String
        {
            if (this._furnitureData == null)
            {
                return "";
            }


            return this._furnitureData.title;
        }

    }
}
