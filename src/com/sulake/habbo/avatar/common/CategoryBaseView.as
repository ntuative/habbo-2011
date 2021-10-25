package com.sulake.habbo.avatar.common
{

    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.core.window.IWindowContainer;

    import flash.utils.Dictionary;

    import com.sulake.core.assets.IAsset;

    import flash.display.BitmapData;

    import com.sulake.core.window.utils.PropertyStruct;

    import flash.geom.Point;

    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.habbo.avatar.AvatarEditorView;
    import com.sulake.core.window.components.IBitmapWrapperWindow;

    public class CategoryBaseView
    {

        protected var _windowManager: IHabboWindowManager;
        protected var _assetLibrary: IAssetLibrary;
        protected var _window: IWindowContainer;
        protected var var_2467: Dictionary;
        protected var var_2468: String = "";
        protected var var_2469: String = "";
        protected var var_2446: IAvatarEditorCategoryModel;
        protected var var_2067: Boolean;

        public function CategoryBaseView(param1: IHabboWindowManager, param2: IAssetLibrary, param3: IAvatarEditorCategoryModel)
        {
            this._assetLibrary = param2;
            this._windowManager = param1;
            this.var_2446 = param3;
        }

        public function dispose(): void
        {
            var _loc1_: AvatarEditorGridView;
            if (this.var_2467)
            {
                for each (_loc1_ in this.var_2467)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                }

                this.var_2467 = null;
            }

            if (this._window)
            {
                this._window.dispose();
                this._window = null;
            }

            this._assetLibrary = null;
            this._windowManager = null;
            this.var_2446 = null;
            this.var_2067 = false;
        }

        public function init(): void
        {
        }

        public function reset(): void
        {
            var _loc1_: AvatarEditorGridView;
            for each (_loc1_ in this.var_2467)
            {
                _loc1_.dispose();
            }

            this.var_2467 = null;
            this.var_2468 = "";
            this.var_2469 = "";
            this.var_2067 = false;
        }

        public function getWindowContainer(): IWindowContainer
        {
            if (!this.var_2067)
            {
                this.init();
            }

            return this._window;
        }

        public function showPalettes(param1: String, param2: int): void
        {
            if (!this.var_2467)
            {
                return;
            }

            if (!this.var_2067)
            {
                this.init();
            }

            var _loc3_: AvatarEditorGridView = this.var_2467[param1] as AvatarEditorGridView;
            if (!_loc3_)
            {
                return;
            }

            _loc3_.showPalettes(param2);
        }

        protected function setElementImage(bmpWindow: IBitmapWrapperWindow, active: Boolean): void
        {
            var asset: IAsset;
            var assetName: String;
            var src: BitmapData;
            if (!this._assetLibrary)
            {
                return;
            }

            if (bmpWindow == null)
            {
                return;
            }

            var result: Array = bmpWindow.properties.filter(function (param1: *, param2: int, param3: Array): Boolean
                                                            {
                                                                return PropertyStruct(param1).key == "bitmap_asset_name";
                                                            });
            var offset: Point = new Point();
            if (result && result.length)
            {
                assetName = (PropertyStruct(result[0]).value as String);
                if (active)
                {
                    assetName = assetName.replace("_on", "");
                }

                asset = this._assetLibrary.getAssetByName(assetName);
                if (asset && (asset is BitmapDataAsset))
                {
                    bmpWindow.bitmap = new BitmapData(bmpWindow.width, bmpWindow.height, false, AvatarEditorView.var_1634);
                    src = (asset.content as BitmapData);
                    offset.x = (bmpWindow.width - src.width) / 2;
                    offset.y = (bmpWindow.height - src.height) / 2;
                    bmpWindow.bitmap.copyPixels(src, src.rect, offset);
                }

            }

        }

        protected function updateGridView(): void
        {
            var _loc1_: IWindowContainer = this._window.findChildByName("grid_container") as IWindowContainer;
            if (_loc1_ == null)
            {
                return;
            }

            _loc1_.removeChildAt(0);
            var _loc2_: AvatarEditorGridView = this.var_2467[this.var_2468];
            if (_loc2_ == null)
            {
                return;
            }

            var _loc3_: IWindowContainer = _loc2_.window;
            if (_loc3_ == null)
            {
                return;
            }

            _loc1_.visible = true;
            _loc1_.addChild(_loc3_);
            _loc1_.invalidate();
            if (_loc2_.firstView)
            {
                _loc2_.initFromList();
            }

        }

        protected function activateTab(param1: String): void
        {
            var _loc3_: IBitmapWrapperWindow;
            if (!this._window)
            {
                return;
            }

            var _loc2_: IWindowContainer = this._window.findChildByName(param1) as IWindowContainer;
            if (_loc2_)
            {
                _loc3_ = (_loc2_.findChildByTag("bitmap") as IBitmapWrapperWindow);
                this.setElementImage(_loc3_, true);
            }

        }

        protected function inactivateTab(param1: String): void
        {
            var _loc3_: IBitmapWrapperWindow;
            if (!this._window)
            {
                return;
            }

            var _loc2_: IWindowContainer = this._window.findChildByName(param1) as IWindowContainer;
            if (_loc2_)
            {
                _loc3_ = (_loc2_.findChildByTag("bitmap") as IBitmapWrapperWindow);
                this.setElementImage(_loc3_, false);
            }

        }

        protected function attachImages(): void
        {
            var _loc2_: IBitmapWrapperWindow;
            if (!this._window)
            {
                return;
            }

            var _loc1_: Array = [];
            this._window.groupChildrenWithTag("bitmap", _loc1_, true);
            for each (_loc2_ in _loc1_)
            {
                this.setElementImage(_loc2_, false);
            }

        }

    }
}
