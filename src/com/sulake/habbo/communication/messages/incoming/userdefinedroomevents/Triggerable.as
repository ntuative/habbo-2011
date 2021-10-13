package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents
{
    import com.sulake.core.communication.messages.IMessageDataWrapper;

    public class Triggerable 
    {

        private var var_3073:Boolean;
        private var _furniLimit:int;
        private var var_3071:Array = new Array();
        private var _id:int;
        private var var_3074:String;
        private var var_3072:Array = new Array();
        private var var_3075:int;
        private var var_3076:int;

        public function Triggerable(param1:IMessageDataWrapper)
        {
            var _loc5_:int;
            super();
            this.var_3073 = param1.readBoolean();
            this._furniLimit = param1.readInteger();
            var _loc2_:int = param1.readInteger();
            var _loc3_:int;
            while (_loc3_ < _loc2_)
            {
                _loc5_ = param1.readInteger();
                this.var_3071.push(_loc5_);
                _loc3_++;
            };
            this.var_3075 = param1.readInteger();
            this._id = param1.readInteger();
            this.var_3074 = param1.readString();
            var _loc4_:int = param1.readInteger();
            _loc3_ = 0;
            while (_loc3_ < _loc4_)
            {
                this.var_3072.push(param1.readInteger());
                _loc3_++;
            };
            this.var_3076 = param1.readInteger();
        }

        public function get stuffTypeSelectionEnabled():Boolean
        {
            return (this.var_3073);
        }

        public function get stuffTypeSelectionCode():int
        {
            return (this.var_3076);
        }

        public function set stuffTypeSelectionCode(param1:int):void
        {
            this.var_3076 = param1;
        }

        public function get furniLimit():int
        {
            return (this._furniLimit);
        }

        public function get stuffIds():Array
        {
            return (this.var_3071);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get stringParam():String
        {
            return (this.var_3074);
        }

        public function get intParams():Array
        {
            return (this.var_3072);
        }

        public function get code():int
        {
            return (0);
        }

        public function get stuffTypeId():int
        {
            return (this.var_3075);
        }

        public function getBoolean(param1:int):Boolean
        {
            return (this.var_3072[param1] == 1);
        }

    }
}