package com.sulake.habbo.catalog.viewer
{
    import flash.display.BitmapData;
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IItemGridWindow;
    import com.sulake.core.window.components.IScrollbarWindow;
    import com.sulake.core.window.components.ITextWindow;

    public class BundleProductContainer extends ProductContainer implements IProductContainer, IItemGrid 
    {

        private static const var_2816:int = 6;

        private var var_2817:BitmapData;

        public function BundleProductContainer(param1:Offer, param2:Array)
        {
            super(param1, param2);
            var _loc3_:BitmapDataAsset = (param1.page.viewer.catalog.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset);
            if (_loc3_ != null)
            {
                this.var_2817 = (_loc3_.content as BitmapData);
            }
            else
            {
                this.var_2817 = new BitmapData(1, 1, true, 0xFFFFFF);
            };
        }

        override public function dispose():void
        {
            super.dispose();
            this.var_2817 = null;
        }

        override public function initProductIcon(param1:IRoomEngine):void
        {
            setIconImage(this.var_2817.clone());
        }

        public function populateItemGrid(param1:IItemGridWindow, param2:IScrollbarWindow, param3:XML):void
        {
            var _loc5_:IProduct;
            var _loc6_:IWindowContainer;
            var _loc7_:BitmapData;
            var _loc4_:int;
            for each (_loc5_ in offer.productContainer.products)
            {
                _loc6_ = (offer.page.viewer.catalog.windowManager.buildFromXML(param3) as IWindowContainer);
                param1.addGridItem(_loc6_);
                _loc5_.view = _loc6_;
                _loc7_ = _loc5_.initIcon(this);
                if (_loc7_ != null)
                {
                    _loc7_.dispose();
                };
                _loc5_.grid = this;
            };
            if (param2 != null)
            {
                param2.visible = (offer.productContainer.products.length > var_2816);
            };
        }

        public function setBundleCounter(param1:int):void
        {
            var _loc2_:ITextWindow = (_view.findChildByName("bundleCounter") as ITextWindow);
            if (_loc2_ != null)
            {
                _loc2_.text = (param1 + "");
            };
        }

        public function select(param1:IGridItem):void
        {
            Logger.log(("Product Bundle, select item: " + param1));
        }

        public function startDragAndDrop(param1:IGridItem):Boolean
        {
            return (false);
        }

    }
}