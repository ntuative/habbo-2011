package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
    public class FurniData 
    {

        private var var_2933:int;
        private var var_2934:String;
        private var _objId:int;
        private var var_2935:int;
        private var _category:int;
        private var var_2650:String;
        private var var_2936:Boolean;
        private var var_2937:Boolean;
        private var var_2938:Boolean;
        private var var_2504:Boolean;
        private var var_2939:int;
        private var var_2940:int;
        private var var_2538:String = "";
        private var var_2941:int = -1;

        public function FurniData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:int)
        {
            this.var_2933 = param1;
            this.var_2934 = param2;
            this._objId = param3;
            this.var_2935 = param4;
            this._category = param5;
            this.var_2650 = param6;
            this.var_2936 = param7;
            this.var_2937 = param8;
            this.var_2938 = param9;
            this.var_2504 = param10;
            this.var_2939 = param11;
        }

        public function setExtraData(param1:String, param2:int):void
        {
            this.var_2538 = param1;
            this.var_2940 = param2;
        }

        public function get stripId():int
        {
            return (this.var_2933);
        }

        public function get itemType():String
        {
            return (this.var_2934);
        }

        public function get objId():int
        {
            return (this._objId);
        }

        public function get classId():int
        {
            return (this.var_2935);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get stuffData():String
        {
            return (this.var_2650);
        }

        public function get isGroupable():Boolean
        {
            return (this.var_2936);
        }

        public function get isRecyclable():Boolean
        {
            return (this.var_2937);
        }

        public function get isTradeable():Boolean
        {
            return (this.var_2938);
        }

        public function get isSellable():Boolean
        {
            return (this.var_2504);
        }

        public function get expiryTime():int
        {
            return (this.var_2939);
        }

        public function get slotId():String
        {
            return (this.var_2538);
        }

        public function get songId():int
        {
            return (this.var_2941);
        }

        public function get extra():int
        {
            return (this.var_2940);
        }

    }
}