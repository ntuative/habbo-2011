package com.sulake.habbo.catalog.viewer
{
    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.habbo.room.IRoomEngine;
    import flash.display.BitmapData;

    public class ProductContainer extends ProductGridItem implements IGetImageListener, IProductContainer, IGridItem 
    {

        protected var var_2607:Offer;
        private var var_2839:Array;
        private var var_2840:int;

        public function ProductContainer(param1:Offer, param2:Array)
        {
            this.var_2607 = param1;
            this.var_2839 = param2;
        }

        public function get iconCallbackId():int
        {
            return (this.var_2840);
        }

        public function set iconCallbackId(param1:int):void
        {
            this.var_2840 = param1;
        }

        public function get products():Array
        {
            return (this.var_2839);
        }

        public function get firstProduct():IProduct
        {
            return (this.var_2839[0] as IProduct);
        }

        public function get offer():Offer
        {
            return (this.var_2607);
        }

        override public function dispose():void
        {
            var _loc1_:Product;
            super.dispose();
            for each (_loc1_ in this.var_2839)
            {
                _loc1_.dispose();
            };
            this.var_2839 = null;
            this.var_2840 = 0;
        }

        public function initProductIcon(param1:IRoomEngine):void
        {
        }

        public function imageReady(param1:int, param2:BitmapData):void
        {
            setIconImage(param2);
        }

    }
}