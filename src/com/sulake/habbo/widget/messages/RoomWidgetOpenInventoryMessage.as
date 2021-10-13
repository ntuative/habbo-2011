package com.sulake.habbo.widget.messages
{
    public class RoomWidgetOpenInventoryMessage extends RoomWidgetMessage 
    {

        public static const var_1894:String = "RWGOI_MESSAGE_OPEN_INVENTORY";
        public static const var_1827:String = "inventory_effects";
        public static const var_1820:String = "inventory_badges";
        public static const var_1902:String = "inventory_clothes";
        public static const var_1901:String = "inventory_furniture";

        private var var_4860:String;

        public function RoomWidgetOpenInventoryMessage(param1:String)
        {
            super(var_1894);
            this.var_4860 = param1;
        }

        public function get inventoryType():String
        {
            return (this.var_4860);
        }

    }
}