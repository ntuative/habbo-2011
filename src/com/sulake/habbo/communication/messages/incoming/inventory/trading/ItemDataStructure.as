package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
    public class ItemDataStructure 
    {

        private var var_2942:int;
        private var var_2934:String;
        private var var_2943:int;
        private var var_2944:int;
        private var _category:int;
        private var var_2650:String;
        private var var_2940:int;
        private var var_2945:int;
        private var var_2946:int;
        private var var_2947:int;
        private var var_2948:int;
        private var var_2949:Boolean;
        private var var_2950:int;

        public function ItemDataStructure(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:int, param12:Boolean)
        {
            this.var_2942 = param1;
            this.var_2934 = param2;
            this.var_2943 = param3;
            this.var_2944 = param4;
            this._category = param5;
            this.var_2650 = param6;
            this.var_2940 = param7;
            this.var_2945 = param8;
            this.var_2946 = param9;
            this.var_2947 = param10;
            this.var_2948 = param11;
            this.var_2949 = param12;
        }

        public function get itemID():int
        {
            return (this.var_2942);
        }

        public function get itemType():String
        {
            return (this.var_2934);
        }

        public function get roomItemID():int
        {
            return (this.var_2943);
        }

        public function get itemTypeID():int
        {
            return (this.var_2944);
        }

        public function get category():int
        {
            return (this._category);
        }

        public function get stuffData():String
        {
            return (this.var_2650);
        }

        public function get extra():int
        {
            return (this.var_2940);
        }

        public function get timeToExpiration():int
        {
            return (this.var_2945);
        }

        public function get creationDay():int
        {
            return (this.var_2946);
        }

        public function get creationMonth():int
        {
            return (this.var_2947);
        }

        public function get creationYear():int
        {
            return (this.var_2948);
        }

        public function get groupable():Boolean
        {
            return (this.var_2949);
        }

        public function get songID():int
        {
            return (this.var_2940);
        }

    }
}