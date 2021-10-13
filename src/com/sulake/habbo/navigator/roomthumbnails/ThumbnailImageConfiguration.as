package com.sulake.habbo.navigator.roomthumbnails
{
    import com.sulake.habbo.navigator.HabboNavigator;
    import flash.display.BitmapData;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class ThumbnailImageConfiguration 
    {

        private var _navigator:HabboNavigator;
        private var _id:int;
        private var _type:int;
        private var var_3851:String;
        private var var_3852:BitmapData;
        private var _selected:Boolean;
        private var var_3853:BitmapData;
        private var var_3854:IBitmapWrapperWindow;
        private var var_3855:Rectangle;
        private var var_3856:int = 1;

        public function ThumbnailImageConfiguration(param1:HabboNavigator, param2:int, param3:int, param4:String, param5:BitmapData)
        {
            this._navigator = param1;
            this._id = param2;
            this._type = param3;
            this.var_3851 = param4;
            this.var_3853 = param5;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get picName():String
        {
            return (this.var_3851);
        }

        public function getImg():BitmapData
        {
            if (this.var_3852 == null)
            {
                this.var_3852 = this._navigator.getButtonImage(this.var_3851);
            };
            return (this.var_3852);
        }

        public function registerListImg(param1:IBitmapWrapperWindow):void
        {
            this.var_3854 = param1;
            this.refreshListImg();
        }

        public function copyTo(param1:BitmapData):void
        {
            var _loc2_:BitmapData = this.getImg();
            param1.copyPixels(_loc2_, _loc2_.rect, new Point(((param1.width - _loc2_.width) / 2), (param1.height - _loc2_.height)), null, null, true);
        }

        public function setSelected(param1:Boolean):void
        {
            if (this._selected == param1)
            {
                return;
            };
            this._selected = param1;
            this.refreshListImg();
        }

        private function refreshListImg():void
        {
            var _loc1_:Rectangle;
            if (this.var_3855 == null)
            {
                _loc1_ = this.var_3854.bitmap.rect;
                this.var_3855 = new Rectangle(this.var_3856, this.var_3856, (_loc1_.width - (2 * this.var_3856)), (_loc1_.height - (2 * this.var_3856)));
            };
            this.var_3854.bitmap.fillRect(this.var_3854.bitmap.rect, 4281545523);
            this.var_3854.bitmap.fillRect(this.var_3855, 4284900966);
            this.copyTo(this.var_3854.bitmap);
            if (this._selected)
            {
                this.var_3854.bitmap.copyPixels(this.var_3853, this.var_3853.rect, new Point(0, 0), null, null, true);
            };
            this.var_3854.invalidate();
        }

    }
}