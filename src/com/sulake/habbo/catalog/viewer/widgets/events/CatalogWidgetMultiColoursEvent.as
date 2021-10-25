package com.sulake.habbo.catalog.viewer.widgets.events
{

    import flash.events.Event;

    public class CatalogWidgetMultiColoursEvent extends Event
    {

        private var _colours: Array;
        private var _backgroundAssetName: String;
        private var _colourAssetName: String;
        private var _chosenColourAssetName: String;

        public function CatalogWidgetMultiColoursEvent(colours: Array, backgroundAssetName: String, colourAssetName: String, chosenColourAssetName: String, param5: Boolean = false, param6: Boolean = false)
        {
            super(WidgetEvent.CWE_MULTI_COLOUR_ARRAY, param5, param6);
            this._colours = colours;
            this._backgroundAssetName = backgroundAssetName;
            this._colourAssetName = colourAssetName;
            this._chosenColourAssetName = chosenColourAssetName;
        }

        public function get colours(): Array
        {
            return this._colours;
        }

        public function get backgroundAssetName(): String
        {
            return this._backgroundAssetName;
        }

        public function get colourAssetName(): String
        {
            return this._colourAssetName;
        }

        public function get chosenColourAssetName(): String
        {
            return this._chosenColourAssetName;
        }

    }
}
