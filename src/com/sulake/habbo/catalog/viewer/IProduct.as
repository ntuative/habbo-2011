package com.sulake.habbo.catalog.viewer
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.session.product.IProductData;
    import com.sulake.habbo.session.furniture.IFurnitureData;

    import flash.display.BitmapData;

    import com.sulake.core.window.IWindowContainer;

    public interface IProduct extends IGetImageListener
    {

        function dispose(): void;

        function get productType(): String;

        function get productClassId(): int;

        function get extraParam(): String;

        function get productCount(): int;

        function get expiration(): int;

        function get productData(): IProductData;

        function get furnitureData(): IFurnitureData;

        function initIcon(param1: IProductContainer, param2: IGetImageListener = null): BitmapData;

        function set view(param1: IWindowContainer): void;

        function set grid(param1: IItemGrid): void;

    }
}
