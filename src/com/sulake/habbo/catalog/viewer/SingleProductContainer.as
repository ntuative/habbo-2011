package com.sulake.habbo.catalog.viewer
{

    import flash.display.BitmapData;

    import com.sulake.habbo.room.IRoomEngine;

    public class SingleProductContainer extends ProductContainer implements IProductContainer
    {

        public function SingleProductContainer(param1: Offer, param2: Array)
        {
            super(param1, param2);
        }

        override public function dispose(): void
        {
            super.dispose();
        }

        override public function initProductIcon(param1: IRoomEngine): void
        {
            var _loc2_: IProduct = firstProduct;
            var _loc3_: BitmapData = _loc2_.initIcon(this, this);
            this.setIconImage(_loc3_);
            if (_loc3_ != null)
            {
                _loc3_.dispose();
            }

        }

    }
}
