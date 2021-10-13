package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class CatalogWidgetColoursEvent extends Event 
    {

        private var var_2716:Array;
        private var var_2717:String;
        private var var_2718:String;
        private var var_2719:String;

        public function CatalogWidgetColoursEvent(param1:Array, param2:String, param3:String, param4:String, param5:Boolean=false, param6:Boolean=false)
        {
            super(WidgetEvent.CWE_COLOUR_ARRAY, param5, param6);
            this.var_2716 = param1;
            this.var_2717 = param2;
            this.var_2718 = param3;
            this.var_2719 = param4;
        }

        public function get colours():Array
        {
            return (this.var_2716);
        }

        public function get backgroundAssetName():String
        {
            return (this.var_2717);
        }

        public function get colourAssetName():String
        {
            return (this.var_2718);
        }

        public function get chosenColourAssetName():String
        {
            return (this.var_2719);
        }

    }
}