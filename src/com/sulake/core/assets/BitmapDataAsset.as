package com.sulake.core.assets
{

    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;

    public class BitmapDataAsset implements ILazyAsset
    {

        protected static var _instances: uint = 0;
        protected static var _allocatedByteCount: uint = 0;

        private var _disposed: Boolean = false;
        private var _content: Object;
        private var _bitmap: BitmapData;
        private var _offset: Point = new Point(0, 0);
        private var _flipH: Boolean = false;
        private var _flipV: Boolean = false;
        private var _declaration: AssetTypeDeclaration;
        private var _url: String;

        public function BitmapDataAsset(param1: AssetTypeDeclaration, param2: String = null)
        {
            this._declaration = param1;
            this._url = param2;
            _instances++;
        }

        public static function get instances(): uint
        {
            return _instances;
        }

        public static function get allocatedByteCount(): uint
        {
            return _allocatedByteCount;
        }

        public function get url(): String
        {
            return this._url;
        }

        public function get flipH(): Boolean
        {
            return this._flipH;
        }

        public function get flipV(): Boolean
        {
            return this._flipV;
        }

        public function get offset(): Point
        {
            return this._offset;
        }

        public function get content(): Object
        {
            if (!this._bitmap)
            {
                this.prepareLazyContent();
            }


            return this._bitmap;
        }

        public function get disposed(): Boolean
        {
            return this._disposed;
        }

        public function get declaration(): AssetTypeDeclaration
        {
            return this._declaration;
        }

        public function dispose(): void
        {
            if (!this._disposed)
            {
                _instances--;

                if (this._bitmap)
                {
                    try
                    {
                        _allocatedByteCount = _allocatedByteCount - this._bitmap.width * this._bitmap.height * 4;
                        this._bitmap.dispose();
                    }
                    catch (e: Error)
                    {
                    }

                }


                this._content = null;
                this._bitmap = null;
                this._offset = null;
                this._declaration = null;
                this._url = null;
                this._disposed = true;
            }

        }

        public function setUnknownContent(content: Object): void
        {
            this._content = content;
            this._bitmap = null;
        }

        public function prepareLazyContent(): void
        {
            var bitmap: Bitmap;

            if (this._content == null)
            {
                return;
            }


            if (this._content is Class)
            {
                bitmap = new this._content() as Bitmap;

                if (bitmap != null)
                {
                    this._bitmap = bitmap.bitmapData.clone();
                    bitmap.bitmapData.dispose();

                    if (this._bitmap != null)
                    {
                        _allocatedByteCount = _allocatedByteCount + this._bitmap.width * this._bitmap.height * 4;
                        this._content = null;

                        return;
                    }


                    throw new Error("Failed to convert Bitmap Class to BitmapDataAsset!");
                }


                this._bitmap = new this._content() as BitmapData;

                if (this._bitmap != null)
                {
                    this._content = null;

                    return;
                }


                throw new Error("Failed to convert BitmapData Class to BitmapDataAsset!");
            }


            if (this._content is Bitmap)
            {
                this._bitmap = Bitmap(this._content).bitmapData;

                if (this._bitmap != null)
                {
                    this._content = null;
                }
                else
                {
                    throw new Error("Failed to convert Bitmap to BitmapDataAsset!");
                }

            }


            if (this._content is BitmapData)
            {
                this._bitmap = this._content as BitmapData;

                if (this._bitmap != null)
                {
                    this._content = null;

                    return;
                }


                throw new Error("Failed to convert BitmapData to BitmapDataAsset!");
            }


            if (this._content is BitmapDataAsset)
            {
                this._bitmap = BitmapDataAsset(this._content)._bitmap;
                this._offset = BitmapDataAsset(this._content)._offset;
                this._flipH = BitmapDataAsset(this._content)._flipH;
                this._flipV = BitmapDataAsset(this._content)._flipV;

                if (this._bitmap != null)
                {
                    this._content = null;

                    return;
                }


                throw new Error("Failed to read content from BitmaDataAsset!");
            }

        }

        public function setFromOtherAsset(asset: IAsset): void
        {
            if (asset is BitmapDataAsset)
            {
                this._bitmap = BitmapDataAsset(asset)._bitmap;
                this._offset = BitmapDataAsset(asset)._offset;
            }
            else
            {
                throw new Error("Provided asset should be of type BitmapDataAsset!");
            }

        }

        public function setParamsDesc(params: XMLList): void
        {
            var key: String;
            var value: String;

            for (var i: int = 0; i < params.length(); i++)
            {
                key = params[i].attribute("key");
                value = params[i].attribute("value");

                switch (key)
                {
                    case "offset":
                        var coords: Array = value.split(",");
                        this._offset.x = parseInt(coords[0]);
                        this._offset.y = parseInt(coords[1]);
                        break;

                    case "flipH":
                        this._flipH = value == "1" || value == "true";
                        break;

                    case "flipV":
                        this._flipV = value == "1" || value == "true";
                        break;
                }

            }

        }

    }
}
