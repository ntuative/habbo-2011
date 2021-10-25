package com.sulake.habbo.toolbar.events
{

    import flash.events.Event;
    import flash.display.BitmapData;

    public class HabboToolbarSetIconEvent extends Event
    {

        public static const var_145: String = "HTIE_SET_TOOLBAR_ICON";
        public static const var_432: String = "HTIE_SET_TOOLBAR_ICON_BITMAP";
        public static const var_176: String = "HTIE_SET_TOOLBAR_ICON_STATE";
        public static const var_306: String = "HTIE_REMOVE_TOOLBAR_ICON";

        private var var_2661: String;
        private var var_2120: String;
        private var _bitmapData: BitmapData;
        private var var_4521: String;

        public function HabboToolbarSetIconEvent(param1: String, param2: String, param3: String = null, param4: Boolean = false, param5: Boolean = false)
        {
            super(param1, param4, param5);
            this.var_2661 = param2;
            this.var_2120 = param3;
        }

        public function get iconId(): String
        {
            return this.var_2661;
        }

        public function get bitmapData(): BitmapData
        {
            return this._bitmapData;
        }

        public function get assetName(): String
        {
            return this.var_2120;
        }

        public function get iconState(): String
        {
            return this.var_4521;
        }

        public function set bitmapData(param1: BitmapData): void
        {
            this._bitmapData = param1;
        }

        public function set assetName(param1: String): void
        {
            this.var_2120 = param1;
        }

        public function set iconState(param1: String): void
        {
            this.var_4521 = param1;
        }

    }
}
