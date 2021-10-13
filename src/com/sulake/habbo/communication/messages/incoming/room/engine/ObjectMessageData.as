package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class ObjectMessageData 
    {

        private var _id:int = 0;
        private var _x:Number = 0;
        private var var_2497:Number = 0;
        private var var_2498:Number = 0;
        private var var_3035:int = 0;
        private var var_3038:int = 0;
        private var var_3039:int = 0;
        private var _type:int = 0;
        private var var_3036:String = "";
        private var var_2940:int = -1;
        private var _state:int = 0;
        private var _data:String = "";
        private var var_2939:int = 0;
        private var var_3040:String = null;
        private var var_3037:Boolean = false;

        public function ObjectMessageData(param1:int)
        {
            this._id = param1;
        }

        public function setReadOnly():void
        {
            this.var_3037 = true;
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get x():Number
        {
            return (this._x);
        }

        public function set x(param1:Number):void
        {
            if (!this.var_3037)
            {
                this._x = param1;
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

        public function get dir():int
        {
            return (this.var_3035);
        }

        public function set dir(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3035 = param1;
            };
        }

        public function get sizeX():int
        {
            return (this.var_3038);
        }

        public function set sizeX(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3038 = param1;
            };
        }

        public function get sizeY():int
        {
            return (this.var_3039);
        }

        public function set sizeY(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_3039 = param1;
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

        public function get staticClass():String
        {
            return (this.var_3040);
        }

        public function set staticClass(param1:String):void
        {
            if (!this.var_3037)
            {
                this.var_3040 = param1;
            };
        }

        public function get extra():int
        {
            return (this.var_2940);
        }

        public function set extra(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_2940 = param1;
            };
        }

        public function get expiryTime():int
        {
            return (this.var_2939);
        }

        public function set expiryTime(param1:int):void
        {
            if (!this.var_3037)
            {
                this.var_2939 = param1;
            };
        }

    }
}