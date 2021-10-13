package com.sulake.room.events
{
    public class RoomSpriteMouseEvent 
    {

        private var _type:String = "";
        private var var_4978:String = "";
        private var var_4078:String = "";
        private var var_4983:String = "";
        private var var_4984:Number = 0;
        private var var_4985:Number = 0;
        private var var_3033:Number = 0;
        private var var_3034:Number = 0;
        private var var_4980:Boolean = false;
        private var var_4979:Boolean = false;
        private var var_4981:Boolean = false;
        private var var_4982:Boolean = false;

        public function RoomSpriteMouseEvent(param1:String, param2:String, param3:String, param4:String, param5:Number, param6:Number, param7:Number=0, param8:Number=0, param9:Boolean=false, param10:Boolean=false, param11:Boolean=false, param12:Boolean=false)
        {
            this._type = param1;
            this.var_4978 = param2;
            this.var_4078 = param3;
            this.var_4983 = param4;
            this.var_4984 = param5;
            this.var_4985 = param6;
            this.var_3033 = param7;
            this.var_3034 = param8;
            this.var_4980 = param9;
            this.var_4979 = param10;
            this.var_4981 = param11;
            this.var_4982 = param12;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get eventId():String
        {
            return (this.var_4978);
        }

        public function get canvasId():String
        {
            return (this.var_4078);
        }

        public function get spriteTag():String
        {
            return (this.var_4983);
        }

        public function get screenX():Number
        {
            return (this.var_4984);
        }

        public function get screenY():Number
        {
            return (this.var_4985);
        }

        public function get localX():Number
        {
            return (this.var_3033);
        }

        public function get localY():Number
        {
            return (this.var_3034);
        }

        public function get ctrlKey():Boolean
        {
            return (this.var_4980);
        }

        public function get altKey():Boolean
        {
            return (this.var_4979);
        }

        public function get shiftKey():Boolean
        {
            return (this.var_4981);
        }

        public function get buttonDown():Boolean
        {
            return (this.var_4982);
        }

    }
}