package com.sulake.habbo.communication.messages.incoming.room.engine
{
    public class PublicRoomObjectMessageData 
    {

        private var _name:String = "";
        private var _type:String = "";
        private var _x:Number = 0;
        private var var_2497:Number = 0;
        private var var_2498:Number = 0;
        private var var_3035:int = 0;
        private var var_3038:int = 0;
        private var var_3039:int = 0;
        private var var_3037:Boolean = false;

        public function setReadOnly():void
        {
            this.var_3037 = true;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function set type(param1:String):void
        {
            if (!this.var_3037)
            {
                this._type = param1;
            };
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            if (!this.var_3037)
            {
                this._name = param1;
            };
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

    }
}