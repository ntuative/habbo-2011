package com.sulake.room.object.visualization.utils
{
    import flash.utils.ByteArray;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.display.BitmapDataChannel;

    public class GraphicAssetPalette 
    {

        private static var var_1783:Array = [];

        private var var_2441:Array = [];
        private var var_4313:int = 0;
        private var var_4314:int = 0;

        public function GraphicAssetPalette(param1:ByteArray, param2:int, param3:int)
        {
            var _loc4_:uint;
            var _loc5_:uint;
            var _loc6_:uint;
            var _loc7_:uint;
            super();
            param1.position = 0;
            while (param1.bytesAvailable >= 3)
            {
                _loc4_ = param1.readUnsignedByte();
                _loc5_ = param1.readUnsignedByte();
                _loc6_ = param1.readUnsignedByte();
                _loc7_ = ((((0xFF << 24) | (_loc4_ << 16)) | (_loc5_ << 8)) | _loc6_);
                this.var_2441.push(_loc7_);
            };
            while (this.var_2441.length < 0x0100)
            {
                this.var_2441.push(0);
            };
            while (var_1783.length < 0x0100)
            {
                var_1783.push(0);
            };
            this.var_4313 = param2;
            this.var_4314 = param3;
        }

        public function get primaryColor():int
        {
            return (this.var_4313);
        }

        public function get secondaryColor():int
        {
            return (this.var_4314);
        }

        public function dispose():void
        {
            this.var_2441 = [];
        }

        public function colorizeBitmap(param1:BitmapData):void
        {
            var _loc2_:BitmapData = param1.clone();
            param1.paletteMap(param1, param1.rect, new Point(0, 0), var_1783, this.var_2441, var_1783, var_1783);
            param1.copyChannel(_loc2_, param1.rect, new Point(0, 0), BitmapDataChannel.ALPHA, BitmapDataChannel.ALPHA);
            _loc2_.dispose();
        }

    }
}