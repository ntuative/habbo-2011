package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
    public class SaveableRoomSettingsData 
    {

        private var _roomId:int;
        private var _name:String;
        private var var_2400:String;
        private var var_2981:int;
        private var _password:String;
        private var var_2465:int;
        private var var_3059:int;
        private var var_1029:Array;
        private var var_3061:Array;
        private var var_2988:Boolean;
        private var var_3063:Boolean;
        private var var_3064:Boolean;
        private var var_3065:Boolean;

        public function get allowPets():Boolean
        {
            return (this.var_2988);
        }

        public function set allowPets(param1:Boolean):void
        {
            this.var_2988 = param1;
        }

        public function get allowFoodConsume():Boolean
        {
            return (this.var_3063);
        }

        public function set allowFoodConsume(param1:Boolean):void
        {
            this.var_3063 = param1;
        }

        public function get allowWalkThrough():Boolean
        {
            return (this.var_3064);
        }

        public function set allowWalkThrough(param1:Boolean):void
        {
            this.var_3064 = param1;
        }

        public function get hideWalls():Boolean
        {
            return (this.var_3065);
        }

        public function set hideWalls(param1:Boolean):void
        {
            this.var_3065 = param1;
        }

        public function get roomId():int
        {
            return (this._roomId);
        }

        public function set roomId(param1:int):void
        {
            this._roomId = param1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(param1:String):void
        {
            this._name = param1;
        }

        public function get description():String
        {
            return (this.var_2400);
        }

        public function set description(param1:String):void
        {
            this.var_2400 = param1;
        }

        public function get doorMode():int
        {
            return (this.var_2981);
        }

        public function set doorMode(param1:int):void
        {
            this.var_2981 = param1;
        }

        public function get password():String
        {
            return (this._password);
        }

        public function set password(param1:String):void
        {
            this._password = param1;
        }

        public function get categoryId():int
        {
            return (this.var_2465);
        }

        public function set categoryId(param1:int):void
        {
            this.var_2465 = param1;
        }

        public function get maximumVisitors():int
        {
            return (this.var_3059);
        }

        public function set maximumVisitors(param1:int):void
        {
            this.var_3059 = param1;
        }

        public function get tags():Array
        {
            return (this.var_1029);
        }

        public function set tags(param1:Array):void
        {
            this.var_1029 = param1;
        }

        public function get controllers():Array
        {
            return (this.var_3061);
        }

        public function set controllers(param1:Array):void
        {
            this.var_3061 = param1;
        }

    }
}