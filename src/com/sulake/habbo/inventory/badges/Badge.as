package com.sulake.habbo.inventory.badges
{

    import com.sulake.habbo.inventory.common.IThumbListDrawableItem;

    import flash.display.BitmapData;

    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    import flash.geom.Point;

    public class Badge implements IThumbListDrawableItem
    {

        private const BADGE_BG_SELECTED: int = 0x888888;
        private const BADGE_BG_DESELECTED: int = 0xCCCCCC;

        private var _type: String;
        private var _isInUse: Boolean;
        private var _isSelected: Boolean;
        private var _iconImage: BitmapData = new BitmapData(1, 1, false, 0xFF00FF00);
        private var _window: IWindowContainer;
        private var _view: IWindow;

        public function Badge(type: String, window: IWindowContainer)
        {
            this._type = type;
            this._window = window;
            this._view = this._window.findChildByTag("BG_COLOR");
        }

        public function get type(): String
        {
            return this._type;
        }

        public function get isInUse(): Boolean
        {
            return this._isInUse;
        }

        public function get isSelected(): Boolean
        {
            return this._isSelected;
        }

        public function get iconImage(): BitmapData
        {
            return this._iconImage;
        }

        public function get window(): IWindowContainer
        {
            return this._window;
        }

        public function set isInUse(value: Boolean): void
        {
            this._isInUse = value;
        }

        public function set isSelected(value: Boolean): void
        {
            this._isSelected = value;

            if (this._view == null)
            {
                return;
            }

            if (value)
            {
                this._view.color = this.BADGE_BG_SELECTED;
            }
            else
            {
                this._view.color = this.BADGE_BG_DESELECTED;
            }

        }

        public function set iconImage(bitmap: BitmapData): void
        {
            this._iconImage = bitmap;

            if (this._iconImage == null)
            {
                return;
            }

            if (this._window == null)
            {
                return;
            }

            var wrapper: IBitmapWrapperWindow = this._window.findChildByName("bitmap") as IBitmapWrapperWindow;
            
            if (wrapper == null)
            {
                return;
            }

            bitmap = this._iconImage;

            var sizedBitmap: BitmapData = wrapper.bitmap ? wrapper.bitmap : new BitmapData(wrapper.width, wrapper.height);
            
            sizedBitmap.fillRect(sizedBitmap.rect, 0);
            sizedBitmap.copyPixels(bitmap, bitmap.rect, new Point(sizedBitmap.width / 2 - bitmap.width / 2, sizedBitmap.height / 2 - bitmap.height / 2));
            
            wrapper.bitmap = sizedBitmap;
        }

    }
}
