package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ItemMessageData 
    {

        private var _id:int = 0;
        private var var_3030:Boolean = false;
        private var var_3031:int = 0;
        private var var_3032:int = 0;
        private var var_3033:int = 0;
        private var var_3034:int = 0;
        private var var_2497:Number = 0;
        private var var_2498:Number = 0;
        private var var_3035:String = "";
        private var _type:int = 0;
        private var var_3036:String = "";
        private var var_2940:int = 0;
        private var _state:int = 0;
        private var _data:String = "";
        private var var_3037:Boolean = false;

        public function ItemMessageData(param1:int, param2:int, param3:Boolean)
        {
            this._id = param1;
            this._type = param2;
            this.var_3030 = param3;
        }

        public function setReadOnly():void
        {
            this.var_3037 = true;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get isOldFormat():Boolean
        {
            return (this.var_3030);
        }

        public function get wallX():Number
        {
            return (this.var_3031);
        }

        public function set wallX(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_3031 = param1;
            };
        }

        public function get wallY():Number
        {
            return (this.var_3032);
        }

        public function set wallY(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_3032 = param1;
            };
        }

        public function get localX():Number
        {
            return (this.var_3033);
        }

        public function set localX(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_3033 = param1;
            };
        }

        public function get localY():Number
        {
            return (this.var_3034);
        }

        public function set localY(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_3034 = param1;
            };
        }

        public function get y():Number
        {
            return (this.var_2497);
        }

        public function set y(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_2497 = param1;
            };
        }

        public function get z():Number
        {
            return (this.var_2498);
        }

        public function set z(param1:Number):void
        {
            if (!this.var_3037)
            {
                this.var_2498 = param1;
            };
        }

        public function get dir():String
        {
            return (this.var_3035);
        }

        public function set dir(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_3035 = param1;
            };
        }

        public function get type():int
        {
            return (this._type);
        }

        public function set type(param1:int):void
        {
            if (!this.var_3037)
            {
                this._type = param1;
            };
        }

        public function get state():int
        {
            return (this._state);
        }

        public function set state(param1:int):void
        {
            if (!this.var_3037)
            {
                this._state = param1;
            };
        }

        public function get data():String
        {
            return (this._data);
        }

        public function set data(param1:String):void
        {
            if (!this.var_3037)
            {
                this._data = param1;
            };
        }

    }
}