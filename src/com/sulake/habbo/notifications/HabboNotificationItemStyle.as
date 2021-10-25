package com.sulake.habbo.notifications
{

    import flash.display.BitmapData;

    import com.sulake.core.utils.Map;

    public class HabboNotificationItemStyle
    {

        private var _componentLinks: Array;
        private var _icon: BitmapData;
        private var _loaded: Boolean;
        private var _iconSrc: String;

        public function HabboNotificationItemStyle(defaults: Map, icon: BitmapData, loaded: Boolean, iconSource: String)
        {
            if (defaults == null)
            {
                this._componentLinks = [];
                this._icon = null;
            }
            else
            {
                this._componentLinks = defaults["uilinks"];
                this._icon = defaults["icon"];
            }

            if (icon != null)
            {
                this._icon = icon;
                this._loaded = loaded;
            }
            else
            {
                this._loaded = false;
            }

            this._iconSrc = iconSource;
        }

        public function dispose(): void
        {
            if (this._loaded && this._icon != null)
            {
                this._icon.dispose();
                this._icon = null;
            }

        }

        public function get icon(): BitmapData
        {
            return this._icon;
        }

        public function get componentLinks(): Array
        {
            return this._componentLinks;
        }

        public function get iconSrc(): String
        {
            return this._iconSrc;
        }

    }
}
