package com.sulake.habbo.communication.messages.incoming.roomsettings
{
    public class RoomSettingsData 
    {

        public static const var_1687:int = 0;
        public static const var_896:int = 1;
        public static const var_897:int = 2;
        public static const var_1688:Array = ["open", "closed", "password"];

        private var _roomId:int;
        private var _name:String;
        private var var_2400:String;
        private var var_2981:int;
        private var var_2465:int;
        private var var_3059:int;
        private var var_3060:int;
        private var var_1029:Array;
        private var var_3061:Array;
        private var var_3062:int;
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

        public function get maximumVisitorsLimit():int
        {
            return (this.var_3060);
        }

        public function set maximumVisitorsLimit(param1:int):void
        {
            this.var_3060 = param1;
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

        public function get controllerCount():int
        {
            return (this.var_3062);
        }

        public function set controllerCount(param1:int):void
        {
            this.var_3062 = param1;
        }

    }
}