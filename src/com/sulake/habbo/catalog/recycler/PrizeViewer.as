package com.sulake.habbo.catalog.recycler
{

    import com.sulake.habbo.room.IGetImageListener;
    import com.sulake.core.window.components.IBitmapWrapperWindow;
    import com.sulake.habbo.room.ImageResult;
    import com.sulake.room.utils.Vector3d;
    import com.sulake.habbo.catalog.enum.ProductTypeEnum;
    import com.sulake.core.window.components.ITextWindow;
    import com.sulake.habbo.room.IRoomEngine;
    import com.sulake.core.window.IWindowContainer;

    import flash.display.BitmapData;
    import flash.geom.Point;

    public class PrizeViewer implements IGetImageListener
    {

        private var var_2711: IBitmapWrapperWindow;

        public function dispose(): void
        {
            this.var_2711 = null;
        }

        public function viewProduct(param1: IRoomEngine, param2: IWindowContainer, param3: String, param4: int, param5: String, param6: String, param7: String = ""): void
        {
            var _loc8_: ImageResult;
            this.var_2711 = (param2.findChildByName("ctlg_teaserimg_1") as IBitmapWrapperWindow);
            switch (param3)
            {
                case ProductTypeEnum.var_112:
                    _loc8_ = param1.getFurnitureImage(param4, new Vector3d(90, 0, 0), 64, this, 0, param7);
                    break;
                case ProductTypeEnum.var_113:
                    _loc8_ = param1.getWallItemImage(param4, new Vector3d(90, 0, 0), 64, this, 0, param7);
                    break;
                default:
                    return;
            }

            if (_loc8_ != null)
            {
                this.setPreviewImage(_loc8_.data, true);
            }

            var _loc9_: ITextWindow = param2.findChildByName("ctlg_product_name") as ITextWindow;
            if (_loc9_ != null)
            {
                _loc9_.text = param5;
            }

            _loc9_ = (param2.findChildByName("ctlg_description") as ITextWindow);
            if (_loc9_ != null)
            {
                _loc9_.text = param6;
            }

        }

        public function imageReady(param1: int, param2: BitmapData): void
        {
            this.setPreviewImage(param2, true);
        }

        private function setPreviewImage(param1: BitmapData, param2: Boolean): void
        {
            var _loc3_: Point;
            if (this.var_2711 != null && !this.var_2711.disposed)
            {
                if (param1 == null)
                {
                    param1 = new BitmapData(1, 1);
                    param2 = true;
                }

                this.var_2711.bitmap = new BitmapData(this.var_2711.width, this.var_2711.height, true, 0xFFFFFF);
                this.var_2711.bitmap.fillRect(this.var_2711.bitmap.rect, 0xFFFFFF);
                _loc3_ = new Point((this.var_2711.width - param1.width) / 2, (this.var_2711.height - param1.height) / 2);
                this.var_2711.bitmap.copyPixels(param1, param1.rect, _loc3_, null, null, true);
            }

            if (param2 && param1 != null)
            {
                param1.dispose();
            }

        }

    }
}
