package com.sulake.habbo.navigator.roomthumbnails
{

    import com.sulake.habbo.navigator.HabboNavigator;

    import flash.display.BitmapData;

    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class ThumbnailImageConfiguration
    {

        private var _navigator: HabboNavigator;
        private var _id: int;
        private var _type: int;
        private var _picName: String;
        private var _image: BitmapData;
        private var _selected: Boolean;
        private var _unknown1: BitmapData;
        private var _listImage: IBitmapWrapperWindow;
        private var _rect: Rectangle;
        private var _offset: int = 1;

        public function ThumbnailImageConfiguration(param1: HabboNavigator, param2: int, param3: int, param4: String, param5: BitmapData)
        {
            this._navigator = param1;
            this._id = param2;
            this._type = param3;
            this._picName = param4;
            this._unknown1 = param5;
        }

        public function get id(): int
        {
            return this._id;
        }

        public function get picName(): String
        {
            return this._picName;
        }

        public function getImg(): BitmapData
        {
            if (this._image == null)
            {
                this._image = this._navigator.getButtonImage(this._picName);
            }

            return this._image;
        }

        public function registerListImg(param1: IBitmapWrapperWindow): void
        {
            this._listImage = param1;
            this.refreshListImg();
        }

        public function copyTo(param1: BitmapData): void
        {
            var _loc2_: BitmapData = this.getImg();
            param1.copyPixels(_loc2_, _loc2_.rect, new Point((param1.width - _loc2_.width) / 2, param1.height - _loc2_.height), null, null, true);
        }

        public function setSelected(param1: Boolean): void
        {
            if (this._selected == param1)
            {
                return;
            }

            this._selected = param1;
            this.refreshListImg();
        }

        private function refreshListImg(): void
        {
            var _loc1_: Rectangle;
            if (this._rect == null)
            {
                _loc1_ = this._listImage.bitmap.rect;
                this._rect = new Rectangle(this._offset, this._offset, _loc1_.width - 2 * this._offset, _loc1_.height - 2 * this._offset);
            }

            this._listImage.bitmap.fillRect(this._listImage.bitmap.rect, 4281545523);
            this._listImage.bitmap.fillRect(this._rect, 4284900966);
            this.copyTo(this._listImage.bitmap);
            if (this._selected)
            {
                this._listImage.bitmap.copyPixels(this._unknown1, this._unknown1.rect, new Point(0, 0), null, null, true);
            }

            this._listImage.invalidate();
        }

    }
}
