package com.sulake.room.object.visualization.utils
{

    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.IAsset;

    import flash.display.BitmapData;

    public class GraphicAsset implements IGraphicAsset
    {

        private var _assetName: String;
        private var _libraryAssetName: String;
        private var _asset: BitmapDataAsset;
        private var _flipH: Boolean;
        private var _flipV: Boolean;
        private var _usesPalette: Boolean;
        private var _offsetX: int;
        private var _offsetY: int;
        private var _width: int;
        private var _height: int;
        private var _loading: Boolean;

        public function GraphicAsset(assetName: String, libraryAssetName: String, asset: IAsset, flipH: Boolean, flipV: Boolean, offsetX: int, offsetY: int, usesPalette: Boolean = false)
        {
            this._assetName = assetName;
            this._libraryAssetName = libraryAssetName;

            var bitmap: BitmapDataAsset = asset as BitmapDataAsset;
            
            if (bitmap != null)
            {
                this._asset = bitmap;
                this._loading = false;
            }
            else
            {
                this._asset = null;
                this._loading = true;
            }

            this._flipH = flipH;
            this._flipV = flipV;
            this._offsetX = offsetX;
            this._offsetY = offsetY;
            this._usesPalette = usesPalette;
        }

        public function dispose(): void
        {
            this._asset = null;
        }

        private function initialize(): void
        {
            var bitmap: BitmapData;

            if (!this._loading && this._asset != null)
            {
                bitmap = (this._asset.content as BitmapData);
                
                if (bitmap != null)
                {
                    this._width = bitmap.width;
                    this._height = bitmap.height;
                }

                this._loading = true;
            }

        }

        public function get flipV(): Boolean
        {
            return this._flipV;
        }

        public function get flipH(): Boolean
        {
            return this._flipH;
        }

        public function get width(): int
        {
            this.initialize();

            return this._width;
        }

        public function get height(): int
        {
            this.initialize();
            
            return this._height;
        }

        public function get assetName(): String
        {
            return this._assetName;
        }

        public function get libraryAssetName(): String
        {
            return this._libraryAssetName;
        }

        public function get asset(): IAsset
        {
            return this._asset;
        }

        public function get usesPalette(): Boolean
        {
            return this._usesPalette;
        }

        public function get offsetX(): int
        {
            if (!this._flipH)
            {
                return this._offsetX;
            }

            return -(this.width + this._offsetX);
        }

        public function get offsetY(): int
        {
            if (!this._flipV)
            {
                return this._offsetY;
            }

            return -(this.height + this._offsetY);
        }

        public function get originalOffsetX(): int
        {
            return this._offsetX;
        }

        public function get originalOffsetY(): int
        {
            return this._offsetY;
        }

    }
}
