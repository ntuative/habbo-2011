package com.sulake.core.assets
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.Bitmap;

    public class BitmapDataAsset implements ILazyAsset 
    {

        protected static var var_594:uint = 0;
        protected static var var_595:uint = 0;

        private var _disposed:Boolean = false;
        private var var_2129:Object;
        private var _bitmap:BitmapData;
        private var _offset:Point = new Point(0, 0);
        private var var_2126:Boolean = false;
        private var var_2127:Boolean = false;
        private var var_2128:AssetTypeDeclaration;
        private var var_2104:String;

        public function BitmapDataAsset(param1:AssetTypeDeclaration, param2:String=null)
        {
            this.var_2128 = param1;
            this.var_2104 = param2;
            var_594++;
        }

        public static function get instances():uint
        {
            return (var_594);
        }

        public static function get allocatedByteCount():uint
        {
            return (var_595);
        }

        public function get url():String
        {
            return (this.var_2104);
        }

        public function get flipH():Boolean
        {
            return (this.var_2126);
        }

        public function get flipV():Boolean
        {
            return (this.var_2127);
        }

        public function get offset():Point
        {
            return (this._offset);
        }

        public function get content():Object
        {
            if (!this._bitmap)
            {
                this.prepareLazyContent();
            };
            return (this._bitmap);
        }

        public function get disposed():Boolean
        {
            return (this._disposed);
        }

        public function get declaration():AssetTypeDeclaration
        {
            return (this.var_2128);
        }

        public function dispose():void
        {
            if (!this._disposed)
            {
                var_594--;
                if (this._bitmap)
                {
                    try
                    {
                        var_595 = (var_595 - ((this._bitmap.width * this._bitmap.height) * 4));
                        this._bitmap.dispose();
                    }
                    catch(e:Error)
                    {
                    };
                };
                this.var_2129 = null;
                this._bitmap = null;
                this._offset = null;
                this.var_2128 = null;
                this.var_2104 = null;
                this._disposed = true;
            };
        }

        public function setUnknownContent(param1:Object):void
        {
            this.var_2129 = param1;
            this._bitmap = null;
        }

        public function prepareLazyContent():void
        {
            var _loc1_:Bitmap;
            if (this.var_2129 == null)
            {
                return;
            };
            if ((this.var_2129 is Class))
            {
                _loc1_ = (new this.var_2129() as Bitmap);
                if (_loc1_ != null)
                {
                    this._bitmap = _loc1_.bitmapData.clone();
                    _loc1_.bitmapData.dispose();
                    if (this._bitmap != null)
                    {
                        var_595 = (var_595 + ((this._bitmap.width * this._bitmap.height) * 4));
                        this.var_2129 = null;
                        return;
                    };
                    throw (new Error("Failed to convert Bitmap Class to BitmapDataAsset!"));
                };
                this._bitmap = (new this.var_2129() as BitmapData);
                if (this._bitmap != null)
                {
                    this.var_2129 = null;
                    return;
                };
                throw (new Error("Failed to convert BitmapData Class to BitmapDataAsset!"));
            };
            if ((this.var_2129 is Bitmap))
            {
                this._bitmap = Bitmap(this.var_2129).bitmapData;
                if (this._bitmap != null)
                {
                    this.var_2129 = null;
                }
                else
                {
                    throw (new Error("Failed to convert Bitmap to BitmapDataAsset!"));
                };
            };
            if ((this.var_2129 is BitmapData))
            {
                this._bitmap = (this.var_2129 as BitmapData);
                if (this._bitmap != null)
                {
                    this.var_2129 = null;
                    return;
                };
                throw (new Error("Failed to convert BitmapData to BitmapDataAsset!"));
            };
            if ((this.var_2129 is BitmapDataAsset))
            {
                this._bitmap = BitmapDataAsset(this.var_2129)._bitmap;
                this._offset = BitmapDataAsset(this.var_2129)._offset;
                this.var_2126 = BitmapDataAsset(this.var_2129).var_2126;
                this.var_2127 = BitmapDataAsset(this.var_2129).var_2127;
                if (this._bitmap != null)
                {
                    this.var_2129 = null;
                    return;
                };
                throw (new Error("Failed to read content from BitmaDataAsset!"));
            };
        }

        public function setFromOtherAsset(param1:IAsset):void
        {
            if ((param1 is BitmapDataAsset))
            {
                this._bitmap = BitmapDataAsset(param1)._bitmap;
                this._offset = BitmapDataAsset(param1)._offset;
            }
            else
            {
                throw (new Error("Provided asset should be of type BitmapDataAsset!"));
            };
        }

        public function setParamsDesc(param1:XMLList):void
        {
            var _loc3_:String;
            var _loc4_:String;
            var _loc5_:Array;
            var _loc2_:uint;
            while (_loc2_ < param1.length())
            {
                _loc3_ = param1[_loc2_].attribute("key");
                _loc4_ = param1[_loc2_].attribute("value");
                switch (_loc3_)
                {
                    case "offset":
                        _loc5_ = _loc4_.split(",");
                        this._offset.x = parseInt(_loc5_[0]);
                        this._offset.y = parseInt(_loc5_[1]);
                        break;
                    case "flipH":
                        this.var_2126 = ((_loc4_ == "1") || (_loc4_ == "true"));
                        break;
                    case "flipV":
                        this.var_2127 = ((_loc4_ == "1") || (_loc4_ == "true"));
                        break;
                };
                _loc2_++;
            };
        }

    }
}