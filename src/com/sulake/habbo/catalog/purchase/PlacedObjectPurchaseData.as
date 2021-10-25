package com.sulake.habbo.catalog.purchase
{

    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.catalog.IPurchasableOffer;

    public class PlacedObjectPurchaseData implements IDisposable
    {

        private var _disposed: Boolean = false;
        private var _objectId: int;
        private var _category: int;
        private var _roomId: int;
        private var _roomCategory: int;
        private var _wallLocation: String = "";
        private var _x: int = 0;
        private var _y: int = 0;
        private var _direction: int = 0;
        private var _offerId: int;
        private var _productClassId: int;
        private var _productData: IProductData;
        private var _furnitureData: IFurnitureData;

        public function PlacedObjectPurchaseData(roomId: int, roomCategory: int, objectId: int, category: int, wallLocation: String, x: int, y: int, direction: int, offer: IPurchasableOffer)
        {
            this._roomId = roomId;
            this._roomCategory = roomCategory;
            this._objectId = objectId;
            this._category = category;
            this._wallLocation = wallLocation;
            this._x = x;
            this._y = y;
            this._direction = direction;

            this.setOfferData(offer);
        }

        public function dispose(): void
        {
            this._disposed = true;
            this._productData = null;
            this._furnitureData = null;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        private function setOfferData(offer: IPurchasableOffer): void
        {
            this._offerId = offer.offerId;
            this._productClassId = offer.productContainer.firstProduct.productClassId;
            this._productData = offer.productContainer.firstProduct.productData;
            this._furnitureData = offer.productContainer.firstProduct.furnitureData;
        }

        public function toString(): String
        {
            return [
                this._roomCategory,
                this._roomId,
                this._objectId,
                this._category,
                this._wallLocation,
                this._x,
                this._y,
                this._direction,
                this._offerId,
                this._productClassId
            ].toString();
        }

        public function get objectId(): int
        {
            return this._objectId;
        }

        public function get category(): int
        {
            return this._category;
        }

        public function get roomId(): int
        {
            return this._roomId;
        }

        public function get roomCategory(): int
        {
            return this._roomCategory;
        }

        public function get wallLocation(): String
        {
            return this._wallLocation;
        }

        public function get x(): int
        {
            return this._x;
        }

        public function get y(): int
        {
            return this._y;
        }

        public function get direction(): int
        {
            return this._direction;
        }

        public function get offerId(): int
        {
            return this._offerId;
        }

        public function get productClassId(): int
        {
            return this._productClassId;
        }

    }
}
