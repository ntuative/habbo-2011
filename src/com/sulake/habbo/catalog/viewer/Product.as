package com.sulake.habbo.catalog.viewer
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;
    import com.sulake.habbo.room.ImageResult;

    import flash.display.BitmapData;

    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.habbo.catalog.IHabboCatalog;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.core.window.IWindowContainer;

    public class Product extends ProductGridItem implements IProduct, IGetImageListener
    {

        private var _productType: String;
        private var _productClassId: int;
        private var _extraParam: String;
        private var _productCount: int;
        private var _expiration: int;
        private var _productData: IProductData;
        private var _furnitureData: IFurnitureData;

        public function Product(param1: String, param2: int, param3: String, param4: int, param5: int, param6: IProductData, param7: IFurnitureData)
        {
            this._productType = param1;
            this._productClassId = param2;
            this._extraParam = param3;
            this._productCount = param4;
            this._expiration = param5;
            this._productData = param6;
            this._furnitureData = param7;
        }

        public function get productType(): String
        {
            return this._productType;
        }

        public function get productClassId(): int
        {
            return this._productClassId;
        }

        public function get extraParam(): String
        {
            return this._extraParam;
        }

        public function get productCount(): int
        {
            return this._productCount;
        }

        public function get expiration(): int
        {
            return this._expiration;
        }

        public function get productData(): IProductData
        {
            return this._productData;
        }

        public function get furnitureData(): IFurnitureData
        {
            return this._furnitureData;
        }

        override public function dispose(): void
        {
            super.dispose();
            this._productType = "";
            this._productClassId = 0;
            this._extraParam = "";
            this._productCount = 0;
            this._expiration = 0;
            this._productData = null;
        }

        public function initIcon(container: IProductContainer, listener: IGetImageListener = null): BitmapData
        {
            var imageResult: ImageResult;
            var bitmap: BitmapData;

            if (listener == null)
            {
                listener = this;
            }


            var roomEngine: IRoomEngine = (container as ProductContainer).offer.page.viewer.roomEngine;
            var catalog: IHabboCatalog = (container as ProductContainer).offer.page.viewer.catalog;

            switch (this._productType)
            {
                case ProductTypeEnum.var_112:
                    imageResult = roomEngine.getFurnitureIcon(this.productClassId, listener);
                    break;
                case ProductTypeEnum.var_113:
                    imageResult = roomEngine.getWallItemIcon(this.productClassId, listener, this._extraParam);
                    break;
                case ProductTypeEnum.var_118:
                    bitmap = catalog.getPixelEffectIcon(this.productClassId);
                    break;
                case ProductTypeEnum.var_153:
                    bitmap = catalog.getSubscriptionProductIcon(this.productClassId);
                    break;
                default:
                    Logger.log("[Product] Can not yet handle this type of product: " + this.productType);
            }


            if (imageResult != null)
            {
                bitmap = imageResult.data;

                if (listener == this)
                {
                    this.setIconImage(bitmap);
                }

            }


            return bitmap;
        }

        public function imageReady(param1: int, param2: BitmapData): void
        {
            Logger.log("[Product] Bundle Icon Image Ready!" + param1);
            setIconImage(param2);
        }

        override public function set view(container: IWindowContainer): void
        {
            var window: IWindow;
            var textWindow: ITextWindow;

            if (!container)
            {
                return;
            }


            super.view = container;

            if (this._productCount > 1)
            {
                window = _view.findChildByName("multiContainer");

                if (window)
                {
                    window.visible = true;
                }


                textWindow = (_view.findChildByName("multiCounter") as ITextWindow);

                if (textWindow)
                {
                    textWindow.text = "x" + this.productCount;
                }

            }

        }

    }
}
