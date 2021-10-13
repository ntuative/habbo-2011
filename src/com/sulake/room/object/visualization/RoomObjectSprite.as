package com.sulake.room.object.visualization
{
    import flash.display.BitmapData;
    import flash.geom.Point;

    public final class RoomObjectSprite implements IRoomObjectSprite 
    {

        private static var var_1454:int = 0;

        private var var_2242:BitmapData = null;
        private var var_2120:String = "";
        private var var_1023:Boolean = true;
        private var var_2997:String = "";
        private var var_4054:int = 0xFF;
        private var _color:int = 0xFFFFFF;
        private var var_2238:String = "normal";
        private var var_2126:Boolean = false;
        private var var_2127:Boolean = false;
        private var _offset:Point = new Point(0, 0);
        private var var_2237:int = 0;
        private var _height:int = 0;
        private var var_2529:Number = 0;
        private var var_4992:Boolean = false;
        private var var_4993:Boolean = true;
        private var var_4137:Boolean = false;
        private var _updateID:int = 0;
        private var _instanceId:int = 0;
        private var var_4994:Array = null;

        public function RoomObjectSprite()
        {
            this._instanceId = var_1454++;
        }

        public function dispose():void
        {
            this.var_2242 = null;
            this.var_2237 = 0;
            this._height = 0;
        }

        public function get asset():BitmapData
        {
            return (this.var_2242);
        }

        public function get assetName():String
        {
            return (this.var_2120);
        }

        public function get visible():Boolean
        {
            return (this.var_1023);
        }

        public function get tag():String
        {
            return (this.var_2997);
        }

        public function get alpha():int
        {
            return (this.var_4054);
        }

        public function get color():int
        {
            return (this._color);
        }

        public function get blendMode():String
        {
            return (this.var_2238);
        }

        public function get flipV():Boolean
        {
            return (this.var_2127);
        }

        public function get flipH():Boolean
        {
            return (this.var_2126);
        }

        public function get offsetX():int
        {
            return (this._offset.x);
        }

        public function get offsetY():int
        {
            return (this._offset.y);
        }

        public function get width():int
        {
            return (this.var_2237);
        }

        public function get height():int
        {
            return (this._height);
        }

        public function get relativeDepth():Number
        {
            return (this.var_2529);
        }

        public function get varyingDepth():Boolean
        {
            return (this.var_4992);
        }

        public function get capturesMouse():Boolean
        {
            return (this.var_4993);
        }

        public function get clickHandling():Boolean
        {
            return (this.var_4137);
        }

        public function get instanceId():int
        {
            return (this._instanceId);
        }

        public function get updateId():int
        {
            return (this._updateID);
        }

        public function get filters():Array
        {
            return (this.var_4994);
        }

        public function set asset(param1:BitmapData):void
        {
            if (param1 != null)
            {
                this.var_2237 = param1.width;
                this._height = param1.height;
            };
            this.var_2242 = param1;
            this._updateID++;
        }

        public function set assetName(param1:String):void
        {
            this.var_2120 = param1;
            this._updateID++;
        }

        public function set visible(param1:Boolean):void
        {
            this.var_1023 = param1;
            this._updateID++;
        }

        public function set tag(param1:String):void
        {
            this.var_2997 = param1;
            this._updateID++;
        }

        public function set alpha(param1:int):void
        {
            param1 = (param1 & 0xFF);
            this.var_4054 = param1;
            this._updateID++;
        }

        public function set color(param1:int):void
        {
            param1 = (param1 & 0xFFFFFF);
            this._color = param1;
            this._updateID++;
        }

        public function set blendMode(param1:String):void
        {
            this.var_2238 = param1;
            this._updateID++;
        }

        public function set filters(param1:Array):void
        {
            this.var_4994 = param1;
            this._updateID++;
        }

        public function set flipH(param1:Boolean):void
        {
            this.var_2126 = param1;
            this._updateID++;
        }

        public function set flipV(param1:Boolean):void
        {
            this.var_2127 = param1;
            this._updateID++;
        }

        public function set offsetX(param1:int):void
        {
            this._offset.x = param1;
            this._updateID++;
        }

        public function set offsetY(param1:int):void
        {
            this._offset.y = param1;
            this._updateID++;
        }

        public function set relativeDepth(param1:Number):void
        {
            this.var_2529 = param1;
            this._updateID++;
        }

        public function set varyingDepth(param1:Boolean):void
        {
            this.var_4992 = param1;
            this._updateID++;
        }

        public function set capturesMouse(param1:Boolean):void
        {
            this.var_4993 = param1;
            this._updateID++;
        }

        public function set clickHandling(param1:Boolean):void
        {
            this.var_4137 = param1;
            this._updateID++;
        }

    }
}