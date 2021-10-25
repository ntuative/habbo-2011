package com.sulake.habbo.catalog.viewer
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room.IRoomEngine;

    import flash.display.BitmapData;

    public class ProductContainer extends ProductGridItem implements IGetImageListener, IProductContainer, IGridItem
    {

        protected var _offer: Offer;
        private var _products: Array;
        private var _iconCallbackId: int;

        public function ProductContainer(offer: Offer, products: Array)
        {
            this._offer = offer;
            this._products = products;
        }

        public function get iconCallbackId(): int
        {
            return this._iconCallbackId;
        }

        public function set iconCallbackId(param1: int): void
        {
            this._iconCallbackId = param1;
        }

        public function get products(): Array
        {
            return this._products;
        }

        public function get firstProduct(): IProduct
        {
            return this._products[0] as IProduct;
        }

        public function get offer(): Offer
        {
            return this._offer;
        }

        override public function dispose(): void
        {
            super.dispose();

            var product: Product;
            for each (product in this._products)
            {
                product.dispose();
            }


            this._products = null;
            this._iconCallbackId = 0;
        }

        public function initProductIcon(param1: IRoomEngine): void
        {
        }

        public function imageReady(_: int, bitmap: BitmapData): void
        {
            setIconImage(bitmap);
        }

    }
}
