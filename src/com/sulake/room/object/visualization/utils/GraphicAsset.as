package com.sulake.room.object.visualization.utils
{
    import com.sulake.core.assets.BitmapDataAsset;
    import com.sulake.core.assets.IAsset;
    import flash.display.BitmapData;

    public class GraphicAsset implements IGraphicAsset 
    {

        private var var_2120:String;
        private var var_4987:String;
        private var var_2242:BitmapDataAsset;
        private var var_2126:Boolean;
        private var var_2127:Boolean;
        private var var_4988:Boolean;
        private var _offsetX:int;
        private var var_2038:int;
        private var var_2237:int;
        private var _height:int;
        private var var_2047:Boolean;

        public function GraphicAsset(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:Boolean=false)
        {
            this.var_2120 = param1;
            this.var_4987 = param2;
            var _loc9_:BitmapDataAsset = (param3 as BitmapDataAsset);
            if (_loc9_ != null)
            {
                this.var_2242 = _loc9_;
                this.var_2047 = false;
            }
            else
            {
                this.var_2242 = null;
                this.var_2047 = true;
            };
            this.var_2126 = param4;
            this.var_2127 = param5;
            this._offsetX = param6;
            this.var_2038 = param7;
            this.var_4988 = param8;
        }

        public function dispose():void
        {
            this.var_2242 = null;
        }

        private function initialize():void
        {
            var _loc1_:BitmapData;
            if (((!(this.var_2047)) && (!(this.var_2242 == null))))
            {
                _loc1_ = (this.var_2242.content as BitmapData);
                if (_loc1_ != null)
                {
                    this.var_2237 = _loc1_.width;
                    this._height = _loc1_.height;
                };
                this.var_2047 = true;
            };
        }

        public function get flipV():Boolean
        {
            return (this.var_2127);
        }

        public function get flipH():Boolean
        {
            return (this.var_2126);
        }

        public function get width():int
        {
            this.initialize();
            return (this.var_2237);
        }

        public function get height():int
        {
            this.initialize();
            return (this._height);
        }

        public function get assetName():String
        {
            return (this.var_2120);
        }

        public function get libraryAssetName():String
        {
            return (this.var_4987);
        }

        public function get asset():IAsset
        {
            return (this.var_2242);
        }

        public function get usesPalette():Boolean
        {
            return (this.var_4988);
        }

        public function get offsetX():int
        {
            if (!this.var_2126)
            {
                return (this._offsetX);
            };
            return (-(this.width + this._offsetX));
        }

        public function get offsetY():int
        {
            if (!this.var_2127)
            {
                return (this.var_2038);
            };
            return (-(this.height + this.var_2038));
        }

        public function get originalOffsetX():int
        {
            return (this._offsetX);
        }

        public function get originalOffsetY():int
        {
            return (this.var_2038);
        }

    }
}